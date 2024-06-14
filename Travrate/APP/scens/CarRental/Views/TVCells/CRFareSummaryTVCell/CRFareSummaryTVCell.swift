//
//  CRFareSummaryTVCell.swift
//  Travrate
//
//  Created by FCI on 14/06/24.
//

import UIKit

class CRFareSummaryTVCell: TableViewCell {
    
    
    @IBOutlet weak var topview: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        topview.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        topview.layer.cornerRadius = 8
    }
    
    
    
}
