//
//  CancellationStringTVCell.swift
//  Travrate
//
//  Created by FCI on 23/05/24.
//

import UIKit

class CancellationStringTVCell: TableViewCell {

    @IBOutlet weak var cancellationStringlbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func updateUI() {
        cancellationStringlbl.text = cellInfo?.title ?? ""
    }
    
}
