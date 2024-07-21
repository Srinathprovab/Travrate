//
//  ActivitiesTrips.swift
//  Travrate
//
//  Created by Admin on 21/07/24.
//

import Foundation


extension BookingsVC {
    
    //MARK: - callActivitiestUpcomingAPI
    func callActivitiestUpcomingAPI() {
        showToast(message: "callActivitiestUpcomingAPI")
        DispatchQueue.main.async {
            self.setupActivitiestUpcomingTVCells()
        }
    }
    
    func setupActivitiestUpcomingTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        
        for i in 0...100 {
            MySingleton.shared.tablerow.append(TableRow(cellType:.ActivitiesTripsTVCell))
        }
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
    //MARK: - callActivitiestCompletedTVCells
    func callActivitiestCompletedTVCells(){
        setupActivitiestCompletedTVCells()
    }
    
    func setupActivitiestCompletedTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
    
    //MARK: - callActivitiestCancelledTVCells
    func callActivitiestCancelledTVCells(){
        setupActivitiestCancelledTVCells()
    }
    
    
    func setupActivitiestCancelledTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
       
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
}
