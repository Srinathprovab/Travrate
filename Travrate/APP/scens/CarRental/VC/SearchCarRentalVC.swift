//
//  SearchCarRentalVC.swift
//  Travrate
//
//  Created by FCI on 10/06/24.
//

import UIKit

class SearchCarRentalVC: BaseTableVC {
    
    
    static var newInstance: SearchCarRentalVC? {
        let storyboard = UIStoryboard(name: Storyboard.CarRental.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SearchCarRentalVC
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
        MySingleton.shared.callboolapi = true
        guard let vc = DashBoardTBVC.newInstance.self else {return}
        vc.selectedIndex = 0
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
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
    
    
//car_from:Istanbul Airport
//from_loc_id:59007
//from_country_code:
//car_to:
//to_loc_id:
//to_country_code:
//departure_date:27-07-2024
//depart_time:12:05
//drop_date:28-07-2024
//drop_time:12:05
//age_1:20
//depature_time:00:00
//return_time:00:00
    
    
//    "label": "Abbeville City, Louisiana",
//           "value": "Abbeville City",
//           "id": "61338",
//           "category": "Search Results",
//           "type": "Search Results",
    //       "count": 0
    
    override func didTapOnSearchBtnAction(cell:SearchCarRentalTVCell) {
        
        print(defaults.string(forKey: UserDefaultsKeys.pickuplocationname))
        print(defaults.string(forKey: UserDefaultsKeys.pickuplocationcode))
        print(defaults.string(forKey: UserDefaultsKeys.pickuplocDate))
        print(defaults.string(forKey: UserDefaultsKeys.dropuplocDate))
        print(defaults.string(forKey: UserDefaultsKeys.pickuplocTime))
        print(defaults.string(forKey: UserDefaultsKeys.dropuplocTime))
        print(MySingleton.shared.carRentalDriverAge)
        
       // gotoCarRentalResultsVC()
    }
    
    func gotoCarRentalResultsVC() {
        callapibool = true
        defaults.set(false, forKey: "carrentalfilteronce")
        guard let vc = CarRentalResultsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}



extension SearchCarRentalVC {
    
    
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


