//
//  TransferTrips.swift
//  Travrate
//
//  Created by Admin on 21/07/24.
//

import Foundation

extension BookingsVC {
    
    //MARK: - callTransferstUpcomingAPI
    func callTransferstUpcomingAPI() {
        showToast(message: "callTransferstUpcomingAPI")
        DispatchQueue.main.async {
            self.setupTransferstUpcomingTVCells()
        }
    }
    
    func setupTransferstUpcomingTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        for i in 0...100 {
            MySingleton.shared.tablerow.append(TableRow(cellType:.TransferTripsTVCell)) // HotelTripsTVCell TransferTripsTVCell
        }
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
    //MARK: - callTransferstCompletedTVCells
    func callTransferstCompletedTVCells(){
        setupTransferstCompletedTVCells()
    }
    
    func setupTransferstCompletedTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
    
    //MARK: - callTransferstCancelledTVCells
    func callTransferstCancelledTVCells(){
        setupTransferstCancelledTVCells()
    }
    
    
    func setupTransferstCancelledTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
       
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
}
