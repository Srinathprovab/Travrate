//
//  SelectedSportInfoTVCell.swift
//  Travgate
//
//  Created by FCI on 10/05/24.
//

import UIKit

class SelectedSportInfoTVCell: TableViewCell {
    
    
    @IBOutlet weak var sportimg2: UIImageView!
    @IBOutlet weak var sportimg1: UIImageView!
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    @IBOutlet weak var sportcitylbl: UILabel!
    @IBOutlet weak var tournamentnamelbl: UILabel!
    
    
    var participantsA = [Participants]()
    var delegate:SportInfoTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        titlelbl.text = MySingleton.shared.sportListData?.eventType?.name
        subtitlelbl.text = MySingleton.shared.sportListData?.name
        sportcitylbl.text = MySingleton.shared.sportListData?.venue?.name
        datelbl.text = "\(MySingleton.shared.sportListData?.dateOfEvent ?? "")-\(MySingleton.shared.sportListData?.timeOfEvent ?? "")"
        tournamentnamelbl.text = MySingleton.shared.sportListData?.tournament?.name
        
        participantsA = MySingleton.shared.participantsArray
        
        if participantsA.isEmpty == false {
            
            self.sportimg1.sd_setImage(with: URL(string: participantsA[0].participants_img ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            
            self.sportimg2.sd_setImage(with: URL(string: participantsA[1].participants_img ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            
            
        }
    }
    
    
    func setupUI() {
       
    }
    
    
   
    
}
