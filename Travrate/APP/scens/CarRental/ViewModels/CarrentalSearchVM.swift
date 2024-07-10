//
//  CarrentalSearchVM.swift
//  Travrate
//
//  Created by Admin on 10/07/24.
//

import Foundation


protocol CarrentalSearchVMDelegate : BaseViewModelProtocol {
    func carrentalPreserachRespons(response : CarrentalPreSearchModel)
    func carrentalserachRespons(response : CarSearchModel)
    func carListRespons(response : CarListModel)
}

class CarrentalSearchVM {
    
    var view: CarrentalSearchVMDelegate!
    init(_ view: CarrentalSearchVMDelegate) {
        self.view = view
    }
    
    
    func CALL_PRE_CAR_SEARCH_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: "\(ApiEndpoints.general_pre_car_search)",urlParams: parms as? Dictionary<String, String>, parameters: parms, resultType: CarrentalPreSearchModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.carrentalPreserachRespons(response: response)
                } else {
                    
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    func CALL_CAR_SEARCH_API(dictParam: [String: Any],url:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        BASE_URL = ""
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: url, parameters: parms, resultType: CarSearchModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    BASE_URL = BASE_URL1
                    self.view.carrentalserachRespons(response: response)
                } else {
                    
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    func CALL_CAR_LIST_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.car_car_list,urlParams: parms as? Dictionary<String, String>, parameters: parms, resultType: CarListModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.carListRespons(response: response)
                } else {
                    
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
}
