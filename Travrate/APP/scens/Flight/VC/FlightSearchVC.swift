//
//  FlightSearchVC.swift
//  TravgateApp
//
//  Created by FCI on 03/01/24.
//

import UIKit

class FlightSearchVC: BaseTableVC, SearchDataViewModelDelegate, GetAirlineViewModelDelegate {
    
    
    
    @IBOutlet weak var logoimg: UIImageView!
    @IBOutlet weak var onewayView: BorderedView!
    @IBOutlet weak var onewaylbl: UILabel!
    @IBOutlet weak var roundtripView: BorderedView!
    @IBOutlet weak var roundtriplbl: UILabel!
    @IBOutlet weak var multicityView: BorderedView!
    @IBOutlet weak var multicitylbl: UILabel!
    
    @IBOutlet weak var flightSearchTitllelbl: UILabel!
    @IBOutlet weak var onewayTitllelbl: UILabel!
    @IBOutlet weak var roundtripTitllelbl: UILabel!
    
    
    var isfromVC = String()
    static var newInstance: FlightSearchVC? {
        let storyboard = UIStoryboard(name: Storyboard.Flight.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? FlightSearchVC
        return vc
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        basicloderBool = false
        addObserver()
        
        
        
        if isfromVC == "dashbord" {
            roundtripTap()
        }else {
            if let journytype = defaults.string(forKey: UserDefaultsKeys.journeyType), journytype == "circle" {
                roundtripTap()
            }else {
                onewayTap()
            }
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        
        MySingleton.shared.recentsearchvm = SearchDataViewModel(self)
        MySingleton.shared.airlinevm = GetAirlineViewModel(self)
        
        
        
    }
    
    func onewayTap() {
        //  logoimg.image = UIImage(named: "onewayimg")
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
        //  logoimg.image = UIImage(named: "circleimg")
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
        
        let previousjourneyType = defaults.string(forKey: UserDefaultsKeys.previousjourneyType)
        defaults.set(previousjourneyType, forKey: UserDefaultsKeys.journeyType)
        
        
        if isfromVC == "resultsReturn" {
            MySingleton.shared.callboolapi = false
            dismiss(animated: true)
        }else {
            MySingleton.shared.callboolapi = true
            guard let vc = DashBoardTBVC.newInstance.self else {return}
            vc.selectedIndex = 0
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false)
        }
        
    }
    
    
    
    override func didTapOnReturnDateBtnAction(cell:FlightSearchTVCell) {
        defaults.set("circle", forKey: UserDefaultsKeys.previousjourneyType)
        roundtripTap()
    }
    
    
    
    override func didTapOnCloserecentSearchBtnAction(cell: YourRecentSearchesCVCell) {
        
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["id"] = cell.origin
        
        print(" ==== cell.origin ==== ")
        print(cell.origin)
        
        callGetRemoveRecentSearchAPI()
    }
    
    override func didTapOnSearchRecentFlightsBtnAction(cell: YourRecentSearchesCVCell) {
        
        
        
        defaults.setValue(cell.trip_type, forKey: UserDefaultsKeys.journeyType)
        defaults.setValue(cell.adult, forKey: UserDefaultsKeys.adultCount)
        defaults.setValue(cell.child, forKey: UserDefaultsKeys.childCount)
        defaults.setValue(cell.infant, forKey: UserDefaultsKeys.infantsCount)
        defaults.setValue(cell.from, forKey: UserDefaultsKeys.fromCity)
        defaults.setValue(cell.from_loc_id, forKey: UserDefaultsKeys.fromlocid)
        defaults.setValue(cell.to, forKey: UserDefaultsKeys.toCity)
        defaults.setValue(cell.to_loc_id, forKey: UserDefaultsKeys.tolocid)
        defaults.setValue(cell.depature, forKey: UserDefaultsKeys.calDepDate)
        defaults.setValue(cell.sreturn, forKey: UserDefaultsKeys.calRetDate)
        // defaults.setValue(cell.carrier, forKey: UserDefaultsKeys.journeyType)
        //  defaults.setValue(cell.psscarrier, forKey: UserDefaultsKeys.journeyType)
        //  defaults.setValue(cell.search_flight, forKey: UserDefaultsKeys.journeyType)
        // defaults.setValue(cell.search_source, forKey: UserDefaultsKeys.journeyType)
        defaults.setValue(cell.currency, forKey: UserDefaultsKeys.selectedCurrency)
        defaults.setValue(cell.user_id, forKey: UserDefaultsKeys.userid)
        defaults.setValue(cell.v_class, forKey: UserDefaultsKeys.selectClass)
        defaults.setValue(cell.fcityname, forKey: UserDefaultsKeys.fromcitynameshow)
        defaults.setValue(cell.tcityname, forKey: UserDefaultsKeys.tocitynameshow)
        
        
        defaults.setValue(cell.from_custom, forKey: UserDefaultsKeys.fromcityname)
        defaults.setValue(cell.to_custom, forKey: UserDefaultsKeys.tocityname)
        
        defaults.setValue(cell.fcityname, forKey: UserDefaultsKeys.fcity)
        defaults.setValue(cell.tcityname, forKey: UserDefaultsKeys.tcity)
        
        didTapOnFlightSearchBtnAction()
        
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
    
    
    
    //MARK: - didTapOnOnewayBtnAction
    @IBAction func didTapOnOnewayBtnAction(_ sender: Any) {
        defaults.set("oneway", forKey: UserDefaultsKeys.previousjourneyType)
        onewayTap()
    }
    
    
    //MARK: - didTapOnRoundTripBtnAction
    @IBAction func didTapOnRoundTripBtnAction(_ sender: Any) {
        roundtripTap()
        NotificationCenter.default.post(name: NSNotification.Name("roundtripTap"), object: nil)
    }
    
    //MARK: - didTapOnMulticityBtnAction
    @IBAction func didTapOnMulticityBtnAction(_ sender: Any) {
        multicityTap()
    }
    
    
}


extension FlightSearchVC {
    
    
    func setupUI(){
        
        
        if !UserDefaults.standard.bool(forKey: "ExecuteOnce") {
            
            defaults.set("+965", forKey: UserDefaultsKeys.mobilecountrycode)
            
            defaults.set("Flight", forKey: UserDefaultsKeys.tabselect)
            defaults.set("circle", forKey: UserDefaultsKeys.journeyType)
            defaults.set("KWD", forKey: UserDefaultsKeys.selectedCurrency)
            defaults.set("1", forKey: UserDefaultsKeys.totalTravellerCount)
            
            defaults.set("Economy", forKey: UserDefaultsKeys.selectClass)
            defaults.set("1", forKey: UserDefaultsKeys.adultCount)
            defaults.set("0", forKey: UserDefaultsKeys.childCount)
            defaults.set("0", forKey: UserDefaultsKeys.infantsCount)
            let totaltraverlers = "\(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") Adult | \(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") Child | \(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "") Infant | \(defaults.string(forKey: UserDefaultsKeys.selectClass) ?? "")"
            defaults.set(totaltraverlers, forKey: UserDefaultsKeys.travellerDetails)
            
            
            //Hotel default Values
            defaults.set("1", forKey: UserDefaultsKeys.roomcount)
            defaults.set("2", forKey: UserDefaultsKeys.hoteladultscount)
            defaults.set("0", forKey: UserDefaultsKeys.hotelchildcount)
           // /*defaults.set("\(defaults.string(forKey: UserDefaultsKeys.roomcount) ?? "") Rooms,\(defaults.string(forKey: UserDefaultsKeys.hoteladultscount) ?? "") Adults,\*/(defaults.string(forKey: UserDefaultsKeys.hotelchildcount) ?? "") Child", forKey: UserDefaultsKeys.selectPersons)
            
            let roomscount = defaults.integer(forKey: UserDefaultsKeys.roomcount)
            let adultcount = defaults.integer(forKey: UserDefaultsKeys.hoteladultscount)
            let childcount = defaults.integer(forKey: UserDefaultsKeys.hotelchildcount)
            
            
            let adultsCoutntStr = adultcount > 1 ? "Room \(roomscount) | Adult \(adultcount)" : "Room \(roomscount) | Adult \(adultcount)"
            var labelText = adultsCoutntStr
            if childcount > 0 {
                labelText += ", Child \(childcount)"
            }
           
            defaults.set(labelText, forKey: UserDefaultsKeys.selectPersons)
            defaults.set(true, forKey: "ExecuteOnce")
            
        }
        
        //        roundtripTap()
        
        commonTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Top left corner, Top right corner respectively
        commonTableView.layer.cornerRadius = 12
        commonTableView.clipsToBounds = true
        commonTableView.registerTVCells(["FlightSearchTVCell",
                                         "YourRecentSearchesTVCell",
                                         "EmptyTVCell"])
    
        
        let currentlang = LanguageManager.shared.currentLanguage()
        if currentlang == "ar" {
            flightSearchTitllelbl.text = "بحث الرحلات"
            onewayTitllelbl.text = "ذهاب فقط"
            roundtripTitllelbl.text = " ذهاب وعودة"
            
        } else {
            flightSearchTitllelbl.text = "Flight Search"
            onewayTitllelbl.text = "One - way"
            roundtripTitllelbl.text = "Round - Trip"
        }
        
        
        
        
    }
    
    
    
    func setupOnewayTVCells() {
        
        MySingleton.shared.tablerow.removeAll()
        MySingleton.shared.tablerow.append(TableRow(key:"oneway",cellType:.FlightSearchTVCell))
        MySingleton.shared.tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        
        
        if (MySingleton.shared.recentData?.count ?? 0) > 0 {
            MySingleton.shared.tablerow.append(TableRow(cellType:.YourRecentSearchesTVCell))
            MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        }
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    func setupRoundTripTVCells() {
        MySingleton.shared.tablerow.removeAll()
        MySingleton.shared.tablerow.append(TableRow(key:"circle",cellType:.FlightSearchTVCell))
        MySingleton.shared.tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        
        if (MySingleton.shared.recentData?.count ?? 0) > 0 {
            MySingleton.shared.tablerow.append(TableRow(cellType:.YourRecentSearchesTVCell))
            MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        }
        
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
}




extension FlightSearchVC {
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




//MARK: - callGetRecentSearchAPI
extension FlightSearchVC {
    
    func callGetRecentSearchAPI() {
        MySingleton.shared.recentsearchvm?.CALL_GET_FLIGHT_SEARCH_RECENT_DATA_API(dictParam: [:])
    }
    
    func flightRecentSearchDate(response: SearchDataModel) {
        MySingleton.shared.recentData = response.recent_searches ?? []
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.getAirlinesAPI()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType)
            if journyType == "oneway" {
                
                DispatchQueue.main.async {[self] in
                    setupOnewayTVCells()
                    
                }
            }else {
                
                DispatchQueue.main.async {[self] in
                    setupRoundTripTVCells()
                }
                
            }
            
        }
        
        if MySingleton.shared.returnDateTapbool == true {
            MySingleton.shared.returnDateTapbool = true
        }
        
    }
    
    
    //MARK: -  callGetRemoveRecentSearchAPI   removeflightRecentSearchDate
    
    
    
    func callGetRemoveRecentSearchAPI() {
        
        MySingleton.shared.recentsearchvm?.CALL_GET_REMOVE_FLIGHT_SEARCH_RECENT_DATA_API(dictParam: MySingleton.shared.payload)
        
    }
    
    
    func removeflightRecentSearchDate(response: LoginModel) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType)
            if journyType == "oneway" {
                
                DispatchQueue.main.async {[self] in
                    setupOnewayTVCells()
                }
            }else {
                
                DispatchQueue.main.async {[self] in
                    setupRoundTripTVCells()
                }
                
            }
        }
    }
    
    
}


//MARK: getAirlinesAPI   airlinesList
extension FlightSearchVC {
    
    func getAirlinesAPI() {
        MySingleton.shared.airlinevm?.CALL_FLIGHT_LODER_DETAILS_API(dictParam: [:])
    }
    
    
    func airlinesList(response: GetAirlineModel) {
        
        MySingleton.shared.airlinelist = response.data ?? []
    }
    
}



//MARK: - addObserver
extension FlightSearchVC {
    
    func addObserver() {
        
        
        DispatchQueue.main.async {
            //  self.callGetRecentSearchAPI()
        }
        
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
