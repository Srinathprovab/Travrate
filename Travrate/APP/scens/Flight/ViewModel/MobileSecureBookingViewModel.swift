//
//  MobileSecureBookingViewModel.swift
//  TravgateApp
//
//  Created by FCI on 10/01/24.
//

import Foundation
protocol MobileSecureBookingViewModelDelegate : BaseViewModelProtocol {
    func getHandelResponseDetails(response:updatePaymentFlightModel)
    func mobilesecurebookingDetails(response:MobilePrePaymentModel)
}

class MobileSecureBookingViewModel {
    
    var view: MobileSecureBookingViewModelDelegate!
    init(_ view: MobileSecureBookingViewModelDelegate) {
        self.view = view
    }
    
    
    
    
    //MARK:  mobile_secure_booking API
    func CALL_GET_HANDEL_RESPONSE_API(dictParam: [String: Any],url:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        BASE_URL = ""
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: url , parameters: parms, resultType: updatePaymentFlightModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    BASE_URL = BASE_URL1
                    self.view.getHandelResponseDetails(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    //MARK:  mobile_secure_booking API
    func Call_mobile_secure_booking_API(dictParam: [String: Any],url:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        BASE_URL = ""
        ServiceManager.postOrPutApiCall(endPoint: url , parameters: parms, resultType: MobilePrePaymentModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    BASE_URL = BASE_URL1
                    self.view.mobilesecurebookingDetails(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }

    
}
