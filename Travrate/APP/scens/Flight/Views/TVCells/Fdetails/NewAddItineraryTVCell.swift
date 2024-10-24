//
//  NewAddItineraryTVCell.swift
//  Travrate
//
//  Created by Admin on 05/09/24.
//

import UIKit

class NewAddItineraryTVCell: UITableViewCell {
    
    @IBOutlet weak var operatorimg: UIImageView!
    @IBOutlet weak var depimg: UIImageView!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var timeViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var timelbl: UILabel!
    @IBOutlet weak var flightnumber: UILabel!
    @IBOutlet weak var fromcitylbl: UILabel!
    @IBOutlet weak var fromdatelbl: UILabel!
    @IBOutlet weak var fromairportlbl: UILabel!
    @IBOutlet weak var fromterminallbl: UILabel!
    @IBOutlet weak var tocitylbl: UILabel!
    @IBOutlet weak var todatelbl: UILabel!
    @IBOutlet weak var toairportlbl: UILabel!
    @IBOutlet weak var toterminallbl: UILabel!
    @IBOutlet weak var hourslbl: UILabel!
    @IBOutlet weak var stopslbl: UILabel!
    @IBOutlet weak var imgwidth: NSLayoutConstraint!
    @IBOutlet weak var imgleft: NSLayoutConstraint!
    @IBOutlet weak var economylbl: UILabel!
    @IBOutlet weak var totalJourneyTimelbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
