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
    
    
    
    var res :ActivitiesVoucherModel?
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
        
        
        
        
        
        
        
    }
    
    
    override func updateUI() {
        res = cellInfo?.moreData as? ActivitiesVoucherModel
        
        
        
        MySingleton.shared.setAttributedTextnew(str1: "Address: ",
                                                str2:  MySingleton.shared.activity_loc,
                                                lbl: addresslblb,
                                                str1font: .InterSemiBold(size: 16),
                                                str2font: .InterSemiBold(size: 16),
                                                str1Color: .TitleColor,
                                                str2Color: .fareSubTitle)
        
        
        // Usage
        let currentDateFormatted = formattedCurrentDate()
       
        MySingleton.shared.setAttributedTextnew(str1: "Activity : ",
                                                str2:  currentDateFormatted,
                                                lbl: activitydatelbl,
                                                str1font: .InterSemiBold(size: 16),
                                                str2font: .InterSemiBold(size: 16),
                                                str1Color: .TitleColor,
                                                str2Color: .fareSubTitle)
        
        
        MySingleton.shared.setAttributedTextnew(str1: "Activity Code: ",
                                                str2:  res?.data?.booking_itinerary_details?[0].activity_code ?? "",
                                                lbl: activitycodelbl,
                                                str1font: .InterSemiBold(size: 16),
                                                str2font: .InterSemiBold(size: 16),
                                                str1Color: .TitleColor,
                                                str2Color: .fareSubTitle)
        
        
        
        
    }


    func formattedCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        let currentDate = Date()
        let formattedDate = dateFormatter.string(from: currentDate)
        return formattedDate
    }

   

    
}
