//
//  ViewFlightDetailsVC.swift
//  TravgateApp
//
//  Created by FCI on 09/01/24.
//

import UIKit

class ViewFlightDetailsVC: BaseTableVC,FlightDetailsViewModelDelegate {
    func farerulesList(response: FareRulesModel) {
        
    }
    
    
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    
    var fd = [[ItinearyFlightDetails]]()
    
    static var newInstance: ViewFlightDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Flight.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ViewFlightDetailsVC
        return vc
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUI()
        
        MySingleton.shared.fdvm = FlightDetailsViewModel(self)
    }
    
    
    func setUI() {
        
        setuplabels(lbl: titlelbl, text: "Flight Details", textcolor: .BackBtnColor, font: .InterBold(size: 14), align: .center)

        commonTableView.registerTVCells(["TicketIssuingTimeTVCell",
                                         "ItineraryTVCell",
                                         "EmptyTVCell",
                                         "FareBreakdownTVCell"])
        
        
    }
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        callapibool = false
        MySingleton.shared.callboolapi = false
        dismiss(animated: true)
    }
    
    
    
}






extension ViewFlightDetailsVC {
    
    func callAPI() {
        holderView.isHidden = true
        
        MySingleton.shared.afterResultsBool = true
        loderBool = true
        showLoadera()
        
        
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["search_id"] = MySingleton.shared.searchid
        MySingleton.shared.payload["booking_source"] = MySingleton.shared.bookingsource
        MySingleton.shared.payload["selectedResultindex"] = MySingleton.shared.selectedResult
        MySingleton.shared.payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        MySingleton.shared.fdvm?.CALL_FLIGHT_DETAILS_API(dictParam: MySingleton.shared.payload)
        
    }
    
    
    func flightDetails(response: FlightDetailsModel) {
        loderBool = false
        hideLoadera()
        
        holderView.isHidden = false
        self.fd = response.flightDetails ?? [[]]
        
        DispatchQueue.main.async {[self] in
            setupBookingInformationTVCell()
        }
        
    }
    
    
    func setupBookingInformationTVCell() {
        
        MySingleton.shared.tablerow.removeAll()
        
        
        for (index,element) in fd.enumerated() {
            MySingleton.shared.tablerow.append(TableRow(title: "\(index)",
                                                        moreData: element,
                                                        cellType: .ItineraryTVCell))
           
        }
        
                
        MySingleton.shared.tablerow.append(TableRow(height: 50,
                                                    cellType: .EmptyTVCell))
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
        
    }
    
    
}


//MARK: - addObserver
extension ViewFlightDetailsVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(nointrnetreload), name: Notification.Name("nointrnetreload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        
        
        if MySingleton.shared.callboolapi == true {
            callAPI()
        }
    }
    
    
    @objc func reload() {
        DispatchQueue.main.async {[self] in
            commonTableView.reloadData()
        }
    }
    
    @objc func nointrnetreload() {
        
        DispatchQueue.main.async {[self] in
            commonTableView.reloadData()
        }
    }
    
    //MARK: - resultnil
    @objc func resultnil() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = "noresult"
        self.present(vc, animated: true)
    }
    
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = "nointernet"
        self.present(vc, animated: true)
    }
    
    
}
