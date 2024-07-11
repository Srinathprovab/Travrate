//
//  SelectedCarRentalTVCell.swift
//  Travrate
//
//  Created by FCI on 14/06/24.
//

import UIKit

class SelectedCarRentalTVCell: TableViewCell {
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var carimg: UIImageView!
    @IBOutlet weak var caroption1: UILabel!
    @IBOutlet weak var caroption2: UILabel!
    @IBOutlet weak var caroption3: UILabel!
    @IBOutlet weak var caroption4: UILabel!
    @IBOutlet weak var caroption5: UILabel!
    @IBOutlet weak var caroption6: UILabel!
    @IBOutlet weak var caroption7: UILabel!
    
    
    
    var product_code = String()
    var result_token = String()
    var result_index = String()
    var carlist:Result_token?
    var delegate:CarRentalResultTVCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        
        carlist = cellInfo?.moreData as? Result_token
        
        
        carimg.sd_setImage(with: URL(string: carlist?.car_image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"), options: [.retryFailed], completed: { (image, error, cacheType, imageURL) in
            if let error = error {
                // Handle error loading image
                print("Error loading image: \(error.localizedDescription)")
                // Check if the error is due to a 404 Not Found response
                if (error as NSError).code == NSURLErrorBadServerResponse {
                    // Set placeholder image for 404 error
                    self.carimg.image = UIImage(named: "noimage")
                } else {
                    // Set placeholder image for other errors
                    self.carimg.image = UIImage(named: "noimage")
                }
            }
        })
        
        
        
        titlelbl.text = carlist?.car_name ?? ""
        caroption2.text = "\(carlist?.luggageMed ?? "") Medium Bags"
        caroption3.text = carlist?.transmission ?? ""
        caroption4.text = "\(carlist?.luggageLarge ?? "") Large Bags"
        caroption5.text = carlist?.from_loc ?? ""
        caroption6.text = carlist?.product?[0].mileage ?? ""
        caroption7.text = "\(carlist?.luggageSmall ?? "") Small Bags"
        
    }
    
    
    
}




