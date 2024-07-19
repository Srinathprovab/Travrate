//
//  ActivitiesPreProcessBookingVM.swift
//  Travrate
//
//  Created by Admin on 18/07/24.
//

import Foundation


protocol ActivitiesPreProcessBookingVMDelegate : BaseViewModelProtocol {
    func preBookingResponse(response : ActivitiesPreProcessBookingModel)
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
        
        ServiceManager.getApiCall(endPoint: "\(ApiEndpoints.activity_activity_detail)/\(MySingleton.shared.activites_searchid)" , parameters: parms, resultType: ActivitiesPreProcessBookingModel.self, p:dictParam) { sucess, result, errorMessage in
            
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
    
    
}
