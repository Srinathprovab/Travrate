//
//  SportsSearchTVCell.swift
//  Travgate
//
//  Created by FCI on 10/05/24.
//

import UIKit
import DropDown

protocol SportsSearchTVCellDelegate: AnyObject {
    
    func didTapOnSelectServiceBtn(cell:SportsSearchTVCell)
    func didTapOnSearchSportsBtnAction(cell:SportsSearchTVCell)
    func donedatePicker(cell:SportsSearchTVCell)
    func cancelDatePicker(cell:SportsSearchTVCell)
    
}

class SportsSearchTVCell: TableViewCell, SportServiceVMDelegate {
    
    
    
    @IBOutlet weak var selectServiceView: UIView!
    @IBOutlet weak var selectServicelbl: UILabel!
    @IBOutlet weak var teamTF: UITextField!
    @IBOutlet weak var venuTF: UITextField!
    @IBOutlet weak var depDateTF: UITextField!
    @IBOutlet weak var depDatelbl: UILabel!
    @IBOutlet weak var retDateTF: UITextField!
    @IBOutlet weak var retDatelbl: UILabel!
    @IBOutlet weak var searchbtn: UIButton!
    @IBOutlet weak var serviceTF: UITextField!
    @IBOutlet weak var serviceCloseBtn: UIButton!
    @IBOutlet weak var serviceTV: UITableView!
    @IBOutlet weak var serviceTVHeight: NSLayoutConstraint!
    @IBOutlet weak var teamTV: UITableView!
    @IBOutlet weak var teamTVheight: NSLayoutConstraint!
    @IBOutlet weak var venuTV: UITableView!
    @IBOutlet weak var venuTVHeight: NSLayoutConstraint!
    
    
    var keystr = String()
    var txtbool = String()
    var sportCityNameArray = [String]()
    var sportCityIdArray = [String]()
    let depDatePicker = UIDatePicker()
    let retDatePicker = UIDatePicker()
    let dropDown = DropDown()
    
    weak var delegate:SportsSearchTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        
        MySingleton.shared.sportsCityvm = SportServiceVM(self)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setupUI(){
        
        
        searchbtn.layer.cornerRadius = 4
        
        serviceTF.tag = 3
        serviceTF.textColor = .TitleColor
        serviceTF.font = .OpenSansMedium(size: 16)
        serviceTF.delegate = self
        serviceTF.addTarget(self, action: #selector(textFiledEditingChanged(_:)), for: .editingChanged)
        serviceTF.setLeftPaddingPoints(35)
        
        teamTF.tag = 1
        teamTF.textColor = .TitleColor
        teamTF.font = .OpenSansMedium(size: 16)
        teamTF.delegate = self
        teamTF.addTarget(self, action: #selector(textFiledEditingChanged(_:)), for: .editingChanged)
        teamTF.setLeftPaddingPoints(35)
        
        venuTF.tag = 2
        venuTF.textColor = .TitleColor
        venuTF.font = .OpenSansMedium(size: 16)
        venuTF.delegate = self
        venuTF.addTarget(self, action: #selector(textFiledEditingChanged(_:)), for: .editingChanged)
        venuTF.setLeftPaddingPoints(35)
        
        
        serviceTV.layer.borderWidth = 1
        serviceTV.layer.borderColor = UIColor.AppBorderColor.cgColor
        
        teamTV.layer.borderWidth = 1
        teamTV.layer.borderColor = UIColor.AppBorderColor.cgColor
        
        venuTV.layer.borderWidth = 1
        venuTV.layer.borderColor = UIColor.AppBorderColor.cgColor
        
    }
    
    override func updateUI() {
        
        
        setupTV()
        serviceTVHeight.constant = 0
        teamTVheight.constant = 0
        venuTVHeight.constant = 0
        // CallSportTeamListAPI(str: "")
        serviceCloseBtn.setImage(UIImage(named: "downarrownew")?.withRenderingMode(.alwaysOriginal).withTintColor(.TitleColor), for: .normal)
        
        sportCityNameArray.removeAll()
        sportCityNameArray.append("Please Select Service")
        sportCityIdArray.append("")
        
        MySingleton.shared.sportsVenuList.forEach { i in
            sportCityNameArray.append("\(i.name ?? "")")
            sportCityIdArray.append("\(i.id ?? "")")
        }
        
        
        
        depDatelbl.text = defaults.string(forKey: UserDefaultsKeys.sportcalDepDate) ?? "Select Date"
        retDatelbl.text = defaults.string(forKey: UserDefaultsKeys.sportcalRetDate) ?? "Select Date"
        depDatelbl.textColor = depDatelbl.text == "Select Date" ? .subtitleNewcolor:.TitleColor
        retDatelbl.textColor = retDatelbl.text == "Select Date" ? .subtitleNewcolor:.TitleColor
        
        
        
        
        if MySingleton.shared.sportsserviceName.isEmpty == false {
            serviceTF.text = MySingleton.shared.sportsserviceName
            serviceTF.textColor = .TitleColor
        }
        
        if MySingleton.shared.sportsTeamName.isEmpty == false {
            teamTF.text = MySingleton.shared.sportsTeamName
            teamTF.textColor = .TitleColor
        }
        
        if MySingleton.shared.sportsVenuName.isEmpty == false {
            venuTF.text = MySingleton.shared.sportsVenuName
            venuTF.textColor = .TitleColor
        }
        
        if MySingleton.shared.sportFromDate.isEmpty == false {
            depDatelbl.text = MySingleton.shared.sportFromDate
            depDatelbl.textColor = .TitleColor
        }
        
        if MySingleton.shared.sportToDate.isEmpty == false {
            retDatelbl.text = MySingleton.shared.sportToDate
            retDatelbl.textColor = .TitleColor
        }
        
        
        
        setupDropDown()
        showdepDatePicker()
        showretDatePicker()
        
        
        
    }
    
    
    @IBAction func didTapOnClearSearviceTFBtnAction(_ sender: Any) {
        serviceTF.text = ""
        serviceTF.placeholder = "Please select Service"
        serviceTVHeight.constant = 0
        venuTVHeight.constant = 0
        teamTVheight.constant = 0
        serviceCloseBtn.setImage(UIImage(named: "downarrownew")?.withRenderingMode(.alwaysOriginal).withTintColor(.TitleColor), for: .normal)
        serviceTF.becomeFirstResponder()
    }
    
    @IBAction func didTapOnClearvenuTFBtnAction(_ sender: Any) {
        venuTF.text = ""
        venuTF.placeholder = "Enter Team, Match (or) Artist"
        serviceTVHeight.constant = 0
        venuTVHeight.constant = 0
        teamTVheight.constant = 0
        venuTF.becomeFirstResponder()
    }
    
    
    @IBAction func didTapOnClearTeamTFBtnAction(_ sender: Any) {
        teamTF.text = ""
        teamTF.placeholder = "Enter Venue, City  (or) Country"
        serviceTVHeight.constant = 0
        venuTVHeight.constant = 0
        teamTVheight.constant = 0
        teamTF.becomeFirstResponder()
    }
    
    
    @IBAction func didTapOnSelectServiceBtnAction(_ sender: Any) {
        dropDown.show()
    }
    
    
    @IBAction func didTapOnSearchSportsBtnAction(_ sender: Any) {
        delegate?.didTapOnSearchSportsBtnAction(cell: self)
    }
    
    
    
}



extension SportsSearchTVCell {
    
    
    
    
    func setupDropDown() {
        
        dropDown.dataSource = sportCityNameArray
        dropDown.direction = .bottom
        dropDown.backgroundColor = .WhiteColor
        dropDown.anchorView = self.selectServiceView
        dropDown.bottomOffset = CGPoint(x: 0, y: selectServiceView.frame.size.height + 10)
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            
            self?.selectServicelbl.text = self?.sportCityNameArray[index]
            self?.selectServicelbl.textColor = .TitleColor
            
            MySingleton.shared.sportscityName = self?.sportCityNameArray[index] ?? ""
            MySingleton.shared.sportscityId = self?.sportCityIdArray[index] ?? ""
            
            if item == "Please Select Service" {
                self?.selectServicelbl.textColor = .subtitleNewcolor
            }
            
            self?.delegate?.didTapOnSelectServiceBtn(cell: self!)
            
        }
    }
    
    
    
    
}



extension SportsSearchTVCell:UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - setupTV
    func setupTV() {
        
        serviceTV.delegate = self
        serviceTV.dataSource = self
        serviceTV.register(UINib(nibName: "SelectSportServiceTVCell", bundle: nil), forCellReuseIdentifier: "cell2")
        
        
        teamTV.delegate = self
        teamTV.dataSource = self
        teamTV.register(UINib(nibName: "SelectSportServiceTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        venuTV.delegate = self
        venuTV.dataSource = self
        venuTV.register(UINib(nibName: "SelectSportServiceTVCell", bundle: nil), forCellReuseIdentifier: "cell1")
    }
    
    
    
    //MARK: - Text Filed Editing Changed
    
    @objc func textFiledEditingChanged(_ textField:UITextField) {
        
        
        if textField == teamTF {
            txtbool = "team"
            CallSportTeamListAPI(str: textField.text ?? "")
        }else if textField == serviceTF {
            serviceCloseBtn.setImage(UIImage(named: "dropup")?.withRenderingMode(.alwaysOriginal).withTintColor(.TitleColor), for: .normal)
            txtbool = "service"
            CallSportServiceListAPI(str: textField.text ?? "")
        }else{
            txtbool = "venu"
            CallSportVenuListAPI(str: textField.text ?? "")
        }
        
        
    }
    
    
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == teamTF {
            txtbool = "team"
            teamTF.text = ""
            //  CallSportTeamListAPI(str: textField.text ?? "")
        }else if textField == serviceTF {
            txtbool = "service"
            serviceTF.text = ""
            serviceCloseBtn.setImage(UIImage(named: "dropup")?.withRenderingMode(.alwaysOriginal).withTintColor(.TitleColor), for: .normal)
            CallSportServiceListAPI(str: "")
        }else {
            txtbool = "venu"
            venuTF.text = ""
            //   CallSportVenuListAPI(str: textField.text ?? "")
        }
    }
    
    
    func CallSportServiceListAPI(str:String) {
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["term"] = str
        MySingleton.shared.sportsCityvm?.CALL_GET_SPORTS_CITY_LIST_API(dictParam: MySingleton.shared.payload)
    }
    
    
    func CallSportTeamListAPI(str:String) {
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["term"] = str
        MySingleton.shared.sportsCityvm?.CALL_GET_SPORTS_EVENT_LIST_API(dictParam: MySingleton.shared.payload)
    }
    
    func CallSportVenuListAPI(str:String) {
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["term"] = str
        MySingleton.shared.sportsCityvm?.CALL_GET_SPORTS_TYPE_LIST_API(dictParam: MySingleton.shared.payload)
    }
    
    
    
    func sportServiceList(response: SportsServiceModel) {
        if txtbool == "team" {
            
            MySingleton.shared.sportsTeamtList = response.data ?? []
            serviceTVHeight.constant = 0
            teamTVheight.constant = 260
            venuTVHeight.constant = 0
            
            DispatchQueue.main.async {[self] in
                teamTV.reloadData()
            }
        }else if txtbool == "service" {
            
            MySingleton.shared.sportsVenuList = response.data ?? []
            serviceTVHeight.constant = 260
            venuTVHeight.constant = 0
            teamTVheight.constant = 0
            
            DispatchQueue.main.async {[self] in
                serviceTV.reloadData()
            }
        }else {
            
            MySingleton.shared.sportsCityList = response.data ?? []
            
            
            serviceTVHeight.constant = 0
            venuTVHeight.constant = 150
            teamTVheight.constant = 0
            
            DispatchQueue.main.async {[self] in
                venuTV.reloadData()
            }
        }
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == teamTV {
            return MySingleton.shared.sportsTeamtList.count
        }else if tableView == serviceTV {
            return MySingleton.shared.sportsVenuList.count
        }else {
            return MySingleton.shared.sportsCityList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        
        if tableView == teamTV {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SelectSportServiceTVCell {
                cell.selectionStyle = .none
                let data = MySingleton.shared.sportsTeamtList[indexPath.row]
                cell.titlelbl.text = data.label
                cell.teamid = data.id ?? ""
                ccell = cell
            }
        }else if tableView == serviceTV {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as? SelectSportServiceTVCell {
                cell.selectionStyle = .none
                let data = MySingleton.shared.sportsVenuList[indexPath.row]
                cell.titlelbl.text = data.name
                cell.teamid = data.id ?? ""
                ccell = cell
            }
        }else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as? SelectSportServiceTVCell {
                cell.selectionStyle = .none
                let data = MySingleton.shared.sportsCityList[indexPath.row]
                cell.titlelbl.text = data.value
                cell.venuId = data.id ?? ""
                ccell = cell
            }
        }
        
        return ccell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SelectSportServiceTVCell {
            
            
            if tableView == teamTV {
                
                
                teamTF.text = cell.titlelbl.text ?? ""
                teamTF.resignFirstResponder()
                //venuTF.becomeFirstResponder()
                MySingleton.shared.sportsTeamName = cell.titlelbl.text ?? ""
                MySingleton.shared.sportsTeamId = cell.teamid
                
            }else if tableView == serviceTV {
                
                
                serviceTF.text = cell.titlelbl.text ?? ""
                serviceTF.resignFirstResponder()
              //  teamTF.becomeFirstResponder()
                MySingleton.shared.sportsserviceName = cell.titlelbl.text ?? ""
                MySingleton.shared.sportsservicId = cell.teamid
                
                
            }else {
                
                venuTF.text = cell.titlelbl.text ?? ""
                venuTF.resignFirstResponder()
                if depDatelbl.text != "Select Date" {
                   // depDateTF.becomeFirstResponder()
                }
                MySingleton.shared.sportsVenuName = cell.titlelbl.text ?? ""
                MySingleton.shared.sportsVenuId = cell.venuId
                
            }
            
            serviceCloseBtn.setImage(UIImage(named: "downarrownew")?.withRenderingMode(.alwaysOriginal).withTintColor(.TitleColor), for: .normal)
            serviceTVHeight.constant = 0
            teamTVheight.constant = 0
            venuTVHeight.constant = 0
        }
    }
    
    
    
    
}


extension SportsSearchTVCell {
    
    
    //MARK: - showdepDatePicker
    func showdepDatePicker(){
        //Formate Date
        depDatePicker.datePickerMode = .date
        depDatePicker.minimumDate = Date()
        depDatePicker.preferredDatePickerStyle = .wheels
        
        let formter = DateFormatter()
        formter.dateFormat = "dd-MM-yyyy"
        
        
        if let sportcalDepDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.sportcalDepDate) ?? "") {
            depDatePicker.date = sportcalDepDate
            
            if self.retDatelbl.text == "Select Date" {
                retDatePicker.date = sportcalDepDate
            }
            
            // Check if checkout date is smaller than checkin date
            if let sportcalRetDate = formter.date(from: self.retDatelbl.text ?? ""),
               sportcalRetDate < sportcalDepDate {
                retDatePicker.date = sportcalDepDate
                
                // Also update the label to reflect the change
                self.retDatelbl.text = formter.string(from: sportcalDepDate)
            }
        }
        
        
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        self.depDateTF.inputAccessoryView = toolbar
        self.depDateTF.inputView = depDatePicker
        
    }
    
    
    
    
    
    
    //MARK: - showretDatePicker
    func showretDatePicker(){
        //Formate Date
        retDatePicker.datePickerMode = .date
        //        retDatePicker.minimumDate = Date()
        // Set minimumDate for retDatePicker based on depDatePicker or retdepDatePicker
        let selectedDate = self.depDateTF.isFirstResponder ? depDatePicker.date : retDatePicker.date
        retDatePicker.minimumDate = selectedDate
        
        retDatePicker.preferredDatePickerStyle = .wheels
        
        
        let formter = DateFormatter()
        formter.dateFormat = "dd-MM-yyyy"
        
        
        if let sportcalDepDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.sportcalDepDate) ?? "") {
            
            if self.retDatelbl.text == "Select Date" {
                retDatePicker.date = sportcalDepDate
                
            }else {
                if let sportcalRetDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.sportcalRetDate) ?? "") {
                    retDatePicker.date = sportcalRetDate
                }
            }
        }
        
        
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        self.retDateTF.inputAccessoryView = toolbar
        self.retDateTF.inputView = retDatePicker
        
        
    }
    
    
    @objc func donedatePicker(){
        depDatelbl.textColor = .TitleColor
        retDatelbl.textColor = .TitleColor
        
        delegate?.donedatePicker(cell:self)
    }
    
    
    @objc func cancelDatePicker(){
        delegate?.cancelDatePicker(cell:self)
    }
    
}
