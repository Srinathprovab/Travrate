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
}

class DriverDetailsTVCell: TableViewCell,UITextViewDelegate {
    
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var fnameTF: UITextField!
    @IBOutlet weak var lnameTF: UITextField!
    @IBOutlet weak var nationaslityTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var postalcodeTF: UITextField!
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var emailidTF: UITextField!
    @IBOutlet weak var countrycodeView: UIView!
    @IBOutlet weak var countrycodeTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    
    
    
    var placeHolder = "Address"
    var delegate:DriverDetailsTVCellDelegate?
    var dropDown = DropDown()
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
        
        setupTF(tf: fnameTF)
        setupTF(tf: lnameTF)
        setupTF(tf: emailidTF)
        setupTF(tf: mobileTF)
        setupTF(tf: nationaslityTF)
        setupTF(tf: cityTF)
        setupTF(tf: postalcodeTF)
        
        setupTitleDropDown()
        setupAddressTextView()
    }
    
    func setupTF(tf:UITextField) {
        tf.font = .OpenSansRegular(size: 14)
        tf.setLeftPaddingPoints(15)
        tf.addTarget(self, action: #selector(editingTextFieldChanged(_:)), for: .editingChanged)
    }
    
    func setupAddressTextView() {
        
        addressTextView.layer.cornerRadius = 6
        addressTextView.clipsToBounds = true
        addressTextView.layer.borderWidth = 1
        addressTextView.layer.borderColor = UIColor.AppBorderColor.cgColor
        
        addressTextView.text = ""
        addressTextView.delegate = self
        addressTextView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 4)
        addressTextView.setPlaceholder(ph: placeHolder)
    }
    
    @objc func textViewDidChange(_ textView: UITextView) {
        textView.checkPlaceholder()
        delegate?.textViewDidChange(textView: textView)
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
    
    
    
    
    
   
}


