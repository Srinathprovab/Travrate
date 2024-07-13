//
//  PreTransfersearchVM.swift
//  Travrate
//
//  Created by Admin on 13/07/24.
//

import Foundation

protocol PreTransfersearchVMDelegate : BaseViewModelProtocol {
    func pretransfersearchDetails(response : PreTransfersearchModel)
    func transfersearchDetails(response : TransferSearchMode)
    func transferslistDetails(response : TransferListModel)
}

class PreTransfersearchVM {
    
    var view: PreTransfersearchVMDelegate!
    init(_ view: PreTransfersearchVMDelegate) {
        self.view = view
    }
    
    
    func CALL_PRE_TRANSFER_SERACH_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.general_pre_transfer_search ,urlParams: parms as? Dictionary<String, String>, parameters: parms, resultType: PreTransfersearchModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.pretransfersearchDetails(response: response)
                } else {
                    
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    func CALL_TRANSFER_SERACH_API(dictParam: [String: Any],url:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        BASE_URL = ""
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: url ,urlParams: parms as? Dictionary<String, String>, parameters: parms, resultType: TransferSearchMode.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    BASE_URL = BASE_URL1
                    self.view.transfersearchDetails(response: response)
                } else {
                    
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    func CALL_TRANSFER_LIST_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.transfers_transfer_list ,urlParams: parms as? Dictionary<String, String>, parameters: parms, resultType: TransferListModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.transferslistDetails(response: response)
                } else {
                    
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
}
