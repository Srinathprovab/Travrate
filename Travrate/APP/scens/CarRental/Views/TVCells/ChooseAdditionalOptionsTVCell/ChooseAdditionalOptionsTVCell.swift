//
//  ChooseAdditionalOptionsTVCell.swift
//  Travrate
//
//  Created by FCI on 14/06/24.
//

import UIKit

class ChooseAdditionalOptionsTVCell: TableViewCell {
    
    
    @IBOutlet weak var driver1CheckboxImg: UIImageView!
    @IBOutlet weak var driver2CheckboxImg: UIImageView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
    @IBAction func didTapOnAdditionalDriverBtnAction(_ sender: Any) {
        driver1CheckboxImg.image = UIImage(named: "newcheck")
        driver2CheckboxImg.image = UIImage(named: "newuncheck")
    }
    
    @IBAction func didTapOnChildSeatBtnAction(_ sender: Any) {
        driver1CheckboxImg.image = UIImage(named: "newuncheck")
        driver2CheckboxImg.image = UIImage(named: "newcheck")
    }
    
    
}
