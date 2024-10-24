//
//  ModifyHotelSearchVC.swift
//  TravgateApp
//
//  Created by FCI on 13/02/24.
//

import UIKit

class ModifyHotelSearchVC: BaseTableVC {
    
    
    static var newInstance: ModifyHotelSearchVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ModifyHotelSearchVC
        return vc
    }
    var countrycode = String()
    let formatter = DateFormatter()
    
    override func viewWillAppear(_ animated: Bool) {
        formatter.dateFormat = "dd-MM-yyyy"
        addObserver()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    
    //MARK: - didTapOnClassBtnAction
    override func didTapOnClassBtnAction(cell:FlightSearchTVCell){
        commonTableView.reloadData()
    }
    
    
    //MARK: - didTapOnAdvanceOption
    override func didTapOnAdvanceOption(cell: FlightSearchTVCell) {
        commonTableView.reloadData()
    }
    
    
    
    override func didTapOnFlightSearchBtnAction(cell:FlightSearchTVCell) {
        didTapOnHotelSearchBtnAction()
    }
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        callapibool = false
        dismiss(animated: true)
    }
    
    
    
    //MARK: - donedatePicker cancelDatePicker
    override func donedatePicker(cell:HotelSearchTVCell){
        
        
        let selectedDepDate = cell.checkinDatePicker.date
        if let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: selectedDepDate) {
            if cell.checkinTF.isFirstResponder == true {
                defaults.set(formatter.string(from: selectedDepDate), forKey: UserDefaultsKeys.checkin)
                defaults.set(formatter.string(from: nextDay), forKey: UserDefaultsKeys.checkout)
                cell.checkoutDatePicker.minimumDate = selectedDepDate
            }else {
                
                
                defaults.set(formatter.string(from: cell.checkinDatePicker.date), forKey: UserDefaultsKeys.checkin)
                defaults.set(formatter.string(from: cell.checkoutDatePicker.date), forKey: UserDefaultsKeys.checkout)
                
//                cell.checkinDatePicker.minimumDate = cell.checkinDatePicker.date
//                cell.checkoutDatePicker.minimumDate = cell.checkoutDatePicker.date
                
                
            }
            
        }
        
        commonTableView.reloadData()
        self.view.endEditing(true)
    }
    
    override func cancelDatePicker(cell:HotelSearchTVCell){
        self.view.endEditing(true)
    }
    
    
    
    //MARK: - didTapOnAddRoomsBtnAction
    override func didTapOnAddRoomsBtnAction(cell:HotelSearchTVCell) {
        guard let vc = AddRoomsVCViewController.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: false)
    }
    
    
    //MARK: - didTapOnSelectNationlatiyBtnAction
    override func didTapOnSelectNationlatiyBtnAction(cell:HotelSearchTVCell) {
        guard let vc = NationalityVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    
    
    //MARK: - didTapOnSelectNoofNightsBtnAction
    override func didTapOnSelectNoofNightsBtnAction(cell:HotelSearchTVCell) {
        
    }
    
    //MARK: - didTapOnSelectCountryCodeList
    override func didTapOnSelectCountryCodeList(cell:HotelSearchTVCell){
        commonTableView.reloadData()
    }
    
    
    override func didTapOnHotelSearchBtnAction(cell:HotelSearchTVCell) {
        didTapOnHotelSearchBtnAction()
    }
}


extension ModifyHotelSearchVC {
    
    
    func setupUI(){
        
       // setInitalValues()
        
        commonTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Top left corner, Top right corner respectively
        commonTableView.layer.cornerRadius = 12
        commonTableView.clipsToBounds = true
        commonTableView.registerTVCells(["HotelSearchTVCell",
                                         "EmptyTVCell"])
        
        setupTVCells()
        
    }
    
    
    
    func setupTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.HotelSearchTVCell))
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
}



extension ModifyHotelSearchVC {
    
    
    func didTapOnHotelSearchBtnAction() {
        
        NotificationCenter.default.post(name: NSNotification.Name("resetallFilters"), object: nil)
        MySingleton.shared.payload.removeAll()
        
        
        MySingleton.shared.payload["city"] = defaults.string(forKey: UserDefaultsKeys.locationcity)
        MySingleton.shared.payload["hotel_destination"] = defaults.string(forKey: UserDefaultsKeys.locationid)
        
        MySingleton.shared.payload["hotel_checkin"] = MySingleton.shared.convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.checkin) ?? "", f1: "dd-MM-yyyy", f2: "dd/MM/yyyy")
        MySingleton.shared.payload["hotel_checkout"] = MySingleton.shared.convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.checkout) ?? "", f1: "dd-MM-yyyy", f2: "dd/MM/yyyy")
        
        MySingleton.shared.payload["rooms"] = "\(defaults.string(forKey: UserDefaultsKeys.roomcount) ?? "1")"
        MySingleton.shared.payload["adult"] = adtArray
        MySingleton.shared.payload["child"] = chArray
        
        
        hotelfiltermodel.starRatingNew = starRatingInputArray
        if starRatingInputArray.count > 0 {
           // MySingleton.shared.payload["star_rating"] = starRatingInputArray
            MySingleton.shared.payload["star_rating"] = hotelfiltermodel.starRatingNew
        }
        
        
        if defaults.string(forKey: UserDefaultsKeys.hotelchildcount) == "0" {
            
            MySingleton.shared.payload["childAge_1"] = [""]
            
        }else {
            
            for roomIndex in 0..<totalRooms {
                if let numChildren = Int(chArray[roomIndex]), numChildren > 0 {
                    var childAges: [String] = Array(repeating: "0", count: numChildren)
                    
                    if numChildren > 2 {
                        childAges.append("0")
                    }
                    
                    MySingleton.shared.payload["childAge_\(roomIndex + 1)"] = childAges
                }
            }
            
        }
        
        
        
        
        MySingleton.shared.payload["nationality"] = defaults.string(forKey: UserDefaultsKeys.hnationalitycode)
        
        
        
      
        //        MySingleton.shared.payload["language"] = "english"
            MySingleton.shared.payload["search_source"] = "MOBILE(I)"
        //        MySingleton.shared.payload["currency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD"
        //        MySingleton.shared.payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        
        if defaults.string(forKey: UserDefaultsKeys.locationcity) == "City/Location" || defaults.string(forKey: UserDefaultsKeys.locationcity) == nil{
            showToast(message: "Enter Hotel or City ")
        }else if defaults.string(forKey: UserDefaultsKeys.checkin) == "Add Date" || defaults.string(forKey: UserDefaultsKeys.checkin) == nil{
            showToast(message: "Enter Checkin Date")
        }else if defaults.string(forKey: UserDefaultsKeys.checkout) == "Add Date" || defaults.string(forKey: UserDefaultsKeys.checkout) == nil{
            showToast(message: "Enter Checkout Date")
        }
        else if defaults.string(forKey: UserDefaultsKeys.checkout) == defaults.string(forKey: UserDefaultsKeys.checkin) {
            showToast(message: "Enter Different Dates")
        }else if defaults.string(forKey: UserDefaultsKeys.hnationality) == "Select Nationality" {
            showToast(message: "Please Select Nationality.")
        }else {
            
            do{
                
                let jsonData = try JSONSerialization.data(withJSONObject: MySingleton.shared.payload, options: JSONSerialization.WritingOptions.prettyPrinted)
                let jsonStringData =  NSString(data: jsonData as Data, encoding: NSUTF8StringEncoding)! as String
                
                print(jsonStringData)
                
                
            }catch{
                print(error.localizedDescription)
            }
            
            gotoHotelResultVC()
            
        }
    }
    
    
    func gotoHotelResultVC() {
        
        MySingleton.shared.loderString = "loder"
        MySingleton.shared.afterResultsBool = false
        hotelSearchResult.removeAll()
        loderBool = true
        callapibool = true
        defaults.set(false, forKey: "hoteltfilteronce")
        guard let vc = SearchHotelsResultVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.payload =  MySingleton.shared.payload
        present(vc, animated: true)
    }
    
    
}



extension ModifyHotelSearchVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        
    }
    
    
    @objc func reload() {
        commonTableView.reloadData()
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
