//
//  SportsViewVoucherVM.swift
//  Travrate
//
//  Created by Admin on 10/07/24.
//

import Foundation

protocol SportsViewVoucherVMDelegate : BaseViewModelProtocol {
    func voucherDetails(response : SportsVoucherModel)
}

class SportsViewVoucherVM {
    
    var view: SportsViewVoucherVMDelegate!
    init(_ view: SportsViewVoucherVMDelegate) {
        self.view = view
    }
    
    
    func CALL_SPORT_VOUCHER_API(dictParam: [String: Any],url:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        BASE_URL = ""
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: url,parameters: parms as NSDictionary, resultType: SportsVoucherModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    BASE_URL = BASE_URL1
                    self.view.voucherDetails(response: response)
                } else {
                    // Show alert
                    print("error = \(errorMessage ?? "")")
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
}
