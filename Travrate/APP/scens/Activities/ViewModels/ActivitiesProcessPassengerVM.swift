//
//  ActivitiesProcessPassengerVM.swift
//  Travrate
//
//  Created by Admin on 19/07/24.
//

import Foundation

protocol ActivitiesProcessPassengerVMDelegate : BaseViewModelProtocol {
    func processPassengerDetailsResponse(response : sportssecureBooingModel)
    func activitieSendToPaymeentDetailsResponse(response : SendToPaymentModel)
    func activitiesSecureBookingDetails(response : SendToPaymentModel)
}

class ActivitiesProcessPassengerVM {
    
    var view: ActivitiesProcessPassengerVMDelegate!
    init(_ view: ActivitiesProcessPassengerVMDelegate) {
        self.view = view
    }
    
    
    
    func CALL_PROCESS_PASSENGER_DETAILS_BOOKING_API(dictParam: [String: Any],urlstr:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        BASE_URL = ""
       self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: urlstr , parameters: parms, resultType: sportssecureBooingModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    BASE_URL = BASE_URL1
                    self.view.processPassengerDetailsResponse(response: response)
                } else {
                    // Show alert
                    //  print("error === \(errorMessage ?? "")")
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    func CALL_SEND_TO_PAYMENT_API(dictParam: [String: Any],urlstr:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        BASE_URL = ""
       self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: urlstr , parameters: parms, resultType: SendToPaymentModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    BASE_URL = BASE_URL1
                    self.view.activitieSendToPaymeentDetailsResponse(response: response)
                } else {
                    // Show alert
                    //  print("error === \(errorMessage ?? "")")
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    func CALL_ACTIVITIES_SECURE_BOOKING_API(dictParam: [String: Any],urlstr:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        BASE_URL = ""
       self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: urlstr , parameters: parms, resultType: SendToPaymentModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    BASE_URL = BASE_URL1
                    self.view.activitiesSecureBookingDetails(response: response)
                } else {
                    // Show alert
                    //  print("error === \(errorMessage ?? "")")
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
}
