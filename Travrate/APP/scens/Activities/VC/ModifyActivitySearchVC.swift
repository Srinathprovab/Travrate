//
//  ModifyActivitySearchVC.swift
//  Travrate
//
//  Created by Admin on 17/07/24.
//

import UIKit

class ModifyActivitySearchVC: BaseTableVC {
    
    
    
    static var newInstance: ModifyActivitySearchVC? {
        let storyboard = UIStoryboard(name: Storyboard.Activities.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ModifyActivitySearchVC
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
    
    
    func setupUI() {
        
        commonTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        commonTableView.layer.cornerRadius = 8
        commonTableView.registerTVCells(["ActivitiesSearchTVCell"])
        setupTVCells()
        
    }
    
    func setupTVCells() {
        
        MySingleton.shared.tablerow.removeAll()
        
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.ActivitiesSearchTVCell))
        
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
        
    }
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        callapibool = false
        MySingleton.shared.callboolapi = false
        dismiss(animated: true)
    }
    
    
    
    override func donedatePicker(cell: ActivitiesSearchTVCell) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        
        let selectedDepDate = cell.depDatePicker.date
        defaults.set(formatter.string(from: selectedDepDate), forKey: UserDefaultsKeys.calActivitesDepDate)
        if let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: selectedDepDate) {
            defaults.set(formatter.string(from: nextDay), forKey: UserDefaultsKeys.calActivitesRetDate)
            cell.retDatePicker.minimumDate = nextDay
        }
        
        
        commonTableView.reloadData()
        self.view.endEditing(true)
    }

    
    override func cancelDatePicker(cell: ActivitiesSearchTVCell) {
        self.view.endEditing(true)
    }
    
    
    override func didTapOnActivitesSearchBtnAction(cell: ActivitiesSearchTVCell) {
        print("didTapOnActivitesSearchBtnAction")
        
        
        let cityid = defaults.string(forKey: UserDefaultsKeys.activitescityid)
        let cityname = defaults.string(forKey: UserDefaultsKeys.activitescityname)
        let fromdate = defaults.string(forKey: UserDefaultsKeys.calActivitesDepDate)
        let todate = defaults.string(forKey: UserDefaultsKeys.calActivitesRetDate)
        let adultcount = defaults.string(forKey: UserDefaultsKeys.activitesadultCount)
        let childcount = defaults.string(forKey: UserDefaultsKeys.activiteschildCount)
        let infantcount = defaults.string(forKey: UserDefaultsKeys.activitesinfantsCount)
        
        
        let citynamebool =  cityname == "Select Destination City" ? false : true
        let fromdateBool =  fromdate == "Select Date" ? false : true
        let todateBool =  cityname == "Select Date" ? false : true
        
        
        if citynamebool == false {
            showToast(message: "Please Select Destination City")
        }else  if fromdateBool == false {
            showToast(message: "Please Select Date")
        }else if todateBool == false {
            showToast(message: "Please Select Date")
        }else {
            
            MySingleton.shared.payload.removeAll()
            MySingleton.shared.payload["activity_destination"] = cityname
            MySingleton.shared.payload["activity_destination_id"] = cityid
            MySingleton.shared.payload["from_date"] = fromdate
            MySingleton.shared.payload["to_date"] = todate
            MySingleton.shared.payload["adult"] = adultcount
            MySingleton.shared.payload["child"] = childcount
            MySingleton.shared.payload["infant"] = infantcount
            
            gotoActivitiesSearchResultsVC()
        }
        
    }
    
    
    func gotoActivitiesSearchResultsVC() {
        MySingleton.shared.callboolapi = true
        defaults.set(false, forKey: "activitesfilteronce")
        guard let vc = ActivitiesSearchResultsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
}






//MARK: - addObserver
extension ModifyActivitySearchVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(nointrnetreload), name: Notification.Name("nointrnetreload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        
        
        if MySingleton.shared.callboolapi == true {
            // callAPI()
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
