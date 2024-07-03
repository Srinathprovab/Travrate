//
//  ShareResultViewModel.swift
//  Travrate
//
//  Created by Admin on 25/06/24.
//

import Foundation

protocol ShareResultViewModelDelegate : BaseViewModelProtocol {
    func sahreResultResponse(response:LoginModel)
    func sahreHotelResultResponse(response:LoginModel)
}

class ShareResultViewModel {
    
    var view: ShareResultViewModelDelegate!
    init(_ view: ShareResultViewModelDelegate) {
        self.view = view
    }
    
    
    //MARK:  CALL_SHARE_RESULT_API
    func CALL_SHARE_RESULT_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
       // self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.ajax_share_itinerary,parameters: parms, resultType: LoginModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
              //  self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.sahreResultResponse(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    //MARK:  CALL_SHARE_RESULT_API
    func CALL_Hotel_SHARE_RESULT_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
       // self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.ajax_share_itinerary_hotel,parameters: parms, resultType: LoginModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
              //  self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.sahreHotelResultResponse(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }

    
}
