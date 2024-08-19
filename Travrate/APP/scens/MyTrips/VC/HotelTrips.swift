//
//  HotelTrips.swift
//  Travrate
//
//  Created by Admin on 21/07/24.
//

import Foundation



extension BookingsVC {
    
    func callHotelTripsAPI() {
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["user_id"] = "2893"
        
        DispatchQueue.main.async {
            self.trips?.CALL_GET_HOTEL_TRIPS_API(dictParam: MySingleton.shared.payload)
        }
    }
    
    
    func hotelTripsResponse(response : HotelTripsModel) {
        basicloderBool = false
        
        
        DispatchQueue.main.async {[self] in
            if tripsBtnTap == "upcoming" {
                setupHoteltUpcomingTVCells(res: response.upcoming_booking ?? [])
            }else  if tripsBtnTap == "completed" {
                setupHoteltCompletedTVCells(res: response.completed_booking ?? [])
            }else {
                setupHoteltCancelledTVCells(res: response.cancelled_booking ?? [])
            }
            
        }
        
    }
    
}


extension BookingsVC {
    
    //MARK: -  setupHoteltUpcomingTVCells
    func setupHoteltUpcomingTVCells(res:[Hotel_Completed_booking]) {
        MySingleton.shared.tablerow.removeAll()

        if res.count > 0 {
            res.forEach { i in
                MySingleton.shared.tablerow.append(TableRow(moreData:i,cellType:.HotelTripsTVCell))
            }
            
        }else {
            TableViewHelper.EmptyMessage(message: "No data found", tableview: commonTableView, vc: self)
        }
        
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
    //MARK: -  setupHoteltCompletedTVCells
    func setupHoteltCompletedTVCells(res:[Hotel_Completed_booking]) {
        MySingleton.shared.tablerow.removeAll()

        if res.count > 0 {
            res.forEach { i in
                MySingleton.shared.tablerow.append(TableRow(moreData:i,cellType:.HotelTripsTVCell))
            }
            
        }else {
            TableViewHelper.EmptyMessage(message: "No data found", tableview: commonTableView, vc: self)
        }
        
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
    //MARK: -  setupHoteltCancelledTVCells
    func setupHoteltCancelledTVCells(res:[Hotel_Completed_booking]) {
        MySingleton.shared.tablerow.removeAll()

        if res.count > 0 {
            res.forEach { i in
                MySingleton.shared.tablerow.append(TableRow(moreData:i,cellType:.HotelTripsTVCell))
            }
            
        }else {
            TableViewHelper.EmptyMessage(message: "No data found", tableview: commonTableView, vc: self)
        }
        
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
}
