//
//  CarBookingVM.swift
//  Travrate
//
//  Created by Admin on 12/07/24.
//

import Foundation


protocol CarBookingVMDelegate : BaseViewModelProtocol {
    func carBookingdetails(response : CarSecureBookingMode)
    func carPrePaymentDetails(response : carPrePaymrntConfirmationModel)
    func carSendtoPaymentDetails(response : CarSecureBookingMode)
    func carSecureBookingDetails(response : CarSecureBookingMode)
}

class CarBookingVM {
    
    var view: CarBookingVMDelegate!
    init(_ view: CarBookingVMDelegate) {
        self.view = view
    }
    
    
    func CALL_CAR_BOOKING_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.car_booking,parameters: parms, resultType: CarSecureBookingMode.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.carBookingdetails(response: response)
                } else {
                    
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    func CALL_CAR_PRE_PAYMENT_BOOKING_API(dictParam: [String: Any],urlstr:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        BASE_URL = ""
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: urlstr, urlParams: parms as? Dictionary<String, String>,resultType: carPrePaymrntConfirmationModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    BASE_URL = BASE_URL1
                    self.view.carPrePaymentDetails(response: response)
                } else {
                    
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    func CALL_CAR_SEND_TO_PAYMENT_API(dictParam: [String: Any],urlstr:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        BASE_URL = ""
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: urlstr, resultType: CarSecureBookingMode.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    BASE_URL = BASE_URL1
                    self.view.carSendtoPaymentDetails(response: response)
                } else {
                    
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    func CALL_CAR_SECURE_BOOKING_API(dictParam: [String: Any],urlstr:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        BASE_URL = ""
        self.view?.showLoader()
        
        //        ServiceManager.postOrPutApiCall(endPoint: urlstr,urlParams: parms as? Dictionary<String, String>, resultType: CarSecureBookingMode.self, p:dictParam) { sucess, result, errorMessage in
        //
        ServiceManager.postOrPutApiCall(endPoint: urlstr,urlParams: parms as? Dictionary<String, String> ,parameters: parms as NSDictionary, resultType: CarSecureBookingMode.self, p:dictParam){ sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    BASE_URL = BASE_URL1
                    self.view.carSecureBookingDetails(response: response)
                } else {
                    
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
}
