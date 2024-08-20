//
//  ActivitiesTripsTVCell.swift
//  Travrate
//
//  Created by Admin on 21/07/24.
//

import UIKit

protocol ActivitiesTripsTVCellDelegate {
    func didTapOnActivitesDetailsBtnAction(cell:ActivitiesTripsTVCell)
}

class ActivitiesTripsTVCell: TableViewCell {
    
    
    @IBOutlet weak var activitylocimg: UIImageView!
    @IBOutlet weak var activityimg: UIImageView!
    @IBOutlet weak var activityNamelbl: UILabel!
    @IBOutlet weak var activityloclbl: UILabel!
    @IBOutlet weak var kwdlbl: UILabel!
    @IBOutlet weak var detailsBtn: UIButton!
    @IBOutlet weak var nametyprlbl: UILabel!
    @IBOutlet weak var durationTypelbl: UILabel!
    @IBOutlet weak var calimg: UIImageView!

    
    
    var activitiesVoucherUrl = String()
    var details: Activities_Completed_booking?
    var delegate:ActivitiesTripsTVCellDelegate?
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
        
       // activitylocimg.image = UIImage(named: "loc11")?.withRenderingMode(.alwaysOriginal).withTintColor(HexColor("#3C627A"))
        activityimg.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        activityimg.layer.cornerRadius = 12
        detailsBtn.layer.cornerRadius = 4
        
        setuplabels(lbl: activityNamelbl, text: "", textcolor: .TitleColor, font: .InterMedium(size: 16), align: .left)
        setuplabels(lbl: activityloclbl, text: "", textcolor: HexColor("#01A7EE"), font: .InterMedium(size: 13), align: .left)
        setuplabels(lbl: nametyprlbl, text: "", textcolor: .TitleColor, font: .InterMedium(size: 12), align: .center)
        setuplabels(lbl: durationTypelbl, text: "", textcolor: .TitleColor, font: .InterMedium(size: 12), align: .center)
        
        detailsBtn.titleLabel?.font = .InterBold(size: 14)
        detailsBtn.addTarget(self, action: #selector(didTapOnActivitesDetailsBtnAction(_:)), for: .touchUpInside)
        
    }
    
    
    override func updateUI() {
        details = cellInfo?.moreData as? Activities_Completed_booking
        
        activityNamelbl.text = details?.itinerary_details?[0].activity_name
        activityloclbl.text = details?.itinerary_details?[0].country ?? "Address Not Avaliable"
        
        self.activityimg.sd_setImage(with: URL(string: details?.itinerary_details?[0].image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"), options: [.retryFailed], completed: { (image, error, cacheType, imageURL) in
            if let error = error {
                // Handle error loading image
               // print("Error loading image: \(error.localizedDescription)")
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
        
        activitiesVoucherUrl = details?.voucher_url ?? ""
        
        
    }
    
    
    
    @objc func didTapOnActivitesDetailsBtnAction(_ sender:UIButton) {
        delegate?.didTapOnActivitesDetailsBtnAction(cell: self)
    }
    
    
    
}
