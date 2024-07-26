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
    @IBOutlet weak var namelbl: UILabel!
    @IBOutlet weak var passengerslbl: UILabel!
    @IBOutlet weak var cancellationPolicylbl: UILabel!
    @IBOutlet weak var durationTypelbl: UILabel!
    @IBOutlet weak var calimg: UIImageView!
    
    var bookingsource = String()
    var activitycode = String()
    var activitylist :Activity?


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
       
    }
    
    
    override func updateUI() {
        
        durationTypelbl.text = MySingleton.shared.activity_duration_type
        namelbl.text = MySingleton.shared.activity_name_type
        
        
        if durationTypelbl.text == "" {
            durationTypelbl.isHidden = true
            calimg.isHidden = true
        }
        
        activitylist = cellInfo?.moreData as? Activity
        activitycode = activitylist?.code ?? ""
        
        activityNamelbl.text = MySingleton.shared.activity_name
        activityloclbl.text =  MySingleton.shared.activity_loc
        
        
        passengerslbl.text = (Int(totalPax) ?? 1) > 1 ? "\(totalPax) Passenger(s)":"\(totalPax) Passenger"
        cancellationPolicylbl.text = MySingleton.shared.activity_cancellation_string
        
        
        activityimg.sd_setImage(with: URL(string: MySingleton.shared.activity_image), placeholderImage:UIImage(contentsOfFile:"placeholder.png"), options: [.retryFailed], completed: { (image, error, cacheType, imageURL) in
            if let error = error {
                // Handle error loading image
                print("Error loading image: \(error.localizedDescription)")
                // Check if the error is due to a 404 Not Found response
                if (error as NSError).code == NSURLErrorBadServerResponse {
                    // Set placeholder image for 404 error
                    self.activityimg.image = UIImage(named: "noimage")
                } else {
                    // Set placeholder image for other errors
                    self.activityimg.image = UIImage(named: "noimage")
                }
            }
        })
    }
    
    
    
    
}
