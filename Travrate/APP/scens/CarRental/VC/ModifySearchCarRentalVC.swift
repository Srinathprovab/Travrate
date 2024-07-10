//
//  ModifySearchCarRentalVC.swift
//  Travrate
//
//  Created by Admin on 10/07/24.
//

import UIKit

class ModifySearchCarRentalVC: BaseTableVC {
    
    
    static var newInstance: ModifySearchCarRentalVC? {
        let storyboard = UIStoryboard(name: Storyboard.CarRental.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ModifySearchCarRentalVC
        return vc
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTV), name: Notification.Name("reloadTV"), object: nil)
    }
    
    @objc func reloadTV() {
        commonTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        
    }
    
    
    //MARK: - tfeditingChanged
    override func tfeditingChanged(tf: UITextField) {
        if tf.tag == 1 {
            print("tag 1")
        }else {
            print("tag 2")
        }
    }
    
    //MARK: - didTapOnBackBtnAction
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        MySingleton.shared.callboolapi = false
        dismiss(animated: true)
    }
    
    
    override func didTapOnPickupLocationBtnAction(cell: SearchCarRentalTVCell) {
        commonTableView.reloadData()
    }
    
    
    override func donedatePicker(cell:SearchCarRentalTVCell) {
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        
        if cell.pickupDateTF.isFirstResponder == true {
            defaults.set(formatter.string(from: cell.pickupDatePicker.date), forKey: UserDefaultsKeys.pickuplocDate)
            defaults.set(formatter.string(from: cell.pickupDatePicker.date), forKey: UserDefaultsKeys.dropuplocDate)
            cell.dropupDatePicker.date = cell.pickupDatePicker.date
            
        }else {
            
            
            
            defaults.set(formatter.string(from: cell.pickupDatePicker.date), forKey: UserDefaultsKeys.pickuplocDate)
            defaults.set(formatter.string(from: cell.dropupDatePicker.date), forKey: UserDefaultsKeys.dropuplocDate)
            print(defaults.string(forKey: UserDefaultsKeys.pickuplocDate))
            
        }
        
        commonTableView.reloadData()
        self.view.endEditing(true)
    }
    override func cancelDatePicker(cell:SearchCarRentalTVCell) {
        view.endEditing(true)
    }
    
    override func doneTimePicker(cell:SearchCarRentalTVCell) {
        commonTableView.reloadData()
    }
    
    
    override func didTapOnSearchBtnAction(cell:SearchCarRentalTVCell) {
        
        guard let pickuplocationname =  defaults.string(forKey: UserDefaultsKeys.pickuplocationname) else {return}
        guard let pickuplocationcode =  defaults.string(forKey: UserDefaultsKeys.pickuplocationcode) else {return}
        guard let pickuplocDate =  defaults.string(forKey: UserDefaultsKeys.pickuplocDate) else {return}
        guard let dropuplocDate =  defaults.string(forKey: UserDefaultsKeys.dropuplocDate) else {return}
        guard let pickuplocTime =  defaults.string(forKey: UserDefaultsKeys.pickuplocTime) else {return}
        guard let dropuplocTime =  defaults.string(forKey: UserDefaultsKeys.dropuplocTime) else {return}
        
        if pickuplocationname == "Select Location" {
            showToast(message: "Select Location")
        }else if pickuplocDate == "Select Date" {
            showToast(message: "Select Pick Up Date")
        }else if dropuplocDate == "Select Date" {
            showToast(message: "Select Date")
        }else if pickuplocTime == "Select Time" {
            showToast(message: "Select Pick Up Time")
        }else if dropuplocTime == "Select Time" {
            showToast(message: "Select Time")
        }else if MySingleton.shared.carRentalDriverAge == "" {
            showToast(message: "Select Driver Age")
        }else {
            
            MySingleton.shared.payload.removeAll()
            MySingleton.shared.payload["car_from"] = pickuplocationname
            MySingleton.shared.payload["from_loc_id"] = pickuplocationcode
            MySingleton.shared.payload["car_to"] = ""
            MySingleton.shared.payload["to_loc_id"] = ""
            MySingleton.shared.payload["departure_date"] = pickuplocDate
            MySingleton.shared.payload["depart_time"] = pickuplocTime
            MySingleton.shared.payload["drop_date"] = dropuplocDate
            MySingleton.shared.payload["drop_time"] = dropuplocTime
            MySingleton.shared.payload["age_1"] = MySingleton.shared.carRentalDriverAge
            
            gotoCarRentalResultsVC()
        }
        
    }
    
    func gotoCarRentalResultsVC() {
        callapibool = true
        defaults.set(false, forKey: "carrentalfilteronce")
        guard let vc = CarRentalResultsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}



extension ModifySearchCarRentalVC {
    
    
    func setupUI(){
        
        
        
        commonTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Top left corner, Top right corner respectively
        commonTableView.layer.cornerRadius = 12
        commonTableView.clipsToBounds = true
        commonTableView.registerTVCells(["SearchCarRentalTVCell",
                                         "EmptyTVCell"])
        
        
        setupTVCells()
        
    }
    
    
    
    
    func setupTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.SearchCarRentalTVCell))
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
}


