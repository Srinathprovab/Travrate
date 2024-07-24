//
//  SelectedSportInfoTVCell.swift
//  Travgate
//
//  Created by FCI on 10/05/24.
//

import UIKit

class SelectedSportInfoTVCell: TableViewCell {
    
    
    @IBOutlet weak var sportimg2: UIImageView!
    @IBOutlet weak var sportimg1: UIImageView!
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    @IBOutlet weak var sportcitylbl: UILabel!
    @IBOutlet weak var tournamentnamelbl: UILabel!
    @IBOutlet weak var vslbl: UILabel!
    
    var participantsA = [Participants]()
    var delegate:SportInfoTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        titlelbl.text = MySingleton.shared.sportListData?.eventType?.name
        subtitlelbl.text = MySingleton.shared.sportListData?.name
        sportcitylbl.text = MySingleton.shared.sportListData?.venue?.name
        datelbl.text = "\(MySingleton.shared.sportListData?.dateOfEvent ?? "")-\(MySingleton.shared.sportListData?.timeOfEvent ?? "")"
        tournamentnamelbl.text = MySingleton.shared.sportListData?.tournament?.name
        
        participantsA = MySingleton.shared.participantsArray
        
        
        if participantsA.isEmpty == false {
            
//            self.sportimg1.isHidden = false
//            self.sportimg2.isHidden = false
//            self.vslbl.isHidden = false
//            
            
            
            self.sportimg1.sd_setImage(with: URL(string: participantsA[0].participants_img ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"), options: [.retryFailed], completed: { (image, error, cacheType, imageURL) in
                if let error = error {
                    // Handle error loading image
                    print("Error loading image: \(error.localizedDescription)")
                    // Check if the error is due to a 404 Not Found response
                    if (error as NSError).code == NSURLErrorBadServerResponse {
                        // Set placeholder image for 404 error
                        self.sportimg1.isHidden = true
                        self.vslbl.isHidden = true
                    } else {
                        // Set placeholder image for other errors
                        self.sportimg1.isHidden = true
                        self.vslbl.isHidden = true
                    }
                }else {
                    self.sportimg1.isHidden = false
                    self.vslbl.isHidden = false
                }
            })
            
            
            
            self.sportimg2.sd_setImage(with: URL(string: participantsA[1].participants_img ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"), options: [.retryFailed], completed: { (image, error, cacheType, imageURL) in
                if let error = error {
                    // Handle error loading image
                    print("Error loading image: \(error.localizedDescription)")
                    // Check if the error is due to a 404 Not Found response
                    if (error as NSError).code == NSURLErrorBadServerResponse {
                        // Set placeholder image for 404 error
                        self.sportimg2.isHidden = true
                        self.vslbl.isHidden = true
                    } else {
                        // Set placeholder image for other errors
                        self.sportimg2.isHidden = true
                        self.vslbl.isHidden = true
                    }
                }else {
                    self.sportimg2.isHidden = false
                    self.vslbl.isHidden = false
                }
            })
            
            
            
            
            
        }
    }
    
    
    func setupUI() {
       
    }
    
    
   
    
}
