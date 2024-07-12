//
//  CRFareSummaryTVCell.swift
//  Travrate
//
//  Created by FCI on 14/06/24.
//

import UIKit

class CRFareSummaryTVCell: TableViewCell {
    
    
    @IBOutlet weak var topview: UIView!
    @IBOutlet weak var carrentalPrice: UILabel!
    @IBOutlet weak var subtotalprice: UILabel!
    @IBOutlet weak var totalprice: UILabel!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var notificationkwdlbl: UILabel!
    @IBOutlet weak var priceChangekwdlbl: UILabel!
    
    
    
    
    var carproductDetails :Product?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        
        notificationView.isHidden = true
        priceView.isHidden = true
        
       
        
        if  hotelpriceCheck == true {
            priceView.isHidden = false
        } else {
            priceView.isHidden = true
        }
        
        if  hotelnotificationCheck == true {
            notificationView.isHidden = false
        } else {
            notificationView.isHidden = true
        }
        
        
//        if hotelpriceCheck  == false && hotelnotificationCheck == false  {
//            priceView.isHidden = true
//            notificationView.isHidden = true
//        } else {
//            priceView.isHidden = false
//            notificationView.isHidden = false
//        }
        
        
        carproductDetails = cellInfo?.moreData as? Product
        topview.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        topview.layer.cornerRadius = 8
        
        MySingleton.shared.setAttributedTextnew(str1: carproductDetails?.currency ?? "",
                                                str2: carproductDetails?.total ?? "",
                                                lbl: carrentalPrice,
                                                str1font: .InterSemiBold(size: 16),
                                                str2font: .InterSemiBold(size: 16),
                                                str1Color: .TitleColor,
                                                str2Color: .TitleColor)
        
        MySingleton.shared.setAttributedTextnew(str1: carproductDetails?.currency ?? "",
                                                str2: carproductDetails?.total ?? "",
                                                lbl: subtotalprice,
                                                str1font: .InterSemiBold(size: 16),
                                                str2font: .InterSemiBold(size: 16),
                                                str1Color: .TitleColor,
                                                str2Color: .TitleColor)
        
        
        MySingleton.shared.setAttributedTextnew(str1: carproductDetails?.currency ?? "",
                                                str2: carproductDetails?.total ?? "",
                                                lbl: totalprice,
                                                str1font: .InterSemiBold(size: 16),
                                                str2font: .InterSemiBold(size: 16),
                                                str1Color: .TitleColor,
                                                str2Color: .TitleColor)
        
        
        
        
        
        notificationkwdlbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD") \(hotelnotificationPrice)"
        priceChangekwdlbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD") \(hotelpriceChange)"
        
    }
    
    
    
}
