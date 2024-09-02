//
//  ActivitiesTrips.swift
//  Travrate
//
//  Created by Admin on 21/07/24.
//

import Foundation



extension BookingsVC {
    
    func callActivitiesTripsAPI() {
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid)
        
        DispatchQueue.main.async {
            self.trips?.CALL_GET_ACTIVITIES_TRIPS_API(dictParam: MySingleton.shared.payload)
        }
    }
    
    
    func activitiesTripsResponse(response : ActivitiesTripsModel) {
        basicloderBool = false
        
        
        DispatchQueue.main.async {[self] in
            if tripsBtnTap == "upcoming" {
                setupActivitiestUpcomingTVCells(res: response.upcoming_booking ?? [])
            }else  if tripsBtnTap == "completed" {
                setupActivitiestCompletedTVCells(res: response.completed_booking ?? [])
            }else {
                setupActivitiestCancelledTVCells(res: response.cancelled_booking ?? [])
            }
            
        }
    }
    
    
}


extension BookingsVC {
    
    
    
    func setupActivitiestUpcomingTVCells(res:[Activities_Completed_booking]) {
        MySingleton.shared.tablerow.removeAll()
        
        if res.count > 0 {
            res.forEach { i in
                MySingleton.shared.tablerow.append(TableRow(moreData:i,cellType:.ActivitiesTripsTVCell))
            }
            
        }else {
            TableViewHelper.EmptyMessage(message: "No data found", tableview: commonTableView, vc: self)
        }
        
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
    
    func setupActivitiestCompletedTVCells(res:[Activities_Completed_booking]) {
        MySingleton.shared.tablerow.removeAll()
        
        if res.count > 0 {
            res.forEach { i in
                MySingleton.shared.tablerow.append(TableRow(moreData:i,cellType:.ActivitiesTripsTVCell))
            }
            
        }else {
            TableViewHelper.EmptyMessage(message: "No data found", tableview: commonTableView, vc: self)
        }
        
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
    
    func setupActivitiestCancelledTVCells(res:[Activities_Completed_booking]) {
        MySingleton.shared.tablerow.removeAll()
        
        if res.count > 0 {
            res.forEach { i in
                MySingleton.shared.tablerow.append(TableRow(moreData:i,cellType:.ActivitiesTripsTVCell))
            }
            
        }else {
            TableViewHelper.EmptyMessage(message: "No data found", tableview: commonTableView, vc: self)
        }
        
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
}
