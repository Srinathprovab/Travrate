//
//  SportDetailsVM.swift
//  Travrate
//
//  Created by FCI on 28/05/24.
//

import Foundation

protocol SportDetailsVMDelegate : BaseViewModelProtocol {
    func sportDetails(response : SportsDetailsModel)
   
}

class SportDetailsVM {

    var view: SportDetailsVMDelegate!
    init(_ view: SportDetailsVMDelegate) {
        self.view = view
    }
    
    
    func CALL_SPORTS_DETAILS_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

        self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.sport_pre_sport_tickets,parameters: parms, resultType: SportsDetailsModel.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.sportDetails(response: response)
                } else {
                   
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    

   
}
