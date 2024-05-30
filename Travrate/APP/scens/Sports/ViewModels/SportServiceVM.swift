//
//  SportServiceVM.swift
//  Travrate
//
//  Created by FCI on 20/05/24.
//

import Foundation
protocol SportServiceVMDelegate : BaseViewModelProtocol {
    func sportServiceList(response : SportsServiceModel)
}

class SportServiceVM {

    var view: SportServiceVMDelegate!
    init(_ view: SportServiceVMDelegate) {
        self.view = view
    }


    func CALL_GET_SPORTS_CITY_LIST_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

       // self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.general_get_sport_type ,urlParams: parms as? Dictionary<String, String>, parameters: parms, resultType: SportsServiceModel.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
              //  self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.sportServiceList(response: response)
                } else {
                   
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    func CALL_GET_SPORTS_EVENT_LIST_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

       // self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.general_get_sport_event_list ,urlParams: parms as? Dictionary<String, String>, parameters: parms, resultType: SportsServiceModel.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
              //  self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.sportServiceList(response: response)
                } else {
                   
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    func CALL_GET_SPORTS_TYPE_LIST_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

       // self.view?.showLoader() general_get_sport_city_list   general_get_sport_type

        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.general_get_sport_city_list,urlParams: parms as? Dictionary<String, String> ,parameters: parms, resultType: SportsServiceModel.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
              //  self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.sportServiceList(response: response)
                } else {
                   
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }

}
