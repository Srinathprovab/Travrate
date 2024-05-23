//
//  HolidaySelectedVM.swift
//  Travrate
//
//  Created by FCI on 17/05/24.
//

import Foundation
protocol HolidaySelectedVMDelegate : BaseViewModelProtocol {
    func holidaySelectedResponse(response : HolidaySelectedModel)
    func holidayEnquireySucesse(response : HolidayEnquireyModel)
    func otpRequestResponse(response : OTPSucessModel)
}

class HolidaySelectedVM {

    var view: HolidaySelectedVMDelegate!
    init(_ view: HolidaySelectedVMDelegate) {
        self.view = view
    }


    func CALL_GET_SELECTED_HOLIDAY_LIST_API(dictParam: [String: Any],key:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

        self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: "\(ApiEndpoints.holiday_more_info)/\(key)" ,urlParams: parms as? Dictionary<String, String> , parameters: parms, resultType: HolidaySelectedModel.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.holidaySelectedResponse(response: response)
                } else {
                   
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    func CALL_SEND_OTP_REQUEST_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

       // self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.holiday_send_otp_for_special_offer, parameters: parms, resultType: OTPSucessModel.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
               // self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.otpRequestResponse(response: response)
                } else {
                   
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    func CALL_HOLIDAY_ENQUIREY_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

       // self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.holiday_holiday_requests, parameters: parms, resultType: HolidayEnquireyModel.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
               // self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.holidayEnquireySucesse(response: response)
                } else {
                   
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    

}
