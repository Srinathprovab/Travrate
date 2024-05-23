//
//  SportListVM.swift
//  Travrate
//
//  Created by FCI on 21/05/24.
//

import Foundation

protocol SportListVMDelegate : BaseViewModelProtocol {
    func sportPreSearchResponse(response : LoginModel)
    func sportListResponse(response : SportListModel)
}

class SportListVM {

    var view: SportListVMDelegate!
    init(_ view: SportListVMDelegate) {
        self.view = view
    }
    
    
    func CALL_GET_PRE_SPORTS_SEARCH_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

        self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: "\(ApiEndpoints.general_pre_sports_search)",urlParams: parms as? Dictionary<String, String>, parameters: parms, resultType: LoginModel.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.sportPreSearchResponse(response: response)
                } else {
                   
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    


    func CALL_GET_SPORTS_SEARCH_API(dictParam: [String: Any],searchid:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

        self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: "\(ApiEndpoints.sport_api_sport_search)/\(searchid)", urlParams: parms as? Dictionary<String, String>,parameters: parms, resultType: SportListModel.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.sportListResponse(response: response)
                } else {
                   
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
   
}
