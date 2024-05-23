//
//  SelectSportServiceTVCell.swift
//  Travrate
//
//  Created by FCI on 21/05/24.
//

import UIKit

class SelectSportServiceTVCell: UITableViewCell {

    @IBOutlet weak var titlelbl: UILabel!
    
    var teamid = String()
    var venuId = String()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
