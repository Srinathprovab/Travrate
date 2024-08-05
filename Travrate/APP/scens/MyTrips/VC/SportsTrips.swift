//
//  SportsTrips.swift
//  Travrate
//
//  Created by Admin on 21/07/24.
//

import Foundation


extension BookingsVC {
    
    //MARK: - callSportstUpcomingAPI
    func callSportstUpcomingAPI() {
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["user_id"] = "2893"
        trips?.CALL_GET_SPORTS_TRIPS_API(dictParam: MySingleton.shared.payload)
    }
    
    
    func sportsTripsResponse(response: SportsTripModel) {
        basicloderBool = false
        
        if tripsBtnTap == "upcoming" {
            DispatchQueue.main.async {
                self.setupSportstUpcomingTVCells(data:  response.data?.upcoming ?? [])
            }
        }else {
            DispatchQueue.main.async {
                self.setupSportstCompletesTVCells(data:  response.data?.completed ?? [])
            }
        }
    }
    
    
    
    func setupSportstUpcomingTVCells(data:[SportsUpcoming]) {
        MySingleton.shared.tablerow.removeAll()
        
        if data.count > 0 {
            data.forEach { i in
                TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
                MySingleton.shared.tablerow.append(TableRow(title:i.eventType_name,
                                                            subTitle: i.event_name,
                                                            price: "\(i.totel_amount ?? "0")",
                                                            currency: "kwd",
                                                            key: i.voucher_url,
                                                            headerText: i.event_name,
                                                            moreData: i.participants,
                                                            tempText: "\(i.dateOfEvent ?? "")-\(i.timeOfEvent ?? "")",
                                                            cellType:.SportsTripsTVCell))
            }
        }else {
            TableViewHelper.EmptyMessage(message: "No data found", tableview: commonTableView, vc: self)
        }
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    func setupSportstCompletesTVCells(data:[SportsCompleted]) {
        MySingleton.shared.tablerow.removeAll()
        
        if data.count > 0 {
            data.forEach { i in
                
                TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
                MySingleton.shared.tablerow.append(TableRow(title:i.eventType_name,
                                                            subTitle: i.event_name,
                                                            price: "\(i.totel_amount ?? "0")",
                                                            currency: "kwd",
                                                            key: i.voucher_url,
                                                            headerText: i.event_name,
                                                            moreData: i.participants,
                                                            tempText: "\(i.dateOfEvent ?? "")-\(i.timeOfEvent ?? "")",
                                                            cellType:.SportsTripsTVCell))
                
            }
        }else {
            TableViewHelper.EmptyMessage(message: "No data found", tableview: commonTableView, vc: self)
        }
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
}
