//
//  SeatingArrangementTVCell.swift
//  Travrate
//
//  Created by FCI on 30/05/24.
//

import UIKit

class SeatingArrangementTVCell: TableViewCell {

    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var desclbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title ?? ""
        desclbl.text = cellInfo?.subTitle ?? ""
    }
    
}
