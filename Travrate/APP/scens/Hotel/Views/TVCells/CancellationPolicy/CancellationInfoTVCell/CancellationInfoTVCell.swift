//
//  CancellationInfoTVCell.swift
//  Travrate
//
//  Created by Admin on 20/08/24.
//

import UIKit

class CancellationInfoTVCell: UITableViewCell {
    
    @IBOutlet weak var titlelbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI() {
        setuplabels(lbl: titlelbl, text: "", textcolor: .TitleColor, font:.OpenSansRegular(size: 12), align: .left)
        titlelbl.numberOfLines = 0
    }
    
    
    
}
