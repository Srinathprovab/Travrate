//
//  ChoosePackageTVCell.swift
//  Travrate
//
//  Created by FCI on 10/06/24.
//

import UIKit

protocol ChoosePackageTVCellDelergate:AnyObject {
    func didTapOnSelectPackageBtnAction(cell:ChoosePackageTVCell)
}

class ChoosePackageTVCell: TableViewCell {
    

    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var titleView: BorderedView!
    @IBOutlet weak var kwdlbl: UILabel!
    @IBOutlet weak var selectBtn: UIButton!
    
    @IBOutlet weak var liabililtylbl: UILabel!
    @IBOutlet weak var depositelbl: UILabel!
    @IBOutlet weak var milagelbl: UILabel!
    
 
    var carproductcode = String()
    var extraOptionPrice = String()
    var carproduct : Product?
    weak var delegate:ChoosePackageTVCellDelergate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        
        
      
        carproduct = cellInfo?.moreData as? Product
        carproductcode = carproduct?.product_type ?? ""
        extraOptionPrice = carproduct?.total ?? ""
        
        selectBtn.layer.cornerRadius = 4
        selectBtn.addTarget(self, action: #selector(didTapOnSelectPackageBtnAction(_:)), for: .touchUpInside)
        MySingleton.shared.setAttributedTextnew(str1: "\( carproduct?.currency ?? ""):",
                                                str2: "\( carproduct?.total ?? "")",
                                                lbl: kwdlbl,
                                                str1font: .InterSemiBold(size: 12),
                                                str2font: .InterSemiBold(size: 22),
                                                str1Color: .TitleColor,
                                                str2Color: .TitleColor)
        
        
        MySingleton.shared.setAttributedTextnew(str1: "Excess liability \(carproduct?.currency ?? ""):",
                                                str2: "\( carproduct?.excess ?? "")",
                                                lbl: liabililtylbl,
                                                str1font: .InterSemiBold(size: 14),
                                                str2font: .InterSemiBold(size: 14),
                                                str1Color: .TitleColor,
                                                str2Color: .TitleColor)
        
        
        MySingleton.shared.setAttributedTextnew(str1: "Excluded Security Deposit \(carproduct?.currency ?? ""):",
                                                str2: "\( carproduct?.deposit ?? "")",
                                                lbl: depositelbl,
                                                str1font: .InterSemiBold(size: 14),
                                                str2font: .InterSemiBold(size: 14),
                                                str1Color: .TitleColor,
                                                str2Color: .TitleColor)
        
        
        
        titlelbl.text = carproduct?.product_type
        milagelbl.text = carproduct?.mileage ?? ""
        
        if titlelbl.text == "BAS" {
            titlelbl.text = "BASIC"
        }
        
        
        if cellInfo?.title == "Premium plus+" {
            titleView.backgroundColor = .Buttoncolor
        }
        
        
        
       
        
    }
    
    
    
    @objc func didTapOnSelectPackageBtnAction(_ sender:UIButton) {
        delegate?.didTapOnSelectPackageBtnAction(cell: self)
    }
    
}
