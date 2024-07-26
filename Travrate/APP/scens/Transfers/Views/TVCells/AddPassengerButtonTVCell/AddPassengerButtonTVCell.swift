//
//  AddPassengerButtonTVCell.swift
//  Travrate
//
//  Created by Admin on 15/07/24.
//

import UIKit

protocol AddPassengerButtonTVCellDelegate: AnyObject {
    func didTapOnAddPassengerBtnAction(cell:AddPassengerButtonTVCell)
}

class AddPassengerButtonTVCell: TableViewCell {
    
    
    @IBOutlet weak var addpassengerBtn: UIButton!

    
   weak var delegate:AddPassengerButtonTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        addpassengerBtn.layer.cornerRadius = 4
        addpassengerBtn.addTarget(self, action: #selector(didTapOnAddPassengerBtnAction(_:)), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    @objc func didTapOnAddPassengerBtnAction(_ sender:UIButton) {
        delegate?.didTapOnAddPassengerBtnAction(cell: self)
    }
    
}
