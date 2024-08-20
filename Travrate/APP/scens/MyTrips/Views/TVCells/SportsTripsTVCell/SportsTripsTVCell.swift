//
//  SportsTripsTVCell.swift
//  Travrate
//
//  Created by Admin on 21/07/24. ActivitiesTripsTVCell  CarRentalTripsTVCell SportsTripsTVCell
//

import UIKit


protocol SportsTripsTVCellDelegate :AnyObject{
    func didTapOnVoucherBtnAction(cell:SportsTripsTVCell)
}

class SportsTripsTVCell: TableViewCell {
    
    @IBOutlet weak var sportimg2: UIImageView!
    @IBOutlet weak var sportimg1: UIImageView!
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    @IBOutlet weak var sportcitylbl: UILabel!
    @IBOutlet weak var viewTicketBtn: UIButton!
    @IBOutlet weak var kwdlbl: UILabel!
    
    
    weak var delegate:SportsTripsTVCellDelegate?
    var voutureUrl = String()
    var participantsA = [Participants]()
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
        viewTicketBtn.layer.cornerRadius = 4
    }
    
    
    override func updateUI() {
        
        participantsA = cellInfo?.moreData as? [Participants] ?? []
        voutureUrl = cellInfo?.key ?? ""
        titlelbl.text = cellInfo?.title ?? ""
        subtitlelbl.text = cellInfo?.subTitle ?? ""
        sportcitylbl.text = cellInfo?.headerText ?? ""
        datelbl.text = cellInfo?.tempText ?? ""
        
        MySingleton.shared.setAttributedTextnew(str1: "\(cellInfo?.currency ?? ""): ",
                                                str2: cellInfo?.price ?? "",
                                                lbl: kwdlbl,
                                                str1font: .InterBold(size: 12),
                                                str2font: .InterBold(size: 20),
                                                str1Color: .BackBtnColor,
                                                str2Color: .BackBtnColor)
        
        
        
        
        
        
        
        if participantsA.isEmpty == false {
            
            self.sportimg1.sd_setImage(with: URL(string: participantsA[0].participants_img ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"), options: [.retryFailed], completed: { (image, error, cacheType, imageURL) in
                if let error = error {
                    // Handle error loading image
                   // print("Error loading image: \(error.localizedDescription)")
                    // Check if the error is due to a 404 Not Found response
                    if (error as NSError).code == NSURLErrorBadServerResponse {
                        // Set placeholder image for 404 error
                        self.sportimg1.isHidden = true
                    } else {
                        // Set placeholder image for other errors
                        self.sportimg1.isHidden = true
                    }
                }else {
                    self.sportimg1.isHidden = false
                }
            })
            
            
            
            self.sportimg2.sd_setImage(with: URL(string: participantsA[1].participants_img ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"), options: [.retryFailed], completed: { (image, error, cacheType, imageURL) in
                if let error = error {
                    // Handle error loading image
                 //   print("Error loading image: \(error.localizedDescription)")
                    // Check if the error is due to a 404 Not Found response
                    if (error as NSError).code == NSURLErrorBadServerResponse {
                        // Set placeholder image for 404 error
                        self.sportimg2.isHidden = true
                    } else {
                        // Set placeholder image for other errors
                        self.sportimg2.isHidden = true
                    }
                }else {
                    self.sportimg2.isHidden = false
                }
            })
            
            
        }
    }
    
    
    
    
    @IBAction func didTapOnVoucherBtnAction(_ sender: Any) {
        delegate?.didTapOnVoucherBtnAction(cell: self)
    }
    
    
    
}
