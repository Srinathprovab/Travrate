//
//  PickupTVCell.swift
//  Travrate
//
//  Created by Admin on 12/07/24.
//

import UIKit

class PickupTVCell: TableViewCell {
    
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var locationlbl: UILabel!
    @IBOutlet weak var addresslbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        
        titlelbl.text = cellInfo?.buttonTitle ?? ""
        datelbl.text = cellInfo?.title ?? ""
        locationlbl.text = cellInfo?.subTitle ?? ""
        addresslbl.text = cellInfo?.text ?? ""
        
    }
    
}
