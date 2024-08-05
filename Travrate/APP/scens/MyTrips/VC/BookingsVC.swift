//
//  BookingsVC.swift
//  TravgateApp
//
//  Created by FCI on 07/02/24.
//

import UIKit

class BookingsVC: BaseTableVC, TripsViewModelDelegate {
    
    
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
    var trips :TripsViewModel?
    var tripsBtnTap = "upcoming"
    
    override func viewWillAppear(_ animated: Bool) {
        
        basicloderBool = true
        loderBool = false
        hideLoadera()
        
        
        tabselect = defaults.string(forKey: UserDefaultsKeys.tripsselect) ?? "Flight"
        if tabselect == "Sports" {
            cancelledView.isHidden = true
        }
        
        
        if  tripsBtnTap == "upcoming" {
            DispatchQueue.main.async {
                self.tapOnUpcomingBtn()
            }
        }else  if  tripsBtnTap == "completed" {
            DispatchQueue.main.async {
                self.tapOnCompletedBtn()
            }
        }else {
            DispatchQueue.main.async {
                self.tapOnCancelledBtn()
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        
        trips = TripsViewModel(self)
    }
    
    
    func setupUI() {
        
        
        
        commonTableView.registerTVCells(["FlightTripsTVCell",
                                         "HotelTripsTVCell",
                                         "TransferTripsTVCell",
                                         "SportsTripsTVCell",
                                         "CarRentalTripsTVCell",
                                         "ActivitiesTripsTVCell",
                                         "FlightUpcomingTVCell",
                                         "EmptyTVCell"])
        
        
    }
    
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        callapibool = false
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
    
    
    
    //MARK: - didTapOnViewVoutureBtnAction Flights
    override func didTapOnViewVoutureBtnAction(cell: FlightTripsTVCell) {
        gotoLoadWebViewVC(urlStr1: cell.voutureurl)
    }
    
    func gotoLoadWebViewVC(urlStr1:String) {
        guard let vc = LoadWebViewVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.urlString = urlStr1
        vc.keystr = "voucher"
        present(vc, animated: true)
    }
    
    
    //MARK: - didTapOnVoucherBtnAction Sports
    override func didTapOnVoucherBtnAction(cell: SportsTripsTVCell) {
        print(cell.voutureUrl)
        gotoLoadWebViewVC(urlStr1: cell.voutureUrl)
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
        basicloderBool = true
        tripsBtnTap = "upcoming"
        
        if callapibool == true {
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
    }
    
    func setupCompletedTVCells() {
        basicloderBool = true
        tripsBtnTap = "completed"
        
        if callapibool == true {
            if tabselect == "Flight" {
                callFlightCompletedTVCells()
            }else if tabselect == "Transfers" {
                callTransferstCompletedTVCells()
            }else if tabselect == "Sports" {
                
                callSportstUpcomingAPI()
            }else if tabselect == "Car Rentals" {
                callCarRentaltCompletedTVCells()
            }else if tabselect == "Activities" {
                callActivitiestCompletedTVCells()
            }else{
                callHoteltCompletedTVCells()
            }
        }
    }
    
    
    func setupCancelledTVCells() {
        basicloderBool = true
        tripsBtnTap = "cancelled"
        
        if callapibool == true {
            if tabselect == "Flight" {
                callFlightCancelledTVCells()
            }else if tabselect == "Transfers" {
                callTransferstCancelledTVCells()
            }else if tabselect == "Sports" {
                callSportstUpcomingAPI()
            }else if tabselect == "Car Rentals" {
                callCarRentaltCancelledTVCells()
            }else if tabselect == "Activities" {
                callActivitiestCancelledTVCells()
            }else {
                callHoteltCancelledTVCells()
            }
        }
    }
    
}



