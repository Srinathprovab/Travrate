//
//  AddDeatilsOfPersonTVCell.swift
//  Travrate
//
//  Created by FCI on 28/05/24.
//

import UIKit
import DropDown
import CoreData


protocol AddDeatilsOfPersonTVCellDelegate: AnyObject {
    
    
    func didTapOnExpandAdultViewbtnAction(cell:AddDeatilsOfPersonTVCell)
    func tfeditingChanged(tf:UITextField)
    func didTapOnTitleBtnAction(cell:AddDeatilsOfPersonTVCell)
    func donedatePicker(cell:AddDeatilsOfPersonTVCell)
    func cancelDatePicker(cell:AddDeatilsOfPersonTVCell)
    
    
}

class AddDeatilsOfPersonTVCell: TableViewCell {
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var dropdownimg: UIImageView!
    @IBOutlet weak var holderView: UIStackView!
    @IBOutlet weak var fnameTF: UITextField!
    @IBOutlet weak var lnameTF: UITextField!
    @IBOutlet weak var dobTF: UITextField!
    @IBOutlet weak var passportnoTF: UITextField!
    @IBOutlet weak var selectCountryTF: UITextField!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var nameTitleSelectBtn: UIButton!
    @IBOutlet weak var passportIssueingCountrySelectBtn: UIButton!
    @IBOutlet weak var fnameView: UIView!
    @IBOutlet weak var lnameView: UIView!
    @IBOutlet weak var dobView: UIView!
    @IBOutlet weak var passportnoView: UIView!
    @IBOutlet weak var cityofbirthTF: UITextField!
    @IBOutlet weak var cityofbirthView: UITextField!
    @IBOutlet weak var selectCountryView: UIView!
    
    
    let dobDatePicker = UIDatePicker()
    let passportDatePicker = UIDatePicker()
    let dropDown = DropDown()
    let dropDown1 = DropDown()
    let mealsDropdown = DropDown()
    let specialAssistenceDropDown = DropDown()
    let titledropDown = DropDown()
    let flyerdropDown = DropDown()
    var clist = [Country_list]()
    var countryNames = [String]()
    var natinalityCode = String()
    var countryCode = String()
    var isssuingCountryCode = String()
    var maxLength = 50
    var nationalityName = String()
    var passIssuingCountryName = String()
    var expandViewBool = true
    weak var delegate:AddDeatilsOfPersonTVCellDelegate?
    var indexposition = Int()
    var isSearchBool = Bool()
    var searchText = String()
    var filterdcountrylist = [Country_list]()
    var countrycodesArray = [String]()
    var originArray = [String]()
    var isocountrycodeArray = [String]()
    var frequentflyersArrayString = [String]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        
    }
    
    override func prepareForReuse() {
        collapsView()
    }
    
    
    
    @objc func tfeditingChanged(tf:UITextField) {
        delegate?.tfeditingChanged(tf: tf)
    }
    
    
    func expandView() {
        dropdownimg.image = UIImage(named: "dropup")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppLabelColor)
        holderView.isHidden = false
    }
    
    
    func collapsView() {
        dropdownimg.image = UIImage(named: "downarrow1")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppLabelColor)
        holderView.isHidden = true
    }
    
    
    override func updateUI() {
        
        titlelbl.text = cellInfo?.title
        
        guard let characterLimit = cellInfo?.characterLimit else {
            return
        }
        indexposition = characterLimit - 1
        
        
        
        filterdcountrylist = MySingleton.shared.countrylist
        loadCountryNamesAndCode()
        
        MySingleton.shared.frequent_flyersArray.forEach { i in
            frequentflyersArrayString.append(i.airline_name ?? "")
        }
        flyerdropDown.dataSource = frequentflyersArrayString
        
        
        
        if let cellInfo = cellInfo {
            if cellInfo.key == "person1" {
                if travelerArray.count <= self.indexposition {
                    travelerArray += Array(repeating: Traveler(), count: (self.indexposition ) - travelerArray.count + 1)
                }
                
                // Update the gender property of the Traveler object at the specified index
            
                travelerArray[self.indexposition ].laedpassenger = "0"
                titledropDown.dataSource = ["Mr","Ms","Mrs"]
                travelerArray[self.indexposition ].passengertype = "Adult"
                
            }
            
            titleTF.text = "Mr"
            travelerArray[self.indexposition].mrtitle = "1"
            travelerArray[self.indexposition].gender = "1"
            
            showdobDatePicker()
        }
        
        
        if cellInfo?.title == "Person 1" {
            setAttributedText(str1: "Person 1", str2: "  Lead")
            travelerArray[self.indexposition ].laedpassenger = "1"
            expandView()
            expandViewBool = false
        }
    }
    
    
    func setupUI() {
        
        setuplabels(lbl: titlelbl, text: "", textcolor: .AppLabelColor, font: .LatoBold(size: 14), align: .left)
        dropdownimg.image = UIImage(named: "down")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppLabelColor)
        
        
        
        
        collapsView()
        
        setupTextField(txtField: cityofbirthTF, tag1: 7, label: "City Of Birth*", placeholder: "City Of Birth")
        setupTextField(txtField: titleTF, tag1: 11, label: "Title", placeholder: "MR")
        setupTextField(txtField: fnameTF, tag1: 1, label: "First Name", placeholder: "First Name")
        setupTextField(txtField: lnameTF, tag1: 2, label: "Last Name", placeholder: "Last Name")
        setupTextField(txtField: dobTF, tag1: 3, label: "Date of Birth", placeholder: "DOB")
        setupTextField(txtField: passportnoTF, tag1: 5, label: "Passport No", placeholder: "Passport No")
        setupTextField(txtField: selectCountryTF, tag1: 6, label: "Passport Issuing Country", placeholder: "Select Country")
        
        
        passportIssueingCountrySelectBtn.isHidden = true
        passportIssueingCountrySelectBtn.setTitle("", for: .normal)
        passportIssueingCountrySelectBtn.addTarget(self, action: #selector(didTapOnPassportIssuingCountrySelectBtnAction(_:)), for: .touchUpInside)
        
        
        
        showdobDatePicker()
        setupTitleDropDown()
       // setupView(v: titleView)
        setupView(v: fnameView)
        setupView(v: lnameView)
        setupView(v: dobView)
        setupIssuingCountryDropDown()
        
        selectCountryTF.addTarget(self, action: #selector(searchTextChanged(textField:)), for: .editingChanged)
        
    }
    
    
    
    func setupView(v:UIView) {
        v.layer.cornerRadius = 4
        v.clipsToBounds = true
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
        v.layer.borderWidth = 1
    }
    
    
    
    @objc func didTapOnPassportIssuingCountrySelectBtnAction(_ sender:UIButton) {
        // dropDown1.show()
    }
    
    @objc func didTapOnPassportNationalitySelectBtnAction(_ sender:UIButton) {
        dropDown.show()
    }
    
    
    @objc func didTapOnFrequentFlyrPgmBtn(_ sender:UIButton) {
        print("didTapOnFrequentFlyrPgmBtn")
    }
    
    @objc func didTapOnMealPreferenceBtn(_ sender:UIButton) {
        mealsDropdown.show()
    }
    
    @objc func didTapOnSpecialAssicintenceBtn(_ sender:UIButton) {
        specialAssistenceDropDown.show()
    }
    
    
    
    func setupTextField(txtField:UITextField,tag1:Int,label:String,placeholder:String) {
        txtField.setLeftPaddingPoints(15)
        txtField.delegate = self
        txtField.tag = tag1
        txtField.placeholder = placeholder
        txtField.textColor = .AppLabelColor
        txtField.backgroundColor = .clear
        txtField.font = UIFont.LatoRegular(size: 16)
        txtField.addTarget(self, action: #selector(editingTextField1(textField:)), for: .editingChanged)
        
    }
    
    
    
    
    
    func setupTitleDropDown() {
        
        titledropDown.direction = .bottom
        titledropDown.backgroundColor = .WhiteColor
        titledropDown.anchorView = self.titleView
        
        titledropDown.bottomOffset = CGPoint(x: 0, y: titleView.frame.size.height + 20)
        titledropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.titleTF.text = item
            
            if travelerArray.count <= self?.indexposition ?? 0 {
                travelerArray += Array(repeating: Traveler(), count: (self?.indexposition ?? 0) - travelerArray.count + 1)
            }
            
            switch item {
            case "Mr":
                travelerArray[self?.indexposition ?? 0].mrtitle = "1"
                travelerArray[self?.indexposition ?? 0].gender = "1"
                break
                
                
            case "Master":
                travelerArray[self?.indexposition ?? 0].mrtitle = "4"
                travelerArray[self?.indexposition ?? 0].gender = "1"
                break
                
            case "Ms":
                travelerArray[self?.indexposition ?? 0].mrtitle = "2"
                travelerArray[self?.indexposition ?? 0].gender = "2"
                break
                
                
            case "Miss":
                travelerArray[self?.indexposition ?? 0].mrtitle = "3"
                travelerArray[self?.indexposition ?? 0].gender = "2"
                break
                
            case "Mrs":
                travelerArray[self?.indexposition ?? 0].mrtitle = "5"
                travelerArray[self?.indexposition ?? 0].gender = "2"
                break
                
            default:
                break
                
            }
            
            self?.titleView.layer.borderColor = UIColor.AppBorderColor.cgColor
            self?.fnameTF.becomeFirstResponder()
            self?.delegate?.didTapOnTitleBtnAction(cell: self!)
        }
        
    }
    
    
    
     func textFieldDidEndEditing(_ textField: UITextField) {
         if textField == fnameTF {
             lnameTF.becomeFirstResponder()
         }else if textField == lnameTF {
             dobTF.becomeFirstResponder()
         }else if textField == passportnoTF {
             selectCountryTF.becomeFirstResponder()
         }
    }
    
    
    
    
    func showdobDatePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        
        // Format Date
        dobDatePicker.datePickerMode = .date
        dobDatePicker.maximumDate = Date() // Maximum date is today
        
        // Calculate the minimum date (30 years before today)
        let calendar = Calendar.current
        if let thirtyYearsAgo = calendar.date(byAdding: .year, value: -30, to: Date()) {
            dobDatePicker.minimumDate = thirtyYearsAgo
        }
        
        dobDatePicker.preferredDatePickerStyle = .wheels
        
        // ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        
        toolbar.setItems([doneButton, spaceButton, cancelButton], animated: false)
        
        dobTF.inputAccessoryView = toolbar
        dobTF.inputView = dobDatePicker
    }


    
    
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        
        if dobTF.isFirstResponder {
            dobTF.text = formatter.string(from: dobDatePicker.date)
            if travelerArray.count <= indexposition {
                travelerArray += Array(repeating: Traveler(), count: indexposition - travelerArray.count + 1)
            }
            
            // Update the gender property of the Traveler object at the specified index
            travelerArray[indexposition].dob = dobTF.text
            
            if let dateobj = formatter.date(from: self.dobTF.text ?? "") {
                let calendar = Calendar.current
                travelerArray[indexposition].day = "\(calendar.component(.day, from: dateobj))"
                travelerArray[indexposition].month = "\(calendar.component(.month, from: dateobj))"
                travelerArray[indexposition].year = "\(calendar.component(.year, from: dateobj))"
            }
            
            
            self.dobTF.resignFirstResponder()
            self.dobView.layer.borderColor = UIColor.AppBorderColor.cgColor
            self.passportnoTF.becomeFirstResponder()
            
        }
        
       //delegate?.donedatePicker(cell: self)
    }
    
    @objc func cancelDatePicker(){
        self.dobTF.resignFirstResponder()
    }
    
    
    
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == dobTF {
            if let cellInfo = cellInfo {
                if cellInfo.key == "adult" {
                    MySingleton.shared.ageCategory = AgeCategory.adult
                } else if cellInfo.key == "child" {
                    MySingleton.shared.ageCategory = AgeCategory.child
                } else {
                    MySingleton.shared.ageCategory = AgeCategory.infant
                }
                showdobDatePicker()
            }
        }
        
        else if textField == selectCountryTF {
            loadCountryNamesAndCode()
        }
    }
    
    
    
    
    @objc func editingTextField1(textField: UITextField) {
        
        if travelerArray.count <= indexposition {
            travelerArray += Array(repeating: Traveler(), count: indexposition - travelerArray.count + 1)
        }
        
        if let text = textField.text, !text.isEmpty {
            
            switch textField {
                
            case fnameTF:
                fnameView.layer.borderColor = UIColor.AppBorderColor.cgColor
                travelerArray[indexposition].firstName = text
                break
                
            case lnameTF:
                lnameView.layer.borderColor = UIColor.AppBorderColor.cgColor
                travelerArray[indexposition].lastName = text
                break
                
                
            case passportnoTF:
                passportnoView.layer.borderColor = UIColor.AppBorderColor.cgColor
                travelerArray[indexposition].passportno = text
                break
                
                
            case cityofbirthTF:
                cityofbirthView.layer.borderColor = UIColor.AppBorderColor.cgColor
                travelerArray[indexposition].cityofbirth = text
                break
                
                
            default:
                break
            }
            
            
            
        }
        
        
    }
    
    
    
    private func getIndexPath() -> IndexPath? {
        guard let tableView = superview as? UITableView else {
            return nil
        }
        
        return tableView.indexPath(for: self)
    }
    
    
    
    @IBAction func didTapOnExpandAdultViewbtnAction(_ sender: Any) {
        delegate?.didTapOnExpandAdultViewbtnAction(cell: self)
    }
    
    
    @objc func searchTextChanged(textField: UITextField) {
        searchText = textField.text ?? ""
        filterContentForSearchText(searchText)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        
        filterdcountrylist.removeAll()
        filterdcountrylist = MySingleton.shared.countrylist.filter { thing in
            return "\(thing.name?.lowercased() ?? "")".contains(searchText.lowercased())
        }
        
        loadCountryNamesAndCode()
        dropDown1.show()
        
    }
    
    func loadCountryNamesAndCode(){
        countryNames.removeAll()
        countrycodesArray.removeAll()
        isocountrycodeArray.removeAll()
        originArray.removeAll()
        
        filterdcountrylist.forEach { i in
            countryNames.append(i.name ?? "")
            countrycodesArray.append(i.country_code ?? "")
            isocountrycodeArray.append(i.iso_country_code ?? "")
            originArray.append(i.origin ?? "")
        }
        
        
        DispatchQueue.main.async {[self] in
            dropDown1.dataSource = countryNames
        }
        
    }
    
    
    @IBAction func didTapOnTitileSelectBtnAction(_ sender: Any) {
        titledropDown.show()
    }
    
    
    
    
}


extension AddDeatilsOfPersonTVCell {
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if textField == passportnoTF {
            
            // Define a character set that includes numbers and alphabets
            let allowedCharacterSet = CharacterSet(charactersIn: "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz")
            
            // Check if the replacementString contains only allowed characters
            if string.rangeOfCharacter(from: allowedCharacterSet.inverted) != nil {
                return false // Reject the change
            }
            
            // Make sure the combined text (current text + replacement) doesn't exceed a certain length
            let currentText = textField.text ?? ""
            let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
            return updatedText.count <= maxLength
            
        }else {
            
            let currentString: NSString = (textField.text ?? "") as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            
            return newString.length <= maxLength
        }
        
        
        
    }
    
    func setAttributedText(str1:String,str2:String)  {
        
        let atter1 = [NSAttributedString.Key.foregroundColor:UIColor.AppLabelColor,NSAttributedString.Key.font:UIFont.LatoBold(size: 14)] as [NSAttributedString.Key : Any]
        let atter2 = [NSAttributedString.Key.foregroundColor:UIColor.AppCalenderDateSelectColor,NSAttributedString.Key.font:UIFont.LatoRegular(size: 10)] as [NSAttributedString.Key : Any]
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        let atterStr2 = NSMutableAttributedString(string: str2, attributes: atter2)
        
        
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        combination.append(atterStr2)
        
        titlelbl.attributedText = combination
        
    }
    
    
    
    func setupIssuingCountryDropDown() {
        
        dropDown1.direction = .bottom
        dropDown1.backgroundColor = .WhiteColor
        dropDown1.anchorView = self.selectCountryView
        dropDown1.bottomOffset = CGPoint(x: 0, y: selectCountryView.frame.size.height + 20)
        dropDown1.selectionAction = { [weak self] (index: Int, item: String) in
            self?.selectCountryTF.text = self?.countryNames[index] ?? ""
            
            
            if travelerArray.count <= self?.indexposition ?? 0 {
                travelerArray += Array(repeating: Traveler(), count: (self?.indexposition ?? 0) - travelerArray.count + 1)
            }
            
            // Update the gender property of the Traveler object at the specified index
            travelerArray[self?.indexposition ?? 0].passportIssuingCountry = self?.originArray[index] ?? ""
            travelerArray[self?.indexposition ?? 0].passportIssuingCountryName = self?.countryNames[index] ?? ""
            self?.cityofbirthTF.becomeFirstResponder()
            self?.selectCountryView.layer.borderColor = UIColor.AppBorderColor.cgColor
            
        }
        
    }
    
}

