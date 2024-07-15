//
//  AddDeatilsOfPassengerTVCell.swift
//  Travrate
//
//  Created by Admin on 15/07/24.
//

import UIKit
import DropDown

protocol AddDeatilsOfPassengerTVCellDelegate {
    
    func didTapOnExpandAdultViewbtnAction(cell:AddDeatilsOfPassengerTVCell)
    func tfeditingChanged(tf:UITextField)
    func didTapOnTitleBtnAction(cell:AddDeatilsOfPassengerTVCell)
    func didTapOnMrBtnAction(cell:AddDeatilsOfPassengerTVCell)
    func didTapOnMrsBtnAction(cell:AddDeatilsOfPassengerTVCell)
    
}

class AddDeatilsOfPassengerTVCell: TableViewCell {
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var saveView: UIView!
    @IBOutlet weak var fnameTF: UITextField!
    @IBOutlet weak var lnameTF: UITextField!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var nameTitleSelectBtn: UIButton!
    @IBOutlet weak var fnameView: UIView!
    @IBOutlet weak var lnameView: UIView!
    @IBOutlet weak var passengerView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var countrycodeTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var countrycodeView: BorderedView!
    @IBOutlet weak var emailview: BorderedView!
    @IBOutlet weak var mobileview: UIStackView!
    
    
    
    var maxLength = 8
    var isSearchBool = Bool()
    var searchText = String()
    var filterdcountrylist = [Country_list]()
    var countryNames = [String]()
    var countrycodesArray = [String]()
    var originArray = [String]()
    var isocountrycodeArray = [String]()
    
    var nationalityCode = String()
    let dropDown = DropDown()
    var countryNameArray = [String]()
    var isoCountryCode = String()
    var billingCountryName = String()
    
    let titledropDown = DropDown()
    var expandViewBool = true
    var delegate:AddDeatilsOfPassengerTVCellDelegate?
    var indexposition = Int()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        
    }
    
    
    
    @objc func tfeditingChanged(tf:UITextField) {
        delegate?.tfeditingChanged(tf: tf)
    }
    
    
    override func updateUI() {
        
        passengerView.isHidden = true
        titlelbl.text = cellInfo?.title
        
        guard let characterLimit = cellInfo?.characterLimit else {
            return
        }
        indexposition = characterLimit - 1
        
        
        if let cellInfo = cellInfo {
            if cellInfo.key == "adult" {
                if travelerArray.count <= self.indexposition {
                    travelerArray += Array(repeating: Traveler(), count: (self.indexposition ) - travelerArray.count + 1)
                }
                
                // Update the gender property of the Traveler object at the specified index
                travelerArray[self.indexposition ].passengertype = "AD"
                travelerArray[self.indexposition ].laedpassenger = "0"
                travelerArray[self.indexposition ].middlename = ""
                titledropDown.dataSource = ["Mr","Ms","Mrs"]
            } else {
                if travelerArray.count <= self.indexposition {
                    travelerArray += Array(repeating: Traveler(), count: (self.indexposition ) - travelerArray.count + 1)
                }
                
                // Update the gender property of the Traveler object at the specified index
                travelerArray[self.indexposition ].passengertype = "CH"
                travelerArray[self.indexposition ].laedpassenger = "0"
                travelerArray[self.indexposition ].middlename = ""
                titledropDown.dataSource = ["Master","Miss"]
            }
            
        }
        
        
        if cellInfo?.title == "Passenger 1" {
            closeBtn.isHidden = true
            passengerView.isHidden = false
            setAttributedText(str1: "Passenger 1", str2: "  Lead Passanger")
            travelerArray[self.indexposition ].laedpassenger = "1"
            expandViewBool = false
        }
    }
    
    
    func setupUI() {
        contentView.backgroundColor = .WhiteColor
        setuplabels(lbl: titlelbl, text: "", textcolor: .AppLabelColor, font: .OpenSansRegular(size: 14), align: .left)
        
        holderView.layer.borderColor = UIColor.AppBorderColor.cgColor
        holderView.layer.borderWidth = 1
        holderView.layer.cornerRadius = 4
        holderView.clipsToBounds = true
        
        setupTextField(txtField: titleTF, tag1: 1, label: "Title*", placeholder: "Mr")
        setupTextField(txtField: fnameTF, tag1: 1, label: "First Name*", placeholder: "First Name*")
        setupTextField(txtField: lnameTF, tag1: 2, label: "Last Name*", placeholder: "Last Name*")
        setupTextField(txtField: emailTF, tag1: 2, label: "Email Id*", placeholder: "Email Address*")
        setupTextField(txtField: mobileTF, tag1: 2, label: "Mobile", placeholder: "Mobile Number")
        setupTextField(txtField: mobileTF, tag1: 2, label: "+965", placeholder: "Code")
        
        
        setupTitleDropDown()
        
        setupView(v: titleView)
        setupView(v: fnameView)
        setupView(v: lnameView)
        
        setupDropDown()
        countrycodeTF.addTarget(self, action: #selector(searchTextChanged(textField:)), for: .editingChanged)
        countrycodeTF.addTarget(self, action: #selector(searchTextBegin(textField:)), for: .editingDidBegin)
        
        
    }
    
    
    
    func setupView(v:UIView) {
        v.layer.cornerRadius = 4
        v.clipsToBounds = true
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
        v.layer.borderWidth = 1
    }
    
    
    func setupTextField(txtField:UITextField,tag1:Int,label:String,placeholder:String) {
        txtField.setLeftPaddingPoints(15)
        txtField.delegate = self
        txtField.tag = tag1
        txtField.placeholder = placeholder
        txtField.backgroundColor = .clear
        txtField.font = UIFont.LatoRegular(size: 14)
        txtField.addTarget(self, action: #selector(editingTextField1(textField:)), for: .editingChanged)
        txtField.textColor = .AppLabelColor
    }
    
    
    
    func setupTitleDropDown() {
        
        titledropDown.direction = .bottom
        titledropDown.textColor = .AppLabelColor
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
                
                
            case emailTF:
                emailview.layer.borderColor = UIColor.AppBorderColor.cgColor
                travelerArray[indexposition].email = text
                break
                
            case mobileTF:
                mobileview.layer.borderColor = UIColor.AppBorderColor.cgColor
                travelerArray[indexposition].mobile = text
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
    
    
    
    @IBAction func didTapOnTitileSelectBtnAction(_ sender: Any) {
        titledropDown.show()
    }
    
    
    
    func setAttributedText(str1:String,str2:String)  {
        
        let atter1 = [NSAttributedString.Key.foregroundColor:UIColor.AppLabelColor,NSAttributedString.Key.font:UIFont.LatoRegular(size: 14)] as [NSAttributedString.Key : Any]
        let atter2 = [NSAttributedString.Key.foregroundColor:UIColor.Buttoncolor,NSAttributedString.Key.font:UIFont.LatoRegular(size: 10)] as [NSAttributedString.Key : Any]
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        let atterStr2 = NSMutableAttributedString(string: str2, attributes: atter2)
        
        
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        combination.append(atterStr2)
        
        titlelbl.attributedText = combination
        
    }
    
}



extension AddDeatilsOfPassengerTVCell {
    
    func setupDropDown() {
        
        dropDown.direction = .bottom
        dropDown.backgroundColor = .WhiteColor
        dropDown.anchorView = self.countrycodeView
        dropDown.bottomOffset = CGPoint(x: 0, y: countrycodeView.frame.size.height + 10)
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            
            self?.countrycodeTF.text = self?.countrycodesArray[index]
            self?.isoCountryCode = self?.isocountrycodeArray[index] ?? ""
            self?.billingCountryName = self?.countryNames[index] ?? ""
            self?.nationalityCode = self?.originArray[index] ?? ""
            self?.countrycodeTF.textColor = .AppLabelColor
            
            
            
            self?.countrycodeTF.text = self?.countrycodesArray[index] ?? ""
            MySingleton.shared.paymobilecountrycode = self?.countrycodesArray[index] ?? ""
            self?.countrycodeTF.resignFirstResponder()
            self?.mobileTF.text = ""
            self?.mobileTF.becomeFirstResponder()
            
            self?.mobileview.layer.borderColor = UIColor.BorderColor.cgColor
            travelerArray[self?.indexposition ?? 0 ].mobilecountrycode = item
            
           // self?.delegate?.didTapOnCountryCodeBtn(cell: self!)
            
        }
    }
    
    
    
    
    
    @objc func searchTextBegin(textField: UITextField) {
        textField.text = ""
        filterdcountrylist.removeAll()
        filterdcountrylist =  MySingleton.shared.countrylist
        loadCountryNamesAndCode()
        dropDown.show()
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
        filterdcountrylist =  MySingleton.shared.countrylist.filter { thing in
            return "\(thing.name?.lowercased() ?? "")".contains(searchText.lowercased())
        }
        
        loadCountryNamesAndCode()
        dropDown.show()
        
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
            dropDown.dataSource = countryNames
        }
    }
    
}


extension AddDeatilsOfPassengerTVCell {
    
    //MARK - UITextField Delegates
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //For mobile numer validation
        if textField == mobileTF {
            maxLength = self.billingCountryName.getMobileNumberMaxLength() ?? 8
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet) && newString.length <= maxLength
        }else {
            maxLength = 100
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        //  return true
    }
    
    
}

