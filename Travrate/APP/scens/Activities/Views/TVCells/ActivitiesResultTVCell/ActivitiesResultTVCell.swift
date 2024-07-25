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
    @IBOutlet weak var nametyprlbl: UILabel!
    @IBOutlet weak var durationTypelbl: UILabel!
    @IBOutlet weak var calimg: UIImageView!

    var selecteddurationType = String()
    var selectedNameType = String()
    var selectedImage = String()
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
        
        setuplabels(lbl: activityNamelbl, text: "", textcolor: .TitleColor, font: .InterMedium(size: 16), align: .left)
        setuplabels(lbl: activityloclbl, text: "", textcolor: HexColor("#01A7EE"), font: .InterMedium(size: 13), align: .left)
        setuplabels(lbl: nametyprlbl, text: "", textcolor: .TitleColor, font: .InterMedium(size: 12), align: .center)
        setuplabels(lbl: durationTypelbl, text: "", textcolor: .TitleColor, font: .InterMedium(size: 12), align: .center)
        
        detailsBtn.titleLabel?.font = .InterBold(size: 14)
        detailsBtn.addTarget(self, action: #selector(didTapOnActivitesDetailsBtnAction(_:)), for: .touchUpInside)
        
    }
    
    
    override func updateUI() {
        
        resultToken = cellInfo?.title ?? ""
        activitylist = cellInfo?.moreData as? Activity
        activitycode = activitylist?.code ?? ""
        
        activityNamelbl.text = activitylist?.name ?? ""
        activityloclbl.text = "Address not Available"
        MySingleton.shared.setAttributedTextnew(str1: "\(MySingleton.shared.activites_currency) ",
                                                str2: activitylist?.amountStarts ?? "",
                                                lbl: kwdlbl,
                                                str1font: .InterMedium(size: 12),
                                                str2font: .InterBold(size: 22),
                                                str1Color: .TitleColor,
                                                str2Color: HexColor("#3C627A"))
        
        
        selectedImage = activitylist?.image ?? ""
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
        
        
        MySingleton.shared.activity_name = activitylist?.name ?? ""
        MySingleton.shared.activity_loc = "Address not Available"
        durationTypelbl.text = activitylist?.activityDuration ?? ""
        durationTypelbl.isHidden = activitylist?.activityDuration == "" || activitylist?.activityDuration == nil ? true : false
        calimg.isHidden = activitylist?.activityDuration == "" || activitylist?.activityDuration == nil ? true : false
        nametyprlbl.text = activitylist?.modalities?[0].name ?? ""
        
        selecteddurationType = durationTypelbl.text ?? ""
        selectedNameType = nametyprlbl.text ?? ""
        
    }
    
    
    
    @objc func didTapOnActivitesDetailsBtnAction(_ sender:UIButton) {
        delegate?.didTapOnActivitesDetailsBtnAction(cell: self)
    }
    
    
    
}
