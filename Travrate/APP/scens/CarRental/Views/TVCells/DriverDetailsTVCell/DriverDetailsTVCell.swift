//
//  DriverDetailsTVCell.swift
//  Travrate
//
//  Created by FCI on 14/06/24.
//

import UIKit
import DropDown

class DriverDetailsTVCell: TableViewCell {
    
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var fnameTF: UITextField!
    @IBOutlet weak var lnameTF: UITextField!
    @IBOutlet weak var dobTF: UITextField!
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var dobView: UIView!
    @IBOutlet weak var ageView: UIView!
    @IBOutlet weak var passportnoTF: UITextField!
    @IBOutlet weak var nationaslityTF: UITextField!
    @IBOutlet weak var civilidTF: UITextField!
    @IBOutlet weak var emailidTF: UITextField!
    @IBOutlet weak var countrycodeView: UIView!
    @IBOutlet weak var countrycodeTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    
    
    var dropDown = DropDown()
    var agedropDown = DropDown()
    let datePicker = UIDatePicker()
    var delegate:MainTravelPersonTVCellDelete?
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
        
        setupTF(tf: fnameTF)
        setupTF(tf: lnameTF)
        setupTF(tf: emailidTF)
        setupTF(tf: mobileTF)
        setupTF(tf: nationaslityTF)
        setupTF(tf: civilidTF)
        setupTF(tf: dobTF)
        setupTF(tf: ageTF)
        setupTF(tf: passportnoTF)
        setupTF(tf: dobTF)
        
        setupTitleDropDown()
        showDatePicker()
        
    }
    
    func setupTF(tf:UITextField) {
        tf.font = .OpenSansRegular(size: 14)
        tf.setLeftPaddingPoints(15)
        tf.addTarget(self, action: #selector(editingTextFieldChanged(_:)), for: .editingChanged)
    }
    
    @objc func editingTextFieldChanged( _ tf:UITextField) {
        delegate?.editingTextFieldChanged(tf: tf)
    }
    
    
    
    @IBAction func didTapOnTitleDropDownAction(_ sender: Any) {
        dropDown.show()
    }
    
}


extension DriverDetailsTVCell {
    
    
    func setupTitleDropDown() {
        
        dropDown.dataSource = ["MR","MRS","MISS"]
        dropDown.direction = .bottom
        dropDown.backgroundColor = .WhiteColor
        dropDown.anchorView = self.titleView
        dropDown.bottomOffset = CGPoint(x: 0, y: titleView.frame.size.height + 10)
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            
            self?.titleTF.text = item
            
            // self?.delegate?.didTapOnTitleSelectBtnAction(cell: self!)
            
        }
    }
    
    
    
    
    //MARK: - DATE PICKER
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        dobTF.inputAccessoryView = toolbar
        dobTF.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        dobTF.text = formatter.string(from: datePicker.date)
        dobTF.resignFirstResponder()
        //delegate?.donedatePicker(cell: self)
    }
    
    @objc func cancelDatePicker(){
        dobTF.resignFirstResponder()
        // delegate?.cancelDatePicker(cell: self)
    }
}


