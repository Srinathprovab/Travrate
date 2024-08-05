//
//  TripsViewModel.swift
//  Travrate
//
//  Created by Admin on 03/08/24.
//

import Foundation

protocol TripsViewModelDelegate : BaseViewModelProtocol {
    func flightTripsResponse(response : FlightsTripsModel)
    func sportsTripsResponse(response : SportsTripModel)
    
}

class TripsViewModel {
    
    var view: TripsViewModelDelegate!
    init(_ view: TripsViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_GET_FLIGHT_TRIPS_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.report_flight,parameters: parms, resultType: FlightsTripsModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.flightTripsResponse(response: response)
                } else {
                    
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    func CALL_GET_SPORTS_TRIPS_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.report_sports,parameters: parms, resultType: SportsTripModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.sportsTripsResponse(response: response)
                } else {
                    
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
}
