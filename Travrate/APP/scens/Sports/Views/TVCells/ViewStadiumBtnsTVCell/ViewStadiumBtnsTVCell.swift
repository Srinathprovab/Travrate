//
//  ViewStadiumBtnsTVCell.swift
//  Travrate
//
//  Created by FCI on 22/05/24.
//

import UIKit


protocol ViewStadiumBtnsTVCellDelegate: AnyObject {
    func didTapOnViewStadiumBtnAction(cell:ViewStadiumBtnsTVCell)
    func didTapOnSeatingArrangementsBtnAction(cell:ViewStadiumBtnsTVCell)
}

class ViewStadiumBtnsTVCell: TableViewCell {
    
    
    weak var delegate:ViewStadiumBtnsTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func didTapOnViewStadiumBtnAction(_ sender: Any) {
        delegate?.didTapOnViewStadiumBtnAction(cell: self)
    }
    
    
    
    @IBAction func didTapOnSeatingArrangementsBtnAction(_ sender: Any) {
        delegate?.didTapOnSeatingArrangementsBtnAction(cell: self)
    }
    
    
}
