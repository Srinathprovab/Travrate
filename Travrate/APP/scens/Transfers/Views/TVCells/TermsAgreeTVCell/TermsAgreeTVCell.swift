//
//  TermsAgreeTVCell.swift
//  Travgate
//
//  Created by FCI on 09/05/24.
//

import UIKit

protocol TermsAgreeTVCellDelegate: AnyObject {
    func didTapOnCheckBoxBtnAction(cell:TermsAgreeTVCell)
    func didTapOnTermsBtnAction(cell:TermsAgreeTVCell)
    func didTapOnPrivacyPolicyBtnAction(cell:TermsAgreeTVCell)
}

class TermsAgreeTVCell: TableViewCell {
    
    @IBOutlet weak var checkboximg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    
    
    
    weak var delegate:TermsAgreeTVCellDelegate?
    var checkBool = false
    var str1 = String()
    var str2 =  String()
    var str3 =  String()
    var str4 =  String()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
  
    
    @objc func labelTapped(gesture:UITapGestureRecognizer) {
        if gesture.didTapAttributedString("Terms ans Conditions", in: titlelbl) {
            
            checkBool = true
            checkboximg.image = UIImage(named: "check")
            MySingleton.shared.checkTermsAndCondationStatus = true
            
            delegate?.didTapOnTermsBtnAction(cell: self)
        }else if gesture.didTapAttributedString("Privacy Policy.", in: titlelbl) {
            
            checkBool = true
            checkboximg.image = UIImage(named: "check")
            MySingleton.shared.checkTermsAndCondationStatus = true
            
            delegate?.didTapOnPrivacyPolicyBtnAction(cell: self)
        }
        
        
    }
    
    
    override func updateUI() {
       // titlelbl.text = cellInfo?.title ?? ""
        
        if cellInfo?.key == "transfer" {
             str1 = "By booking this item, you agree to pay the total amount shown, which includes Service Fees. You also agree to the "
             str2 = "Terms ans Conditions"
             str3 = " and "
             str4 = "Privacy Policy."
            
        }else {

            str1 = "By Booking This item, You agree to pay the total amount shown, with includes service fees. you also agree to the "
            str2 = "Terms ans Conditions"
            str3 = " and "
            str4 = "Privacy Policy."
        }
        
        
        self.setAttributedTextnew(str1: str1,
                                  str2: str2,
                                  str3: str3,
                                  str4: str4,
                                  lbl: titlelbl,
                                  str1font: .InterMedium(size: 14),
                                  str2font: .InterBold(size: 14),
                                  str1Color: .TitleColor,
                                  str2Color: .BooknowBtnColor)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        titlelbl.addGestureRecognizer(tapGesture)
        titlelbl.isUserInteractionEnabled = true
    }
    
    
    @IBAction func didTapOnCheckBoxBtnAction(_ sender: Any) {
        // checkboximg.image = UIImage(named: checkBool ? "check" : "uncheck")
        checkBool.toggle()
        if checkBool {
            checkboximg.image = UIImage(named: "check")
            MySingleton.shared.checkTermsAndCondationStatus = true
        }else {
            checkboximg.image = UIImage(named: "uncheck")
            MySingleton.shared.checkTermsAndCondationStatus = false
        }
        
        
        delegate?.didTapOnCheckBoxBtnAction(cell: self)
    }
    
    
    func setAttributedTextnew(str1:String,str2:String,str3:String,str4:String,lbl:UILabel,str1font:UIFont,str2font:UIFont,str1Color:UIColor,str2Color:UIColor)  {
        
        let atter1 = [NSAttributedString.Key.foregroundColor:str1Color,
                      NSAttributedString.Key.font:str1font] as [NSAttributedString.Key : Any]
        
        // Attributes for link text with underline
            let atter2 = [
                NSAttributedString.Key.foregroundColor: str2Color,
                NSAttributedString.Key.font: str2font,
                NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                NSAttributedString.Key.underlineColor: str2Color
            ] as [NSAttributedString.Key: Any]
        
      
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        let atterStr2 = NSMutableAttributedString(string: str2, attributes: atter2)
        let atterStr3 = NSMutableAttributedString(string: str3, attributes: atter1)
        let atterStr4 = NSMutableAttributedString(string: str4, attributes: atter2)
        
        
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        combination.append(atterStr2)
        combination.append(atterStr3)
        combination.append(atterStr4)
        
        lbl.attributedText = combination
        
    }
    
}
