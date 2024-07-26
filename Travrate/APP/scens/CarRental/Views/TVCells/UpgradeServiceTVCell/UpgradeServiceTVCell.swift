//
//  UpgradeServiceTVCell.swift
//  Travrate
//
//  Created by FCI on 17/06/24.
//

import UIKit

protocol UpgradeServiceTVCellDelegate:AnyObject {
    func didTapOnUpgradeServiceBtnAction(cell:UpgradeServiceTVCell)
}


class UpgradeServiceTVCell: TableViewCell {
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var dropdownimg: UIImageView!
    
    
    weak var delegate:UpgradeServiceTVCellDelegate?
    var selectbool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    @IBAction func didTapOnUpgradeServiceBtnAction(_ sender: Any) {
        delegate?.didTapOnUpgradeServiceBtnAction(cell: self)
    }
    
    
}

