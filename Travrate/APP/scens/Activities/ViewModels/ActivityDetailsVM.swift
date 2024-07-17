//
//  ActivityDetailsVM.swift
//  Travrate
//
//  Created by Admin on 17/07/24.
//

import Foundation


protocol ActivityDetailsVMDelagate : BaseViewModelProtocol {
    func activitesDetailsResponse(response : ActivityDetailsModel)
}

class ActivityDetailsVM {
    
    var view: ActivityDetailsVMDelagate!
    init(_ view: ActivityDetailsVMDelagate) {
        self.view = view
    }
    
    
    func CALL_GET_ACTIVITES_DETAILS_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
       self.view?.showLoader()
        
        ServiceManager.getApiCall(endPoint: "\(ApiEndpoints.activity_activity_detail)/\(MySingleton.shared.activites_searchid)" , urlParams: parms as? Dictionary<String, String>, parameters: parms, resultType: ActivityDetailsModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.activitesDetailsResponse(response: response)
                } else {
                    // Show alert
                    //  print("error === \(errorMessage ?? "")")
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
}
