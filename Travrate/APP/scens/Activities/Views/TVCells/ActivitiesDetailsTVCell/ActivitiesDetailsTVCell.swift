//
//  ActivitiesDetailsTVCell.swift
//  Travrate
//
//  Created by Admin on 17/07/24.
//

import UIKit

class ActivitiesDetailsTVCell: TableViewCell {
    
    
    @IBOutlet weak var activitieslbl: UILabel!
    @IBOutlet weak var highlightslbl: UILabel!
    @IBOutlet weak var detailslbl: UILabel!
    @IBOutlet weak var activitiesBtnUL: UIView!
    @IBOutlet weak var highlightsBtnUL: UIView!
    @IBOutlet weak var detailsBtnUL: UIView!
    @IBOutlet weak var activitiesBtn: UIButton!
    @IBOutlet weak var highlightsBtn: UIButton!
    @IBOutlet weak var detailsBtn: UIButton!
    @IBOutlet weak var detailsTV: UITableView!
    @IBOutlet weak var tvheight: NSLayoutConstraint!
    
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
        ativitieBtnTap()
    }
    
    
    func setupUI() {
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
        activitieslbl.textColor = .Buttoncolor
        highlightslbl.textColor = .SubTitleColor
        detailslbl.textColor = .SubTitleColor
        
        activitiesBtnUL.backgroundColor = .Buttoncolor
        highlightsBtnUL.backgroundColor = .WhiteColor
        detailsBtnUL.backgroundColor = .WhiteColor
    }
    
    
    func highlightsBtnTap() {
        activitieslbl.textColor = .SubTitleColor
        highlightslbl.textColor = .Buttoncolor
        detailslbl.textColor = .SubTitleColor
        
        activitiesBtnUL.backgroundColor = .WhiteColor
        highlightsBtnUL.backgroundColor = .Buttoncolor
        detailsBtnUL.backgroundColor = .WhiteColor
    }
    
    func detailsBtnTap() {
        activitieslbl.textColor = .SubTitleColor
        highlightslbl.textColor = .SubTitleColor
        detailslbl.textColor = .Buttoncolor
        
        activitiesBtnUL.backgroundColor = .WhiteColor
        highlightsBtnUL.backgroundColor = .WhiteColor
        detailsBtnUL.backgroundColor = .Buttoncolor
    }
    
    
}
