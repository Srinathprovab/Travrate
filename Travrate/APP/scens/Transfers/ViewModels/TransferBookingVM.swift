//
//  TransferBookingVM.swift
//  Travrate
//
//  Created by Admin on 15/07/24.
//

import Foundation

protocol TransferBookingVMDelegate : BaseViewModelProtocol {
    func bookingResponse(response : TransferBookingModel)
    func prePaymentConformationResponse(response : TransferPrePaymentConfModel)
    func preSendtoPaymentResponse(response : TransferPrePaymentConfModel)
    func transfersSecurebookingDetails(response : SendToPaymentModel)
}

class TransferBookingVM {
    
    var view: TransferBookingVMDelegate!
    init(_ view: TransferBookingVMDelegate) {
        self.view = view
    }
    
    
    func CALL_BOOKING_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.transfers_booking,parameters: parms, resultType: TransferBookingModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.bookingResponse(response: response)
                } else {
                    
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    func CALL_PRE_PAYMENT_CONFORMATION_API(dictParam: [String: Any],urlstr:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        BASE_URL = ""
        self.view?.showLoader()
        
        print(urlstr)
        
        
        ServiceManager.getApiCall(endPoint: urlstr,urlParams: parms as? Dictionary<String, String> ,parameters: parms as NSDictionary, resultType: TransferPrePaymentConfModel.self, p:dictParam){ sucess, result, errorMessage in
        
      //  ServiceManager.getApiCallForJson(endPoint: urlString,parameters: parms, resultType: TransferPrePaymentConfModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    BASE_URL = BASE_URL1
                    self.view.prePaymentConformationResponse(response: response)
                } else {
                    
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    func CALL_PRE_SENDTO_PAYMENT__API(dictParam: [String: Any],urlstr:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        BASE_URL = ""
        self.view?.showLoader()
        
        ServiceManager.getApiCall(endPoint: urlstr,urlParams: parms as? Dictionary<String, String> ,parameters: parms as NSDictionary, resultType: TransferPrePaymentConfModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    
                    guard let response = result else {return}
                    BASE_URL = BASE_URL1
                    self.view.preSendtoPaymentResponse(response: response)
                } else {
                    
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    func CALL_TRANSFERS_SECURE_BOOKING_API(dictParam: [String: Any],urlstr:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        BASE_URL = ""
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: urlstr,parameters: parms as NSDictionary, resultType: SendToPaymentModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    
                    guard let response = result else {return}
                    BASE_URL = BASE_URL1
                    self.view.transfersSecurebookingDetails(response: response)
                } else {
                    
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
}
