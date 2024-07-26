//
//  SportInfoTVCell.swift
//  Travgate
//
//  Created by FCI on 10/05/24.
//

import UIKit

protocol SportInfoTVCellDelegate: AnyObject {
    func didTapOnViewTicketBtnAction(cell:SportInfoTVCell)
    func didTapOnViewStadiumBtnAction(cell:SportInfoTVCell)
}

class SportInfoTVCell: TableViewCell {
    
    
    @IBOutlet weak var sportimg2: UIImageView!
    @IBOutlet weak var sportimg1: UIImageView!
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    @IBOutlet weak var sportcitylbl: UILabel!
    @IBOutlet weak var viewTicketBtn: UIButton!
    @IBOutlet weak var kwdlbl: UILabel!
    @IBOutlet weak var vslbl: UILabel!
    
    
    var participantsA = [Participants]()
    var searchid = String()
    var token = String()
    weak var delegate:SportInfoTVCellDelegate?
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
        vslbl.isHidden = true
        
        titlelbl.text = cellInfo?.title ?? ""
        subtitlelbl.text = cellInfo?.subTitle ?? ""
        searchid = cellInfo?.searchid ?? ""
        token = cellInfo?.tokenid ?? ""
        sportcitylbl.text = cellInfo?.headerText ?? ""
        datelbl.text = cellInfo?.tempText ?? ""
        
        MySingleton.shared.setAttributedTextnew(str1: "\(cellInfo?.currency ?? ""): ",
                                                str2: cellInfo?.price ?? "",
                                                lbl: kwdlbl,
                                                str1font: .OpenSansRegular(size: 12),
                                                str2font: .OpenSansBold(size: 20),
                                                str1Color: .TitleColor,
                                                str2Color: .TitleColor)
        
        
        
        if cellInfo?.key == "list" {
            participantsA = cellInfo?.moreData as! [Participants]
        }
        
        if cellInfo?.key == "bookingdetails" {
            kwdlbl.isHidden = true
            viewTicketBtn.setTitle("View Stadium", for: .normal)
            
            titlelbl.text = MySingleton.shared.sportEventList?.eventType?.name
            subtitlelbl.text = MySingleton.shared.sportEventList?.name
            sportcitylbl.text = MySingleton.shared.sportEventList?.venue?.name
            datelbl.text = "\(MySingleton.shared.sportEventList?.dateOfEvent ?? "")-\(MySingleton.shared.sportEventList?.timeOfEvent ?? "")"
            
            participantsA = MySingleton.shared.sportEventList?.participants ?? []
        }
        
        
        
        if cellInfo?.key == "bc" {
            kwdlbl.isHidden = true
            viewTicketBtn.setTitle("View Stadium", for: .normal)
            
            titlelbl.text = MySingleton.shared.sportvoucherEventList?.eventType?.name
            subtitlelbl.text = MySingleton.shared.sportvoucherEventList?.name
            sportcitylbl.text = MySingleton.shared.sportvoucherEventList?.venue?.name
            datelbl.text = "\(MySingleton.shared.sportvoucherEventList?.dateOfEvent ?? "")-\(MySingleton.shared.sportvoucherEventList?.timeOfEvent ?? "")"
            
            participantsA = MySingleton.shared.sportvoucherEventList?.participants ?? []
        }
        
        if cellInfo?.key == "sports" {
            kwdlbl.isHidden = false
            viewTicketBtn.setTitle("View Stadium", for: .normal)
            
            titlelbl.text = MySingleton.shared.sportEventList?.eventType?.name
            subtitlelbl.text = MySingleton.shared.sportEventList?.name
            sportcitylbl.text = MySingleton.shared.sportEventList?.venue?.name
            datelbl.text = "\(MySingleton.shared.sportEventList?.dateOfEvent ?? "")-\(MySingleton.shared.sportEventList?.timeOfEvent ?? "")"
            
            participantsA = MySingleton.shared.sportEventList?.participants ?? []
        }
        
        
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
        viewTicketBtn.layer.cornerRadius = 4
    }
    
    
    @IBAction func didTapOnViewTicketBtnAction(_ sender: Any) {
        if (sender as AnyObject).titleLabel.text == "View Stadium" {
            delegate?.didTapOnViewStadiumBtnAction(cell: self)
        }else {
            delegate?.didTapOnViewTicketBtnAction(cell: self)
        }
        
    }
    
}
