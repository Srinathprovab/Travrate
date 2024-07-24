//
//  BookTransfersVC.swift
//  Travgate
//
//  Created by FCI on 08/05/24.
//

import UIKit

class BookTransfersVC: BaseTableVC {
    
    @IBOutlet weak var onewaybtn: UIButton!
    @IBOutlet weak var roundtripBtn: UIButton!
    
    
    static var newInstance: BookTransfersVC? {
        let storyboard = UIStoryboard(name: Storyboard.Transfers.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? BookTransfersVC
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
        setupTVCells(keystr: "oneway")
    }
    
    func taponRoundtripBtnAction() {
        onewaybtn.backgroundColor = .WhiteColor
        onewaybtn.setTitleColor(UIColor.TitleColor, for: .normal)
        roundtripBtn.backgroundColor = .Buttoncolor
        roundtripBtn.setTitleColor(UIColor.WhiteColor, for: .normal)
        
        defaults.set("circle", forKey: UserDefaultsKeys.transferjournytype)
        setupTVCells(keystr: "circle")
    }
    
    
    //MARK: - didTapOnBackBtnAction
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        MySingleton.shared.callboolapi = true
        guard let vc = DashBoardTBVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.selectedIndex = 0
        self.present(vc, animated: false)
    }
    
    
    override func didTapOnSearchBtnAction(cell: BookTransfersTVCell) {
        
        
        self.didTapOnSearchBtnAction()
    }
    
    
    
    override func donedatePicker(cell: BookTransfersTVCell) {
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        
        
        let selectedDepDate = cell.depDatePicker.date
        if let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: selectedDepDate) {
            if cell.depDateTF.isFirstResponder == true {
                defaults.set(formatter.string(from: cell.depDatePicker.date), forKey: UserDefaultsKeys.transfercalDepDate)
                defaults.set(formatter.string(from: nextDay), forKey: UserDefaultsKeys.transfercalRetDate)
                cell.retDatePicker.minimumDate = nextDay
                
            }else {
                
                defaults.set(formatter.string(from: cell.depDatePicker.date), forKey: UserDefaultsKeys.transfercalDepDate)
                defaults.set(formatter.string(from: cell.retDatePicker.date), forKey: UserDefaultsKeys.transfercalRetDate)
                
            }
        }
        
        
        
       
        
        commonTableView.reloadData()
        self.view.endEditing(true)
    }
    
    override func cancelDatePicker(cell: BookTransfersTVCell) {
        self.view.endEditing(true)
    }
    
    override func doneTimePicker(cell:BookTransfersTVCell) {
        commonTableView.reloadData()
        self.view.endEditing(true)
    }
    
    override func cancelTimePicker(cell:BookTransfersTVCell) {
        self.view.endEditing(true)
    }
    
    
    
    
}



extension BookTransfersVC {
    
    
    func setupUI(){
        
        setupBtn(btn: onewaybtn)
        setupBtn(btn: roundtripBtn)
        
        
        commonTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Top left corner, Top right corner respectively
        commonTableView.layer.cornerRadius = 12
        commonTableView.clipsToBounds = true
        commonTableView.registerTVCells(["BookTransfersTVCell",
                                         "EmptyTVCell"])
        
        
        taponOnewayBtn()
    }
    
    
    func setupBtn(btn:UIButton) {
        btn.layer.cornerRadius = 4
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.BorderColor.cgColor
    }
    
    
    func setupTVCells(keystr:String) {
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(key:keystr,
                                                    cellType:.BookTransfersTVCell))
        
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
    func didTapOnSearchBtnAction() {
        
        
        
        let journytype =  defaults.string(forKey: UserDefaultsKeys.transferjournytype)
        let fromcity =  defaults.string(forKey: UserDefaultsKeys.transferfromcityname)
        let fromcityid =  defaults.string(forKey: UserDefaultsKeys.transferfromcityid)
        let tocity =  defaults.string(forKey: UserDefaultsKeys.transfertocityname)
        let tocityid =  defaults.string(forKey: UserDefaultsKeys.transfertocityid)
        let fromdate =  defaults.string(forKey: UserDefaultsKeys.transfercalDepDate)
        let fromtime =  defaults.string(forKey: UserDefaultsKeys.transfercalDepTime)
        let todate =  defaults.string(forKey: UserDefaultsKeys.transfercalRetDate)
        let totime =  defaults.string(forKey: UserDefaultsKeys.transfercalRetTime)
        let fromlatitude =  defaults.string(forKey: UserDefaultsKeys.transferfromlat)
        let fromlongitude =  defaults.string(forKey: UserDefaultsKeys.transferfromlang)
        let tolatitude =  defaults.string(forKey: UserDefaultsKeys.transfertolat)
        let tolongitude =  defaults.string(forKey: UserDefaultsKeys.transfertolang)
        
    
        
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["transfer_type"] = journytype
        MySingleton.shared.payload["transfer_from"] = fromcity
        MySingleton.shared.payload["from_loc_id"] = fromcityid
        MySingleton.shared.payload["from_lat"] = fromlatitude
        MySingleton.shared.payload["from_lng"] = fromlongitude
        MySingleton.shared.payload["transfer_to"] = tocity
        MySingleton.shared.payload["to_loc_id"] = tocityid
        MySingleton.shared.payload["to_lat"] = tolatitude
        MySingleton.shared.payload["to_lng"] = tolongitude
        MySingleton.shared.payload["departure_date"] = fromdate
        MySingleton.shared.payload["depart_time"] = fromtime
        
      
        if journytype == "oneway" {
            
            MySingleton.shared.payload["return_date"] = ""
            MySingleton.shared.payload["return_time"] = ""
            
            if fromcity == "From Airport*" {
                showToast(message: "Select From Airtport")
            }else if tocity == "To Airport*" {
                showToast(message: "Select To Airtport")
            }else if fromdate == "Select Date*" {
                showToast(message: "Select Date")
            }else if fromtime == "Select Time*" {
                showToast(message: "Select Time")
            }else {
                gotoTransfersListVC()
            }
        }else {
            
            MySingleton.shared.payload["return_date"] = todate
            MySingleton.shared.payload["return_time"] = totime
            
            
            if fromcity == "From Airport*" {
                showToast(message: "Select From Airtport")
            }else if tocity == "To Airport*" {
                showToast(message: "Select To Airtport")
            }else if fromdate == "Select Date*" {
                showToast(message: "Select Date")
            }else if fromtime == "Select Time*" {
                showToast(message: "Select Time")
            }else if todate == "Select Date*" {
                showToast(message: "Select Date")
            }else if totime == "Select Time*" {
                showToast(message: "Select Time")
            }else {
                gotoTransfersListVC()
            }
            
            
        }
        
    }

    
    func gotoTransfersListVC() {
        MySingleton.shared.afterResultsBool = false
        defaults.set(false, forKey: "transferfilteronce")
        callapibool = true
        guard let vc = TransfersListVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
}




