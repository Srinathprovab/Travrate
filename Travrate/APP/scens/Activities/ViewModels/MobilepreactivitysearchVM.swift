//
//  MobilepreactivitysearchVM.swift
//  Travrate
//
//  Created by Admin on 17/07/24.
//

import Foundation

protocol MobilepreactivitysearchVMDelegate : BaseViewModelProtocol {
    func preSearchResponse(response : MobilepreactivitysearchModel)
    func activitylistResponse(response : ActivitesListModel)
}

class MobilepreactivitysearchVM {
    
    var view: MobilepreactivitysearchVMDelegate!
    init(_ view: MobilepreactivitysearchVMDelegate) {
        self.view = view
    }
    
    
    func CALL_MOBILE_PRE_ACTIVITES_SEARCH_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
      //  self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.general_mobile_pre_activity_search , urlParams: parms as? Dictionary<String, String>, parameters: parms, resultType: MobilepreactivitysearchModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.preSearchResponse(response: response)
                } else {
                    
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    func CALL_ACTIVITES_SERCH_API(dictParam: [String: Any],urlstr:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        BASE_URL = ""
      //  self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: urlstr , urlParams: parms as? Dictionary<String, String>, parameters: parms, resultType: ActivitesListModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    BASE_URL = BASE_URL1
                    self.view.activitylistResponse(response: response)
                } else {
                    
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
}
