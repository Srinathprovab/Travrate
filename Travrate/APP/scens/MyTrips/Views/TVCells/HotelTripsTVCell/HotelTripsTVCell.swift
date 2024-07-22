//
//  HotelTripsTVCell.swift
//  Travrate
//
//  Created by Admin on 21/07/24.
//

import UIKit
import AARatingBar

class HotelTripsTVCell: TableViewCell {
    
    // @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var hotelVoucherBtn: UIButton!
    //  @IBOutlet weak var bottomView: UIView!
    
    //    @IBOutlet weak var belowDateLabel: UILabel!
    //    @IBOutlet weak var roomCountStackView: UIStackView!
    @IBOutlet weak var roomCountLabel: UILabel!
    @IBOutlet weak var hotelnamelbl: UILabel!
    @IBOutlet weak var hotellocationlbl: UILabel!
    @IBOutlet weak var hotelimage: UIImageView!
    @IBOutlet weak var chickinlbl: UILabel!
    @IBOutlet weak var checkoutlbl: UILabel!
    @IBOutlet weak var guestlbl: UILabel!
    @IBOutlet weak var ratingView: AARatingBar!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        hotelVoucherBtn.layer.cornerRadius = 4
        //        mainStackView.layer.cornerRadius = 8
        //        mainStackView.layer.borderColor = UIColor.lightGray.cgColor
        //        mainStackView.layer.borderWidth = 0.7
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
