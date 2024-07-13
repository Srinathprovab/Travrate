//
//  GetTransferCityVM.swift
//  Travrate
//
//  Created by Admin on 13/07/24.
//

import Foundation


protocol GetTransferCityVMDelegate : BaseViewModelProtocol {
    func transferCitylist(response : [GetTransferCityModel])
}

class GetTransferCityVM {

    var view: GetTransferCityVMDelegate!
    init(_ view: GetTransferCityVMDelegate) {
        self.view = view
    }
    
    
    func CALL_GET_CITY_LIST_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

        self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: "\(ApiEndpoints.transfers_get_location_list)",urlParams: parms as? Dictionary<String, String>, parameters: parms, resultType: [GetTransferCityModel].self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.transferCitylist(response: response)
                } else {
                   
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    


    
    
   
}
