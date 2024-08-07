//
//  FlightTrips.swift
//  Travrate
//
//  Created by Admin on 21/07/24.
//

import Foundation


extension BookingsVC {
    
    //MARK: - callFlightUpcomingAPI
    func callFlightUpcomingAPI() {
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid)
        trips?.CALL_GET_FLIGHT_TRIPS_API(dictParam: MySingleton.shared.payload)
    }
    
    func flightTripsResponse(response: FlightsTripsModel) {
        basicloderBool = false
        DispatchQueue.main.async {
            self.setupFlightUpcomingTVCells(res:  response.completed?.booking_details ?? [])
        }
    }
    
    
    func setupFlightUpcomingTVCells(res:[Flight_trips_Booking_details]) {
        MySingleton.shared.tablerow.removeAll()
        
        if res[0].booking_itinerary_details?.count ?? 0 > 0 {
            TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
            MySingleton.shared.tablerow.append(TableRow(moreData:res,cellType:.FlightTripsTVCell))
        }else {
            TableViewHelper.EmptyMessage(message: "No data found", tableview: commonTableView, vc: self)
        }
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
    //MARK: - callFlightCompletedTVCells
    func callFlightCompletedTVCells(){
        setupFlightCompletedTVCells()
    }
    
    func setupFlightCompletedTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        TableViewHelper.EmptyMessage(message: "No data found", tableview: commonTableView, vc: self)
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
    
    //MARK: - callFlightCancelledTVCells
    func callFlightCancelledTVCells(){
        setupFlightCancelledTVCells()
    }
    
    
    func setupFlightCancelledTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        TableViewHelper.EmptyMessage(message: "No data found", tableview: commonTableView, vc: self)
        
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
}
