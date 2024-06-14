//
//  SelectedCRPackageTVCell.swift
//  Travrate
//
//  Created by FCI on 14/06/24.
//

import UIKit

class SelectedCRPackageTVCell: TableViewCell {
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var titleView: BorderedView!
    @IBOutlet weak var kwdlbl: UILabel!
    @IBOutlet weak var selectBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func updateUI() {
        selectBtn.layer.cornerRadius = 4
       // selectBtn.addTarget(self, action: #selector(didTapOnSelectPackageBtnAction(_:)), for: .touchUpInside)
        MySingleton.shared.setAttributedTextnew(str1: "KWD:",
                                                str2: "250.00",
                                                lbl: kwdlbl,
                                                str1font: .InterSemiBold(size: 12),
                                                str2font: .InterSemiBold(size: 22),
                                                str1Color: .TitleColor,
                                                str2Color: .TitleColor)
        
        
        titlelbl.text = cellInfo?.title ?? ""
        
        if cellInfo?.title == "Premium plus+" {
            titleView.backgroundColor = .Buttoncolor
        }
    }
    
}
