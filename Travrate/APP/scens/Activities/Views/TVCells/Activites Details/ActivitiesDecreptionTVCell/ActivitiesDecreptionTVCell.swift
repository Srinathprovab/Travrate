//
//  ActivitiesDecreptionTVCell.swift
//  Travrate
//
//  Created by Admin on 17/07/24.
//

import UIKit

class ActivitiesDecreptionTVCell: TableViewCell {
    
    @IBOutlet weak var activitiestitlelbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func updateUI() {
        self.activitiestitlelbl.text = MySingleton.shared.activity_details?.content?.description?.htmlToString1
    }
    
}
