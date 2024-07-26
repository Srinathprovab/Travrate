//
//  BDPickupLocationTVCell.swift
//  Travrate
//
//  Created by Admin on 22/07/24.
//

import UIKit

protocol BDPickupLocationTVCellDelegate:AnyObject {
    func editingTextField(tf:UITextField)
}

class BDPickupLocationTVCell: TableViewCell {
    
    @IBOutlet weak var selectedDateTF: UITextField!
    @IBOutlet weak var hotelinfoTF: UITextField!
    
    
    
    weak var delegate:BDPickupLocationTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        selectedDateTF.setLeftPaddingPoints(15)
        selectedDateTF.isUserInteractionEnabled = false
        selectedDateTF.text = defaults.string(forKey: UserDefaultsKeys.calActivitesDepDate) ?? ""
        hotelinfoTF.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        hotelinfoTF.setLeftPaddingPoints(15)
    }
    
    
    @objc func editingChanged(_ tf:UITextField) {
        delegate?.editingTextField(tf: tf)
    }
    
    
    
}
