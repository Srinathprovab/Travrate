//
//  BookTransfersTVCell.swift
//  Travgate
//
//  Created by FCI on 08/05/24.
//

import UIKit
import DropDown

protocol BookTransfersTVCellDelegate: AnyObject {
    func donedatePicker(cell:BookTransfersTVCell)
    func cancelDatePicker(cell:BookTransfersTVCell)
    func doneTimePicker(cell:BookTransfersTVCell)
    func cancelTimePicker(cell:BookTransfersTVCell)
    func didTapOnSearchBtnAction(cell:BookTransfersTVCell)
    func didTapOnTransferCityBtnAction(cell:BookTransfersTVCell)
    
}

class BookTransfersTVCell: TableViewCell, GetTransferCityVMDelegate {
    
    
    
    @IBOutlet weak var fromView: BorderedView!
    @IBOutlet weak var fromTF: UITextField!
    @IBOutlet weak var toView: BorderedView!
    @IBOutlet weak var toTF: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var depDateTF: UITextField!
    @IBOutlet weak var depTimeTF: UITextField!
    @IBOutlet weak var retDateTF: UITextField!
    @IBOutlet weak var retTimeTF: UITextField!
    @IBOutlet weak var returnView: BorderedView!
    @IBOutlet weak var fromtv: UITableView!
    @IBOutlet weak var totv: UITableView!
    @IBOutlet weak var fromtvheiht: NSLayoutConstraint!
    @IBOutlet weak var totvheiht: NSLayoutConstraint!
    
    var isSearchBool = Bool()
    var searchText = String()
    var txtbool = Bool()
    var filterdcountrylist = [GetTransferCityModel]()
    var transfercitylist = [GetTransferCityModel]()
    
    var transfercitynamesArray = [String]()
    var transfercityidArray = [String]()
    
    let depDatePicker = UIDatePicker()
    let retDatePicker = UIDatePicker()
    let timePicker = UIDatePicker()
    let returntimePicker = UIDatePicker()
    
    
    weak var delegate:BookTransfersTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        
        MySingleton.shared.transferCityVM = GetTransferCityVM(self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupUI() {
        
        setupTF(tf: depDateTF)
        setupTF(tf: depTimeTF)
        setupTF(tf: retDateTF)
        setupTF(tf: retTimeTF)
        
        returnView.isHidden = true
        searchBtn.layer.cornerRadius = 6
        
        showdepDatePicker()
        showretDatePicker()
        showDepTimePicker()
        showReturnTimePicker()
        
        
        fromTF.tag = 1
        fromTF.textColor = .TitleColor
        fromTF.font = .OpenSansMedium(size: 16)
        fromTF.delegate = self
        fromTF.addTarget(self, action: #selector(textFiledEditingChanged(_:)), for: .editingChanged)
        fromTF.setLeftPaddingPoints(35)
        
        toTF.tag = 2
        toTF.textColor = .TitleColor
        toTF.font = .OpenSansMedium(size: 16)
        toTF.delegate = self
        toTF.addTarget(self, action: #selector(textFiledEditingChanged(_:)), for: .editingChanged)
        toTF.setLeftPaddingPoints(35)
        
        fromtv.layer.borderWidth = 1
        fromtv.layer.borderColor = UIColor.AppBorderColor.cgColor
        totv.layer.borderWidth = 1
        totv.layer.borderColor = UIColor.AppBorderColor.cgColor
        
        
    }
    
    override func updateUI() {
        
        setupTV()
        fromtvheiht.constant = 0
        totvheiht.constant = 0
        
        
        let journytype = defaults.string(forKey: UserDefaultsKeys.transferjournytype)
        if journytype == "oneway" {
            
            
            
            fromTF.text = defaults.string(forKey: UserDefaultsKeys.transferfromcityname) ?? "From Airport*"
            toTF.text = defaults.string(forKey: UserDefaultsKeys.transfertocityname) ?? "To Airport*"
            
            returnView.isHidden = true
            depDateTF.text = defaults.string(forKey: UserDefaultsKeys.transfercalDepDate) ?? ""
            depTimeTF.text = defaults.string(forKey: UserDefaultsKeys.transfercalDepTime) ?? ""
            
            defaults.set("Select Date*", forKey: UserDefaultsKeys.transfercalRetDate)
            defaults.set("Select Time*", forKey: UserDefaultsKeys.transfercalRetTime)
            
        }else {
            returnView.isHidden = false
            depDateTF.text = defaults.string(forKey: UserDefaultsKeys.transfercalDepDate) ?? ""
            retDateTF.text = defaults.string(forKey: UserDefaultsKeys.transfercalRetDate) ?? ""
            
            depTimeTF.text = defaults.string(forKey: UserDefaultsKeys.transfercalDepTime) ?? ""
            retTimeTF.text = defaults.string(forKey: UserDefaultsKeys.transfercalRetTime) ?? ""
        }
        
        
        
        guard let transferfromcityname =  defaults.string(forKey: UserDefaultsKeys.transferfromcityname) else {return}
        guard let transfertocityname =  defaults.string(forKey: UserDefaultsKeys.transfertocityname) else {return}
        guard let transfercalDepDate =  defaults.string(forKey: UserDefaultsKeys.transfercalDepDate) else {return}
        guard let transfercalDepTime =  defaults.string(forKey: UserDefaultsKeys.transfercalDepTime) else {return}
        guard let transfercalRetDate =  defaults.string(forKey: UserDefaultsKeys.transfercalRetDate) else {return}
        guard let transfercalRetTime =  defaults.string(forKey: UserDefaultsKeys.transfercalRetTime) else {return}
       
        
        fromTF.textColor = (transferfromcityname == "From Airport*") ? .subtitleNewcolor : .TitleColor
        toTF.textColor = (transfertocityname == "To Airport*") ? .subtitleNewcolor : .TitleColor
        depDateTF.textColor = (transfercalDepDate == "Select Date*") ? .subtitleNewcolor : .TitleColor
        depTimeTF.textColor = (transfercalDepTime == "Select Time*") ? .subtitleNewcolor : .TitleColor
        retDateTF.textColor = (transfercalRetDate == "Select Date*") ? .subtitleNewcolor : .TitleColor
        retTimeTF.textColor = (transfercalRetTime == "Select Time*") ? .subtitleNewcolor : .TitleColor

        
        
    }
    
    
    func setupTF(tf:UITextField) {
        tf.textColor = .subtitleNewcolor.withAlphaComponent(0.5)
        tf.font = .OpenSansRegular(size: 14)
        tf.setLeftPaddingPoints(40)
        tf.addTarget(self, action: #selector(editingTextField(_:)), for: .editingChanged)
    }
    
    @objc func editingTextField(_ textfield:UITextField) {
        print(textfield.text)
    }
    
    
    @IBAction func didTapOnSearchBtnAction(_ sender: Any) {
        delegate?.didTapOnSearchBtnAction(cell: self)
    }
    
    
    @IBAction func clearFromTextFieldBtnAction(_ sender: Any) {
        fromTF.text = ""
        fromTF.becomeFirstResponder()
        callGetCityListAPI(text: "")
    }
    
    @IBAction func didTapOnClearToTFBtnAction(_ sender: Any) {
        toTF.text = ""
        toTF.becomeFirstResponder()
        callGetCityListAPI(text: "")
    }
    
}


extension BookTransfersTVCell {
    
    //MARK: - showTimePicker
    func showDepTimePicker() {
        // Format Time
        
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        
        // Set 24-hour format
        timePicker.locale = Locale(identifier: "en_GB")
        
        if let selectedTime = defaults.string(forKey: UserDefaultsKeys.transfercalDepTime) {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            if let selectedDate = formatter.date(from: selectedTime) {
                timePicker.date = selectedDate
            }
        }
        
        //ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTimePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTimePicker))
        
        toolbar.setItems([doneButton, spaceButton, cancelButton], animated: false)
        
        self.depTimeTF.inputAccessoryView = toolbar
        self.depTimeTF.inputView = timePicker
    }
    
    
    
    
    //MARK: - showTimePicker
    func showReturnTimePicker() {
        // Format Time
        
        returntimePicker.datePickerMode = .time
        returntimePicker.preferredDatePickerStyle = .wheels
        
        // Set 24-hour format
        returntimePicker.locale = Locale(identifier: "en_GB")
        
        if let selectedTime = defaults.string(forKey: UserDefaultsKeys.transfercalRetTime) {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            if let selectedDate = formatter.date(from: selectedTime) {
                returntimePicker.date = selectedDate
            }
        }
        
        //ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTimePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTimePicker))
        
        toolbar.setItems([doneButton, spaceButton, cancelButton], animated: false)
        
        self.retTimeTF.inputAccessoryView = toolbar
        self.retTimeTF.inputView = returntimePicker
    }
    
    @objc func doneTimePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        if cellInfo?.key == "oneway" {
            self.depTimeTF.text = formatter.string(from: timePicker.date)
            defaults.set(formatter.string(from: timePicker.date), forKey: UserDefaultsKeys.transfercalDepTime)
            self.depTimeTF.resignFirstResponder()
            
        }else {
            self.depTimeTF.text = formatter.string(from: timePicker.date)
            self.retTimeTF.text = formatter.string(from: returntimePicker.date)
            defaults.set(formatter.string(from: timePicker.date), forKey: UserDefaultsKeys.transfercalDepTime)
            defaults.set(formatter.string(from: returntimePicker.date), forKey: UserDefaultsKeys.transfercalRetTime)
            
            self.depTimeTF.resignFirstResponder()
            self.retTimeTF.resignFirstResponder()
            
            self.depTimeTF.textColor = .TitleColor
            self.retTimeTF.textColor = .TitleColor
            
        }
        
        delegate?.doneTimePicker(cell: self)
    }
    
    @objc func cancelTimePicker() {
        
//        if cellInfo?.key == "oneway" {
//            self.depTimeTF.textColor = .TitleColor
//            self.depTimeTF.resignFirstResponder()
//            
//        }else {
//            
//            self.depTimeTF.textColor = .TitleColor
//            self.retTimeTF.textColor = .TitleColor
//            
//            self.depTimeTF.resignFirstResponder()
//            self.retTimeTF.resignFirstResponder()
//        }
        self.depTimeTF.resignFirstResponder()
        self.retTimeTF.resignFirstResponder()
        
        delegate?.cancelTimePicker(cell: self)
    }
}


//MARK: - Text Filed Editing Changed
extension BookTransfersTVCell {
    
    
    @objc func textFiledEditingChanged(_ textField:UITextField) {
        
        
        if textField.tag == 1 {
            txtbool = true
            callGetCityListAPI(text: textField.text ?? "")
        }else {
            txtbool = false
            callGetCityListAPI(text: textField.text ?? "")
        }
        
        
    }
    
    
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == fromTF {
            txtbool = true
            fromTF.text = ""
            fromTF.textColor = .TitleColor
            fromTF.placeholder = "From Airport"
           // callGetCityListAPI(text: textField.text ?? "")
            
        }else {
            txtbool = false
            toTF.text = ""
            toTF.textColor = .TitleColor
            toTF.placeholder = "To AirPort"
           // callGetCityListAPI(text: textField.text ?? "")
            
        }
    }
    
    
    
    
}


extension BookTransfersTVCell:UITableViewDelegate, UITableViewDataSource {
    
    
    func callGetCityListAPI(text: String) {
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["term"] = text
        MySingleton.shared.transferCityVM?.CALL_GET_CITY_LIST_API(dictParam: MySingleton.shared.payload)
    }
    
    func transferCitylist(response: [GetTransferCityModel]) {
        transfercitylist = response
       
        if txtbool == true {
            fromtvheiht.constant = CGFloat(transfercitylist.count * 50)
            totvheiht.constant = 0
            DispatchQueue.main.async {[self] in
                fromtv.reloadData()
            }
        }else {
            totvheiht.constant = CGFloat(transfercitylist.count * 50)
            fromtvheiht.constant = 0
            DispatchQueue.main.async {[self] in
                totv.reloadData()
            }
        }
    }
    
    func setupTV() {
        fromtv.delegate = self
        fromtv.dataSource = self
        fromtv.register(UINib(nibName: "TitleLblTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        totv.delegate = self
        totv.dataSource = self
        totv.register(UINib(nibName: "TitleLblTVCell", bundle: nil), forCellReuseIdentifier: "cell1")
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transfercitylist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        
        if txtbool == true {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TitleLblTVCell {
                cell.selectionStyle = .none
                
                cell.titlelbl.text = transfercitylist[indexPath.row].label
                cell.titlelbl.textColor = .TitleColor
                cell.cityid = transfercitylist[indexPath.row].place_id ?? ""
                cell.lat = transfercitylist[indexPath.row].latitude ?? ""
                cell.lang = transfercitylist[indexPath.row].longitude ?? ""
                
                
                ccell = cell
            }
        }else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as? TitleLblTVCell {
                cell.selectionStyle = .none
                cell.titlelbl.text = transfercitylist[indexPath.row].label
                cell.cityid = transfercitylist[indexPath.row].place_id ?? ""
                cell.lat = transfercitylist[indexPath.row].latitude ?? ""
                cell.lang = transfercitylist[indexPath.row].longitude ?? ""
                ccell = cell
            }
        }
        
        return ccell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? TitleLblTVCell {
            
            
            if txtbool == true {
                
              
                fromTF.text = cell.titlelbl.text
                fromTF.textColor = .TitleColor
                fromTF.resignFirstResponder()
                defaults.setValue(cell.titlelbl.text, forKey: UserDefaultsKeys.transferfromcityname)
                defaults.setValue(cell.cityid, forKey: UserDefaultsKeys.transferfromcityid)
                
                defaults.setValue(cell.lat, forKey: UserDefaultsKeys.transferfromlat)
                defaults.setValue(cell.lang, forKey: UserDefaultsKeys.transferfromlang)
                
                fromtvheiht.constant = 0
                totvheiht.constant = 0
            }else {
                
               
                toTF.text = cell.titlelbl.text
                toTF.textColor = .TitleColor
                toTF.resignFirstResponder()
                defaults.setValue(cell.titlelbl.text, forKey: UserDefaultsKeys.transfertocityname)
                defaults.setValue(cell.cityid, forKey: UserDefaultsKeys.transfertocityid)
                
                defaults.setValue(cell.lat, forKey: UserDefaultsKeys.transfertolat)
                defaults.setValue(cell.lang, forKey: UserDefaultsKeys.transfertolang)
                
                fromtvheiht.constant = 0
                totvheiht.constant = 0
            }
        }
        
        
       // delegate?.didTapOnTransferCityBtnAction(cell: self)
        
    }
    
    
    
    
}





//MARK: - shouldChangeCharactersIn
extension BookTransfersTVCell {
    
    //MARK - UITextField Delegates
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //For mobile numer validation
        let maxLength = 100
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
        //  return true
    }
    
    
}


//MARK: - showdepDatePicker
extension BookTransfersTVCell {
    
    func showdepDatePicker(){
        //Formate Date
        depDatePicker.datePickerMode = .date
        depDatePicker.minimumDate = Date()
        depDatePicker.preferredDatePickerStyle = .wheels
        
        let formter = DateFormatter()
        formter.dateFormat = "dd-MM-yyyy"
        
        
        if let sportcalDepDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.pickuplocDate) ?? "") {
            depDatePicker.date = sportcalDepDate
            
            if self.depDateTF.text == "Select Date" {
                retDatePicker.date = sportcalDepDate
            }
            
            // Check if checkout date is smaller than checkin date
            if let sportcalRetDate = formter.date(from: self.depDateTF.text ?? ""),
               sportcalRetDate < sportcalDepDate {
                retDatePicker.date = sportcalDepDate
                
                // Also update the label to reflect the change
                self.depDateTF.text = formter.string(from: sportcalDepDate)
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
        
        
        if let sportcalDepDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.pickuplocDate) ?? "") {
            
            if self.depDateTF.text == "Select Date" {
                retDatePicker.date = sportcalDepDate
                
            }else {
                if let sportcalRetDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.dropuplocDate) ?? "") {
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
        depDateTF.textColor = .TitleColor
        retDateTF.textColor = .TitleColor
        
        delegate?.donedatePicker(cell:self)
    }
    
    
    @objc func cancelDatePicker(){
        delegate?.cancelDatePicker(cell:self)
    }
    
}
