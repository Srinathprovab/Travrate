//
//  SeeMoreRulesBtnTVCell.swift
//  Travrate
//
//  Created by Admin on 28/06/24.
//

import UIKit

class SeeMoreRulesBtnTVCell: TableViewCell {
    
    @IBOutlet weak var seemorelbl: UILabel!
    @IBOutlet weak var arrowimg: UIImageView!

    var morebool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func didTapOnMoreFareRulesBtnAction(_ sender: Any) {
        morebool.toggle()
        if morebool {
            seeMoreRules()
        }else {
            seeLessRules()
        }
    }
    
    
    func seeLessRules() {
        seemorelbl.text = "See Less Rules"
        arrowimg.image = UIImage(named: "dropup")?.withRenderingMode(.alwaysOriginal).withTintColor(.black)
        NotificationCenter.default.post(name: NSNotification.Name("SeeMoreRules"), object: true)
    }
    
    func seeMoreRules(){
        seemorelbl.text = "See More Rules"
        arrowimg.image = UIImage(named: "downarrow")?.withRenderingMode(.alwaysOriginal).withTintColor(.black)
        NotificationCenter.default.post(name: NSNotification.Name("SeeMoreRules"), object: false)
    }
    
}

