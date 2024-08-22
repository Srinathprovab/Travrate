//
//  FlightTrips.swift
//  Travrate
//
//  Created by Admin on 21/07/24.
//

import Foundation




extension BookingsVC {
    
    func callFlightBookingsAPI() {
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid)
        
        DispatchQueue.main.async {
            self.trips?.CALL_GET_FLIGHT_TRIPS_API(dictParam: MySingleton.shared.payload)
        }
    }
    
    
    func flightTripsResponse(response: FlightsTripsModel) {
        basicloderBool = false
        
        upcommingbookings = response.upcoming_booking ?? [[]]
        completedbookings = response.completed_booking ?? [[]]
        cancelledbookings = response.cancelled_booking ?? [[]]
        
        
        DispatchQueue.main.async {[self] in
            if tripsBtnTap == "upcoming" {
                setupFlightUpcomingTVCells(res: upcommingbookings)
            }else  if tripsBtnTap == "completed" {
                callFlightCompletedTVCells(res: completedbookings)
            }else {
                setupFlightCancelledTVCells(res: cancelledbookings)
            }
            
        }
    
    }
    
}


extension BookingsVC {
    
    func setupFlightUpcomingTVCells(res:[[Booking]]) {
        MySingleton.shared.tablerow.removeAll()
        
        if res.count > 0 {
            res.forEach { i in
                TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
                MySingleton.shared.tablerow.append(TableRow(moreData:i,cellType:.FlightTripsTVCell))
            }
        }else {
            TableViewHelper.EmptyMessage(message: "No data found", tableview: commonTableView, vc: self)
        }
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
    //MARK: - callFlightCompletedTVCells
    func callFlightCompletedTVCells(res:[[Booking]]) {
        MySingleton.shared.tablerow.removeAll()
        
        if res.count > 0 {
            res.forEach { i in
                TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
                MySingleton.shared.tablerow.append(TableRow(moreData:i,cellType:.FlightTripsTVCell))
            }
        }else {
            TableViewHelper.EmptyMessage(message: "No data found", tableview: commonTableView, vc: self)
        }
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    //MARK: - setupFlightCancelledTVCells
    func setupFlightCancelledTVCells(res:[[Booking]]) {
        MySingleton.shared.tablerow.removeAll()
        
        if res.count > 0 {
            res.forEach { i in
                TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
                MySingleton.shared.tablerow.append(TableRow(moreData:i,cellType:.FlightTripsTVCell))
            }
        }else {
            TableViewHelper.EmptyMessage(message: "No data found", tableview: commonTableView, vc: self)
        }
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
}
