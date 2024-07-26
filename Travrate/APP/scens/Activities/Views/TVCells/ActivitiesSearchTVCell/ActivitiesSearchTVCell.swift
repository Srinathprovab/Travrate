//
//  ActivitiesSearchTVCell.swift
//  Travrate
//
//  Created by Admin on 17/07/24.
//

import UIKit

protocol ActivitiesSearchTVCellDelegate:AnyObject {
    func didTapOnActivitesSearchBtnAction(cell:ActivitiesSearchTVCell)
    func donedatePicker(cell:ActivitiesSearchTVCell)
    func cancelDatePicker(cell:ActivitiesSearchTVCell)
}



class ActivitiesSearchTVCell: TableViewCell, GetActivitesDestinationListVMDelegate {
    
    
    
    @IBOutlet weak var holderView: BorderedView!
    @IBOutlet weak var fromlbl: UILabel!
    @IBOutlet weak var depDatelbl: UILabel!
    @IBOutlet weak var depTF: UITextField!
    @IBOutlet weak var retlbl: UILabel!
    @IBOutlet weak var retTF: UITextField!
    @IBOutlet weak var adultDecBtn: UIButton!
    @IBOutlet weak var adultCountlbl: UILabel!
    @IBOutlet weak var adultIncBtn: UIButton!
    @IBOutlet weak var childDecBtn: UIButton!
    @IBOutlet weak var childCountlbl: UILabel!
    @IBOutlet weak var childIncBtn: UIButton!
    @IBOutlet weak var infantDecBtn: UIButton!
    @IBOutlet weak var infantCountlbl: UILabel!
    @IBOutlet weak var infantIncBtn: UIButton!
    @IBOutlet weak var fromtv: UITableView!
    @IBOutlet weak var fromtvHeight: NSLayoutConstraint!
    @IBOutlet weak var fromTF: UITextField!
    @IBOutlet weak var clearBtn: UIButton!
    
    
    
    var payload = [String:Any]()
    var cityList:[GetActivitesDestinationListModel] = []
    var txtbool = Bool()
    
    let depDatePicker = UIDatePicker()
    let retDatePicker = UIDatePicker()
    var isSearchBool = Bool()
    var searchText = String()
    weak var delegate:ActivitiesSearchTVCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        
        MySingleton.shared.getActivitesDestinationListVM = GetActivitesDestinationListVM(self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setupUI() {
        
        
        fromTF.tag = 1
        fromTF.textColor = .TitleColor
        fromTF.font = .OpenSansMedium(size: 16)
        fromTF.delegate = self
        fromTF.addTarget(self, action: #selector(textFiledEditingChanged(_:)), for: .editingChanged)
        fromTF.setLeftPaddingPoints(0)
        
        
        adultIncBtn.addTarget(self, action: #selector(didTapOnAdultIncrementBtnAction(_:)), for: .touchUpInside)
        adultDecBtn.addTarget(self, action: #selector(didTapOnAdultDecrementBtnAction(_:)), for: .touchUpInside)
        childIncBtn.addTarget(self, action: #selector(didTapOnChildIncrementBtnAction(_:)), for: .touchUpInside)
        childDecBtn.addTarget(self, action: #selector(didTapOnChildDecrementBtnAction(_:)), for: .touchUpInside)
        infantIncBtn.addTarget(self, action: #selector(didTapOnInfantIncrementBtnAction(_:)), for: .touchUpInside)
        infantDecBtn.addTarget(self, action: #selector(didTapOnInfantDecrementBtnAction(_:)), for: .touchUpInside)
        
        
        
        fromtv.layer.borderWidth = 1
        fromtv.layer.borderColor = UIColor.AppBorderColor.cgColor
        retTF.isUserInteractionEnabled = false
        
        
        showdepDatePicker()
      //  showretDatePicker()
        
    }
    
    override func updateUI() {
        
        setupTV()
        fromtvHeight.constant = 0
       // CallShowCityListAPI(str: "")
        
        fromlbl.text = defaults.string(forKey: UserDefaultsKeys.activitescityname) ?? ""
        depDatelbl.text = defaults.string(forKey: UserDefaultsKeys.calActivitesDepDate) ?? "Select Date"
        retlbl.text = defaults.string(forKey: UserDefaultsKeys.calActivitesRetDate) ?? "Select Date"
        
        fromlbl.textColor = fromlbl.text == "Select Destination City" ? .subtitleNewcolor : .TitleColor
        updateLabelColor(label: depDatelbl, defaultText: "Select Date", defaultColor: .subtitleNewcolor, selectedColor: .TitleColor)
        updateLabelColor(label: retlbl, defaultText: "Select Date", defaultColor: .subtitleNewcolor, selectedColor: .TitleColor)
        
        func updateLabelColor(label: UILabel, defaultText: String, defaultColor: UIColor, selectedColor: UIColor) {
            label.textColor = label.text == defaultText ? defaultColor : selectedColor
        }
        
        
        adultCountlbl.text = defaults.string(forKey: UserDefaultsKeys.activitesadultCount) ?? "1"
        childCountlbl.text = defaults.string(forKey: UserDefaultsKeys.activiteschildCount) ?? "0"
        infantCountlbl.text = defaults.string(forKey: UserDefaultsKeys.activitesinfantsCount) ?? "0"
        
        MySingleton.shared.adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.activitesadultCount) ?? "") ?? 1
        MySingleton.shared.childCount = Int(defaults.string(forKey: UserDefaultsKeys.activiteschildCount) ?? "") ?? 0
        MySingleton.shared.infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.activitesinfantsCount) ?? "") ?? 0
        
        clearBtn.addTarget(self, action: #selector(didTapOnClearFromTFBtnAction(_:)), for: .touchUpInside)
        
    }
    
    
    @objc func didTapOnClearFromTFBtnAction(_ sender:UIButton) {
        fromTF.text = ""
        fromTF.becomeFirstResponder()
        CallShowCityListAPI(str: "")
    }
    
    
    
    @IBAction func didTapOnFlightSearchBtnAction(_ sender: Any) {
        delegate?.didTapOnActivitesSearchBtnAction(cell: self)
    }
    
    
    //MARK: - Text Filed Editing Changed
    
    
    
    
    @objc func textFiledEditingChanged(_ textField:UITextField) {
        
        
        if textField.text?.isEmpty == true {
            
        }else {
            self.fromlbl.text = ""
            CallShowCityListAPI(str: textField.text ?? "")
        }
        
        
    }
    
    
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        fromTF.placeholder = "Origin"
        self.fromlbl.text = ""
        CallShowCityListAPI(str: textField.text ?? "")
    }
    
    
}

extension ActivitiesSearchTVCell:UITableViewDelegate, UITableViewDataSource {
    
    
    func setupTV() {
        fromtv.delegate = self
        fromtv.dataSource = self
        fromtv.register(UINib(nibName: "TitleLblTVCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    
    func CallShowCityListAPI(str:String) {
        payload.removeAll()
        payload["term"] = str
        MySingleton.shared.getActivitesDestinationListVM?.CALL_GET_ACTIVITES_DESTINATION_LIST_API(dictParam: payload)
    }
    
    
    func destinationCityList(response: [GetActivitesDestinationListModel]) {
        cityList = response
        
        DispatchQueue.main.async {[self] in
            fromtvHeight.constant = CGFloat(cityList.count * 80)
            fromtv.reloadData()
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TitleLblTVCell {
            cell.selectionStyle = .none
            cell.titlelbl.text = cityList[indexPath.row].label
            cell.cityid = cityList[indexPath.row].id ?? ""
            ccell = cell
        }
        
        return ccell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? TitleLblTVCell {
            
            fromlbl.text = "\(cityList[indexPath.row].label ?? "")"
            fromlbl.textColor = .TitleColor
            fromTF.text = ""
            fromTF.placeholder = ""
            fromTF.resignFirstResponder()
            
            
            defaults.set(cityList[indexPath.row].label ?? "", forKey: UserDefaultsKeys.activitescityname)
            defaults.set(cityList[indexPath.row].id ?? "", forKey: UserDefaultsKeys.activitescityid)
            
            
            fromtvHeight.constant = 0
        }
    }
    
}


extension ActivitiesSearchTVCell {
    
    
    //MARK: - showdepDatePicker
    func showdepDatePicker(){
        //Formate Date
        depDatePicker.datePickerMode = .date
        depDatePicker.minimumDate = Date()
        depDatePicker.preferredDatePickerStyle = .wheels
        
        let formter = DateFormatter()
        formter.dateFormat = "dd-MM-yyyy"
        
        
        if let calDepDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.calActivitesDepDate) ?? "") {
            depDatePicker.date = calDepDate
            
            if self.retlbl.text == "Select Date" {
                retDatePicker.date = calDepDate
            }
            
            
            // Check if returnDate date is smaller than calDepDate date
            if let returnDate = formter.date(from: self.retlbl.text ?? ""),
               returnDate < calDepDate {
                retDatePicker.date = calDepDate
                
                // Also update the label to reflect the change
                self.retlbl.text = formter.string(from: calDepDate)
            }
            
            
        }
        
        
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        
        
        let label = UILabel()
        label.text = "" // Initial text, can be changed dynamically
        label.sizeToFit()
        label.font = .OpenSansMedium(size: 16)
        let labelButton = UIBarButtonItem(customView: label)
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        toolbar.setItems([doneButton,flexibleSpace,flexibleSpace,labelButton,flexibleSpace,flexibleSpace, cancelButton], animated: false)
        
        
        
        self.depTF.inputAccessoryView = toolbar
        self.depTF.inputView = depDatePicker
        
    }
    
    
    
    //MARK: - showretDatePicker
    func showretDatePicker(){
        //Formate Date
        retDatePicker.datePickerMode = .date
        //        retDatePicker.minimumDate = Date()
        // Set minimumDate for retDatePicker based on depDatePicker or retDatePicker
        let selectedDate = self.depTF.isFirstResponder ? depDatePicker.date : retDatePicker.date
        retDatePicker.minimumDate = selectedDate
        retDatePicker.preferredDatePickerStyle = .wheels
        
        
        let formter = DateFormatter()
        formter.dateFormat = "dd-MM-yyyy"
        
        
        if let calDepDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.calActivitesDepDate) ?? "") {
            
            if self.retlbl.text == "Select Date" {
                retDatePicker.date = calDepDate
                
            }else {
                if let rcalRetDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.calActivitesRetDate) ?? "") {
                    retDatePicker.date = rcalRetDate
                }
            }
        }
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        let label = UILabel()
        label.text = "" // Initial text, can be changed dynamically
        label.sizeToFit()
        label.font = .OpenSansMedium(size: 16)
        let labelButton = UIBarButtonItem(customView: label)
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        toolbar.setItems([doneButton,flexibleSpace,flexibleSpace,labelButton,flexibleSpace,flexibleSpace, cancelButton], animated: false)
        
        
        self.retTF.inputAccessoryView = toolbar
        self.retTF.inputView = retDatePicker
        
    }
    
    
    @objc func donedatePicker(){
        delegate?.donedatePicker(cell:self)
    }
    
    
    @objc func cancelDatePicker(){
        delegate?.cancelDatePicker(cell:self)
    }
    
}


extension ActivitiesSearchTVCell {
    
    //MARK: - Adult
    @objc func didTapOnAdultIncrementBtnAction(_ sender:UIButton) {
        
        // Increment adults, but don't exceed 9 travelers in total
        if (MySingleton.shared.adultsCount) < 9 {
            MySingleton.shared.adultsCount += 1
            self.adultCountlbl.text = "\(MySingleton.shared.adultsCount)"
        }
        
        updateTotalTravelerCount()
    }
    
    @objc func didTapOnAdultDecrementBtnAction(_ sender:UIButton) {
        
        // Ensure child count doesn't go below 1
        if MySingleton.shared.adultsCount > 1 {
            MySingleton.shared.adultsCount -= 1
            adultCountlbl.text = "\(MySingleton.shared.adultsCount)"
            
           // MySingleton.shared.infantsCount = 0
           // infantCountlbl.text = "0"
        }
        
        updateTotalTravelerCount()
    }
    
    //MARK: - Child
    @objc func didTapOnChildIncrementBtnAction(_ sender:UIButton) {
        
        // Increment adults and children, but don't exceed 9 travelers in total
//        if (MySingleton.shared.adultsCount + MySingleton.shared.childCount) < 9 {
//            MySingleton.shared.childCount += 1
//            self.childCountlbl.text = "\(MySingleton.shared.childCount)"
//        }
        
        // Increment adults, but don't exceed 9 travelers in total
        if ( MySingleton.shared.childCount) < 9 {
            MySingleton.shared.childCount += 1
            self.childCountlbl.text = "\(MySingleton.shared.childCount)"
        }
        
        updateTotalTravelerCount()
    }
    
    @objc func didTapOnChildDecrementBtnAction(_ sender:UIButton) {
        
        // Ensure adult count doesn't go below 1
        if MySingleton.shared.childCount >= 1 {
            MySingleton.shared.childCount -= 1
            childCountlbl.text = "\(MySingleton.shared.childCount)"
        }
        
        updateTotalTravelerCount()
    }
    
    //MARK: - Infant
    @objc func didTapOnInfantIncrementBtnAction(_ sender:UIButton) {
        
        // Increment infants based on the selected adult count, but don't exceed the selected adult count
//        if MySingleton.shared.adultsCount > MySingleton.shared.infantsCount {
//            MySingleton.shared.infantsCount += 1
//            self.infantCountlbl.text = "\(MySingleton.shared.infantsCount)"
//        }
        
        // Increment adults, but don't exceed 9 travelers in total
        if (MySingleton.shared.infantsCount ) < 9 {
            MySingleton.shared.infantsCount += 1
            self.infantCountlbl.text = "\(MySingleton.shared.infantsCount)"
        }
        
        updateTotalTravelerCount()
    }
    
    @objc func didTapOnInfantDecrementBtnAction(_ sender:UIButton) {
        
        // Ensure infant count doesn't go below 1
        if MySingleton.shared.infantsCount >= 1 {
            MySingleton.shared.infantsCount -= 1
            infantCountlbl.text = "\(MySingleton.shared.infantsCount)"
        }
        
        updateTotalTravelerCount()
    }
    
    func updateTotalTravelerCount() {
        
        let totalTravelers = MySingleton.shared.adultsCount + MySingleton.shared.childCount + MySingleton.shared.infantsCount
        print("Total Count === \(totalTravelers)")
        totalPax = "\(totalTravelers)"
        
        //defaults.set(totalTravelers, forKey: UserDefaultsKeys.totalTravellerCount)
        defaults.set(MySingleton.shared.adultsCount, forKey: UserDefaultsKeys.activitesadultCount)
        defaults.set(MySingleton.shared.childCount, forKey: UserDefaultsKeys.activiteschildCount)
        defaults.set(MySingleton.shared.infantsCount, forKey: UserDefaultsKeys.activitesinfantsCount)
        
    }
    
    
}





