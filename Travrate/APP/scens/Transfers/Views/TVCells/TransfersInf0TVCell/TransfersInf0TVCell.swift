//
//  TransfersInf0TVCell.swift
//  Travgate
//
//  Created by FCI on 08/05/24.
//

import UIKit
protocol TransfersInf0TVCellDelegate {
    func didTapOnBookNowBtnAction(cell:TransfersInf0TVCell)
}

class TransfersInf0TVCell: TableViewCell {
    
    
    @IBOutlet weak var carimg: UIImageView!
    @IBOutlet weak var carmodellbl: UILabel!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var kwdlbl: UILabel!
    @IBOutlet weak var passengerslbl: UILabel!
    @IBOutlet weak var freeCancellationTitlelbl: UILabel!
    @IBOutlet weak var booknowlbl: UILabel!
    
    
    
    var token = String()
    var transferlist: Raw_transfer_list?
    var delegate:TransfersInf0TVCellDelegate?
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
        setuplabels(lbl: titlelbl, text: "", textcolor: HexColor("#297B00"), font: .InterMedium(size: 16), align: .center)
        setuplabels(lbl: freeCancellationTitlelbl, text: "", textcolor: HexColor("#44B50C"), font: .InterRegular(size: 14), align: .center)
        setuplabels(lbl: carmodellbl, text: "", textcolor: .TitleColor, font: .InterSemiBold(size: 16), align: .right)
        setuplabels(lbl: passengerslbl, text: "", textcolor: HexColor("#707070"), font: .OpenSansRegular(size: 12), align: .right)
        setuplabels(lbl: booknowlbl, text: "Book Now", textcolor: .WhiteColor, font: .OpenSansMedium(size: 16), align: .center)
    }
    
    
    
    override func updateUI() {
        transferlist = cellInfo?.moreData as? Raw_transfer_list
        token = transferlist?.token ?? ""
        
        passengerslbl.text = "Up to Passengers \(transferlist?.car_detail?.luggage_capacity ?? 0)"
        carmodellbl.text = transferlist?.car_detail?.models?[0]
        titlelbl.text = transferlist?.car_detail?.title ?? ""
        carimg.sd_setImage(with: URL(string: transferlist?.car_detail?.images ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"), options: [.retryFailed], completed: { (image, error, cacheType, imageURL) in
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
        
        
        MySingleton.shared.setAttributedTextnew(str1: transferlist?.currency ?? "",
                                                str2: String(format: "%.2f", transferlist?.price ?? ""),
                                                lbl: kwdlbl,
                                                str1font: .InterSemiBold(size: 12),
                                                str2font: .InterBold(size: 20),
                                                str1Color: .TitleColor,
                                                str2Color: .TitleColor)
        
    }
    
    
    
    @IBAction func didTapOnBookNowBtnAction(_ sender: Any) {
        delegate?.didTapOnBookNowBtnAction(cell: self)
    }
    
}
