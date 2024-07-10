//
//  SportsFareSummeryTVCell.swift
//  Travrate
//
//  Created by FCI on 27/05/24.
//

import UIKit

class SportsFareSummeryTVCell: TableViewCell {
    
    @IBOutlet weak var topview: UIView!
    @IBOutlet weak var grossFarelbl: UILabel!
    @IBOutlet weak var serviceFarelbl: UILabel!
    @IBOutlet weak var personCountlbl: UILabel!
    @IBOutlet weak var costlbl: UILabel!
    @IBOutlet weak var shippingFeeslbl: UILabel!
    @IBOutlet weak var convinceFeelbl: UILabel!
    @IBOutlet weak var totalFarelbl: UILabel!
    @IBOutlet weak var totalgrossFarelbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setupUI(){
        
        topview.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // top left corner, top right corner respectively
        topview.layer.cornerRadius = 8
        
    }
    
    
    //    override func updateUI() {
    //
    //        grossFarelbl.text = "\(MySingleton.shared.sportsBookingData?.event_list?.minTicketPrice?.currency ?? "") \(MySingleton.shared.sportsBookingData?.event_list?.minTicketPrice?.price ?? 0)"
    //
    //        serviceFarelbl.text = "\(MySingleton.shared.sportsBookingData?.ticket_value?.currency ?? "") \(MySingleton.shared.sportsBookingData?.ticket_value?.serviceFee ?? 0)"
    //
    //        personCountlbl.text = "X\(MySingleton.shared.sportsPersonCount)"
    //
    //        costlbl.text = "\(MySingleton.shared.sportsBookingData?.ticket_value?.currency ?? "") 0.0"
    //        shippingFeeslbl.text = "\(MySingleton.shared.sportsBookingData?.ticket_value?.currency ?? "") 0.0"
    //        convinceFeelbl.text = "\(MySingleton.shared.sportsBookingData?.ticket_value?.currency ?? "") 0.0"
    //        totalFarelbl.text = "\(MySingleton.shared.sportsBookingData?.ticket_value?.currency ?? "") 0.0"
    //        totalgrossFarelbl.text = "\(MySingleton.shared.sportsBookingData?.ticket_value?.currency ?? "") 0.0"
    //
    //
    //
    //
    //    }
    
    
    override func updateUI() {
        guard let sportsBookingData = MySingleton.shared.sportsBookingData else { return }
        
        // Extract and format currency and prices
        let currency = sportsBookingData.event_list?.minTicketPrice?.currency ?? ""
        let minTicketPrice = sportsBookingData.event_list?.minTicketPrice?.price ?? 0
        let serviceFee = sportsBookingData.ticket_value?.serviceFee ?? 0
        let sportsPersonCount = MySingleton.shared.sportsPersonCount
        let shippingFees = MySingleton.shared.sportsShippingFees
        
        // Update gross fare based on the number of persons
        let grossFare = sportsPersonCount > 1 ? minTicketPrice * Int(Double(sportsPersonCount)) : minTicketPrice
        
        
        
        // Update other labels
        costlbl.text = "\(currency) \(minTicketPrice)"
        convinceFeelbl.text = "\(currency) 0.0"
        grossFarelbl.text = "\(currency) \(grossFare)"
        shippingFeeslbl.text = "\(currency) \(shippingFees)"
        serviceFarelbl.text = "\(currency) \(serviceFee)"
        personCountlbl.text = "X\(sportsPersonCount)"
        costlbl.text = "\(currency) \((grossFare + serviceFee))"
        
        totalFarelbl.text = "\(currency) \((grossFare + serviceFee) + shippingFees)"
        totalgrossFarelbl.text = "\(currency) \(grossFare)"
        
        
        //        if sportsPersonCount == 0 {
        //            totalFarelbl.text = "\(currency) \((grossFare + serviceFee))"
        //            totalgrossFarelbl.text = "\(currency) \((grossFare + shippingFees))"
        //        }else {
        //            totalFarelbl.text = "\(currency) \((grossFare + serviceFee) * sportsPersonCount)"
        //            totalgrossFarelbl.text = "\(currency) \((grossFare + shippingFees) * sportsPersonCount)"
        //        }
        
        
        
        
        
    }
    
    
    
    
}
