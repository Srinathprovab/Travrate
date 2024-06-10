//
//  CruiseAddItineraryTVCell.swift
//  Travgate
//
//  Created by FCI on 27/02/24.
//

import UIKit

protocol CruiseAddItineraryTVCellDelegate {
    func didTapOnTitleDropDownBtnAction(cell:CruiseAddItineraryTVCell)
}

class CruiseAddItineraryTVCell: UITableViewCell {
    
    
    @IBOutlet weak var daylbl: UILabel!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var subtitleHolderView: UIView!
    @IBOutlet weak var dropdownimg: UIImageView!
    
    
    var showbool = false
    var delegate:CruiseAddItineraryTVCellDelegate?
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
        
        delegate?.didTapOnTitleDropDownBtnAction(cell: self)
        
    }
    
    
}
