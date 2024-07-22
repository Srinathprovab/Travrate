//
//  ContractRemarkTVCell.swift
//  Travrate
//
//  Created by Admin on 22/07/24.
//

import UIKit

protocol ContractRemarkTVCellDelegate {
    func didTapOnDropupBtnAction(cell:ContractRemarkTVCell)
}

class ContractRemarkTVCell: TableViewCell {
    
    @IBOutlet weak var contractremarklbl: UILabel!
    @IBOutlet weak var dropdownbtn: UIButton!

    
    var delegate:ContractRemarkTVCellDelegate?
    var dropdownbool = false
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
        contractremarklbl.isHidden = true
        dropdownbtn.addTarget(self, action: #selector(didTapOnDropupBtnAction(_:)), for: .touchUpInside)
    }
    
    override func updateUI() {
        contractremarklbl.attributedText = cellInfo?.title?.htmlToAttributedString
    }
    
    
    @objc func didTapOnDropupBtnAction(_ sender:UIButton) {
        dropdownbool.toggle();dropdownbool == true ? dropdownbtn.setImage(UIImage(named: "dropup"), for: .normal) : dropdownbtn.setImage(UIImage(named: "downarrow"), for: .normal);contractremarklbl.isHidden = dropdownbool == true ? false : true
        
        delegate?.didTapOnDropupBtnAction(cell: self)
    }
    
    
    
    
}
