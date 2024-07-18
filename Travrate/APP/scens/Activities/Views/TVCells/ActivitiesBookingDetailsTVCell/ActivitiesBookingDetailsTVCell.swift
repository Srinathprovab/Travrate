//
//  ActivitiesBookingDetailsTVCell.swift
//  Travrate
//
//  Created by Admin on 18/07/24.
//

import UIKit

class ActivitiesBookingDetailsTVCell: TableViewCell {
    
    @IBOutlet weak var activityimg: UIImageView!
    @IBOutlet weak var activityNamelbl: UILabel!
    @IBOutlet weak var activityloclbl: UILabel!
    @IBOutlet weak var namebtn: UIButton!
    
    
    var bookingsource = String()
    var activitycode = String()
    var activitylist :Activity?
    var delegate:ActivitiesResultTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupui()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setupui() {
        activityimg.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        activityimg.layer.cornerRadius = 12
        namebtn.layer.cornerRadius = 15
        namebtn.layer.borderWidth = 1
        namebtn.layer.borderColor = UIColor.BorderColor.cgColor
    }
    
    
    override func updateUI() {
        
        activitylist = cellInfo?.moreData as? Activity
        activitycode = activitylist?.code ?? ""
        
        activityNamelbl.text = "Arabian Desert Dunes Safari with Camel Ride and Dinner"
        activityloclbl.text = "P.O Box 30531, Al Jaddaf-1 Bur Dubai (Near Al Jadaf Metro Station - Dubai)"
        
        
        
//        activityimg.sd_setImage(with: URL(string: activitylist?.image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"), options: [.retryFailed], completed: { (image, error, cacheType, imageURL) in
//            if let error = error {
//                // Handle error loading image
//                print("Error loading image: \(error.localizedDescription)")
//                // Check if the error is due to a 404 Not Found response
//                if (error as NSError).code == NSURLErrorBadServerResponse {
//                    // Set placeholder image for 404 error
//                    self.activityimg.image = UIImage(named: "noimage")
//                } else {
//                    // Set placeholder image for other errors
//                    self.activityimg.image = UIImage(named: "noimage")
//                }
//            }
//        })
    }
    
    
}
