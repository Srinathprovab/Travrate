//
//  CarRentalTripsTVCell.swift
//  Travrate
//
//  Created by Admin on 21/07/24.
//

import UIKit


protocol CarRentalTripsTVCellDelagate {
    func didTapOnVoucherBtnAction(cell:CarRentalTripsTVCell)
}

class CarRentalTripsTVCell: TableViewCell {
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var carimg: UIImageView!
    //    @IBOutlet weak var depositeAmountlbl: UILabel!
    //    @IBOutlet weak var markupView: UIStackView!
    //    @IBOutlet weak var viewDetailsBtn: UIButton!
    //    @IBOutlet weak var kwdlbl: UILabel!
    @IBOutlet weak var seatslbl: UILabel!
    @IBOutlet weak var caroption2: UILabel!
    @IBOutlet weak var caroption3: UILabel!
    @IBOutlet weak var caroption4: UILabel!
    @IBOutlet weak var caroption5: UILabel!
    @IBOutlet weak var caroption6: UILabel!
    @IBOutlet weak var caroption7: UILabel!
    //  @IBOutlet weak var markuplbl: UILabel!
    @IBOutlet weak var voucherBtn: UIButton!
    
    
    var voucherString = String()
    var cardetails :Upcoming_booking?
    var delegate:CarRentalTripsTVCellDelagate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setupUI() {
        voucherBtn.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        voucherBtn.layer.cornerRadius = 8
        voucherBtn.addTarget(self, action: #selector(didTapOnVoucherBtnAction(_:)), for: .touchUpInside)
    }
    
    
    override func updateUI() {
        
        
        cardetails = cellInfo?.moreData as? Upcoming_booking
        titlelbl.text = cardetails?.car_name
        voucherString = cardetails?.booking_url ?? ""
        
        self.carimg.sd_setImage(with: URL(string: cardetails?.car_image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"), options: [.retryFailed], completed: { (image, error, cacheType, imageURL) in
            if let error = error {
                // Handle error loading image
               // print("Error loading image: \(error.localizedDescription)")
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
        
        
        
        seatslbl.text = "\(cardetails?.car_data?.adults ?? "") Seats"
        caroption2.text = "\(cardetails?.car_data?.luggageMed ?? "") Medium Bags"
        caroption3.text = cardetails?.car_data?.transmission ?? ""
        caroption4.text = "\(cardetails?.car_data?.luggageLarge ?? "") Large Bags"
        caroption5.text = cardetails?.from_loc ?? ""
        caroption6.text = cardetails?.product?.mileage ?? "Unlimited"
        caroption7.text = "\(cardetails?.car_data?.luggageSmall ?? "") Small Bags"
        
        
        
        
        //        MySingleton.shared.setAttributedTextnew(str1: cardetails?.currency ?? "",
        //                                                str2: cardetails?.total_amount ?? "",
        //                                                lbl: kwdlbl,
        //                                                str1font: .InterBold(size: 12),
        //                                                str2font: .InterBold(size: 16),
        //                                                str1Color: .BackBtnColor,
        //                                                str2Color: .BackBtnColor)
        //
        
        
        
    }
    
    
    
    @objc func didTapOnVoucherBtnAction(_ sender:UIButton) {
        delegate?.didTapOnVoucherBtnAction(cell: self)
    }
    
    
}
