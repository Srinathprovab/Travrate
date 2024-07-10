//
//  PickuplocationListVM.swift
//  Travrate
//
//  Created by Admin on 09/07/24.
//

import Foundation


protocol PickuplocationListVMDelegate : BaseViewModelProtocol {
    func locationListResponse(response : [PickuplocationListModel])
}

class PickuplocationListVM {

    var view: PickuplocationListVMDelegate!
    init(_ view: PickuplocationListVMDelegate) {
        self.view = view
    }
    
    
    func CALL_PICKUP_LOCATION_LIST_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

        self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: "\(ApiEndpoints.ajax_get_car_rental_city_list)",urlParams: parms as? Dictionary<String, String>, parameters: parms, resultType: [PickuplocationListModel].self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.locationListResponse(response: response)
                } else {
                   
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    


    
    
   
}
