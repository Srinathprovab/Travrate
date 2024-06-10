//
//  SearchCarRentalTVCell.swift
//  Travrate
//
//  Created by FCI on 10/06/24.
//

import UIKit
import DropDown

protocol SearchCarRentalTVCellDelegate {
    func didTapOnSearchBtnAction(cell:SearchCarRentalTVCell)
    func tfeditingChanged(tf: UITextField)
}

class SearchCarRentalTVCell: TableViewCell {
    
    
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var pickuplocTF: UITextField!
    @IBOutlet weak var dropuplocTF: UITextField!
    @IBOutlet weak var dropuplocView: BorderedView!
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
    
    
    let pickupTimePicker = UIDatePicker()
    let dropupTimePicker = UIDatePicker()
    let pickupDatePicker = UIDatePicker()
    let dropupDatePicker = UIDatePicker()
    let dropDown = DropDown()
    var delegate:SearchCarRentalTVCellDelegate?
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
       
    }
    
    
    override func updateUI() {
        searchBtn.layer.cornerRadius = 4
        pickuplocTF.addTarget(self, action: #selector(tfeditingChanged(_:)), for: .editingChanged)
        dropuplocTF.addTarget(self, action: #selector(tfeditingChanged(_:)), for: .editingChanged)
        setupDropDown()
        
        showPickupDatePicker()
        showDropupDatePicker()
        
        showPickupTimePicker()
        showDepartTimePicker()
    }
    
    @objc func tfeditingChanged(_ tf: UITextField) {
        delegate?.tfeditingChanged(tf: tf)
    }
    
    
    @IBAction func didTapOnSearchBtnAction(_ sender: Any) {
        delegate?.didTapOnSearchBtnAction(cell: self)
    }
    
    
    
    @IBAction func didTapOnClearPickuplocTFbtnAction(_ sender: Any) {
        pickuplocTF.text = ""
        pickuplocTF.becomeFirstResponder()
    }
    
    
    @IBAction func didTapOnClearDropuplocTFbtnAction(_ sender: Any) {
        dropuplocTF.text = ""
        dropuplocTF.becomeFirstResponder()
    }
    
    
    
    @IBAction func didTapOnSelectAgeBtnAction(_ sender: Any) {
        dropDown.show()
    }
    
    
    @IBAction func didTapOnDropOfSameLocBtnAction(_ sender: Any) {
        dropuplocView.isHidden = true
        dropofSameCheckImage.image = UIImage(named: "check")?.withRenderingMode(.alwaysOriginal)
        dropofDiffCheckImage.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal)
        NotificationCenter.default.post(name: NSNotification.Name("reloadTV"), object: nil)
    }
    
    
    @IBAction func didTapOnDropOfDifferentLocBtnAction(_ sender: Any) {
        dropuplocView.isHidden = false
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
            
        }
    }
}



extension SearchCarRentalTVCell {
    
    
    //MARK: - showPickupDatePicker showDropupDatePicker
    func showPickupDatePicker(){
        //Formate Date
        pickupDatePicker.datePickerMode = .date
        pickupDatePicker.minimumDate = Date()
        pickupDatePicker.preferredDatePickerStyle = .wheels
        
        let formter = DateFormatter()
        formter.dateFormat = "dd-MM-yyyy"
        
        
        if let calDepDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.sportcalDepDate) ?? "") {
            pickupDatePicker.date = calDepDate
            
            if self.dropupDatelbl.text == "Select Date" {
                dropupDatePicker.date = calDepDate
            }
            
            
            // Check if returnDate date is smaller than calDepDate date
            if let returnDate = formter.date(from: self.dropupDatelbl.text ?? ""),
               returnDate < calDepDate {
                dropupDatePicker.date = calDepDate
                
                // Also update the label to reflect the change
                self.dropupDatelbl.text = formter.string(from: calDepDate)
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
    
    
    
    
    
    //MARK: - showDropupDatePicker
    func showDropupDatePicker(){
        //Formate Date
        dropupDatePicker.datePickerMode = .date
        //        retDatePicker.minimumDate = Date()
        
        // Set minimumDate for retDatePicker based on depDatePicker
        let selectedDate = pickupDatePicker.date
        dropupDatePicker.minimumDate = selectedDate
        
        dropupDatePicker.preferredDatePickerStyle = .wheels
        
        
        let formter = DateFormatter()
        formter.dateFormat = "dd-MM-yyyy"
        
        
        if let calRetDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.sportcalRetDate) ?? "") {
            dropupDatePicker.date = calRetDate
            
            // Check if returnDate date is smaller than calDepDate date
            if let returnDate = formter.date(from: self.dropupDatelbl.text ?? ""),
               returnDate < calRetDate {
                dropupDatePicker.date = calRetDate
                
                // Also update the label to reflect the change
                self.dropupDatelbl.text = formter.string(from: calRetDate)
            }
            
            
        } else {
            dropupDatePicker.date = selectedDate
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
            
            let formater = DateFormatter()
            formater.dateFormat = "dd-MMM-yyyy"
            
            if pickupDateTF.isFirstResponder {
                pickupDatelbl.text = formater.string(from: pickupDatePicker.date)
                dropupDatePicker.date = pickupDatePicker.date
                dropupDatelbl.text = formater.string(from: dropupDatePicker.date)
            }else {
                pickupDatelbl.text = formater.string(from: pickupDatePicker.date)
                dropupDatelbl.text = formater.string(from: dropupDatePicker.date)
            }
            
            pickupDatelbl.textColor = .TitleColor
            dropupDatelbl.textColor = .TitleColor
            
            pickupDateTF.resignFirstResponder()
            dropupDateTF.resignFirstResponder()
        }
    
    
        @objc func cancelDatePicker(){
            pickupDateTF.resignFirstResponder()
            dropupDateTF.resignFirstResponder()
        }
    
    
    
}



extension SearchCarRentalTVCell {
    
    //MARK: - showTimePicker
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
        
       // delegate?.doneTimePicker(cell: self)
    }
    
    @objc func cancelTimePicker() {
        
        self.pickupTimeTF.resignFirstResponder()
        self.dropupTimeTF.resignFirstResponder()
        
       // delegate?.cancelTimePicker(cell: self)
    }
}
