//
//  ActivitiesPreProcessBookingVM.swift
//  Travrate
//
//  Created by Admin on 18/07/24.
//

import Foundation


protocol ActivitiesPreProcessBookingVMDelegate : BaseViewModelProtocol {
    func preBookingResponse(response : ActivitiesPreProcessBookingModel)
    func bookingResponse(response : ActivitiesBookingModel)
}

class ActivitiesPreProcessBookingVM {
    
    var view: ActivitiesPreProcessBookingVMDelegate!
    init(_ view: ActivitiesPreProcessBookingVMDelegate) {
        self.view = view
    }
    
    
    func CALL_PRE_PROCESS_BOOKING_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
       self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: "\(ApiEndpoints.activity_pre_process_booking)/\(MySingleton.shared.activites_searchid)" , parameters: parms, resultType: ActivitiesPreProcessBookingModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.preBookingResponse(response: response)
                } else {
                    // Show alert
                    //  print("error === \(errorMessage ?? "")")
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    func CALL_BOOKING_API(dictParam: [String: Any],urlstr:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        BASE_URL = ""
       self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: urlstr , parameters: parms, resultType: ActivitiesBookingModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    BASE_URL = BASE_URL1
                    self.view.bookingResponse(response: response)
                } else {
                    // Show alert
                    //  print("error === \(errorMessage ?? "")")
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    
}
