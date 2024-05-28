//
//  SportsFareSummeryTVCell.swift
//  Travrate
//
//  Created by FCI on 27/05/24.
//

import UIKit

class SportsFareSummeryTVCell: TableViewCell {
    
    @IBOutlet weak var topview: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setupUI(){
        
        topview.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // top left corner, top right corner respectively
        topview.layer.cornerRadius = 8

    }
    
    
}
