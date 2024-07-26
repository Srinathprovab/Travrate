//
//  SelectedServiceTVCell.swift
//  Travrate
//
//  Created by FCI on 17/06/24.
//

import UIKit

protocol SelectedServiceTVCellDelegate:AnyObject {
    func didTapOnSelectServiceBtnAction(cell:SelectedServiceTVCell)
}

class SelectedServiceTVCell: TableViewCell {
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var dropdownimg: UIImageView!
    
    
    weak var delegate:SelectedServiceTVCellDelegate?
    var selectbool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    @IBAction func didTapOnSelectServiceBtnAction(_ sender: Any) {
        selectbool.toggle()
        if selectbool {
            bottomView.isHidden = false
            dropdownimg.image = UIImage(named: "dropup")?.withRenderingMode(.alwaysOriginal).withTintColor(.black)
        }else {
            bottomView.isHidden = true
            dropdownimg.image = UIImage(named: "downarrow")
        }
        
        
        delegate?.didTapOnSelectServiceBtnAction(cell: self)
    }
    
    
}
