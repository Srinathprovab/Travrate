//
//  HotelTripsTVCell.swift
//  Travrate
//
//  Created by Admin on 21/07/24.
//

import UIKit
import AARatingBar

protocol HotelTripsTVCellDelegate:AnyObject {
    func didTapOnViewHotelVoucher(cell:HotelTripsTVCell)
}

class HotelTripsTVCell: TableViewCell {
    
    @IBOutlet weak var hotelVoucherBtn: UIButton!
    @IBOutlet weak var roomCountLabel: UILabel!
    @IBOutlet weak var hotelnamelbl: UILabel!
    @IBOutlet weak var hotellocationlbl: UILabel!
    @IBOutlet weak var hotelimage: UIImageView!
    @IBOutlet weak var chickinlbl: UILabel!
    @IBOutlet weak var checkoutlbl: UILabel!
    @IBOutlet weak var guestlbl: UILabel!
    @IBOutlet weak var ratingView: AARatingBar!
    @IBOutlet weak var viewVoucherBtn: UIButton!
    @IBOutlet weak var roomtypelbl: UILabel!
    @IBOutlet weak var holderView: UIStackView!
    @IBOutlet weak var bottomView: UIView!
    
    weak var delegate:HotelTripsTVCellDelegate?
    var voucherPdfUrl = String()
    var hoteldetils: Hotel_Completed_booking?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        hotelVoucherBtn.layer.cornerRadius = 4
        holderView.layer.cornerRadius = 8
        holderView.layer.borderWidth = 1
        holderView.layer.borderColor = UIColor.BorderColor.cgColor
        
        bottomView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        bottomView.layer.cornerRadius = 8
        
        viewVoucherBtn.addTarget(self, action: #selector(didTapOnViewHotelVoucher(_:)), for: .touchUpInside)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        hoteldetils = cellInfo?.moreData as? Hotel_Completed_booking
        ratingView.isUserInteractionEnabled = false
        
        
        hotelnamelbl.text = hoteldetils?.hotel_name
        hotellocationlbl.text = hoteldetils?.hotel_location
        
        
        
        hotelimage.sd_setImage(with: URL(string: hoteldetils?.hotel_image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"), options: [.retryFailed], completed: { (image, error, cacheType, imageURL) in
            if let error = error {
                // Handle error loading image
               // print("Error loading image: \(error.localizedDescription)")
                // Check if the error is due to a 404 Not Found response
                if (error as NSError).code == NSURLErrorBadServerResponse {
                    // Set placeholder image for 404 error
                    self.hotelimage.image = UIImage(named: "noimage")
                } else {
                    // Set placeholder image for other errors
                    self.hotelimage.image = UIImage(named: "noimage")
                }
            }
        })
        
        
        
        chickinlbl.text = MySingleton.shared.convertDateFormat(inputDate: hoteldetils?.hotel_check_in ?? "", f1: "yyyy-MM-dd", f2: "dd-MM-yy")
        checkoutlbl.text = MySingleton.shared.convertDateFormat(inputDate: hoteldetils?.hotel_check_out ?? "", f1: "yyyy-MM-dd", f2: "dd-MM-yy")
        guestlbl.text = "\(hoteldetils?.customer_details?.count ?? 0)"
        roomCountLabel.text = "\(hoteldetils?.total_rooms ?? 0)"
        voucherPdfUrl = hoteldetils?.voucher_url ?? ""
        if let starRatingString = hoteldetils?.star_rating,
           let starRating = Double(starRatingString) {
            ratingView.value = CGFloat(starRating)
        } else {
            ratingView.value = 0.0
        }

        roomCountLabel.text = "\(hoteldetils?.total_rooms ?? 0)"
        roomtypelbl.text = hoteldetils?.itinerary_details?[0].room_type_name
        
        
    }
    
    
    
    
    @objc func didTapOnViewHotelVoucher(_ sender:UIButton) {
        delegate?.didTapOnViewHotelVoucher(cell: self)
    }
    
    
}
