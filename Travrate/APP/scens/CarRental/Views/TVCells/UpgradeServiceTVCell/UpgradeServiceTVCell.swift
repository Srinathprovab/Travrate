//
//  UpgradeServiceTVCell.swift
//  Travrate
//
//  Created by FCI on 17/06/24.
//

import UIKit

protocol UpgradeServiceTVCellDelegate {
    func didTapOnUpgradeServiceBtnAction(cell:UpgradeServiceTVCell)
}


class UpgradeServiceTVCell: TableViewCell {
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var dropdownimg: UIImageView!
    
    
    var delegate:UpgradeServiceTVCellDelegate?
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
        selectbool.toggle()
        if selectbool {
            bottomView.isHidden = false
            dropdownimg.image = UIImage(named: "dropup")?.withRenderingMode(.alwaysOriginal).withTintColor(.black)
        }else {
            bottomView.isHidden = true
            dropdownimg.image = UIImage(named: "downarrow")
        }
        
        
        delegate?.didTapOnUpgradeServiceBtnAction(cell: self)
    }
    
    
}

