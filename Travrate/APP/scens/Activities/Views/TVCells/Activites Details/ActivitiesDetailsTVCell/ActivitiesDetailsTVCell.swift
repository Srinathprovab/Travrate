//
//  ActivitiesDetailsTVCell.swift
//  Travrate
//
//  Created by Admin on 17/07/24.
//

import UIKit

protocol ActivitiesDetailsTVCellDelegate:AnyObject {
    func didTapOnActivitiesBtnsAction(cell:ActivitiesDetailsTVCell)
    func didTapOnBookNowBtnAction(cell:ActivitiesTypeInfoTVCell)
}

class ActivitiesDetailsTVCell: TableViewCell, ActivitiesTypeTVCellDelegate {
    
    
    @IBOutlet weak var activitieslbl: UILabel!
    @IBOutlet weak var highlightslbl: UILabel!
    @IBOutlet weak var detailslbl: UILabel!
    @IBOutlet weak var activitiesBtnUL: UIView!
    @IBOutlet weak var highlightsBtnUL: UIView!
    @IBOutlet weak var detailsBtnUL: UIView!
    @IBOutlet weak var activitiesBtn: UIButton!
    @IBOutlet weak var highlightsBtn: UIButton!
    @IBOutlet weak var detailsBtn: UIButton!
    
    
    weak var delegate:ActivitiesDetailsTVCellDelegate?
    var tapkey = String()
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
        
    }
    
    
    func setupUI() {
        
        if activitiestap == "activities" {
            ativitieBtnTap()
        }else  if activitiestap == "highlights" {
            highlightsBtnTap()
        }else {
            detailsBtnTap()
        }
        
        activitiesBtn.titleLabel?.font = .InterBold(size: 16)
        highlightsBtn.titleLabel?.font = .InterBold(size: 16)
        detailsBtn.titleLabel?.font = .InterBold(size: 16)
        
        
        activitiesBtn.addTarget(self, action: #selector(didTapONActivitiesBtnAction(_:)), for: .touchUpInside)
        highlightsBtn.addTarget(self, action: #selector(didTapOnHighlightsBtnAction(_:)), for: .touchUpInside)
        detailsBtn.addTarget(self, action: #selector(didTapOnDetailsBtnAction(_:)), for: .touchUpInside)
        
    }
    

    @objc func didTapONActivitiesBtnAction(_ sender:UIButton) {
        ativitieBtnTap()
    }
    
    @objc func didTapOnHighlightsBtnAction(_ sender:UIButton) {
        highlightsBtnTap()
    }
    
    @objc func didTapOnDetailsBtnAction(_ sender:UIButton) {
        detailsBtnTap()
    }
    
    func ativitieBtnTap() {
        tapkey = "activities"
        activitiestap = "activities"
        activitieslbl.textColor = .Buttoncolor
        highlightslbl.textColor = .SubTitleColor
        detailslbl.textColor = .SubTitleColor
        
        activitiesBtnUL.backgroundColor = .Buttoncolor
        highlightsBtnUL.backgroundColor = .WhiteColor
        detailsBtnUL.backgroundColor = .WhiteColor
        
        delegate?.didTapOnActivitiesBtnsAction(cell: self)
    }
    
    
    func highlightsBtnTap() {
        tapkey = "highlights"
        activitiestap = "highlights"
        activitieslbl.textColor = .SubTitleColor
        highlightslbl.textColor = .Buttoncolor
        detailslbl.textColor = .SubTitleColor
        
        activitiesBtnUL.backgroundColor = .WhiteColor
        highlightsBtnUL.backgroundColor = .Buttoncolor
        detailsBtnUL.backgroundColor = .WhiteColor
        
        delegate?.didTapOnActivitiesBtnsAction(cell: self)
    }
    
    func detailsBtnTap() {
        tapkey = "details"
        activitiestap = "details"
        activitieslbl.textColor = .SubTitleColor
        highlightslbl.textColor = .SubTitleColor
        detailslbl.textColor = .Buttoncolor
        
        activitiesBtnUL.backgroundColor = .WhiteColor
        highlightsBtnUL.backgroundColor = .WhiteColor
        detailsBtnUL.backgroundColor = .Buttoncolor
        
        delegate?.didTapOnActivitiesBtnsAction(cell: self)
    }
    
    
    //MARK: - didTapOnBookNowBtnAction  ActivitiesTypeInfoTVCell
    func didTapOnBookNowBtnAction(cell: ActivitiesTypeInfoTVCell) {
        delegate?.didTapOnBookNowBtnAction(cell: cell)
    }
    
    
}



