//
//  NoDataFoundTVCell.swift
//  Travrate
//
//  Created by Admin on 07/08/24.
//

import UIKit

class NoDataFoundTVCell: TableViewCell {
    
    @IBOutlet weak var titlelbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titlelbl.text = "No Data Found"
        titlelbl.font = .InterMedium(size: 16)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
