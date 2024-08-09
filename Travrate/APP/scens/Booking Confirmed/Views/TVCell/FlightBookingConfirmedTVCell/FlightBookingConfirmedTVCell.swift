//
//  FlightBookingConfirmedTVCell.swift
//  Travrate
//
//  Created by Admin on 09/08/24.
//

import UIKit

protocol FlightBookingConfirmedTVCellDelegate: AnyObject {
    func didTapOnBackBtnAction(cell:FlightBookingConfirmedTVCell)
}

class FlightBookingConfirmedTVCell: TableViewCell {
    
    
    
    @IBOutlet weak var appreferencelbl: UILabel!
    @IBOutlet weak var bookingdetelbl: UILabel!
    @IBOutlet weak var gdspnrlbl: UILabel!
    @IBOutlet weak var pnrnolbl: UILabel!
    @IBOutlet weak var referencelbltitlelbl: UILabel!
    @IBOutlet weak var bgimage: UIImageView!
    
    
    var bd = [Booking_details]()
    weak var delegate:FlightBookingConfirmedTVCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        
        bd = cellInfo?.moreData as! [Booking_details]
        
        bgimage.image = UIImage(named: "bookingconfbg")
        appreferencelbl.text = bd[0].app_reference ?? ""
        gdspnrlbl.text = bd[0].app_reference_gds ?? ""
        pnrnolbl.text = bd[0].pnr ?? ""
        bookingdetelbl.text = bd[0].booked_date ?? ""

    }
    
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        delegate?.didTapOnBackBtnAction(cell: self)
    }
    
}
