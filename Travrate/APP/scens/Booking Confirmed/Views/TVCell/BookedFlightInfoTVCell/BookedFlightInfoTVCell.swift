//
//  BookedFlightInfoTVCell.swift
//  Travrate
//
//  Created by Admin on 09/08/24.
//

import UIKit

class BookedFlightInfoTVCell: UITableViewCell {
    
    @IBOutlet weak var ul: UIView!
    @IBOutlet weak var fromCityTimelbl: UILabel!
    @IBOutlet weak var fromCityNamelbl: UILabel!
    @IBOutlet weak var toCityTimelbl: UILabel!
    @IBOutlet weak var toCityNamelbl: UILabel!
    @IBOutlet weak var hourslbl: UILabel!
    @IBOutlet weak var inNolbl: UILabel!
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var deplogoImg: UIImageView!
    @IBOutlet weak var luggagelbl: UILabel!
    @IBOutlet weak var worklbl: UILabel!
    @IBOutlet weak var classlbl: UILabel!
    @IBOutlet weak var baggageView: UIStackView!
   
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
