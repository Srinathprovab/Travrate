//
//  HotelTrips.swift
//  Travrate
//
//  Created by Admin on 21/07/24.
//

import Foundation


extension BookingsVC {
    
    //MARK: - callHoteltUpcomingAPI
    func callHoteltUpcomingAPI() {
        showToast(message: "callHoteltUpcomingAPI")
        DispatchQueue.main.async {
            self.setupHoteltUpcomingTVCells()
        }
    }
    
    func setupHoteltUpcomingTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        for i in 0...100 {
            MySingleton.shared.tablerow.append(TableRow(cellType:.HotelTripsTVCell))
        }
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
    //MARK: - callHoteltCompletedTVCells
    func callHoteltCompletedTVCells(){
        setupHoteltCompletedTVCells()
    }
    
    func setupHoteltCompletedTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
    
    //MARK: - callHoteltCancelledTVCells
    func callHoteltCancelledTVCells(){
        setupHoteltCancelledTVCells()
    }
    
    
    func setupHoteltCancelledTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
       
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
}
