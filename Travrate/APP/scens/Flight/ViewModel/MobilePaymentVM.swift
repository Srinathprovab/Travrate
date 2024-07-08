//
//  MobilePaymentVM.swift
//  Travgate
//
//  Created by FCI on 29/04/24.
//

import Foundation
protocol MobilePaymentVMDelegate : BaseViewModelProtocol {
    func mobolePaymentDetails(response:PaymentModel)
    func mibileSendToPaymentDetails(response:MobilePassengerdetailsModel)
    func flightgetPaymentgatewayUrlDetails(response:getPaymentgatewayUrlModel)
}

class MobilePaymentVM {
    
    var view: MobilePaymentVMDelegate!
    init(_ view: MobilePaymentVMDelegate) {
        self.view = view
    }
    
    
    //MARK:  CALL_MOBILE_PAYMENT_API
    func CALL_MOBILE_PRE_PAYMENT_API(dictParam: [String: Any],url:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
       
      //  self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.flight_mobile_pre_payment_confirmation , parameters: parms, resultType: PaymentModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                
                if sucess {
                    guard let response = result else {return}
                    self.view.mobolePaymentDetails(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    //MARK:  CALL_MOBILE_PAYMENT_API
    func CALL_SEND_TO_PAYMENT_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
       
      //  self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.flight_mobile_send_to_payment , parameters: parms, resultType: MobilePassengerdetailsModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                
                if sucess {
                    guard let response = result else {return}
                    self.view.mibileSendToPaymentDetails(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    func CALL_FLIGHT_GET_PAYMENT_GATEWAY_URL_API(dictParam: [String: Any],url:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        BASE_URL = ""
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: url,parameters: parms as NSDictionary, resultType: getPaymentgatewayUrlModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    BASE_URL = BASE_URL1
                    self.view.flightgetPaymentgatewayUrlDetails(response: response)
                } else {
                    // Show alert
                    print("error = \(errorMessage ?? "")")
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
}
