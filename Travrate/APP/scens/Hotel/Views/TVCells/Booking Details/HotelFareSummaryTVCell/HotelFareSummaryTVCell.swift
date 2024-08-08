//
//  HotelFareSummaryTVCell.swift
//  Travgate
//
//  Created by FCI on 19/03/24.
//

import UIKit

protocol HotelFareSummaryTVCellDelegate:AnyObject {
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
    @IBOutlet weak var addonView: UIView!
    @IBOutlet weak var addonValue: UILabel!
    @IBOutlet weak var roompricelbl: UILabel!
    
    weak var delegate:HotelFareSummaryTVCellDelegate?
    
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
        
        
        MySingleton.shared.setAttributedTextnew(str1: "",
                                                str2: grandTotal,
                                                lbl: roompricelbl,
                                                str1font: .OpenSansRegular(size: 16),
                                                str2font: .OpenSansBold(size: 16),
                                                str1Color: HexColor("#515151"),
                                                str2Color: HexColor("#515151"))
        
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(addon(_:)), name: NSNotification.Name("addon"), object: nil)
        
        
        
    }
    
    
    func setupUI() {
        faresummeryView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        faresummeryView.layer.cornerRadius = 8
        
        
        
        let grandTotalString =  MySingleton.shared.roompaxesdetails[0].net
        let grandTotalDecimal = Decimal(string: grandTotalString ?? "0.0") ?? Decimal(0.0)
        
        updateTotalAmount(updatedGrandTotal: grandTotalDecimal)
        
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





