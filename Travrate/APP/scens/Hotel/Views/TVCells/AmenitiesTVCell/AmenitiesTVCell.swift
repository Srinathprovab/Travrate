//
//  AmenitiesTVCell.swift
//  BabSafar
//
//  Created by MA673 on 02/08/22.
//

import UIKit

class AmenitiesTVCell: TableViewCell {
    
    @IBOutlet weak var titlelbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state amenitiesCV
    }
    
    func setupUI() {
        titlelbl.font = .InterMedium(size: 14)
    }
    
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title
    }
    
}



