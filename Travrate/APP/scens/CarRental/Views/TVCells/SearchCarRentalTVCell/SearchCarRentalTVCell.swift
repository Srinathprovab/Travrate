//
//  SearchCarRentalTVCell.swift
//  Travrate
//
//  Created by FCI on 10/06/24.
//

import UIKit
import DropDown

protocol SearchCarRentalTVCellDelegate:AnyObject {
    func didTapOnPickupLocationBtnAction(cell:SearchCarRentalTVCell)
    func didTapOnSearchBtnAction(cell:SearchCarRentalTVCell)
    func tfeditingChanged(tf: UITextField)
    func donedatePicker(cell:SearchCarRentalTVCell)
    func cancelDatePicker(cell:SearchCarRentalTVCell)
    func doneTimePicker(cell:SearchCarRentalTVCell)
}

class SearchCarRentalTVCell: TableViewCell, PickuplocationListVMDelegate {
    
    
    @IBOutlet weak var dropoffViewHeight: NSLayoutConstraint!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var pickuplocTF: UITextField!
    @IBOutlet weak var pickuplocTV: UITableView!
    @IBOutlet weak var dropuplocTF: UITextField!
    @IBOutlet weak var dropuplocView: BorderedView!
    @IBOutlet weak var dropuplocHolderView: UIView!
    @IBOutlet weak var pickupDatelbl: UILabel!
    @IBOutlet weak var pickupDateTF: UITextField!
    @IBOutlet weak var dropupDatelbl: UILabel!
    @IBOutlet weak var dropupDateTF: UITextField!
    @IBOutlet weak var pickupTimelbl: UILabel!
    @IBOutlet weak var pickupTimeTF: UITextField!
    @IBOutlet weak var dropupTimelbl: UILabel!
    @IBOutlet weak var dropupTimeTF: UITextField!
    @IBOutlet weak var driverAgeView: UIView!
    @IBOutlet weak var driverAgelbl: UILabel!
    @IBOutlet weak var dropofSameCheckImage: UIImageView!
    @IBOutlet weak var dropofDiffCheckImage: UIImageView!
    @IBOutlet weak var tvheight: NSLayoutConstraint!
    @IBOutlet weak var dropofflocTV: UITableView!
    @IBOutlet weak var dropofftvheight: NSLayoutConstraint!
    
    
    
    var searchbool = false
    var samelocbool = false
    var difflocbool = false
    let pickupTimePicker = UIDatePicker()
    let dropupTimePicker = UIDatePicker()
    let pickupDatePicker = UIDatePicker()
    let dropupDatePicker = UIDatePicker()
    let dropDown = DropDown()
    let dropofdropdown = DropDown()
    
    var filterdcountrylist = [PickuplocationListModel]()
    var dropofLocationNamesArray = [String]()
    var dropofLocCodeArray = [String]()
    var isSearchBool = Bool()
    var searchText = String()
    
    var locaionList = [PickuplocationListModel]()
    var Pickupvvm :PickuplocationListVM?
    weak var delegate:SearchCarRentalTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        
        
        Pickupvvm = PickuplocationListVM(self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setupUI() {
        
        dropoffViewHeight.constant = 15
        dropofSameCheckImage.image = UIImage(named: "check")?.withRenderingMode(.alwaysOriginal)
        
        if pickuplocTF.text?.isEmpty == false {
            pickuplocTF.textColor = .TitleColor
        }
        
        pickuplocTF.textColor = .SubTitleColor
        pickuplocTF.font = .OpenSansMedium(size: 16)
        pickuplocTF.delegate = self
        pickuplocTF.addTarget(self, action: #selector(textFiledEditingChanged(_:)), for: .editingChanged)
        
        dropuplocTF.textColor = .SubTitleColor
        dropuplocTF.font = .OpenSansMedium(size: 16)
        dropuplocTF.delegate = self
        dropuplocTF.addTarget(self, action: #selector(textFiledEditingChanged(_:)), for: .editingChanged)
        
        pickuplocTV.layer.borderWidth = 1
        pickuplocTV.layer.borderColor = UIColor.AppBorderColor.cgColor
        dropofflocTV.layer.borderWidth = 1
        dropofflocTV.layer.borderColor = UIColor.AppBorderColor.cgColor
        
    }
    
    
    override func updateUI() {
        
        
        pickuplocTF.text = defaults.string(forKey: UserDefaultsKeys.pickuplocationname) ?? ""
        dropuplocTF.text = defaults.string(forKey: UserDefaultsKeys.dropuplocationname) ?? ""
        pickupDatelbl.text = defaults.string(forKey: UserDefaultsKeys.pickuplocDate) ?? "Select Date"
        dropupDatelbl.text = defaults.string(forKey: UserDefaultsKeys.dropuplocDate) ?? "Select Date"
        pickupTimelbl.text = defaults.string(forKey: UserDefaultsKeys.pickuplocTime) ?? "Select Time"
        dropupTimelbl.text = defaults.string(forKey: UserDefaultsKeys.dropuplocTime) ?? "Select Time"
        driverAgelbl.text = defaults.string(forKey: UserDefaultsKeys.driverage) ?? "Select Driver's Age"
        
       

        updateLabelColor(label: pickupDatelbl, defaultText: "Select Date", defaultColor: .subtitleNewcolor, selectedColor: .TitleColor)
        updateLabelColor(label: dropupDatelbl, defaultText: "Select Date", defaultColor: .subtitleNewcolor, selectedColor: .TitleColor)
        updateLabelColor(label: pickupTimelbl, defaultText: "Select Time", defaultColor: .subtitleNewcolor, selectedColor: .TitleColor)
        updateLabelColor(label: dropupTimelbl, defaultText: "Select Time", defaultColor: .subtitleNewcolor, selectedColor: .TitleColor)
        updateLabelColor(label: driverAgelbl, defaultText: "Select Driver's Age", defaultColor: .subtitleNewcolor, selectedColor: .TitleColor)

        
        
        pickuplocTF.textColor = pickuplocTF.text != "Select Location" ? .TitleColor : .subtitleNewcolor
        dropuplocTF.textColor = pickuplocTF.text != "Select Location" ? .TitleColor : .subtitleNewcolor
        
        
        func updateLabelColor(label: UILabel, defaultText: String, defaultColor: UIColor, selectedColor: UIColor) {
            label.textColor = label.text == defaultText ? defaultColor : selectedColor
        }
        
        setupTV()
        tvheight.constant = 0
        dropofftvheight.constant = 0
        
        searchBtn.layer.cornerRadius = 4
        pickuplocTF.addTarget(self, action: #selector(tfeditingChanged(_:)), for: .editingChanged)
        dropuplocTF.addTarget(self, action: #selector(tfeditingChanged(_:)), for: .editingChanged)
        setupDropDown()
        setupDropofDropDown()
        showpickupDatePicker()
        showdropupDatePicker()
        
        showPickupTimePicker()
        showDepartTimePicker()
        
        
        
//        dropuplocTF.addTarget(self, action: #selector(searchTextChanged(textField:)), for: .editingChanged)
//        dropuplocTF.addTarget(self, action: #selector(searchTextBegin(textField:)), for: .editingDidBegin)
    }
    
    @objc func tfeditingChanged(_ tf: UITextField) {
        delegate?.tfeditingChanged(tf: tf)
    }
    
    
    @IBAction func didTapOnSearchBtnAction(_ sender: Any) {
        delegate?.didTapOnSearchBtnAction(cell: self)
    }
    
    
    
    @IBAction func didTapOnClearPickuplocTFbtnAction(_ sender: Any) {
        tvheight.constant = 0
        pickuplocTF.text = ""
        pickuplocTF.becomeFirstResponder()
    }
    
    
    @IBAction func didTapOnClearDropuplocTFbtnAction(_ sender: Any) {
        dropofftvheight.constant = 0
        dropuplocTF.text = ""
        dropuplocTF.becomeFirstResponder()
    }
    
    @IBAction func didTapOnSelectAgeBtnAction(_ sender: Any) {
        dropDown.show()
    }
    
    
    @IBAction func didTapOnDropOfSameLocBtnAction(_ sender: Any) {
                
        dropoffViewHeight.constant = 15
        dropuplocHolderView.isHidden = true
        dropofSameCheckImage.image = UIImage(named: "check")?.withRenderingMode(.alwaysOriginal)
        dropofDiffCheckImage.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal)
        NotificationCenter.default.post(name: NSNotification.Name("reloadTV"), object: nil)

    }
    
    
    @IBAction func didTapOnDropOfDifferentLocBtnAction(_ sender: Any) {
        dropoffViewHeight.constant = 110
        dropuplocHolderView.isHidden = false
        dropofSameCheckImage.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal)
        dropofDiffCheckImage.image = UIImage(named: "check")?.withRenderingMode(.alwaysOriginal)
        NotificationCenter.default.post(name: NSNotification.Name("reloadTV"), object: nil)
    }
    
}


extension SearchCarRentalTVCell {
    
    func setupDropDown() {
        var ages = [String]()
        ages.removeAll()
        for i in 18...65 {
            ages.append("\(i)")
        }
        
        dropDown.dataSource = ages
        dropDown.direction = .bottom
        dropDown.backgroundColor = .WhiteColor
        dropDown.anchorView = self.driverAgeView
        dropDown.bottomOffset = CGPoint(x: 0, y: driverAgeView.frame.size.height + 10)
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            
            self?.driverAgelbl.text = item
            self?.driverAgelbl.textColor = .TitleColor
            MySingleton.shared.carRentalDriverAge = item
            defaults.set(item, forKey: UserDefaultsKeys.driverage)
            
        }
    }
}


extension SearchCarRentalTVCell:UITableViewDelegate, UITableViewDataSource  {
    
    //MARK: - Text Filed Editing Changed
    @objc func textFiledEditingChanged(_ textField:UITextField) {
        
        if textField == pickuplocTF {
            searchbool = true
            if textField.text?.isEmpty == true {
            }else {
                CallLocationListAPI(str: textField.text ?? "")
            }
        }else {
            searchbool = false
            if textField.text?.isEmpty == true {
            }else {
                CallLocationListAPI(str: textField.text ?? "")
            }
        }
       
        
    }
    
    
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        if textField == pickuplocTF {
            searchbool = true
            pickuplocTF.text = ""
            pickuplocTF.textColor = .TitleColor
            pickuplocTF.placeholder = "Pick Up Location"
            CallLocationListAPI(str: textField.text ?? "")
        }else {
            searchbool = false
            dropuplocTF.text = ""
            dropuplocTF.textColor = .TitleColor
            dropuplocTF.placeholder = "Drop Off Location"
            CallLocationListAPI(str: textField.text ?? "")
        }
    }
    
    
    
    
    
    func CallLocationListAPI(str:String) {
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["term"] = str
        Pickupvvm?.CALL_PICKUP_LOCATION_LIST_API(dictParam: MySingleton.shared.payload)
    }
    
    
    func locationListResponse(response: [PickuplocationListModel]) {
        locaionList = response
        filterdcountrylist = locaionList
        if searchbool == true {
            tvheight.constant = CGFloat(locaionList.count * 50)
            DispatchQueue.main.async {[self] in
                pickuplocTV.reloadData()
            }
        }else {
            dropoffViewHeight.constant = CGFloat(locaionList.count * 50)
            DispatchQueue.main.async {[self] in
                dropofflocTV.reloadData()
            }
        }
        
    }
    
    func setupTV() {
        
        pickuplocTV.delegate = self
        pickuplocTV.dataSource = self
        pickuplocTV.register(UINib(nibName: "TitleLblTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        dropofflocTV.delegate = self
        dropofflocTV.dataSource = self
        dropofflocTV.register(UINib(nibName: "TitleLblTVCell", bundle: nil), forCellReuseIdentifier: "cell1")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  searchbool == true  {
            return locaionList.count
        }else {
            return locaionList.count
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        
        if searchbool == true  {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TitleLblTVCell {
                cell.selectionStyle = .none
                cell.titlelbl.text = locaionList[indexPath.row].label
                cell.titlelbl.textColor = .TitleColor
                
                ccell = cell
            }
        }else {
            
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as? TitleLblTVCell {
                cell.selectionStyle = .none
                cell.titlelbl.text = locaionList[indexPath.row].label
                cell.titlelbl.textColor = .TitleColor
                
                ccell = cell
            }
        }
        
        
        return ccell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? TitleLblTVCell {
            
            
            
            if tableView == pickuplocTV {
                self.pickuplocTF.text = locaionList[indexPath.row].value
                defaults.set(locaionList[indexPath.row].value, forKey: UserDefaultsKeys.pickuplocationname)
                defaults.set(locaionList[indexPath.row].id, forKey: UserDefaultsKeys.pickuplocationcode)
                pickuplocTF.textColor = .TitleColor
                pickuplocTF.resignFirstResponder()
                tvheight.constant = 0
            }else {
                self.dropuplocTF.text = locaionList[indexPath.row].value
                defaults.set(locaionList[indexPath.row].value, forKey: UserDefaultsKeys.dropuplocationname)
                defaults.set(locaionList[indexPath.row].id, forKey: UserDefaultsKeys.dropuplocationcode)
                dropuplocTF.textColor = .TitleColor
                dropuplocTF.resignFirstResponder()
                dropofftvheight.constant = 0
            }
            
           
            delegate?.didTapOnPickupLocationBtnAction(cell: self)
            
            
        }
    }
    
}


//MARK: - showTimePicker
extension SearchCarRentalTVCell {
    
    
    func showPickupTimePicker() {
        // Format Time
        
        pickupTimePicker.datePickerMode = .time
        pickupTimePicker.preferredDatePickerStyle = .wheels
        
        // Set 24-hour format
        pickupTimePicker.locale = Locale(identifier: "en_GB")
        
        if let selectedTime = pickupTimeTF.text {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            if let selectedDate = formatter.date(from: selectedTime) {
                pickupTimePicker.date = selectedDate
            }
        }
        
        //ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTimePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTimePicker))
        
        toolbar.setItems([doneButton, spaceButton, cancelButton], animated: false)
        
        self.pickupTimeTF.inputAccessoryView = toolbar
        self.pickupTimeTF.inputView = pickupTimePicker
    }
    
    
    
    
    //MARK: - showTimePicker
    func showDepartTimePicker() {
        // Format Time
        
        dropupTimePicker.datePickerMode = .time
        dropupTimePicker.preferredDatePickerStyle = .wheels
        
        // Set 24-hour format
        dropupTimePicker.locale = Locale(identifier: "en_GB")
        
        if let selectedTime = dropupTimeTF.text {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            if let selectedDate = formatter.date(from: selectedTime) {
                dropupTimePicker.date = selectedDate
            }
        }
        
        //ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTimePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTimePicker))
        
        toolbar.setItems([doneButton, spaceButton, cancelButton], animated: false)
        
        self.dropupTimeTF.inputAccessoryView = toolbar
        self.dropupTimeTF.inputView = dropupTimePicker
    }
    
    @objc func doneTimePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        self.pickupTimelbl.text = formatter.string(from: pickupTimePicker.date)
        self.dropupTimelbl.text = formatter.string(from: dropupTimePicker.date)
        
        self.pickupTimelbl.textColor = .TitleColor
        self.dropupTimelbl.textColor = .TitleColor
        
        self.pickupTimeTF.resignFirstResponder()
        self.dropupTimeTF.resignFirstResponder()
        
        
        defaults.set( self.pickupTimelbl.text, forKey: UserDefaultsKeys.pickuplocTime)
        defaults.set(self.dropupTimelbl.text, forKey: UserDefaultsKeys.dropuplocTime)
        
        delegate?.doneTimePicker(cell: self)
    }
    
    @objc func cancelTimePicker() {
        
        self.pickupTimeTF.resignFirstResponder()
        self.dropupTimeTF.resignFirstResponder()
        
        // delegate?.cancelTimePicker(cell: self)
    }
}


extension SearchCarRentalTVCell {
    
    
    //MARK: - showpickupDatePicker
    func showpickupDatePicker(){
        //Formate Date
        pickupDatePicker.datePickerMode = .date
        pickupDatePicker.minimumDate = Date()
        pickupDatePicker.preferredDatePickerStyle = .wheels
        
        let formter = DateFormatter()
        formter.dateFormat = "dd-MM-yyyy"
        
        
        if let sportcalDepDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.pickuplocDate) ?? "") {
            pickupDatePicker.date = sportcalDepDate
            
            if self.pickupDatelbl.text == "Select Date" {
                dropupDatePicker.date = sportcalDepDate
            }
            
            // Check if checkout date is smaller than checkin date
            if let sportcalRetDate = formter.date(from: self.pickupDatelbl.text ?? ""),
               sportcalRetDate < sportcalDepDate {
                dropupDatePicker.date = sportcalDepDate
                
                // Also update the label to reflect the change
                self.pickupDatelbl.text = formter.string(from: sportcalDepDate)
            }
        }
        
        
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        self.pickupDateTF.inputAccessoryView = toolbar
        self.pickupDateTF.inputView = pickupDatePicker
        
    }
    
    
    
    
    
    
    //MARK: - showdropupDatePicker
    func showdropupDatePicker(){
        //Formate Date
        dropupDatePicker.datePickerMode = .date
        //        dropupDatePicker.minimumDate = Date()
        // Set minimumDate for dropupDatePicker based on pickupDatePicker or retpickupDatePicker
        let selectedDate = self.pickupDateTF.isFirstResponder ? pickupDatePicker.date : dropupDatePicker.date
        dropupDatePicker.minimumDate = selectedDate
        
        dropupDatePicker.preferredDatePickerStyle = .wheels
        
        
        let formter = DateFormatter()
        formter.dateFormat = "dd-MM-yyyy"
        
        
        if let sportcalDepDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.pickuplocDate) ?? "") {
            
            if self.pickupDatelbl.text == "Select Date" {
                dropupDatePicker.date = sportcalDepDate
                
            }else {
                if let sportcalRetDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.dropuplocDate) ?? "") {
                    dropupDatePicker.date = sportcalRetDate
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
        
        self.dropupDateTF.inputAccessoryView = toolbar
        self.dropupDateTF.inputView = dropupDatePicker
        
        
    }
    
    
    @objc func donedatePicker(){
        pickupDatelbl.textColor = .TitleColor
        dropupDatelbl.textColor = .TitleColor
        
        delegate?.donedatePicker(cell:self)
    }
    
    
    @objc func cancelDatePicker(){
        delegate?.cancelDatePicker(cell:self)
    }
    
}



extension SearchCarRentalTVCell {
    
    
    func setupDropofDropDown() {
        
        dropofdropdown.dataSource = dropofLocationNamesArray
        dropofdropdown.direction = .bottom
        dropofdropdown.backgroundColor = .WhiteColor
        dropofdropdown.anchorView = self.dropuplocView
        dropofdropdown.bottomOffset = CGPoint(x: 0, y: dropuplocView.frame.size.height + 10)
        dropofdropdown.selectionAction = { [weak self] (index: Int, item: String) in
            
            self?.dropuplocTF.text = ""
            self?.dropuplocTF.text = item
            self?.dropuplocTF.textColor = .TitleColor
            
            defaults.set(item, forKey: UserDefaultsKeys.dropuplocationname)
            defaults.set(self?.dropofLocCodeArray[index], forKey: UserDefaultsKeys.dropuplocationcode)
            
        }
    }
    
    
    
    @objc func searchTextBegin(textField: UITextField) {
        textField.text = ""
        CallLocationListAPI(str: "")
        dropofdropdown.show()
    }
    
    
    @objc func searchTextChanged(textField: UITextField) {
        searchText = textField.text ?? ""
        if searchText == "" {
            isSearchBool = false
            filterContentForSearchText(searchText)
        }else {
            isSearchBool = true
            filterContentForSearchText(searchText)
        }
        
    }
    
    
    func filterContentForSearchText(_ searchText: String) {
        print("Filterin with:", searchText)
        
        filterdcountrylist.removeAll()
        filterdcountrylist =  locaionList.filter { thing in
            return "\(thing.label?.lowercased() ?? "")".contains(searchText.lowercased())
        }
        
        loadCountryNamesAndCode()
        dropofdropdown.show()
        
    }
    
    
    func loadCountryNamesAndCode(){
        dropofLocationNamesArray.removeAll()
        dropofLocCodeArray.removeAll()
        
        filterdcountrylist.forEach { i in
            dropofLocationNamesArray.append(i.label ?? "")
            dropofLocCodeArray.append(i.id ?? "")
        }
        
        DispatchQueue.main.async {[self] in
            dropofdropdown.dataSource = dropofLocationNamesArray
        }
    }
    
    
}
