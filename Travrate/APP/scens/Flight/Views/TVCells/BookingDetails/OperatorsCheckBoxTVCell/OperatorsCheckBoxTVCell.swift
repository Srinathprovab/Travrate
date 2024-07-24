//
//  OperatorsCheckBoxTVCell.swift
//  Travgate
//
//  Created by FCI on 05/04/24.
//

import UIKit
protocol OperatorsCheckBoxTVCellDelegate {
    func enableContinuetoPaymentBtn(cell:OperatorsCheckBoxTVCell)
}

class OperatorsCheckBoxTVCell: TableViewCell {

    
    @IBOutlet weak var check1img: UIImageView!
    @IBOutlet weak var check2img: UIImageView!
    
    @IBOutlet weak var titlelbl1: UILabel!
    @IBOutlet weak var titlelbl2: UILabel!
    
    var check1bool = false
    var check2bool = false
    
    
    var delegate:OperatorsCheckBoxTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func updateUI() {
        
        
        if MySingleton.shared.enablePaymentButtonBool1 == true {
            check1bool = true
            check1img.image = UIImage(named: "check")
        }
        
        if MySingleton.shared.enablePaymentButtonBool2 == true {
            check2bool = true
            check2img.image = UIImage(named: "check")
        }
        
//        if MySingleton.shared.enablePaymentButtonBool1 == true && MySingleton.shared.enablePaymentButtonBool2 == true {
//            check1bool = false
//            check2bool = false
//            check1img.image = UIImage(named: "check")
//            check2img.image = UIImage(named: "check")
//            
//            enableContinueToPaymentBool()
//        }
        
        
        MySingleton.shared.setAttributedTextnew(str1: "*",
                                                    str2: "Multiple operators and Fare Family information added to flight details page. Please read it",
                                                    lbl: titlelbl1,
                                                    str1font: .InterMedium(size: 14),
                                                    str2font: .InterMedium(size: 14),
                                                    str1Color: .BooknowBtnColor,
                                                    str2Color: .BackBtnColor)
            
            
            MySingleton.shared.setAttributedTextnew(str1: "*",
                                                    str2: "Once payment is confirmed, tickets will be issued at the earliest within 24 hours at max",
                                                    lbl: titlelbl2,
                                                    str1font: .InterMedium(size: 14),
                                                    str2font: .InterMedium(size: 14),
                                                    str1Color: .BooknowBtnColor,
                                                    str2Color: .BackBtnColor)
        
    }
    
    
    @IBAction func didTapOnMultipleOperatoreBtnAction(_ sender: Any) {
        
        check1bool.toggle()
        
        if check1bool  {
           
            check1img.image = UIImage(named: "check")
            enableContinueToPaymentBool()
        }else {
           
            check1img.image = UIImage(named: "uncheck")
            enableContinueToPaymentBool()
        }

        
       
    }
    
    
    @IBAction func didTapOnPaymentCeheckBoxBtnAction(_ sender: Any) {
       
        check2bool.toggle()
        
        if check2bool {
           
            check2img.image = UIImage(named: "check")
            enableContinueToPaymentBool()
        }else {
        
            check2img.image = UIImage(named: "uncheck")
            enableContinueToPaymentBool()
        }
        
       
        
    }
    
    
    func enableContinueToPaymentBool() {
        delegate?.enableContinuetoPaymentBtn(cell: self)
    }
}
