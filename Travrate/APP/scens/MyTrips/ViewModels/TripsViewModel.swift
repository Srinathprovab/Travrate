//
//  TripsViewModel.swift
//  Travrate
//
//  Created by Admin on 03/08/24.
//

import Foundation

protocol TripsViewModelDelegate : BaseViewModelProtocol {
    func flightTripsResponse(response : FlightsTripsModel)
    func hotelTripsResponse(response : HotelTripsModel)
    func sportsTripsResponse(response : SportsTripModel)
    func activitiesTripsResponse(response : ActivitiesTripsModel)
    func carrentalTripsResponse(response : CarRentalTripsModel)
    
}

class TripsViewModel {
    
    var view: TripsViewModelDelegate!
    init(_ view: TripsViewModelDelegate) {
        self.view = view
    }
    
    //MARK: - CALL_GET_FLIGHT_TRIPS_API
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
    
    
    
    //MARK: - CALL_GET_HOTEL_TRIPS_API
    func CALL_GET_HOTEL_TRIPS_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.report_hotel,parameters: parms, resultType: HotelTripsModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.hotelTripsResponse(response: response)
                } else {
                    
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    //MARK: - CALL_GET_SPORTS_TRIPS_API
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
    
    
    
    //MARK: - CALL_GET_ACTIVITIES_TRIPS_API
    func CALL_GET_ACTIVITIES_TRIPS_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.report_activities,parameters: parms, resultType: ActivitiesTripsModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.activitiesTripsResponse(response: response)
                } else {
                    
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    //MARK: - CALL_GET_CARRENTAL_TRIPS_API
    func CALL_GET_CARRENTAL_TRIPS_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.report_car,parameters: parms, resultType: CarRentalTripsModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.carrentalTripsResponse(response: response)
                } else {
                    
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
}
