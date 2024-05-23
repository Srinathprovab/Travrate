//
//  HotelFareSummaryTVCell.swift
//  Travgate
//
//  Created by FCI on 19/03/24.
//

import UIKit

protocol HotelFareSummaryTVCellDelegate {
    func didTapOnUserTermsBtnAction(cell:HotelFareSummaryTVCell)
    func didTapOnPrivacyPolicyBtnAction(cell:HotelFareSummaryTVCell)
}

class HotelFareSummaryTVCell: TableViewCell {
    
    @IBOutlet weak var faresummeryView: UIView!
    @IBOutlet weak var hotelnamelbl: UILabel!
    @IBOutlet weak var hotellocationlbl: UILabel!
    @IBOutlet weak var chickinlbl: UILabel!
    @IBOutlet weak var checkoutlbl: UILabel!
    @IBOutlet weak var roomlbl: UILabel!
    @IBOutlet weak var kwdpricelbl: UILabel!
    @IBOutlet weak var checkboximg: UIImageView!
    @IBOutlet weak var addonView: UIView!
    @IBOutlet weak var addonValue: UILabel!
    @IBOutlet weak var termslbl: UILabel!
    
    
    var delegate:HotelFareSummaryTVCellDelegate?
    var checkBool = false
    var str1 = "By booking this item, you agree to pay the total amount shown, which includes Service Fees, on the right and to the,"
    var str2 = " User Terms, "
    var str3 = "Privacy policy."
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        
        
        
        hotelnamelbl.text = MySingleton.shared.roompaxesdetails[0].room_name
        chickinlbl.text = defaults.string(forKey: UserDefaultsKeys.checkin)
        checkoutlbl.text = defaults.string(forKey: UserDefaultsKeys.checkout)
        roomlbl.text = "\(MySingleton.shared.roompaxesdetails[0].no_of_rooms ?? 0)"
        
        
        
        if MySingleton.shared.addonSelectedArray.count > 0 {
            addonView.isHidden = false
        }else {
            addonView.isHidden = true
        }
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(addon(_:)), name: NSNotification.Name("addon"), object: nil)
        
        
        
    }
    
    
    func setupUI() {
        faresummeryView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        faresummeryView.layer.cornerRadius = 8
        
        
        setAttributedString(str1: str1, str2: str2, str3: str3)
        
        let grandTotalString =  MySingleton.shared.roompaxesdetails[0].net
        let grandTotalDecimal = Decimal(string: grandTotalString ?? "0.0") ?? Decimal(0.0)
        
        updateTotalAmount(updatedGrandTotal: grandTotalDecimal)
        
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
    }
    
    
    func updateTotalAmount(updatedGrandTotal:Decimal) {
        // Update totalAmount label
        kwdpricelbl.text = "\(MySingleton.shared.roompaxesdetails[0].currency ?? ""):\(updatedGrandTotal)"
        
        
    }
    
    
    @objc func addon(_ ns: NSNotification) {
        
        // Convert selectedAddonTotalPrice to Decimal
        let selectedAddonTotalPriceDecimal = Decimal(MySingleton.shared.selectedAddonTotalPrice)
        
        // Convert grand total to Decimal
        guard let grandTotalString = MySingleton.shared.roompaxesdetails[0].net,
              let grandTotalDecimal = Decimal(string: grandTotalString) else {
            return // Handle the case where grand total cannot be converted to Decimal
        }
        
        // Add totalkwdvalue to grand total
        let updatedGrandTotal = grandTotalDecimal + selectedAddonTotalPriceDecimal
        
        // Update addonValue label
        addonValue.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? ""): \(selectedAddonTotalPriceDecimal)"
        
        updateTotalAmount(updatedGrandTotal: updatedGrandTotal)
        
    }
    
}


extension HotelFareSummaryTVCell {
    
    
    
    func setAttributedString(str1: String, str2: String, str3: String) {
        let atter1: [NSAttributedString.Key: Any] = [
            .foregroundColor: HexColor("#ED1654"),
            .font: UIFont.OpenSansRegular(size: 12)
        ]
        
        
        let atter2: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Buttoncolor,
            .font: UIFont.OpenSansRegular(size: 12),
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .underlineColor:UIColor.Buttoncolor
        ]
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        let atterStr2 = NSMutableAttributedString(string: str2, attributes: atter2)
        let atterStr3 = NSMutableAttributedString(string: str3, attributes: atter2)
        
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        combination.append(atterStr2)
        combination.append(atterStr3)
        
        termslbl.attributedText = combination
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped(_:)))
        termslbl.addGestureRecognizer(tapGesture)
        termslbl.isUserInteractionEnabled = true
    }
    
    @objc func labelTapped(_ gesture: UITapGestureRecognizer) {
        if gesture.didTapAttributedString(" User Terms, ", in: termslbl) {
            checkBool = true
            checkboximg.image = UIImage(named: "check")
            MySingleton.shared.checkTermsAndCondationStatus = true
            delegate?.didTapOnUserTermsBtnAction(cell: self)
            
        } else if gesture.didTapAttributedString("Privacy policy", in: termslbl) {
            checkBool = true
            checkboximg.image = UIImage(named: "check")
            MySingleton.shared.checkTermsAndCondationStatus = true
            delegate?.didTapOnPrivacyPolicyBtnAction(cell: self)
            
        }
    }
}




