//
//  NewBookingConfirmedTVCell.swift
//  Travgate
//
//  Created by FCI on 01/03/24.
//

import UIKit


protocol NewBookingConfirmedTVCellDelegate: AnyObject {
    func didTapOnBackBtnAction(cell:NewBookingConfirmedTVCell)
}

class NewBookingConfirmedTVCell: TableViewCell {

    
    
    @IBOutlet weak var bookingIdlbl: UILabel!
    @IBOutlet weak var referencelbl: UILabel!
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var referencelbltitlelbl: UILabel!
    @IBOutlet weak var bgimage: UIImageView!
    
    
    weak var delegate:NewBookingConfirmedTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        bookingIdlbl.text = cellInfo?.title ?? ""
        referencelbl.text = cellInfo?.subTitle ?? ""
        datelbl.text = cellInfo?.buttonTitle ?? ""
        
        
       
        if cellInfo?.key == "flight" {
            bgimage.image = UIImage(named: "bookingconfbg")
        }
        
        if cellInfo?.key == "sports" {
            referencelbltitlelbl.text = "Booking Reference:"
        }
        
        
    }
    
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        delegate?.didTapOnBackBtnAction(cell: self)
    }
    
}
