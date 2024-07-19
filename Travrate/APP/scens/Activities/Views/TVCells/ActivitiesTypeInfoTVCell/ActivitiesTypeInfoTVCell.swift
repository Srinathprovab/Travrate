//
//  ActivitiesTypeInfoTVCell.swift
//  Travrate
//
//  Created by Admin on 17/07/24.
//

import UIKit

protocol ActivitiesTypeInfoTVCellDelegate {
    func didTapOnBookNowBtnAction(cell:ActivitiesTypeInfoTVCell)
}

class ActivitiesTypeInfoTVCell: UITableViewCell {
    
    
    @IBOutlet weak var activitiesTypeNamelbl: UILabel!
    @IBOutlet weak var kedlbl: UILabel!
    @IBOutlet weak var booknowbtn: UIButton!
    @IBOutlet weak var img: UIImageView!

    
    var agentpayable = String()
    var rateKeySring = String()
    var delegate:ActivitiesTypeInfoTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        booknowbtn.layer.cornerRadius = 4
        img.layer.cornerRadius = 6
        booknowbtn.addTarget(self, action: #selector(didTapOnBookNowBtnAction(_:)), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @objc func didTapOnBookNowBtnAction(_ sender:UIButton) {
        delegate?.didTapOnBookNowBtnAction(cell: self)
    }
    
}
