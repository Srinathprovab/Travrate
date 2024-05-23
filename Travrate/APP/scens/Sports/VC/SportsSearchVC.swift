//
//  SportsSearchVC.swift
//  Travgate
//
//  Created by FCI on 10/05/24.
//

import UIKit

class SportsSearchVC: BaseTableVC, SportServiceVMDelegate {
    
    
    
    static var newInstance: SportsSearchVC? {
        let storyboard = UIStoryboard(name: Storyboard.Sports.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SportsSearchVC
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
        dismiss(animated: true)
    }
    
    
    
    override func donedatePicker(cell: SportsSearchTVCell) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        cell.depDatelbl.text = formatter.string(from: cell.depDatePicker.date)
        cell.retDatelbl.text = formatter.string(from: cell.retDatePicker.date)
        
        MySingleton.shared.sportFromDate = cell.depDatelbl.text ?? ""
        MySingleton.shared.sportToDate = cell.retDatelbl.text ?? ""
        
        self.view.endEditing(true)
    }
    
    override func cancelDatePicker(cell: SportsSearchTVCell) {
        self.view.endEditing(true)
    }
    
    override func didTapOnSearchSportsBtnAction(cell: SportsSearchTVCell) {
       // gotoSelectSportsListVC()
        
        print("sportscityName : \(MySingleton.shared.sportscityName)")
        print("sportscityId : \(MySingleton.shared.sportscityId)")
        
        print("sportsTeamName : \(MySingleton.shared.sportsTeamName)")
        print("sportsTeamId : \(MySingleton.shared.sportsTeamId)")
        
        print("sportsVenuName : \(MySingleton.shared.sportsVenuName)")
        print("sportsVenuId : \(MySingleton.shared.sportsVenuId)")
        
        print("sportFromDate : \(MySingleton.shared.sportFromDate)")
        print("sportToDate : \(MySingleton.shared.sportToDate)")
        
//    from:
//    destination_id:
//    from_type:
//    to:
//    event_id:
//    venue_type:
//    form_date:25/08/2024
//    to_date:28/08/2024
//    special_events_id:1000
        
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["from"] = ""
        MySingleton.shared.payload["destination_id"] = ""
        MySingleton.shared.payload["from_type"] = ""
        MySingleton.shared.payload["to"] = ""
        MySingleton.shared.payload["event_id"] = ""
        MySingleton.shared.payload["venue_type"] = ""
        MySingleton.shared.payload["form_date"] = MySingleton.shared.convertDateFormat(inputDate: MySingleton.shared.sportFromDate, f1: "dd-MM-yyyy", f2: "dd/MM/yyy")
        MySingleton.shared.payload["to_date"] = MySingleton.shared.convertDateFormat(inputDate: MySingleton.shared.sportToDate, f1: "dd-MM-yyyy", f2: "dd/MM/yyy")
        MySingleton.shared.payload["special_events_id"] = MySingleton.shared.sportscityId
        
        gotoSelectSportsListVC()
    }
    
    
   
    
    func gotoSelectSportsListVC() {
        callapibool = true
        guard let vc = SelectSportsListVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}



extension SportsSearchVC {
    
    
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


extension SportsSearchVC {
    
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
