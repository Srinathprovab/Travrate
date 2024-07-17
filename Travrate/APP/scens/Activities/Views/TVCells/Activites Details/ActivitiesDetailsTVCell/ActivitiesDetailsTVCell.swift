//
//  ActivitiesDetailsTVCell.swift
//  Travrate
//
//  Created by Admin on 17/07/24.
//

import UIKit

protocol ActivitiesDetailsTVCellDelegate {
    func didTapOnActivitiesBtnsAction(cell:ActivitiesDetailsTVCell)
}

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
    
    
    var delegate:ActivitiesDetailsTVCellDelegate?
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
        ativitieBtnTap()
    }
    
    
    func setupUI() {
        activitiesBtn.addTarget(self, action: #selector(didTapONActivitiesBtnAction(_:)), for: .touchUpInside)
        highlightsBtn.addTarget(self, action: #selector(didTapOnHighlightsBtnAction(_:)), for: .touchUpInside)
        detailsBtn.addTarget(self, action: #selector(didTapOnDetailsBtnAction(_:)), for: .touchUpInside)
        setupTV()
    }
    
    @objc func didTapONActivitiesBtnAction(_ sender:UIButton) {
        ativitieBtnTap()
        
        delegate?.didTapOnActivitiesBtnsAction(cell: self)
    }
    
    @objc func didTapOnHighlightsBtnAction(_ sender:UIButton) {
        highlightsBtnTap()
        
        delegate?.didTapOnActivitiesBtnsAction(cell: self)
    }
    
    @objc func didTapOnDetailsBtnAction(_ sender:UIButton) {
        detailsBtnTap()
        
        delegate?.didTapOnActivitiesBtnsAction(cell: self)
    }
    
    func ativitieBtnTap() {
        tapkey = "activities"
        activitieslbl.textColor = .Buttoncolor
        highlightslbl.textColor = .SubTitleColor
        detailslbl.textColor = .SubTitleColor
        
        activitiesBtnUL.backgroundColor = .Buttoncolor
        highlightsBtnUL.backgroundColor = .WhiteColor
        detailsBtnUL.backgroundColor = .WhiteColor
        updateHeight()
        
        
    }
    
    
    func highlightsBtnTap() {
        tapkey = "highlights"
        activitieslbl.textColor = .SubTitleColor
        highlightslbl.textColor = .Buttoncolor
        detailslbl.textColor = .SubTitleColor
        
        activitiesBtnUL.backgroundColor = .WhiteColor
        highlightsBtnUL.backgroundColor = .Buttoncolor
        detailsBtnUL.backgroundColor = .WhiteColor
        updateHeight()
        
    }
    
    func detailsBtnTap() {
        tapkey = "details"
        activitieslbl.textColor = .SubTitleColor
        highlightslbl.textColor = .SubTitleColor
        detailslbl.textColor = .Buttoncolor
        
        activitiesBtnUL.backgroundColor = .WhiteColor
        highlightsBtnUL.backgroundColor = .WhiteColor
        detailsBtnUL.backgroundColor = .Buttoncolor
        updateHeight()
        
    }
    
}



extension ActivitiesDetailsTVCell:UITableViewDelegate, UITableViewDataSource {
    
    
    func setupTV() {
        detailsTV.delegate = self
        detailsTV.dataSource = self
        detailsTV.register(UINib(nibName: "ActivitiesTypeTVCell", bundle: nil), forCellReuseIdentifier: "type")
        detailsTV.register(UINib(nibName: "ActivitiesDecreptionTVCell", bundle: nil), forCellReuseIdentifier: "desc")
        detailsTV.register(UINib(nibName: "ActivitiesHighlightsTVCell", bundle: nil), forCellReuseIdentifier: "highlightes")
        detailsTV.isScrollEnabled = false
        detailsTV.separatorStyle = .none
    }
    
    
    
    func updateHeight() {
        
        
        if tapkey == "activities" {
            tvheight.constant = ((10 * 146 ) + 100)
        }else if tapkey == "highlights" {
            tvheight.constant = 500
        }else {
            tvheight.constant = 600
        }
        
        
        
        detailsTV.reloadData()
        self.layoutIfNeeded() // Ensure the layout is updated
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tapkey == "activities" {
            return 1
        }else if tapkey == "highlights" {
            return 1
        }else {
            return 1
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        
        
        
        
        if tapkey == "activities" {
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "type") as? ActivitiesTypeTVCell {
                cell.selectionStyle = .none
                
                cell.updateHeight()
                ccell = cell
            }
            
        }else if tapkey == "highlights" {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "highlightes") as? ActivitiesHighlightsTVCell {
                cell.selectionStyle = .none
                
                
                
                
                MySingleton.shared.setAttributedTextnew(str1: "Duration : ",
                                                        str2: "\(MySingleton.shared.activity_details?.modalities?[0].duration?.value ?? 0) \((MySingleton.shared.activity_details?.modalities?[0].duration?.metric ?? ""))",
                                                        lbl: cell.durationlbl,
                                                        str1font: .InterSemiBold(size: 16),
                                                        str2font: .InterRegular(size: 16),
                                                        str1Color: .TitleColor,
                                                        str2Color: .subtitleNewcolor)
                
                
                MySingleton.shared.setAttributedTextnew(str1: "Language : ",
                                                        str2: "English",
                                                        lbl: cell.langlbl,
                                                        str1font: .InterSemiBold(size: 16),
                                                        str2font: .InterRegular(size: 16),
                                                        str1Color: .TitleColor,
                                                        str2Color: .subtitleNewcolor)
                
                //   MySingleton.shared.activity_details?.cit
                
                
                MySingleton.shared.setAttributedTextnew(str1: " Type : ",
                                                        str2: "\(MySingleton.shared.activity_details?.type ?? "")",
                                                        lbl: cell.typelbl,
                                                        str1font: .InterSemiBold(size: 16),
                                                        str2font: .InterRegular(size: 16),
                                                        str1Color: .TitleColor,
                                                        str2Color: .subtitleNewcolor)
                
                
                MySingleton.shared.setAttributedTextnew(str1: " Other Activities:",
                                                        str2: "",
                                                        lbl: cell.otherlbl,
                                                        str1font: .InterSemiBold(size: 16),
                                                        str2font: .InterRegular(size: 16),
                                                        str1Color: .TitleColor,
                                                        str2Color: .subtitleNewcolor)
                
                
                
                MySingleton.shared.setAttributedTextnew(str1: "Features : ",
                                                        str2: "\(MySingleton.shared.activity_details?.feature ?? "")",
                                                        lbl: cell.featureslbl,
                                                        str1font: .InterSemiBold(size: 16),
                                                        str2font: .InterRegular(size: 16),
                                                        str1Color: .TitleColor,
                                                        str2Color: .subtitleNewcolor)
                
                
                
                
                
                
                ccell = cell
            }
        }else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "desc") as? ActivitiesDecreptionTVCell {
                cell.selectionStyle = .none
                cell.activitiestitlelbl.text = MySingleton.shared.activity_details?.content?.description?.htmlToString1
                ccell = cell
            }
        }
        
        return ccell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
