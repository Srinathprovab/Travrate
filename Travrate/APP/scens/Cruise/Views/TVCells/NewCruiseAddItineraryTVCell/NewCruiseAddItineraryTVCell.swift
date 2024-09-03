//
//  NewCruiseAddItineraryTVself.swift
//  Travrate
//
//  Created by Admin on 03/09/24.
//

import UIKit

class NewCruiseAddItineraryTVCell: TableViewCell {
    
    
    @IBOutlet weak var daylbl: UILabel!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var subtitleHolderView: UIView!
    @IBOutlet weak var dropdownimg: UIImageView!
    
    
    
    var itanery:Itinerary?
    var showbool = false
    //  weak var delegate:CruiseAddItineraryTVselfDelegate?
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
        itanery = cellInfo?.moreData as? Itinerary
        
        var index = Int(cellInfo?.text ?? "0") ?? 0
        
        self.daylbl.text = "Day \((index) + 1)"
        self.titlelbl.text = itanery?.title ?? ""
        self.subtitlelbl.text = itanery?.desc ?? ""
        
        self.img.sd_setImage(with: URL(string: itanery?.image ?? ""),
                             placeholderImage: UIImage(named: "placeholder.png"), options: [.retryFailed], completed: { (image, error, cacheType, imageURL) in
            if let error = error {
                print("Error loading banner image: \(error.localizedDescription)")
                if (error as NSError).code == NSURLErrorBadServerResponse {
                    self.img.image = UIImage(named: "noimage")
                } else {
                    self.img.image = UIImage(named: "noimage")
                }
            }
        })
    }
    
    
    func setupUI() {
        img.layer.cornerRadius = 6
    }
    
    @IBAction func didTapOnTitleDropDownBtnAction(_ sender: Any) {
        showbool.toggle()
        if showbool {
            
            dropdownimg.image = UIImage(named: "dropup")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppLabelColor)
            subtitleHolderView.isHidden = false
        }else {
            dropdownimg.image = UIImage(named: "downarrow")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppLabelColor)
            subtitleHolderView.isHidden = true
        }
        
        //  delegate?.didTapOnTitleDropDownBtnAction(self: self)
        
    }
    
    
}
