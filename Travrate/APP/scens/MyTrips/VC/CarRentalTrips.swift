//
//  CarRentalTrips.swift
//  Travrate
//
//  Created by Admin on 21/07/24.
//

import Foundation





extension BookingsVC {
    
    func callCarRentalTripsAPI() {
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["user_id"] = "2890"
        
        DispatchQueue.main.async {
            self.trips?.CALL_GET_CARRENTAL_TRIPS_API(dictParam: MySingleton.shared.payload)
        }
    }
    
    
    
    func carrentalTripsResponse(response : CarRentalTripsModel) {
        basicloderBool = false
        
        
        DispatchQueue.main.async {[self] in
            if tripsBtnTap == "upcoming" {
                setupCarRentaltUpcomingTVCells(res: response.upcoming_booking ?? [])
            }else  if tripsBtnTap == "completed" {
                setupCarRentaltCompletedTVCells(res: response.completed_booking ?? [])
            }else {
                setupCarRentaltCancelledTVCells(res: response.cancelled_booking ?? [])
            }
            
        }
    }
    
    
    
}


extension BookingsVC {
    
    
    
    func setupCarRentaltUpcomingTVCells(res:[Upcoming_booking]) {
        MySingleton.shared.tablerow.removeAll()
        
        if res.count > 0 {
            res.forEach { i in
                MySingleton.shared.tablerow.append(TableRow(moreData:i,cellType:.CarRentalTripsTVCell))
            }
            
        }else {
            TableViewHelper.EmptyMessage(message: "No data found", tableview: commonTableView, vc: self)
        }
        
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
    func setupCarRentaltCompletedTVCells(res:[Upcoming_booking]) {
        MySingleton.shared.tablerow.removeAll()
        
        if res.count > 0 {
            res.forEach { i in
                MySingleton.shared.tablerow.append(TableRow(moreData:i,cellType:.CarRentalTripsTVCell))
            }
            
        }else {
            TableViewHelper.EmptyMessage(message: "No data found", tableview: commonTableView, vc: self)
        }
        
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
    
    
    func setupCarRentaltCancelledTVCells(res:[Upcoming_booking]) {
        MySingleton.shared.tablerow.removeAll()
        
        if res.count > 0 {
            res.forEach { i in
                MySingleton.shared.tablerow.append(TableRow(moreData:i,cellType:.CarRentalTripsTVCell))
            }
            
        }else {
            TableViewHelper.EmptyMessage(message: "No data found", tableview: commonTableView, vc: self)
        }
        
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
}
