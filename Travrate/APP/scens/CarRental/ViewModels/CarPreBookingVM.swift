//
//  CarPreBookingVM.swift
//  Travrate
//
//  Created by Admin on 11/07/24.
//

import Foundation

protocol CarPreBookingVMDelegate : BaseViewModelProtocol {
    func carPreBooking(response : CarPreBookingMode)
}

class CarPreBookingVM {

    var view: CarPreBookingVMDelegate!
    init(_ view: CarPreBookingVMDelegate) {
        self.view = view
    }
    
    
    func CALL_CAR_PRE_BOOKING_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

        self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.car_pre_booking,parameters: parms, resultType: CarPreBookingMode.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.carPreBooking(response: response)
                } else {
                   
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    


    
    
   
}
