//
//  NewHotelPriceSummeryTVCell.swift
//  BabSafar
//
//  Created by FCI on 01/09/23.
//

import UIKit

class NewHotelPriceSummeryTVCell: TableViewCell {
    
    @IBOutlet weak var childCountLabel: UILabel!
    @IBOutlet weak var adultCountLabel: UILabel!
    @IBOutlet weak var roomCountLabel: UILabel!
    @IBOutlet weak var addonView: UIView!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var flexibleView: UIView!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var whatsAppView: UIView!
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var priceChangeLabel: UILabel!
    @IBOutlet weak var flexiblePriceLbl: UILabel!
    @IBOutlet weak var whatsAppPriceLbl: UILabel!
    @IBOutlet weak var hotelNamelbl: UILabel!
    @IBOutlet weak var hotelLoclbl: UILabel!
    @IBOutlet weak var checkinDatelbl: UILabel!
    @IBOutlet weak var checkoutDatelbl: UILabel!
    @IBOutlet weak var noofNightslbl: UILabel!
    @IBOutlet weak var roomTypelbl: UILabel!
    @IBOutlet weak var adultsCountlbl: UILabel!
    @IBOutlet weak var childCountlbl: UILabel!
    @IBOutlet weak var pricelbl: UILabel!
    @IBOutlet weak var holderView: UIStackView!
    @IBOutlet weak var pricesummerylbl: UILabel!
    @IBOutlet weak var topview: UIView!
    @IBOutlet weak var roompricelbl: UILabel!
    @IBOutlet weak var totaltitlelbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        holderView.layer.cornerRadius = 8
        holderView.layer.borderWidth = 1
        holderView.layer.borderColor = UIColor.BorderColor.cgColor
        pricesummerylbl.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        pricesummerylbl.layer.cornerRadius = 8
        
        topview.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        topview.layer.cornerRadius = 8
        
        hotelflexibleAmount = Int(hotelflexiblePrie) ?? 0
        hotelwhatsAppAmount = Int(hotelwhatsAppPrice) ?? 0
        hotelpriceChangeAmount = Int(hotelpriceChange) ?? 0
        hotelnotificationAmount = Int(hotelnotificationPrice) ?? 0
        
        HoteladdonAmount = hotelflexibleAmount + hotelwhatsAppAmount + hotelpriceChangeAmount + hotelnotificationAmount
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        if  hotelwhatsAppCheck == true {
            whatsAppView.isHidden = false
        } else {
            whatsAppView.isHidden = true
        }
        
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
        
        if  hotelflexibleCheck == true {
            flexibleView.isHidden = false
        } else {
            flexibleView.isHidden = true
        }
        
        
        if  hotelwhatsAppCheck == false &&  hotelpriceCheck  == false &&  hotelnotificationCheck  == false &&  hotelflexibleCheck  == false {
            addonView.isHidden = true
        } else {
            addonView.isHidden = false
        }
        
        
        hotelNamelbl.text = cellInfo?.title ?? ""
        hotelLoclbl.text = cellInfo?.subTitle ?? ""
        checkinDatelbl.text = defaults.string(forKey: UserDefaultsKeys.checkin) ?? ""
        checkoutDatelbl.text = defaults.string(forKey: UserDefaultsKeys.checkout) ?? ""
        
        noofNightslbl.text = cellInfo?.tempText ?? ""
        roomTypelbl.text = "Room:"
        roomCountLabel.text = cellInfo?.headerText ?? ""
        
        adultsCountlbl.text = "No of Adults:"
        
        if cellInfo?.questionBase != "0" {
            childCountlbl.text = "No of Children:"
            childCountLabel.text = "\(cellInfo?.questionBase ?? "")"
        } else
        {
            childCountlbl.isHidden = true
            childCountLabel.isHidden = true
        }
        adultCountLabel.text = "\(cellInfo?.TotalQuestions ?? "")"
        MySingleton.shared.setAttributedTextnew(str1: "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "")",
                                                str2: String(format: "%.2f", totlConvertedGrand),
                             lbl: pricelbl,
                             str1font: .InterBold(size: 12),
                             str2font: .InterBold(size: 18),
                             str1Color: .TitleColor,
                             str2Color: .TitleColor)
        
        
        
        whatsAppPriceLbl.text =  "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD") \(hotelwhatsAppPrice)"
        flexiblePriceLbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD") \(hotelflexiblePrie)"
        notificationLabel.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD") \(hotelnotificationPrice)"
        priceChangeLabel.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD") \(hotelpriceChange)"
        
        
        roompricelbl.text = grandTotal
        roompricelbl.font = .InterBold(size: 14)
        roompricelbl.textColor = .TitleColor
        
        totaltitlelbl.text = "Total"
        totaltitlelbl.font = .InterBold(size: 16)
        totaltitlelbl.textColor = .TitleColor
        
    }
    
}
