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
    @IBOutlet weak var optionsView: UIView!
    
    
    
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
        
        
        
        
    }
    
    
    
}
