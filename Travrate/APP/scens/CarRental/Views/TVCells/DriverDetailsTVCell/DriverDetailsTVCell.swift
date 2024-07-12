//
//  DriverDetailsTVCell.swift
//  Travrate
//
//  Created by FCI on 14/06/24.
//

import UIKit
import DropDown

protocol DriverDetailsTVCellDelegate {
    func textViewDidChange(textView:UITextView)
    func editingTextFieldChanged(tf:UITextField)
    func didTapOnTitleSelectBtnAction(cell:DriverDetailsTVCell)
    func didTapOnCountryCodeBtn(cell:DriverDetailsTVCell)
}

class DriverDetailsTVCell: TableViewCell,UITextViewDelegate {
    
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var fnameTF: UITextField!
    @IBOutlet weak var lnameTF: UITextField!
    //    @IBOutlet weak var nationaslityTF: UITextField!
    //    @IBOutlet weak var cityTF: UITextField!
    //    @IBOutlet weak var postalcodeTF: UITextField!
    //    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var emailidTF: UITextField!
    @IBOutlet weak var countrycodeView: UIView!
    @IBOutlet weak var countrycodeTF: UITextField!
    @IBOutlet weak var mobileholderView: UIView!
    @IBOutlet weak var mobileTF: UITextField!
    
    
    
    
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
    let titledropDown = DropDown()
    var countryNameArray = [String]()
    var isoCountryCode = String()
    var billingCountryName = String()
    
    var mrtitle = String()
    var placeHolder = "Address"
    var delegate:DriverDetailsTVCellDelegate?
    var agedropDown = DropDown()
    let datePicker = UIDatePicker()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setupUI() {
        
        setupTF(tf: fnameTF, tag: 1)
        setupTF(tf: lnameTF, tag: 2)
        setupTF(tf: emailidTF, tag: 3)
        setupTF(tf: mobileTF, tag: 4)
        //        setupTF(tf: nationaslityTF, tag: 5)
        //        setupTF(tf: cityTF, tag: 6)
        //        setupTF(tf: postalcodeTF, tag: 7)
        
        setupTitleDropDown()
        // setupAddressTextView()
        
        setupDropDown()
        countrycodeTF.addTarget(self, action: #selector(searchTextChanged(textField:)), for: .editingChanged)
        countrycodeTF.addTarget(self, action: #selector(searchTextBegin(textField:)), for: .editingDidBegin)
    }
    
    func setupTF(tf:UITextField,tag:Int) {
        tf.delegate = self
        tf.font = .OpenSansRegular(size: 14)
        tf.setLeftPaddingPoints(15)
        tf.addTarget(self, action: #selector(editingTextFieldChanged(_:)), for: .editingChanged)
    }
    
    //    func setupAddressTextView() {
    //
    //        addressTextView.layer.cornerRadius = 6
    //        addressTextView.clipsToBounds = true
    //        addressTextView.layer.borderWidth = 1
    //        addressTextView.layer.borderColor = UIColor.AppBorderColor.cgColor
    //
    //        addressTextView.text = ""
    //        addressTextView.delegate = self
    //        addressTextView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 4)
    //        addressTextView.setPlaceholder(ph: placeHolder)
    //    }
    
    @objc func textViewDidChange(_ textView: UITextView) {
        textView.checkPlaceholder()
        delegate?.textViewDidChange(textView: textView)
    }
    
    @objc func editingTextFieldChanged( _ tf:UITextField) {
        delegate?.editingTextFieldChanged(tf: tf)
    }
    
    
    
    @IBAction func didTapOnTitleDropDownAction(_ sender: Any) {
        titledropDown.show()
    }
    
}


extension DriverDetailsTVCell {
    
    
    func setupTitleDropDown() {
        
        titledropDown.dataSource = ["Mr","Mrs","Miss"]
        titledropDown.direction = .bottom
        titledropDown.backgroundColor = .WhiteColor
        titledropDown.anchorView = self.titleView
        titledropDown.bottomOffset = CGPoint(x: 0, y: titleView.frame.size.height + 10)
        titledropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            
            self?.titleTF.text = item
            
            if item == "Mr" {
                self?.mrtitle = "1"
            }else if item == "Mrs" {
                self?.mrtitle = "2"
            }else {
                self?.mrtitle = "3"
            }
            
            self?.fnameTF.becomeFirstResponder()
            
            self?.delegate?.didTapOnTitleSelectBtnAction(cell: self!)
            
        }
    }
    
    
    
    
    
    
}


extension DriverDetailsTVCell {
    
    
    func setupDropDown() {
        
        dropDown.direction = .bottom
        dropDown.backgroundColor = .WhiteColor
        dropDown.anchorView = self.mobileholderView
        dropDown.bottomOffset = CGPoint(x: 0, y: mobileholderView.frame.size.height + 10)
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            
            self?.countrycodeTF.text = self?.countrycodesArray[index]
            self?.isoCountryCode = self?.isocountrycodeArray[index] ?? ""
            self?.billingCountryName = self?.countryNames[index] ?? ""
            self?.nationalityCode = self?.originArray[index] ?? ""
            
            
            self?.countrycodeTF.text = self?.countrycodesArray[index] ?? ""
            MySingleton.shared.paymobilecountrycode = self?.countrycodesArray[index] ?? ""
            self?.countrycodeTF.resignFirstResponder()
            self?.mobileTF.text = ""
            self?.mobileTF.becomeFirstResponder()
            
            self?.delegate?.didTapOnCountryCodeBtn(cell: self!)
            
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


extension DriverDetailsTVCell {
    
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

