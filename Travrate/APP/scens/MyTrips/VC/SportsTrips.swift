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
        showToast(message: "callSportstUpcomingAPI")
        DispatchQueue.main.async {
            self.setupSportstUpcomingTVCells()
        }
    }
    
    func setupSportstUpcomingTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        for i in 0...100 {
            MySingleton.shared.tablerow.append(TableRow(cellType:.SportsTripsTVCell)) // HotelTripsTVCell TransferTripsTVCell SportsTripsTVCell
        }
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
    //MARK: - callSportstCompletedTVCells
    func callSportstCompletedTVCells(){
        setupSportstCompletedTVCells()
    }
    
    func setupSportstCompletedTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
    
    //MARK: - callSportstCancelledTVCells
    func callSportstCancelledTVCells(){
        setupSportstCancelledTVCells()
    }
    
    
    func setupSportstCancelledTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
       
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
}
