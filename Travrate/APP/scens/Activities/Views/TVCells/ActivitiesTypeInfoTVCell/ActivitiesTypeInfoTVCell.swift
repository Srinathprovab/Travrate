//
//  ActivitiesTypeInfoTVCell.swift
//  Travrate
//
//  Created by Admin on 17/07/24.
//

import UIKit
import DropDown

protocol ActivitiesTypeInfoTVCellDelegate:AnyObject {
    func didTapOnBookNowBtnAction(cell:ActivitiesTypeInfoTVCell)
}

class ActivitiesTypeInfoTVCell: TableViewCell {
    
    
    @IBOutlet weak var activitiesTypeNamelbl: UILabel!
    @IBOutlet weak var kedlbl: UILabel!
    @IBOutlet weak var booknowbtn: UIButton!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var chooseDateView: BorderedView!
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var chooseDateBtn: UIButton!
    @IBOutlet weak var chooselbl: UILabel!
    @IBOutlet weak var holderView: BorderedView!
    @IBOutlet weak var errorlbl: UILabel!
    
    
    var details:ActivityDetailsModalities?
    
    let dropDown = DropDown()
    var agentpayable = String()
    var rateKeySring = String()
    weak var delegate:ActivitiesTypeInfoTVCellDelegate?
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
        holderView.layer.cornerRadius = 8
        booknowbtn.layer.cornerRadius = 4
        img.layer.cornerRadius = 6
        booknowbtn.addTarget(self, action: #selector(didTapOnBookNowBtnAction(_:)), for: .touchUpInside)
        chooseDateBtn.addTarget(self, action: #selector(didTapOnChooseDateBtnAction(_:)), for: .touchUpInside)
    }
    
    
    @objc func didTapOnBookNowBtnAction(_ sender:UIButton) {
        delegate?.didTapOnBookNowBtnAction(cell: self)
    }
    
    
    @objc func didTapOnChooseDateBtnAction(_ sender:UIButton) {
        dropDown.show()
    }
    
    
    func setupDropDown() {
        
        let startdate = defaults.string(forKey: UserDefaultsKeys.calActivitesDepDate) ?? ""
        let enddate = defaults.string(forKey: UserDefaultsKeys.calActivitesRetDate) ?? ""
        dropDown.dataSource = ["Choose Date","\(startdate)","\(enddate)"]
        dropDown.direction = .bottom
        dropDown.backgroundColor = .WhiteColor
        dropDown.anchorView = self.chooseDateView
        dropDown.bottomOffset = CGPoint(x: 0, y: chooseDateView.frame.size.height + 10)
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            self?.datelbl.text = item
            
            
            if  self?.datelbl.text == "Choose Date" {
                self?.errorlbl.isHidden = false
                self?.errorlbl.text = "Please select the date"
                self?.chooselbl.isHidden = true
               
            }else {
                self?.errorlbl.isHidden = true
                self?.errorlbl.text = ""
                self?.chooselbl.isHidden = false
                
                
                self?.chooselbl.text = "Cancellation from \(item) will charge \(self?.agentpayable ?? "")"
                MySingleton.shared.activity_selecteddate = MySingleton.shared.convertDateFormat(inputDate: item, f1: "dd-MM-yyyy", f2: "yyyy-MM-dd")
                MySingleton.shared.activity_cancellation_string = self?.chooselbl.text ?? ""
            }
            
            
        }
    }
    
    
    
    override func updateUI() {
        
       
        
        let data = cellInfo?.moreData as? ActivityDetailsModalities
        
        
        self.activitiesTypeNamelbl.text = data?.name
        self.rateKeySring = data?.rates?[0].rateDetails?[0].rateKey ?? ""
        self.agentpayable = String(format: "%.2f",  data?.amountsFrom?[0].amount?.default_value ?? 0.0)
        self.setupDropDown()
       
        
        MySingleton.shared.setAttributedTextnew(str1: "\(MySingleton.shared.activites_currency) ",
                                                str2: String(format: "%.2f",  data?.amountsFrom?[0].amount?.default_value ?? 0.0),
                                                lbl: self.kedlbl,
                                                str1font: .InterMedium(size: 12),
                                                str2font: .InterBold(size: 22),
                                                str1Color: .TitleColor,
                                                str2Color: HexColor("#3C627A"))
        
        
        
            
     
        
    }
    
}
