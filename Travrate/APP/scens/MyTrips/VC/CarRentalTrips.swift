//
//  CarRentalTrips.swift
//  Travrate
//
//  Created by Admin on 21/07/24.
//

import Foundation


extension BookingsVC {
    
    //MARK: - callCarRentaltUpcomingAPI
    func callCarRentaltUpcomingAPI() {
        showToast(message: "callCarRentaltUpcomingAPI")
        DispatchQueue.main.async {
            self.setupCarRentaltUpcomingTVCells()
        }
    }
    
    func setupCarRentaltUpcomingTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        
        for i in 0...100 {
            MySingleton.shared.tablerow.append(TableRow(cellType:.CarRentalTripsTVCell)) // HotelTripsTVCell TransferTripsTVCell SportsTripsTVCell CarRentalTripsTVCell
        }
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
    //MARK: - callCarRentaltCompletedTVCells
    func callCarRentaltCompletedTVCells(){
        setupCarRentaltCompletedTVCells()
    }
    
    func setupCarRentaltCompletedTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
    
    //MARK: - callCarRentaltCancelledTVCells
    func callCarRentaltCancelledTVCells(){
        setupCarRentaltCancelledTVCells()
    }
    
    
    func setupCarRentaltCancelledTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
       
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
}
