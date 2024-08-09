//
//  VocherModelDetails.swift
//  BabSafar
//
//  Created by FCI on 08/12/22.
//

import Foundation


struct VocherModelDetails : Codable {
    let flight_details : Voucher_Flight_details?
    let insurance : String?
    let booking_details : [Booking_details]?
    let v_class : String?
    let insurance_totalprice : [String]?
    let voucher_pdf : String?
    let social_links : [Social_links]?
    let bottom_text_info : [Bottom_text_info]?

    enum CodingKeys: String, CodingKey {

        case flight_details = "flight_details"
        case insurance = "insurance"
        case booking_details = "booking_details"
        case v_class = "v_class"
        case insurance_totalprice = "insurance_totalprice"
        case voucher_pdf = "voucher_pdf"
        case social_links = "social_links"
        case bottom_text_info = "bottom_text_info"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        flight_details = try values.decodeIfPresent(Voucher_Flight_details.self, forKey: .flight_details)
        insurance = try values.decodeIfPresent(String.self, forKey: .insurance)
        booking_details = try values.decodeIfPresent([Booking_details].self, forKey: .booking_details)
        v_class = try values.decodeIfPresent(String.self, forKey: .v_class)
        insurance_totalprice = try values.decodeIfPresent([String].self, forKey: .insurance_totalprice)
        voucher_pdf = try values.decodeIfPresent(String.self, forKey: .voucher_pdf)
        social_links = try values.decodeIfPresent([Social_links].self, forKey: .social_links)
        bottom_text_info = try values.decodeIfPresent([Bottom_text_info].self, forKey: .bottom_text_info)
    }

}
