//
//  SportsPaymentViewModel.swift
//  Travrate
//
//  Created by Admin on 08/07/24.
//

import Foundation

protocol SportsPaymentViewModelDelegate : BaseViewModelProtocol {
    func sportsPreBookingDetails(response : SportsPreBookingModel)
    func sportsprepaymentDetails(response : SportsPrePaymentConfirmationModel)
    func sendtopaymentDetails(response : SportsSndtopaymentModel)
    func getPaymentgatewayUrlDetails(response : getPaymentgatewayUrlModel)
    func secureBookingDetails(response : sportssecureBooingModel)
}

class SportsPaymentViewModel {
    
    var view: SportsPaymentViewModelDelegate!
    init(_ view: SportsPaymentViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_SPORTS_PRE_BOOKING_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.sport_sent_to_payment_pre,parameters: parms, resultType: SportsPreBookingModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.sportsPreBookingDetails(response: response)
                } else {
                    
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    func CALL_SPORTS_PAYMENT_CONFIRMATION_API(dictParam: [String: Any],url:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        BASE_URL = ""
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: url,parameters: parms, resultType: SportsPrePaymentConfirmationModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    BASE_URL = BASE_URL1
                    self.view.sportsprepaymentDetails(response: response)
                } else {
                    
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    func CALL_SEND_TO_PAYMENT_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.sport_send_to_payment,parameters: parms, resultType: SportsSndtopaymentModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.sendtopaymentDetails(response: response)
                } else {
                    
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
 //   CALL_GET_SPORT_PAYMENT_GATEWAY_URL_API
    func CALL_GET_SPORT_PAYMENT_GATEWAY_URL_API(dictParam: [String: Any],url:String){
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
                    self.view.getPaymentgatewayUrlDetails(response: response)
                } else {
                    // Show alert
                    print("error = \(errorMessage ?? "")")
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    func CALL_SECURE_BOOKING_API(dictParam: [String: Any],url:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        BASE_URL = ""
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: url,parameters: parms as NSDictionary, resultType: sportssecureBooingModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    BASE_URL = BASE_URL1
                    self.view.secureBookingDetails(response: response)
                } else {
                    // Show alert
                    print("error = \(errorMessage ?? "")")
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
}
