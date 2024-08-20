//
//  BDTransfersInf0TVCell.swift
//  Travgate
//
//  Created by FCI on 08/05/24.
//

import UIKit

class BDTransfersInf0TVCell: TableViewCell {

    
    @IBOutlet weak var carimage: UIImageView!
    @IBOutlet weak var carmodellbl: UILabel!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var passangerslbl: UILabel!
    @IBOutlet weak var triplbl: UILabel!
    
    
    var transferdata : Transfer_data?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func updateUI() {
        transferdata = cellInfo?.moreData as? Transfer_data
        carmodellbl.text = transferdata?.car_detail?.models?[0]
        titlelbl.text = transferdata?.car_detail?.title ?? ""
        passangerslbl.text = "Up to Passengers \(transferdata?.car_detail?.luggage_capacity ?? 0)"
        carimage.sd_setImage(with: URL(string: transferdata?.car_detail?.images ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"), options: [.retryFailed], completed: { (image, error, cacheType, imageURL) in
            if let error = error {
                // Handle error loading image
            //    print("Error loading image: \(error.localizedDescription)")
                // Check if the error is due to a 404 Not Found response
                if (error as NSError).code == NSURLErrorBadServerResponse {
                    // Set placeholder image for 404 error
                    self.carimage.image = UIImage(named: "noimage")
                } else {
                    // Set placeholder image for other errors
                    self.carimage.image = UIImage(named: "noimage")
                }
            }
        })
        
        
        triplbl.font = .InterMedium(size: 14)
        triplbl.text = defaults.string(forKey: UserDefaultsKeys.transferjournytype) == "oneway" ? "Oneway" : "Roundtrip"
        
        
    }
    
}
