//
//  HolidayListVM.swift
//  Travrate
//
//  Created by FCI on 17/05/24.
//

import Foundation


protocol HolidayListVMDelegate : BaseViewModelProtocol {
    func holidayListResponse(response : HolidayListModel)

}

class HolidayListVM {

    var view: HolidayListVMDelegate!
    init(_ view: HolidayListVMDelegate) {
        self.view = view
    }


    func CALL_GET_HOLIDAY_LIST_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

        self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.holiday , parameters: parms, resultType: HolidayListModel.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.holidayListResponse(response: response)
                } else {
                   
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }

}
