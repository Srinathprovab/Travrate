//
//  ActivitiesTypeInfoTVCell.swift
//  Travrate
//
//  Created by Admin on 17/07/24.
//

import UIKit

class ActivitiesTypeInfoTVCell: UITableViewCell {
    
    
    @IBOutlet weak var activitiesTypeNamelbl: UILabel!
    @IBOutlet weak var kedlbl: UILabel!
    @IBOutlet weak var booknowbtn: UIButton!
    @IBOutlet weak var img: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        booknowbtn.layer.cornerRadius = 4
        img.layer.cornerRadius = 6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
