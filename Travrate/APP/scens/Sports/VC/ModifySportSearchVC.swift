//
//  ModifySportSearchVC.swift
//  Travrate
//
//  Created by FCI on 29/05/24.
//

import UIKit

class ModifySportSearchVC: BaseTableVC, SportServiceVMDelegate {
    
    
    
    static var newInstance: ModifySportSearchVC? {
        let storyboard = UIStoryboard(name: Storyboard.Sports.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ModifySportSearchVC
        return vc
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if callapibool == true {
            callGetSportsServiceListAPI()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        
        MySingleton.shared.sportsCityvm = SportServiceVM(self)
        
    }
    
    
    
    
    //MARK: - didTapOnBackBtnAction
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        callapibool = false
        dismiss(animated: true)
    }
    
    
    
    override func donedatePicker(cell: SportsSearchTVCell) {
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        
        
        let selectedDepDate = cell.depDatePicker.date
        if let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: selectedDepDate) {
            if cell.depDateTF.isFirstResponder == true {
                defaults.set(formatter.string(from: cell.depDatePicker.date), forKey: UserDefaultsKeys.sportcalDepDate)
                defaults.set(formatter.string(from: cell.depDatePicker.date), forKey: UserDefaultsKeys.sportcalRetDate)
                cell.retDatePicker.minimumDate = cell.depDatePicker.date
            }else {
                defaults.set(formatter.string(from: cell.depDatePicker.date), forKey: UserDefaultsKeys.sportcalDepDate)
                defaults.set(formatter.string(from: cell.retDatePicker.date), forKey: UserDefaultsKeys.sportcalRetDate)
                
            }
        }
        
    
        
        commonTableView.reloadData()
        self.view.endEditing(true)
    }
    
    override func cancelDatePicker(cell: SportsSearchTVCell) {
        self.view.endEditing(true)
    }
    
    override func didTapOnSearchSportsBtnAction(cell: SportsSearchTVCell) {
        
        if MySingleton.shared.sportscityName.isEmpty == true || MySingleton.shared.sportscityName == "Please Select Service"{
            showToast(message: "Please Select Service")
        }else if MySingleton.shared.sportsTeamName.isEmpty == true {
            showToast(message: "Please Select Team Or Match")
        }else if MySingleton.shared.sportsVenuName.isEmpty == true {
            showToast(message: "Please Select Venu Or Country")
        } else if defaults.string(forKey: UserDefaultsKeys.sportcalDepDate) == "Select Date" {
            showToast(message: "Select Date")
        }else if defaults.string(forKey: UserDefaultsKeys.sportcalRetDate) == "Select Date" {
            showToast(message: "Select Date")
        }else {
            
            MySingleton.shared.payload.removeAll()
            MySingleton.shared.payload["from"] = ""
            MySingleton.shared.payload["destination_id"] = ""
            MySingleton.shared.payload["from_type"] = ""
            MySingleton.shared.payload["to"] = ""
            MySingleton.shared.payload["event_id"] = ""
            MySingleton.shared.payload["venue_type"] = ""
            MySingleton.shared.payload["form_date"] = MySingleton.shared.convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.sportcalDepDate) ?? "", f1: "dd-MM-yyyy", f2: "dd/MM/yyy")
            MySingleton.shared.payload["to_date"] = MySingleton.shared.convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.sportcalRetDate) ?? "", f1: "dd-MM-yyyy", f2: "dd/MM/yyy")
            MySingleton.shared.payload["special_events_id"] = MySingleton.shared.sportscityId
            
            gotoSelectSportsListVC()
            
        }
        
        
    }
    
    func gotoSelectSportsListVC() {
        MySingleton.shared.afterResultsBool = false
        callapibool = true
        defaults.set(false, forKey: "sportfilteronce")
        guard let vc = SelectSportsListVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}



extension ModifySportSearchVC {
    
    
    func setupUI(){
        
        
        
        commonTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Top left corner, Top right corner respectively
        commonTableView.layer.cornerRadius = 12
        commonTableView.clipsToBounds = true
        commonTableView.registerTVCells(["SportsSearchTVCell",
                                         "EmptyTVCell"])
        
        
        
    }
    
    
    func setupBtn(btn:UIButton) {
        btn.layer.cornerRadius = 4
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.BorderColor.cgColor
    }
    
    
    
    
}


extension ModifySportSearchVC {
    
    func callGetSportsServiceListAPI() {
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["term"] = ""
        MySingleton.shared.sportsCityvm?.CALL_GET_SPORTS_CITY_LIST_API(dictParam:  MySingleton.shared.payload)
    }
    
    func sportServiceList(response: SportsServiceModel) {
        MySingleton.shared.sportsCityList = response.data ?? []
        
        DispatchQueue.main.async {
            self.setupTVCells()
        }
    }
    
    
    func setupTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.SportsSearchTVCell))
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
}
