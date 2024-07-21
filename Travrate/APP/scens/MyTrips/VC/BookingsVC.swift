//
//  BookingsVC.swift
//  TravgateApp
//
//  Created by FCI on 07/02/24.
//

import UIKit

class BookingsVC: BaseTableVC {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var upcominglbl: UILabel!
    @IBOutlet weak var completedlbl: UILabel!
    @IBOutlet weak var cancelledlbl: UILabel!
    @IBOutlet weak var upcomingView: UIView!
    @IBOutlet weak var completedView: UIView!
    @IBOutlet weak var cancelledView: UIView!
    
    
    
    static var newInstance: BookingsVC? {
        let storyboard = UIStoryboard(name: Storyboard.MyTrips.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? BookingsVC
        return vc
    }
    
    var tabselect = String()
    var titletext = String()
    
    
    override func viewWillAppear(_ animated: Bool) {
        tabselect = defaults.string(forKey: UserDefaultsKeys.tripsselect) ?? "Flight"
        DispatchQueue.main.async {
            self.tapOnUpcomingBtn()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    func setupUI() {
        commonTableView.registerTVCells(["FlightUpcomingTVCell",
                                         "HotelTripsTVCell",
                                         "TransferTripsTVCell",
                                         "SportsTripsTVCell",
                                         "CarRentalTripsTVCell",
                                         "ActivitiesTripsTVCell",
                                         "EmptyTVCell"])
        
        
    }
    
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func didTapOnUpcomingFlightsBtnAction(_ sender: Any) {
        tapOnUpcomingBtn()
    }
    
    @IBAction func didTapOnCompletedFlightsBtnAction(_ sender: Any) {
        tapOnCompletedBtn()
    }
    
    @IBAction func didTapOnCancelledFlightsBtnAction(_ sender: Any) {
        tapOnCancelledBtn()
    }
    
    
    override func didTapOnViewVoucherBtnAction(cell: FlightUpcomingTVCell) {
        print("didTapOnViewVoucherBtnAction")
    }
    
    
}


extension BookingsVC {
    func tapOnUpcomingBtn() {
        upcomingView.backgroundColor = .AppBtnColor
        completedView.backgroundColor = .WhiteColor
        cancelledView.backgroundColor = .WhiteColor
        
        upcominglbl.textColor = .WhiteColor
        completedlbl.textColor = .AppLabelColor
        cancelledlbl.textColor = .AppLabelColor
        
        setupUpcomingTVCells()
    }
    
    func tapOnCompletedBtn() {
        upcomingView.backgroundColor = .WhiteColor
        completedView.backgroundColor = .AppBtnColor
        cancelledView.backgroundColor = .WhiteColor
        
        upcominglbl.textColor = .AppLabelColor
        completedlbl.textColor = .WhiteColor
        cancelledlbl.textColor = .AppLabelColor
        
        setupCompletedTVCells()
    }
    
    func tapOnCancelledBtn() {
        upcomingView.backgroundColor = .WhiteColor
        completedView.backgroundColor = .WhiteColor
        cancelledView.backgroundColor = .AppBtnColor
        
        upcominglbl.textColor = .AppLabelColor
        completedlbl.textColor = .AppLabelColor
        cancelledlbl.textColor = .WhiteColor
        
        setupCancelledTVCells()
    }
    
    
    func setupUpcomingTVCells() {
        if tabselect == "Flight" {
            self.callFlightUpcomingAPI()
        }else if tabselect == "Transfers" {
            callTransferstUpcomingAPI()
        }else if tabselect == "Sports" {
            callSportstUpcomingAPI()
        }else if tabselect == "Car Rentals" {
            callCarRentaltUpcomingAPI()
        }else if tabselect == "Activities" {
            callActivitiestUpcomingAPI()
        }else{
            self.callHoteltUpcomingAPI()
        }
    }
    
    func setupCompletedTVCells() {
        
        if tabselect == "Flight" {
            callFlightCompletedTVCells()
        }else if tabselect == "Transfers" {
            callTransferstCompletedTVCells()
        }else if tabselect == "Sports" {
            callSportstCompletedTVCells()
        }else if tabselect == "Car Rentals" {
            callCarRentaltCompletedTVCells()
        }else if tabselect == "Activities" {
            callActivitiestCompletedTVCells()
        }else{
            callHoteltCompletedTVCells()
        }
    }
    
    
    func setupCancelledTVCells() {
        
        if tabselect == "Flight" {
            callFlightCancelledTVCells()
        }else if tabselect == "Transfers" {
            callTransferstCancelledTVCells()
        }else if tabselect == "Sports" {
            callSportstCancelledTVCells()
        }else if tabselect == "Car Rentals" {
            callCarRentaltCancelledTVCells()
        }else if tabselect == "Activities" {
            callActivitiestCancelledTVCells()
        }else {
            callHoteltCancelledTVCells()
        }
    }
    
}



