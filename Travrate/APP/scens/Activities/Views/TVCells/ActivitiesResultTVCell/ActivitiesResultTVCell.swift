//
//  ActivitiesResultTVCell.swift
//  Travrate
//
//  Created by Admin on 17/07/24.
//

import UIKit


protocol ActivitiesResultTVCellDelegate {
    func didTapOnActivitesDetailsBtnAction(cell:ActivitiesResultTVCell)
}

class ActivitiesResultTVCell: TableViewCell {
    
    @IBOutlet weak var activityimg: UIImageView!
    @IBOutlet weak var activityNamelbl: UILabel!
    @IBOutlet weak var activityloclbl: UILabel!
    @IBOutlet weak var kwdlbl: UILabel!
    @IBOutlet weak var detailsBtn: UIButton!
    @IBOutlet weak var namebtn: UIButton!
    

    var resultToken = String()
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
        detailsBtn.layer.cornerRadius = 4
        namebtn.layer.cornerRadius = 15
        namebtn.layer.borderWidth = 1
        namebtn.layer.borderColor = UIColor.BorderColor.cgColor
        
        detailsBtn.addTarget(self, action: #selector(didTapOnActivitesDetailsBtnAction(_:)), for: .touchUpInside)
    }
    
    
    override func updateUI() {
        
        resultToken = cellInfo?.title ?? ""
        activitylist = cellInfo?.moreData as? Activity
        activitycode = activitylist?.code ?? ""
        
        activityNamelbl.text = activitylist?.name ?? ""
        activityloclbl.text = "P.O Box 30531, Al Jaddaf-1 Bur Dubai (Near Al Jadaf Metro Station - Dubai)"
        MySingleton.shared.setAttributedTextnew(str1: "\(MySingleton.shared.activites_currency) ",
                                                str2: activitylist?.amountStarts ?? "",
                                                lbl: kwdlbl,
                                                str1font: .InterSemiBold(size: 12),
                                                str2font: .InterSemiBold(size: 22),
                                                str1Color: .TitleColor,
                                                str2Color: .TitleColor)
        
        
        
        activityimg.sd_setImage(with: URL(string: activitylist?.image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"), options: [.retryFailed], completed: { (image, error, cacheType, imageURL) in
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
    
    
    
    @objc func didTapOnActivitesDetailsBtnAction(_ sender:UIButton) {
        delegate?.didTapOnActivitesDetailsBtnAction(cell: self)
    }
    
    
    
}
