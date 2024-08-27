//
//  SportsBookNowTVCell.swift
//  Travrate
//
//  Created by FCI on 22/05/24.
//

import UIKit
import EasyTipView

protocol SportsBookNowTVCellDelegate: AnyObject {
    func didTapOnBookNowBtnAction(cell:SportsBookNowTVCell)
    func didTapOnConfBtnAction(cell:SportsBookNowTVCell)
}

class SportsBookNowTVCell: TableViewCell {
    
    
    @IBOutlet weak var sportnamelbl: UILabel!
    @IBOutlet weak var noofticketslbl: UILabel!
    @IBOutlet weak var bookNowbtn: UIButton!
    @IBOutlet weak var kwdlbk: UILabel!
    @IBOutlet weak var servicefeelbl: UILabel!
    @IBOutlet weak var flashlbl: UILabel!
    @IBOutlet weak var noofTickets: UILabel!
    
    
    var sportsTotalPersonCount = 0
    var easyTipView : EasyTipView!
    let tipViewString =  "Orders are processed manually and subjected to supplier approval. the tickets are delivered 24-72 hours prior to the event"
    var searchid = String()
    var token = String()
    var ticketValue = String()
    weak var delegate:SportsBookNowTVCellDelegate?
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
        bookNowbtn.layer.cornerRadius = 4
        
      
        MySingleton.shared.setAttributedTextnew(str1: "important Notes",
                                                str2: "",
                                                lbl: flashlbl,
                                                str1font: .OpenSansRegular(size: 13),
                                                str2font: .OpenSansMedium(size: 13),
                                                str1Color: HexColor("#707070"),
                                                str2Color: .BooknowBtnColor)
        
        flashlbl.numberOfLines = 0
        
        
        setupflashGesture()
    }
    
    
    
    
    override func updateUI() {
        MySingleton.shared.setAttributedTextnew(str1: "\(cellInfo?.currency ?? ""):", str2: "\(cellInfo?.price ?? "")", lbl: kwdlbk, str1font: .InterBold(size: 12), str2font: .InterBold(size: 20), str1Color: .BackBtnColor, str2Color: .BackBtnColor)
        
        sportnamelbl.text = cellInfo?.title ?? ""
        searchid = cellInfo?.searchid ?? ""
        token = cellInfo?.tokenid ?? ""
        ticketValue = cellInfo?.subTitle ?? ""
        servicefeelbl.text = cellInfo?.headerText ?? ""
        
        noofTickets.text = "No.of tickets \(cellInfo?.text ?? "")"
        sportsTotalPersonCount = Int(cellInfo?.text ?? "0") ?? 0
        
        
    }
    
    
    @IBAction func didTapOnBookNowBtnAction(_ sender: Any) {
        delegate?.didTapOnBookNowBtnAction(cell: self)
    }
    
    
    
}


extension SportsBookNowTVCell {
    
    func setupflashGesture() {
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tappedOnLabel(_:)))
        flashlbl.isUserInteractionEnabled = true
        flashlbl.addGestureRecognizer(tapGesture)
    }
    
    @objc func tappedOnLabel(_ gesture: UITapGestureRecognizer) {
        if gesture.didTapAttributedString("important Notes", in: flashlbl) {
            var preferences = EasyTipView.Preferences()
            preferences.drawing.backgroundColor = .black.withAlphaComponent(0.7)
            preferences.drawing.foregroundColor = .white
            preferences.drawing.arrowPosition = .top
            self.easyTipView = EasyTipView(text: tipViewString, preferences: preferences)
            self.easyTipView.show(forView: flashlbl, withinSuperview: self.contentView)
            
            self.flashlbl.isUserInteractionEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 8) { [unowned self] in
                self.easyTipView.dismiss()
                self.easyTipView = nil
                self.flashlbl.isUserInteractionEnabled = true
            }
            
            
        }
    }
    
    
    
}
