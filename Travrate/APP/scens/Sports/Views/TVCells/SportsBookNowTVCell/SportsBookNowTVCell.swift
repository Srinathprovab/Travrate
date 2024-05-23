//
//  SportsBookNowTVCell.swift
//  Travrate
//
//  Created by FCI on 22/05/24.
//

import UIKit

protocol SportsBookNowTVCellDelegate {
    func didTapOnBookNowBtnAction(cell:SportsBookNowTVCell)
    func didTapOnConfBtnAction(cell:SportsBookNowTVCell)
}

class SportsBookNowTVCell: TableViewCell {

    
    @IBOutlet weak var sportnamelbl: UILabel!
    @IBOutlet weak var noofticketslbl: UILabel!
    @IBOutlet weak var confBtn: UIButton!
    @IBOutlet weak var bookNowbtn: UIButton!
    @IBOutlet weak var kwdlbk: UILabel!
    @IBOutlet weak var servicefeelbl: UILabel!
    
    
    
    var delegate:SportsBookNowTVCellDelegate?
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
        confBtn.layer.cornerRadius = 4
        bookNowbtn.layer.cornerRadius = 4
    }
    
    override func updateUI() {
        MySingleton.shared.setAttributedTextnew(str1: "kwd:", str2: "250.00", lbl: kwdlbk, str1font: .OpenSansRegular(size: 12), str2font: .OpenSansBold(size: 16), str1Color: .TitleColor, str2Color: .TitleColor)
    }
    
    
    @IBAction func didTapOnBookNowBtnAction(_ sender: Any) {
        delegate?.didTapOnBookNowBtnAction(cell: self)
    }
    
    
    
    @IBAction func didTapOnConfBtnAction(_ sender: Any) {
        delegate?.didTapOnConfBtnAction(cell: self)
    }
    
    
}
