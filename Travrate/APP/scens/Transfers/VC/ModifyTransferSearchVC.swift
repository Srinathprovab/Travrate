//
//  ModifyTransferSearchVC.swift
//  Travrate
//
//  Created by Admin on 13/07/24.
//

import UIKit

class ModifyTransferSearchVC: BaseTableVC {
    
    @IBOutlet weak var onewaybtn: UIButton!
    @IBOutlet weak var roundtripBtn: UIButton!
    
    
    static var newInstance: ModifyTransferSearchVC? {
        let storyboard = UIStoryboard(name: Storyboard.Transfers.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ModifyTransferSearchVC
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    
    @IBAction func didTapOnOnewayBtnAction(_ sender: Any) {
        taponOnewayBtn()
    }
    
    @IBAction func didTapOnRoundtripBtnAction(_ sender: Any) {
        taponRoundtripBtnAction()
    }
    
    func taponOnewayBtn() {
        onewaybtn.backgroundColor = .Buttoncolor
        onewaybtn.setTitleColor(UIColor.WhiteColor, for: .normal)
        roundtripBtn.backgroundColor = .WhiteColor
        roundtripBtn.setTitleColor(UIColor.TitleColor, for: .normal)
        
        defaults.set("oneway", forKey: UserDefaultsKeys.transferjournytype)
        setupVisaTVCells(keystr: "oneway")
    }
    
    func taponRoundtripBtnAction() {
        onewaybtn.backgroundColor = .WhiteColor
        onewaybtn.setTitleColor(UIColor.TitleColor, for: .normal)
        roundtripBtn.backgroundColor = .Buttoncolor
        roundtripBtn.setTitleColor(UIColor.WhiteColor, for: .normal)
        
        defaults.set("circle", forKey: UserDefaultsKeys.transferjournytype)
        setupVisaTVCells(keystr: "circle")
    }
    
    
    //MARK: - didTapOnBackBtnAction
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    override func didTapOnSearchBtnAction(cell: BookTransfersTVCell) {
        self.didTapOnSearchBtnAction()
    }
    
    
    
    override func donedatePicker(cell: BookTransfersTVCell) {
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        
        if cell.depDateTF.isFirstResponder == true {
            defaults.set(formatter.string(from: cell.depDatePicker.date), forKey: UserDefaultsKeys.transfercalDepDate)
            defaults.set(formatter.string(from: cell.retDatePicker.date), forKey: UserDefaultsKeys.transfercalRetDate)
            cell.retDatePicker.date = cell.depDatePicker.date
            
        }else {
            
            defaults.set(formatter.string(from: cell.depDatePicker.date), forKey: UserDefaultsKeys.transfercalDepDate)
            defaults.set(formatter.string(from: cell.retDatePicker.date), forKey: UserDefaultsKeys.transfercalRetDate)
            
        }
        
        commonTableView.reloadData()
        self.view.endEditing(true)
    }
    
    override func cancelDatePicker(cell: BookTransfersTVCell) {
        self.view.endEditing(true)
    }
    
    override func doneTimePicker(cell:BookTransfersTVCell) {
        self.view.endEditing(true)
    }
    
    override func cancelTimePicker(cell:BookTransfersTVCell) {
        self.view.endEditing(true)
    }
    
    
    
    
}



extension ModifyTransferSearchVC {
    
    
    func setupUI(){
        
        setupBtn(btn: onewaybtn)
        setupBtn(btn: roundtripBtn)
        
        
        commonTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Top left corner, Top right corner respectively
        commonTableView.layer.cornerRadius = 12
        commonTableView.clipsToBounds = true
        commonTableView.registerTVCells(["BookTransfersTVCell",
                                         "EmptyTVCell"])
        
        
      
        defaults.string(forKey: UserDefaultsKeys.transferjournytype) == "oneway" ? taponOnewayBtn() : taponRoundtripBtnAction()

        
    }
    
    
    func setupBtn(btn:UIButton) {
        btn.layer.cornerRadius = 4
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.BorderColor.cgColor
    }
    
    
    func setupVisaTVCells(keystr:String) {
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(key:keystr,
                                                    cellType:.BookTransfersTVCell))
        
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
    func didTapOnSearchBtnAction() {
    
        
        
        guard let journytype =  defaults.string(forKey: UserDefaultsKeys.transferjournytype) else {return}
        guard let fromcity =  defaults.string(forKey: UserDefaultsKeys.transferfromcityname) else {return}
        guard let fromcityid =  defaults.string(forKey: UserDefaultsKeys.transferfromcityid) else {return}
        guard let tocity =  defaults.string(forKey: UserDefaultsKeys.transfertocityname) else {return}
        guard let tocityid =  defaults.string(forKey: UserDefaultsKeys.transfertocityid) else {return}
        guard let fromdate =  defaults.string(forKey: UserDefaultsKeys.transfercalDepDate) else {return}
        guard let fromtime =  defaults.string(forKey: UserDefaultsKeys.transfercalDepTime) else {return}
        guard let todate =  defaults.string(forKey: UserDefaultsKeys.transfercalRetDate) else {return}
        guard let totime =  defaults.string(forKey: UserDefaultsKeys.transfercalRetTime) else {return}
        guard let fromlatitude =  defaults.string(forKey: UserDefaultsKeys.transfertolang) else {return}
        guard let fromlongitude =  defaults.string(forKey: UserDefaultsKeys.transfertolat) else {return}
        guard let tolatitude =  defaults.string(forKey: UserDefaultsKeys.transfertolat) else {return}
        guard let tolongitude =  defaults.string(forKey: UserDefaultsKeys.transfertolang) else {return}
        
        
        
//    transfer_type:circle
//    transfer_from:Airport Dubai International
//    from_loc_id:ChIJaQ4mkwZdXz4R6e5IegDUleY
//    from_lat:25.2527999878
//    from_lng:55.3643989563
//    transfer_to:Airport Al Maktoum International Airport
//    to_loc_id:ChIJKxDRavt0Xz4RGNmgrLNWd6I
//    to_lat:24.896356
//    to_lng:55.161389
//    departure_date:19-08-2024
//    depart_time:12:05
//    return_date:21-08-2024
//    return_time:12:45
        
        
     
        MySingleton.shared.payload.removeAll()
//        MySingleton.shared.payload["transfer_type"] = journytype
//        MySingleton.shared.payload["transfer_from"] = fromcity
//        MySingleton.shared.payload["from_loc_id"] = fromcityid
//        MySingleton.shared.payload["from_lat"] = fromlatitude
//        MySingleton.shared.payload["from_lng"] = fromlongitude
//        MySingleton.shared.payload["transfer_to"] = tocity
//        MySingleton.shared.payload["to_loc_id"] = tocityid
//        MySingleton.shared.payload["to_lat"] = tolatitude
//        MySingleton.shared.payload["to_lng"] = tolongitude
//        MySingleton.shared.payload["departure_date"] = fromdate
//        MySingleton.shared.payload["depart_time"] = fromtime
        
        MySingleton.shared.payload["transfer_type"] = "circle"
        MySingleton.shared.payload["transfer_from"] = "Airport Dubai International"
        MySingleton.shared.payload["from_loc_id"] = "ChIJaQ4mkwZdXz4R6e5IegDUleY"
        MySingleton.shared.payload["from_lat"] = "25.2527999878"
        MySingleton.shared.payload["from_lng"] = "55.3643989563"
        MySingleton.shared.payload["transfer_to"] = "Airport Al Maktoum International Airport"
        MySingleton.shared.payload["to_loc_id"] = "ChIJKxDRavt0Xz4RGNmgrLNWd6I"
        MySingleton.shared.payload["to_lat"] = "24.896356"
        MySingleton.shared.payload["to_lng"] = "55.161389"
        MySingleton.shared.payload["departure_date"] = "19-08-2024"
        MySingleton.shared.payload["depart_time"] = "12:05"
        MySingleton.shared.payload["return_date"] = "21-08-2024"
        MySingleton.shared.payload["return_time"] = "12:45"
        gotoTransfersListVC()
        
        
//        if journytype == "oneway" {
//
//            MySingleton.shared.payload["return_date"] = ""
//            MySingleton.shared.payload["return_time"] = ""
//
//            if fromcity == "From Airport" {
//                showToast(message: "Select From Airtport")
//            }else if tocity == "To Airport" {
//                showToast(message: "Select To Airtport")
//            }else if fromdate == "Select Date" {
//                showToast(message: "Select Date")
//            }else if fromtime == "Select Time" {
//                showToast(message: "Select Time")
//            }else {
//                gotoTransfersListVC()
//            }
//        }else {
//
//            MySingleton.shared.payload["return_date"] = todate
//            MySingleton.shared.payload["return_time"] = totime
//
//
//            if fromcity == "From Airport" {
//                showToast(message: "Select From Airtport")
//            }else if tocity == "To Airport" {
//                showToast(message: "Select To Airtport")
//            }else if fromdate == "Select Date" {
//                showToast(message: "Select Date")
//            }else if fromtime == "Select Time" {
//                showToast(message: "Select Time")
//            }else if todate == "Select Date" {
//                showToast(message: "Select Date")
//            }else if totime == "Select Time" {
//                showToast(message: "Select Time")
//            }else {
//                gotoTransfersListVC()
//            }
        
        }
    
    
    func gotoTransfersListVC() {
        callapibool = true
        defaults.set(false, forKey: "transferfilteronce")
        guard let vc = TransfersListVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
}




