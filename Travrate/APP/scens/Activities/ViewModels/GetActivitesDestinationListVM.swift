//
//  GetActivitesDestinationListVM.swift
//  Travrate
//
//  Created by Admin on 17/07/24.
//

import Foundation


protocol GetActivitesDestinationListVMDelegate : BaseViewModelProtocol {
    func destinationCityList(response : [GetActivitesDestinationListModel])
}

class GetActivitesDestinationListVM {
    
    var view: GetActivitesDestinationListVMDelegate!
    init(_ view: GetActivitesDestinationListVMDelegate) {
        self.view = view
    }
    
    
    func CALL_GET_ACTIVITES_DESTINATION_LIST_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
      //  self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.ajax_get_activity_destination_list , urlParams: parms as? Dictionary<String, String>, parameters: parms, resultType: [GetActivitesDestinationListModel].self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
            //    self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.destinationCityList(response: response)
                } else {
                    // Show alert
                    //  print("error === \(errorMessage ?? "")")
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
}
