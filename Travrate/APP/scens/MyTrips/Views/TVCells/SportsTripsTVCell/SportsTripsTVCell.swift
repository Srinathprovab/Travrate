//
//  SportsTripsTVCell.swift
//  Travrate
//
//  Created by Admin on 21/07/24. ActivitiesTripsTVCell  CarRentalTripsTVCell SportsTripsTVCell
//

import UIKit

class SportsTripsTVCell: TableViewCell {
    
    @IBOutlet weak var sportimg2: UIImageView!
    @IBOutlet weak var sportimg1: UIImageView!
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    @IBOutlet weak var sportcitylbl: UILabel!
    @IBOutlet weak var viewTicketBtn: UIButton!
    @IBOutlet weak var kwdlbl: UILabel!
    
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
        viewTicketBtn.layer.cornerRadius = 4
    }
    
}
