//
//  VocherDetailsViewModel.swift
//  BabSafar
//
//  Created by FCI on 26/12/22.
//

import Foundation

protocol VocherDetailsViewModelDelegate : BaseViewModelProtocol {
    func vocherdetails(response:VocherModel)
    func sportsvoucherDetails(response:SportsVoucherModel)
    func carrentalVoucherDetails(response:CarVoucherModel)
    func activitiesVoucherDetails(response:ActivitiesVoucherModel)
}

class VocherDetailsViewModel {
    
    var view: VocherDetailsViewModelDelegate!
    init(_ view: VocherDetailsViewModelDelegate) {
        self.view = view
    }
    
    
    //MARK: -  Get voucher Details API
    func Call_Get_voucher_Details_API(dictParam: [String: Any],url:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: url , parameters: parms, resultType: VocherModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.vocherdetails(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    //MARK: -  CALL_GET_SPORTS_VOUCHER_DETAILS_API
    func CALL_GET_SPORTS_VOUCHER_DETAILS_API(dictParam: [String: Any],url:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: url , parameters: parms, resultType: SportsVoucherModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.sportsvoucherDetails(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    //MARK: -  CALL_CAR_RENTAL_VOUCHER_API
    func CALL_CAR_RENTAL_VOUCHER_API(dictParam: [String: Any],url:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        BASE_URL = ""
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: url , parameters: parms, resultType: CarVoucherModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    BASE_URL = BASE_URL1
                    self.view.carrentalVoucherDetails(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    //MARK: -  CALL_CAR_RENTAL_VOUCHER_API
    func CALL_ACTIVITIES_VOUCHER_API(dictParam: [String: Any],url:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        BASE_URL = ""
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: url , parameters: parms, resultType: ActivitiesVoucherModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    BASE_URL = BASE_URL1
                    self.view.activitiesVoucherDetails(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
}
