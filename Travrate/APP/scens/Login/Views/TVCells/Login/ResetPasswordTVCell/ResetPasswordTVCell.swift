//
//  ResetPasswordTVCell.swift
//  TravgateApp
//
//  Created by FCI on 10/01/24.
//

import UIKit

protocol ResetPasswordTVCellDelegate: AnyObject {
    func didTapOnSendEmailBtnAction(cell:ResetPasswordTVCell)
    func editingTextField(tf:UITextField)
    func didTapOnRestPasswordBackBtnAction(cell:ResetPasswordTVCell)
    
}

class ResetPasswordTVCell: TableViewCell {

    @IBOutlet weak var emailtf: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var sendbtn: UIButton!
    @IBOutlet weak var emailview: UIView!
    @IBOutlet weak var mobileview: UIView!
    
    
    @IBOutlet weak var headdertitlelbl: UILabel!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var mobilenotitlelbl: UILabel!
    @IBOutlet weak var emailtitlelbl: UILabel!
    
    weak  var delegate:ResetPasswordTVCellDelegate?
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
        
        
        if LanguageManager.shared.currentLanguage() == "ar" {
            headdertitlelbl.text = "إعادة تعيين كلمة المرور"
            titlelbl.text = "أدخل البريد الإلكتروني المرتبط بحسابك وسنرسل لك رسالة تحتوي على تعليمات لإعادة تعيين كلمة المرور."
            emailtitlelbl.text = "عنوان البريد الالكترونى"
            mobilenotitlelbl.text = "رقم الهاتف المحمول"
            sendbtn.setTitle("يرسل", for: .normal)
            emailtf.placeholder = "عنوان البريد الالكترونى"
            mobileTF.placeholder = "رقم الهاتف المحمول"
            
        } else {
            headdertitlelbl.text = "Reset Password"
            titlelbl.text = "Enter the email associated with your account and we’ll send an Email with instructions to reset your password."
            emailtitlelbl.text = "Email Address"
            mobilenotitlelbl.text = "Mobile Number"
            sendbtn.setTitle("Send", for: .normal)
            emailtf.placeholder = "Email Address"
            mobileTF.placeholder = "Mobile Number"
        }
       
        
        
        
        sendbtn.layer.cornerRadius = 6
        setupTF(tf: emailtf)
        setupTF(tf: mobileTF)
    }
    
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if LanguageManager.shared.currentLanguage() == "ar" {
            textField.textAlignment = .right
            textField.keyboardType = .default
            textField.autocorrectionType = .no
            textField.semanticContentAttribute = .forceLeftToRight
            textField.reloadInputViews()
            textField.setRightPaddingPoints(15)
        } else {
            textField.textAlignment = .left
            textField.semanticContentAttribute = .forceRightToLeft
            textField.setLeftPaddingPoints(15)
        }
    }
    
    
    func setupTF(tf:UITextField) {
        tf.delegate = self
        tf.setLeftPaddingPoints(15)
        tf.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
    }
    
    @objc func editingText(textField:UITextField) {
        if textField.tag == 1 {
            emailview.layer.borderColor = UIColor.BorderColor.cgColor
        }else {
            mobileview.layer.borderColor = UIColor.BorderColor.cgColor
        }
        delegate?.editingTextField(tf: textField)
    }
    
    @IBAction func didTapOnSendEmailBtnAction(_ sender: Any) {
        delegate?.didTapOnSendEmailBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnRestPasswordBackBtnAction(_ sender: Any) {
        delegate?.didTapOnRestPasswordBackBtnAction(cell: self)
    }
    
    
}



extension ResetPasswordTVCell {
    
    
    
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
      
        switch textField.tag {
        case 11://email
            let maxLength = 50
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
            
        case 12://mobile
            let maxLength = 10
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet) && newString.length <= maxLength
            
            
        default:
            let maxLength = 100
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        
    }
    
    
}
