//
//  ActivityInformationTVCell.swift
//  Travrate
//
//  Created by Admin on 18/07/24.
//

import UIKit

class ActivityInformationTVCell: TableViewCell {
    
    
    @IBOutlet weak var addresslblb: UILabel!
    @IBOutlet weak var activitydatelbl: UILabel!
    @IBOutlet weak var activitycodelbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupui()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func setupui() {
        
       
        
        MySingleton.shared.setAttributedTextnew(str1: "Address: ",
                                                str2:  MySingleton.shared.activity_details?.location?.address ?? "",
                                                lbl: addresslblb,
                                                str1font: .InterSemiBold(size: 16),
                                                str2font: .InterSemiBold(size: 16),
                                                str1Color: .TitleColor,
                                                str2Color: .fareSubTitle)
        
        
        MySingleton.shared.setAttributedTextnew(str1: "Activity : ",
                                                str2:  MySingleton.shared.convertDateFormat(inputDate: "\(defaults.string(forKey: UserDefaultsKeys.calActivitesDepDate) ?? "")", f1: "dd-MM-yyyy", f2: "dd MMM yyyy"),
                                                lbl: addresslblb,
                                                str1font: .InterSemiBold(size: 16),
                                                str2font: .InterSemiBold(size: 16),
                                                str1Color: .TitleColor,
                                                str2Color: .fareSubTitle)
        
        
        MySingleton.shared.setAttributedTextnew(str1: "Activity Code: ",
                                                str2:  MySingleton.shared.activity_code,
                                                lbl: addresslblb,
                                                str1font: .InterSemiBold(size: 16),
                                                str2font: .InterSemiBold(size: 16),
                                                str1Color: .TitleColor,
                                                str2Color: .fareSubTitle)
        
        
        
        
        
        
        
        
    }
    
}
