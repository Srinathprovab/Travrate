//
//  CarDetailsVM.swift
//  Travrate
//
//  Created by Admin on 11/07/24.
//

import Foundation

protocol CarDetailsVMDelegate : BaseViewModelProtocol {
    func cardeatils(response : CarDetailsModel)
}

class CarDetailsVM {

    var view: CarDetailsVMDelegate!
    init(_ view: CarDetailsVMDelegate) {
        self.view = view
    }
    
    
    func CALL_SELECT_YOUR_PACKAGE_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

        self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.car_detials,parameters: parms, resultType: CarDetailsModel.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.cardeatils(response: response)
                } else {
                   
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    


    
    
   
}
