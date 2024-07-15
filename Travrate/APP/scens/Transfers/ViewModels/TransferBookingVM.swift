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
        
        ServiceManager.postOrPutApiCall(endPoint: urlString,parameters: parms, resultType: TransferPrePaymentConfModel.self, p:dictParam) { sucess, result, errorMessage in
            
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
        
        ServiceManager.postOrPutApiCall(endPoint: urlString,parameters: parms, resultType: TransferPrePaymentConfModel.self, p:dictParam) { sucess, result, errorMessage in
            
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
    
    
    
    
}
