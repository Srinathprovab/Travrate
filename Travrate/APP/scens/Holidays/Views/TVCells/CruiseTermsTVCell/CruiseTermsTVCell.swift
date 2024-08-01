//
//  CruiseTermsTVCell.swift
//  Travrate
//
//  Created by Admin on 31/07/24.
//

import UIKit

protocol CruiseTermsTVCellDelegate {
    func didTapOnCommonTermsBtnAction()
}

class CruiseTermsTVCell: TableViewCell {
    
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    
    
    var delegate:CruiseTermsTVCellDelegate?
    var termsbool = false
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
        setuplabels(lbl: titlelbl, text: "Terms and Conditions", textcolor: .TitleColor, font: .InterBold(size: 16), align: .left)
        subtitlelbl.isHidden = true
    }
    
    
    override func updateUI() {
         
        let text = " is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        
        
        MySingleton.shared.setAttributedTextnew(str1: "Lorem Ipsum",
                                                str2: text,
                                                lbl: subtitlelbl,
                                                str1font: .InterBold(size: 14),
                                                str2font: .InterRegular(size: 14),
                                                str1Color: .TitleColor,
                                                str2Color: .TitleColor)
        subtitlelbl.textAlignment = .left
       
    }
    
    
    
    @IBAction func didTapOnCruiseTermsBtnAction(_ sender: Any) {
        termsbool.toggle()
        subtitlelbl.isHidden = termsbool ? true:false
        delegate?.didTapOnCommonTermsBtnAction()
    }
    
    
    
}
