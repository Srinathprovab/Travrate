//
//  HotelDetailsViewModel.swift
//  TravgateApp
//
//  Created by FCI on 09/02/24.
//

import Foundation
protocol HotelDetailsViewModelDelegate : BaseViewModelProtocol {
    func hotelDetails(response : HotelSelectedDetailsModel)
}

class HotelDetailsViewModel {
    
    var view: HotelDetailsViewModelDelegate!
    init(_ view: HotelDetailsViewModelDelegate) {
        self.view = view
    }
    
    //MARK: - CALL_HOTEL_DETAILS_API
    func CALL_HOTEL_DETAILS_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: "hotel/\(ApiEndpoints.hotelmobiledetails)",urlParams: parms as? Dictionary<String, String> , parameters: parms as NSDictionary, resultType: HotelSelectedDetailsModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.hotelDetails(response: response)
                } else {
                    // Show alert
                    print("error = \(errorMessage ?? "")")
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
}
