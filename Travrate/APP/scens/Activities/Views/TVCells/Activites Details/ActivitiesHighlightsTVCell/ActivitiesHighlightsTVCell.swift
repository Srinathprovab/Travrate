//
//  ActivitiesHighlightsTVCell.swift
//  Travrate
//
//  Created by Admin on 17/07/24.
//

import UIKit

class ActivitiesHighlightsTVCell: TableViewCell {
    
    @IBOutlet weak var durationlbl: UILabel!
    @IBOutlet weak var langlbl: UILabel!
    @IBOutlet weak var typelbl: UILabel!
    @IBOutlet weak var otherlbl: UILabel!
    @IBOutlet weak var featureslbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        
        MySingleton.shared.setAttributedTextnew(str1: "Duration : ",
                                                str2: "\(MySingleton.shared.activity_details?.modalities?[0].duration?.value ?? 0) \((MySingleton.shared.activity_details?.modalities?[0].duration?.metric ?? ""))",
                                                lbl: self.durationlbl,
                                                str1font: .InterSemiBold(size: 16),
                                                str2font: .InterRegular(size: 16),
                                                str1Color: .TitleColor,
                                                str2Color: .subtitleNewcolor)
        
        
        MySingleton.shared.setAttributedTextnew(str1: "Language : ",
                                                str2: "English",
                                                lbl: self.langlbl,
                                                str1font: .InterSemiBold(size: 16),
                                                str2font: .InterRegular(size: 16),
                                                str1Color: .TitleColor,
                                                str2Color: .subtitleNewcolor)
                
        
        MySingleton.shared.setAttributedTextnew(str1: " Type : ",
                                                str2: "\(MySingleton.shared.activity_details?.type ?? "")",
                                                lbl: self.typelbl,
                                                str1font: .InterSemiBold(size: 16),
                                                str2font: .InterRegular(size: 16),
                                                str1Color: .TitleColor,
                                                str2Color: .subtitleNewcolor)
        
        
        MySingleton.shared.setAttributedTextnew(str1: " Other Activities:",
                                                str2: "",
                                                lbl: self.otherlbl,
                                                str1font: .InterSemiBold(size: 16),
                                                str2font: .InterRegular(size: 16),
                                                str1Color: .TitleColor,
                                                str2Color: .subtitleNewcolor)
        
        
        
        MySingleton.shared.setAttributedTextnew(str1: "Features : ",
                                                str2: "\(MySingleton.shared.activity_details?.feature ?? "")",
                                                lbl: self.featureslbl,
                                                str1font: .InterSemiBold(size: 16),
                                                str2font: .InterRegular(size: 16),
                                                str1Color: .TitleColor,
                                                str2Color: .subtitleNewcolor)
        
       
    }
    
    
    
}
