//
//  SportsBookingVM.swift
//  Travrate
//
//  Created by FCI on 28/05/24.
//

import Foundation

protocol SportsBookingVMDelegate : BaseViewModelProtocol {
    func sportBookingDetails(response : SportsBookingModel)
   
}

class SportsBookingVM {

    var view: SportsBookingVMDelegate!
    init(_ view: SportsBookingVMDelegate) {
        self.view = view
    }
    
    
    func CALL_SPORTS_PRE_BOOKING_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

        self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.sport_pre_booking,parameters: parms, resultType: SportsBookingModel.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.sportBookingDetails(response: response)
                } else {
                   
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    

   
}
