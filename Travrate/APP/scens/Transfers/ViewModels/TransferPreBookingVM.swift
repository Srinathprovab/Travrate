//
//  TransferPreBookingVM.swift
//  Travrate
//
//  Created by Admin on 13/07/24.
//

import Foundation


protocol TransferPreBookingVMDelegate : BaseViewModelProtocol {
    func preBookingResponse(response : TransferPreBookingModel)
}

class TransferPreBookingVM {

    var view: TransferPreBookingVMDelegate!
    init(_ view: TransferPreBookingVMDelegate) {
        self.view = view
    }
    
    
    func CALL_PRE_BOOKING_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

        self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.transfers_pre_booking,parameters: parms, resultType: TransferPreBookingModel.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.preBookingResponse(response: response)
                } else {
                   
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    


    
    
   
}
