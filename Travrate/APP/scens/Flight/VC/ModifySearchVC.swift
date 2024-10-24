//
//  ModifySearchVC.swift
//  TravgateApp
//
//  Created by FCI on 05/01/24.
//

import UIKit

class ModifySearchVC: BaseTableVC {
    
    
    @IBOutlet weak var logoimg: UIImageView!
    @IBOutlet weak var onewayView: BorderedView!
    @IBOutlet weak var onewaylbl: UILabel!
    @IBOutlet weak var roundtripView: BorderedView!
    @IBOutlet weak var roundtriplbl: UILabel!
    @IBOutlet weak var multicityView: BorderedView!
    @IBOutlet weak var multicitylbl: UILabel!
    @IBOutlet weak var closebrn: UIButton!
    
    static var newInstance: ModifySearchVC? {
        let storyboard = UIStoryboard(name: Storyboard.Flight.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ModifySearchVC
        return vc
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    
    func onewayTap() {
        logoimg.image = UIImage(named: "onewayimg")
        onewayView.backgroundColor = .Buttoncolor
        roundtripView.backgroundColor = .WhiteColor
        multicityView.backgroundColor = .WhiteColor
        onewaylbl.textColor = .WhiteColor
        roundtriplbl.textColor = .TitleColor
        multicitylbl.textColor = .TitleColor
        
        defaults.set("oneway", forKey: UserDefaultsKeys.journeyType)
        setupOnewayTVCells()
    }
    
    func roundtripTap() {
        logoimg.image = UIImage(named: "circleimg")
        onewayView.backgroundColor = .WhiteColor
        roundtripView.backgroundColor = .Buttoncolor
        multicityView.backgroundColor = .WhiteColor
        onewaylbl.textColor = .TitleColor
        roundtriplbl.textColor = .WhiteColor
        multicitylbl.textColor = .TitleColor
        
        defaults.set("circle", forKey: UserDefaultsKeys.journeyType)
        setupRoundTripTVCells()
    }
    
    func multicityTap() {
        onewayView.backgroundColor = .WhiteColor
        roundtripView.backgroundColor = .WhiteColor
        multicityView.backgroundColor = .Buttoncolor
        onewaylbl.textColor = .TitleColor
        roundtriplbl.textColor = .TitleColor
        multicitylbl.textColor = .WhiteColor
        
        // setupOnewayTVCells()
    }
    
    
    
    //MARK: - didTapOnClassBtnAction
    override func didTapOnClassBtnAction(cell:FlightSearchTVCell){
        commonTableView.reloadData()
    }
    
    
    //MARK: - didTapOnAdvanceOption
    override func didTapOnAdvanceOption(cell: FlightSearchTVCell) {
        commonTableView.reloadData()
    }
    
    
    
    //MARK: - donedatePicker cancelDatePicker
    override func donedatePicker(cell:FlightSearchTVCell){
        
        let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType)
        if journyType == "oneway" {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            defaults.set(formatter.string(from: cell.depDatePicker.date), forKey: UserDefaultsKeys.calDepDate)
            
        }else {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            
            
            if cell.depTF.isFirstResponder == true {
                defaults.set(formatter.string(from: cell.depDatePicker.date), forKey: UserDefaultsKeys.calDepDate)
                defaults.set(formatter.string(from: cell.depDatePicker.date), forKey: UserDefaultsKeys.calRetDate)
                
                cell.retDatePicker.minimumDate = cell.depDatePicker.date
            }else {
                defaults.set(formatter.string(from: cell.depDatePicker.date), forKey: UserDefaultsKeys.calDepDate)
                defaults.set(formatter.string(from: cell.retDatePicker.date), forKey: UserDefaultsKeys.calRetDate)
                
            }
        }
        
        commonTableView.reloadData()
        self.view.endEditing(true)
    }
    
    override func cancelDatePicker(cell:FlightSearchTVCell){
        self.view.endEditing(true)
    }
    
    
    
    
    override func didTapOnHideReturnDateBtnAction(cell:FlightSearchTVCell) {
        onewayTap()
    }
    
    
    override func didTapOnFlightSearchBtnAction(cell:FlightSearchTVCell) {
        didTapOnFlightSearchBtnAction()
    }
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        MySingleton.shared.callboolapi = false
        NotificationCenter.default.post(name: NSNotification.Name("modifyclose"), object: nil)
        dismiss(animated: true)
        
    }
    
    
    
    override func didTapOnReturnDateBtnAction(cell:FlightSearchTVCell) {
        roundtripTap()
        NotificationCenter.default.post(name: NSNotification.Name("roundtripTap"), object: nil)
        
    }
    
    
    //MARK: - didTapOnAirlineTimeBtnAction
    override func didTapOnAirlineTimeBtnAction(cell:FlightSearchTVCell){
        gotoAirlineSelectVC()
    }
    
    
    func gotoAirlineSelectVC() {
        guard let vc = AirlineSelectVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: false)
    }
    
    
    @IBAction func didTapOnOnewayBtnAction(_ sender: Any) {
        onewayTap()
    }
    
    
    @IBAction func didTapOnRoundTripBtnAction(_ sender: Any) {
        roundtripTap()
        NotificationCenter.default.post(name: NSNotification.Name("roundtripTap"), object: nil)
    }
    
    
    @IBAction func didTapOnMulticityBtnAction(_ sender: Any) {
        multicityTap()
    }
    
}


extension ModifySearchVC {
    
    
    func setupUI(){
        
        
        
        if let journytype = defaults.string(forKey: UserDefaultsKeys.journeyType), journytype == "circle" {
            roundtripTap()
        }else {
            onewayTap()
        }
        
        commonTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Top left corner, Top right corner respectively
        commonTableView.layer.cornerRadius = 12
        commonTableView.clipsToBounds = true
        commonTableView.registerTVCells(["FlightSearchTVCell",
                                         "EmptyTVCell"])
        
    }
    
    
    
    func setupOnewayTVCells() {
        MySingleton.shared.tablerow.removeAll()
        MySingleton.shared.tablerow.append(TableRow(key:"oneway",cellType:.FlightSearchTVCell))
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    func setupRoundTripTVCells() {
        MySingleton.shared.tablerow.removeAll()
        MySingleton.shared.tablerow.append(TableRow(key:"circle",cellType:.FlightSearchTVCell))
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
}



extension ModifySearchVC {
    func didTapOnFlightSearchBtnAction() {
        MySingleton.shared.flightinputspayload.removeAll()
        
        
        
        MySingleton.shared.flightinputspayload["trip_type"] = defaults.string(forKey: UserDefaultsKeys.journeyType)
        MySingleton.shared.flightinputspayload["adult"] = defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1"
        MySingleton.shared.flightinputspayload["child"] = defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0"
        MySingleton.shared.flightinputspayload["infant"] = defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0"
        MySingleton.shared.flightinputspayload["from"] = defaults.string(forKey: UserDefaultsKeys.fromCity)
        MySingleton.shared.flightinputspayload["from_loc_id"] = defaults.string(forKey: UserDefaultsKeys.fromlocid)
        MySingleton.shared.flightinputspayload["to"] = defaults.string(forKey: UserDefaultsKeys.toCity)
        MySingleton.shared.flightinputspayload["to_loc_id"] = defaults.string(forKey: UserDefaultsKeys.tolocid)
        MySingleton.shared.flightinputspayload["depature"] = MySingleton.shared.convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "", f1: "dd-MM-yyyy", f2: "dd/MM/yyyy")
        MySingleton.shared.flightinputspayload["out_jrn"] = "All Times"
        MySingleton.shared.flightinputspayload["ret_jrn"] = "All Times"
        MySingleton.shared.flightinputspayload["direct_flight"] = MySingleton.shared.directflightString
        MySingleton.shared.flightinputspayload["carrier"] = ""
        MySingleton.shared.flightinputspayload["psscarrier"] = defaults.string(forKey: UserDefaultsKeys.fcariercode) ?? "ALL"
        MySingleton.shared.flightinputspayload["search_flight"] = "Search"
        MySingleton.shared.flightinputspayload["search_source"] = "MOBILE(I)"
        MySingleton.shared.flightinputspayload["currency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency)
        MySingleton.shared.flightinputspayload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        MySingleton.shared.flightinputspayload["device_source"] = "MOBILE(I)"
        
        
        if defaults.string(forKey: UserDefaultsKeys.journeyType) == "oneway" {
            
            
            if defaults.string(forKey: UserDefaultsKeys.selectClass) == "P.Economy" {
                MySingleton.shared.flightinputspayload["v_class"] = "Premium"
            }else {
                MySingleton.shared.flightinputspayload["v_class"] = defaults.string(forKey: UserDefaultsKeys.selectClass)
            }
            MySingleton.shared.flightinputspayload["return"] = ""
            
            if defaults.string(forKey: UserDefaultsKeys.fromcityname) == "Origin" {
                showToast(message: "Enter From City")
            }else if defaults.string(forKey: UserDefaultsKeys.tocityname) == "Destination" {
                showToast(message: "Enter To City")
            }else if defaults.string(forKey: UserDefaultsKeys.calDepDate) == "Add Date" || defaults.string(forKey: UserDefaultsKeys.calDepDate) == nil {
                showToast(message: "Add Departure Date")
            }else {
                gotoFlightResultVC()
            }
            
        }else {
            
            if defaults.string(forKey: UserDefaultsKeys.selectClass) == "P.Economy" {
                MySingleton.shared.flightinputspayload["v_class"] = "PremiumEconomy"
            }else {
                MySingleton.shared.flightinputspayload["v_class"] = defaults.string(forKey: UserDefaultsKeys.selectClass)
            }
            
            if defaults.string(forKey: UserDefaultsKeys.rselectClass) == "P.Economy" {
                MySingleton.shared.flightinputspayload["v_class_round"] = "PremiumEconomy"
            }else {
                MySingleton.shared.flightinputspayload["v_class_round"] = defaults.string(forKey: UserDefaultsKeys.rselectClass)
            }
            
            
            // MySingleton.shared.payload["v_class"] = defaults.string(forKey: UserDefaultsKeys.selectClass)
            MySingleton.shared.flightinputspayload["return"] = MySingleton.shared.convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.calRetDate) ?? "", f1: "dd-MM-yyyy", f2: "dd/MM/yyyy")
            
            if defaults.string(forKey: UserDefaultsKeys.fromcityname) == "Origin" {
                showToast(message: "Enter From City")
            }else if defaults.string(forKey: UserDefaultsKeys.tocityname) == "Destination" {
                showToast(message: "Enter To City")
            }else if defaults.string(forKey: UserDefaultsKeys.calDepDate) == "Add Date" || defaults.string(forKey: UserDefaultsKeys.calDepDate) == nil {
                showToast(message: "Add Departure Date")
            }else if defaults.string(forKey: UserDefaultsKeys.calRetDate) == "Add Date" || defaults.string(forKey: UserDefaultsKeys.calRetDate) == nil {
                showToast(message: "Add Return Date")
            }else {
                gotoFlightResultVC()
            }
            
        }
        
        
    }
    
    
    func gotoFlightResultVC() {
        MySingleton.shared.callboolapi = true
        MySingleton.shared.afterResultsBool = false
        defaults.set(false, forKey: "flightfilteronce")
        guard let vc = FlightResultVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}



//MARK: - addObserver
extension ModifySearchVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(nointrnetreload), name: Notification.Name("nointrnetreload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        
        
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
