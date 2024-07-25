//
//  ActivitiesFareSummeryTVCell.swift
//  Travrate
//
//  Created by Admin on 18/07/24.
//

import UIKit


protocol ActivitiesFareSummeryTVCellDelegate {
    func didTapOnDeleteAddonBtnAction(cell:ActivitiesFareSummeryTVCell)
}


class ActivitiesFareSummeryTVCell: TableViewCell {
    
    
    @IBOutlet weak var activitynamelbl: UILabel!
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var adultlbl: UILabel!
    @IBOutlet weak var childlbl: UILabel!
    @IBOutlet weak var infantlbl: UILabel!
    @IBOutlet weak var totalamountlbl: UILabel!
    @IBOutlet weak var adultview: UIView!
    @IBOutlet weak var childview: UIView!
    @IBOutlet weak var infantview: UIView!
    @IBOutlet weak var topview: UIView!
    @IBOutlet weak var notificationkwdlbl: UILabel!
    @IBOutlet weak var priceChangekwdlbl: UILabel!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var priceBtn: UIButton!
    
    
    var delegate:ActivitiesFareSummeryTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupui()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupui(){
        
        
        
    }
    
    
    override func updateUI() {
        topview.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        topview.layer.cornerRadius = 8
        
        
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
        
        activitynamelbl.text = defaults.string(forKey: UserDefaultsKeys.activitesname)
        let adultcount = defaults.integer(forKey: UserDefaultsKeys.activitesadultCount)
        let childcount = defaults.integer(forKey: UserDefaultsKeys.activiteschildCount)
        let infantcount = defaults.integer(forKey: UserDefaultsKeys.activitesinfantsCount)
        childview.isHidden = childcount == 0 ? true : false
        infantview.isHidden = infantcount == 0 ? true : false
        adultlbl.text = "\(adultcount)"
        childlbl.text = "\(childcount)"
        infantlbl.text = "\(infantcount)"
        
        
        //        totlConvertedGrand = 250.00
        MySingleton.shared.setAttributedTextnew(str1: "\(MySingleton.shared.activites_currency) ",
                                                str2: String(format: "%.2f", totlConvertedGrand),
                                                lbl: totalamountlbl,
                                                str1font: .InterBold(size: 16),
                                                str2font: .InterBold(size: 16),
                                                str1Color: .TitleColor,
                                                str2Color: .TitleColor)
        
        
        
        MySingleton.shared.setAttributedTextnew(str1: "",
                                                str2:  MySingleton.shared.convertDateFormat(inputDate: MySingleton.shared.activity_selecteddate, f1: "yyyy-MM-dd", f2: "dd MMM yyyy"),
                                                lbl: datelbl,
                                                str1font: .InterSemiBold(size: 16),
                                                str2font: .InterSemiBold(size: 16),
                                                str1Color: .TitleColor,
                                                str2Color: .TitleColor)
        
        
        notificationkwdlbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD") \(hotelnotificationPrice)"
        priceChangekwdlbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD") \(hotelpriceChange)"
        notificationBtn.addTarget(self, action: #selector(didTapOnDeleteAddonBtnAction(_:)), for: .touchUpInside)
        priceBtn.addTarget(self, action: #selector(didTapOnDeleteAddonBtnAction(_:)), for: .touchUpInside)
        
        
    }
    
    
    
    @objc func didTapOnDeleteAddonBtnAction(_ sender:UIButton) {
        sender.tag == 1 ? tapOnDeleteNotification():tapOnDeletePriceChange()
        delegate?.didTapOnDeleteAddonBtnAction(cell: self)
    }
    
    func tapOnDeleteNotification() {
        totlConvertedGrand -= Double(notificationPrice) ?? 0.0
        self.notificationView.isHidden = true
    }
    
    func tapOnDeletePriceChange() {
        totlConvertedGrand -= Double(priceChange) ?? 0.0
        self.priceView.isHidden = true
    }
    
    
}
