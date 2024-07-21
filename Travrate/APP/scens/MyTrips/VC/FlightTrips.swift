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
        showToast(message: "callFlightUpcomingAPI")
        DispatchQueue.main.async {
            self.setupFlightUpcomingTVCells()
        }
    }
    
    func setupFlightUpcomingTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.FlightUpcomingTVCell))
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
    //MARK: - callFlightCompletedTVCells
    func callFlightCompletedTVCells(){
        setupFlightCompletedTVCells()
    }
    
    func setupFlightCompletedTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
    
    //MARK: - callFlightCancelledTVCells
    func callFlightCancelledTVCells(){
        setupFlightCancelledTVCells()
    }
    
    
    func setupFlightCancelledTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.FlightUpcomingTVCell))
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
}
