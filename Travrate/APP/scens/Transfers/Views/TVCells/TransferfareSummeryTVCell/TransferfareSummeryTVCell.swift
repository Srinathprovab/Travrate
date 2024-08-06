//
//  TransferfareSummeryTVCell.swift
//  Travrate
//
//  Created by Admin on 15/07/24.
//

import UIKit

class TransferfareSummeryTVCell: TableViewCell {
    
    
    @IBOutlet weak var topview: UIView!
    @IBOutlet weak var addonsView: UIView!
    @IBOutlet weak var whatsappView: UIView!
    @IBOutlet weak var flexiview: UIView!
    @IBOutlet weak var basefarelbl: UILabel!
    @IBOutlet weak var whatsapplbl: UILabel!
    @IBOutlet weak var flixilbl: UILabel!
    @IBOutlet weak var taxlbl: UILabel!
    @IBOutlet weak var subtotallbl: UILabel!
    @IBOutlet weak var totalamountlbl: UILabel!
    
    
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
        
        
        
        MySingleton.shared.setAttributedTextnew(str1: "\(transfer_data?.currency ?? "") ",
                                                str2: String(format: "%.2f", Double(hotelwhatsAppPrice) ?? 0.0),
                                                lbl: whatsapplbl,
                                                str1font: .InterSemiBold(size: 16),
                                                str2font: .InterSemiBold(size: 16),
                                                str1Color: .TitleColor,
                                                str2Color: .TitleColor)
        
        MySingleton.shared.setAttributedTextnew(str1: "\(transfer_data?.currency ?? "") ",
                                                str2: String(format: "%.2f", Double(hotelflexiblePrie) ?? 0.0),
                                                lbl: flixilbl,
                                                str1font: .InterSemiBold(size: 16),
                                                str2font: .InterSemiBold(size: 16),
                                                str1Color: .TitleColor,
                                                str2Color: .TitleColor)
        
        
        
        
        MySingleton.shared.setAttributedTextnew(str1: "\(transfer_data?.currency ?? "") ",
                                                str2: String(format: "%.2f", transfer_data?.price ?? 0.0),
                                                lbl: basefarelbl,
                                                str1font: .InterSemiBold(size: 16),
                                                str2font: .InterSemiBold(size: 16),
                                                str1Color: .TitleColor,
                                                str2Color: .TitleColor)
        
        
        MySingleton.shared.setAttributedTextnew(str1: "\(transfer_data?.currency ?? "") ",
                                                str2: "0.0",
                                                lbl: taxlbl,
                                                str1font: .InterSemiBold(size: 16),
                                                str2font: .InterSemiBold(size: 16),
                                                str1Color: .TitleColor,
                                                str2Color: .TitleColor)
        
        
        MySingleton.shared.setAttributedTextnew(str1: "\(transfer_data?.currency ?? "") ",
                                                str2: String(format: "%.2f", totlConvertedGrand),
                                                lbl: subtotallbl,
                                                str1font: .InterSemiBold(size: 16),
                                                str2font: .InterSemiBold(size: 16),
                                                str1Color: .TitleColor,
                                                str2Color: .TitleColor)
        
        
        MySingleton.shared.setAttributedTextnew(str1: "\(transfer_data?.currency ?? "") ",
                                                str2: String(format: "%.2f", totlConvertedGrand),
                                                lbl: totalamountlbl,
                                                str1font: .InterSemiBold(size: 20),
                                                str2font: .InterSemiBold(size: 20),
                                                str1Color: .TitleColor,
                                                str2Color: .TitleColor)
        
        
        
        
        
        
        if  hotelwhatsAppCheck == true {
            addonsView.isHidden = false
            whatsappView.isHidden = false
        } else {
            whatsappView.isHidden = true
        }
        
        if  hotelflexibleCheck == true {
            addonsView.isHidden = false
            flexiview.isHidden = false
        } else {
            flexiview.isHidden = true
        }
        
        
        if hotelflexibleCheck == false && hotelwhatsAppCheck == false {
            addonsView.isHidden = true
        }
    }
    
    func setupUI() {
        topview.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        topview.layer.cornerRadius = 8
        
        
        
        
    }
    
}
