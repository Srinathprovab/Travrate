//
//  SportsSearchTVCell.swift
//  Travgate
//
//  Created by FCI on 10/05/24.
//

import UIKit
import DropDown

protocol SportsSearchTVCellDelegate {
    
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
    
    @IBOutlet weak var teamTV: UITableView!
    @IBOutlet weak var teamTVheight: NSLayoutConstraint!
    @IBOutlet weak var venuTV: UITableView!
    @IBOutlet weak var venuTVHeight: NSLayoutConstraint!
    
    
    var txtbool = Bool()
    var sportCityNameArray = [String]()
    var sportCityIdArray = [String]()
    let depDatePicker = UIDatePicker()
    let retDatePicker = UIDatePicker()
    let dropDown = DropDown()
    
    var delegate:SportsSearchTVCellDelegate?
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
        
//        showdepDatePicker()
//        showretDatePicker()
        
        showCheckInDatePicker()
        showCheckoutDatePicker()
        
        searchbtn.layer.cornerRadius = 4
        
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
        
        teamTV.layer.borderWidth = 1
        teamTV.layer.borderColor = UIColor.AppBorderColor.cgColor
        
        
        venuTV.layer.borderWidth = 1
        venuTV.layer.borderColor = UIColor.AppBorderColor.cgColor
        
    }
    
    override func updateUI() {
        
        
        setupTV()
        teamTVheight.constant = 0
        venuTVHeight.constant = 0
        // CallSportTeamListAPI(str: "")
        
        sportCityNameArray.removeAll()
        sportCityNameArray.append("Please Select Service")
        sportCityIdArray.append("")
        MySingleton.shared.sportsCityList.forEach { i in
            sportCityNameArray.append("\(i.value ?? "")")
            sportCityIdArray.append("\(i.id ?? "")")
        }
        
        setupDropDown()
        
        if MySingleton.shared.sportscityName.isEmpty == false {
            selectServicelbl.text = MySingleton.shared.sportscityName
            selectServicelbl.textColor = .TitleColor
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
        
        
    }
    
    
    @IBAction func didTapOnClearvenuTFBtnAction(_ sender: Any) {
        venuTF.text = ""
    }
    @IBAction func didTapOnClearTeamTFBtnAction(_ sender: Any) {
        teamTF.text = ""
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
            
            self?.delegate?.didTapOnSelectServiceBtn(cell: self!)
            
        }
    }
    

    
    
}



extension SportsSearchTVCell:UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - setupTV
    func setupTV() {
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
            txtbool = true
            CallSportTeamListAPI(str: textField.text ?? "")
        }else {
            txtbool = false
            CallSportVenuListAPI(str: textField.text ?? "")
        }
        
        
    }
    
    
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == teamTF {
            teamTF.placeholder = ""
            //  CallSportTeamListAPI(str: textField.text ?? "")
        }else {
            venuTF.placeholder = ""
            //   CallSportVenuListAPI(str: textField.text ?? "")
        }
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
        if txtbool == true {
            
            MySingleton.shared.sportsTeamtList = response.data ?? []
            teamTVheight.constant = 260
            venuTVHeight.constant = 0
            
            DispatchQueue.main.async {[self] in
                teamTV.reloadData()
            }
        }else {
            
            MySingleton.shared.sportsVenuList = response.data ?? []
           
            
            
            venuTVHeight.constant = 260
            teamTVheight.constant = 0
            
            DispatchQueue.main.async {[self] in
                venuTV.reloadData()
            }
        }
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == teamTV {
            return MySingleton.shared.sportsTeamtList.count
        }else {
            return MySingleton.shared.sportsVenuList.count
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
        }else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as? SelectSportServiceTVCell {
                cell.selectionStyle = .none
                let data = MySingleton.shared.sportsVenuList[indexPath.row]
                cell.titlelbl.text = data.name
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
                venuTF.becomeFirstResponder()
                MySingleton.shared.sportsTeamName = cell.titlelbl.text ?? ""
                MySingleton.shared.sportsTeamId = cell.teamid
                
            }else {
                
                venuTF.text = cell.titlelbl.text ?? ""
                venuTF.resignFirstResponder()
                MySingleton.shared.sportsVenuName = cell.titlelbl.text ?? ""
                MySingleton.shared.sportsVenuId = cell.venuId
                
                
                
            }
            
            teamTVheight.constant = 0
            venuTVHeight.constant = 0
        }
    }
    
    
    
    
}



extension SportsSearchTVCell {


    //MARK: - showdepDatePicker
    func showCheckInDatePicker(){
        //Formate Date
        depDatePicker.datePickerMode = .date
        depDatePicker.minimumDate = Date()
        depDatePicker.preferredDatePickerStyle = .wheels

        let formter = DateFormatter()
        formter.dateFormat = "dd-MM-yyyy"


        if let checkindate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.sportcalDepDate) ?? "") {
            depDatePicker.date = checkindate

            if self.retDatelbl.text == "Select date" {
                retDatePicker.date = checkindate
            }

            // Check if checkout date is smaller than checkin date
            if let checkoutDate = formter.date(from: self.retDatelbl.text ?? ""),
               checkoutDate < checkindate {
                retDatePicker.date = checkindate

                // Also update the label to reflect the change
                self.retDatelbl.text = formter.string(from: checkindate)
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
    func showCheckoutDatePicker(){
        //Formate Date
        retDatePicker.datePickerMode = .date
        //        retDatePicker.minimumDate = Date()
        // Set minimumDate for retDatePicker based on depDatePicker or retdepDatePicker
        let selectedDate = self.depDateTF.isFirstResponder ? depDatePicker.date : retDatePicker.date
        retDatePicker.minimumDate = selectedDate

        retDatePicker.preferredDatePickerStyle = .wheels


        let formter = DateFormatter()
        formter.dateFormat = "dd-MM-yyyy"



        if let checkindate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.sportcalDepDate) ?? "") {

            if self.retDatelbl.text == "Select date" {
                retDatePicker.date = checkindate

            }else {
                if let checkoutdate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.sportcalRetDate) ?? "") {
                    retDatePicker.date = checkoutdate
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
