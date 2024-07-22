//
//  Activities_Booking_itinerary_details.swift
//  Travrate
//
//  Created by Admin on 19/07/24.
//

import Foundation

struct Activities_Booking_itinerary_details : Codable {
    let booking_source : String?
    let app_reference : String?
//    let status : String?
//    let pickup : String?
//    let country : String?
//    let dateFrom : String?
//    let dateTo : String?
//    let comminisionVateAmt : String?
//    let origin : String?
//    let activity_name : String?
//    let city : String?
//    let activity_type : String?
//    let comminisionAmt : String?
//    let supplier_vatNo : String?
//    let contactInfo : String?
//    let supplier_name : String?
    let activity_code : String?
//    let aminities : String?
//    let comminisionPercentage : String?
//    let totalAmount : String?
    let booking_reference : String?
//    let comminisionVatPercentage : String?
//    let address : String?
//    let description : String?

    enum CodingKeys: String, CodingKey {

        case booking_source = "booking_source"
        case app_reference = "app_reference"
//        case status = "status"
//        case pickup = "pickup"
//        case country = "country"
//        case dateFrom = "dateFrom"
//        case dateTo = "dateTo"
//        case comminisionVateAmt = "comminisionVateAmt"
//        case origin = "origin"
//        case activity_name = "activity_name"
//        case city = "city"
//        case activity_type = "activity_type"
//        case comminisionAmt = "comminisionAmt"
//        case supplier_vatNo = "supplier_vatNo"
//        case contactInfo = "contactInfo"
//        case supplier_name = "supplier_name"
        case activity_code = "activity_code"
//        case aminities = "aminities"
//        case comminisionPercentage = "comminisionPercentage"
//        case totalAmount = "totalAmount"
       case booking_reference = "booking_reference"
//        case comminisionVatPercentage = "comminisionVatPercentage"
//        case address = "address"
//        case description = "description"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
//        status = try values.decodeIfPresent(String.self, forKey: .status)
//        pickup = try values.decodeIfPresent(String.self, forKey: .pickup)
//        country = try values.decodeIfPresent(String.self, forKey: .country)
//        dateFrom = try values.decodeIfPresent(String.self, forKey: .dateFrom)
//        dateTo = try values.decodeIfPresent(String.self, forKey: .dateTo)
//        comminisionVateAmt = try values.decodeIfPresent(String.self, forKey: .comminisionVateAmt)
//        origin = try values.decodeIfPresent(String.self, forKey: .origin)
//        activity_name = try values.decodeIfPresent(String.self, forKey: .activity_name)
//        city = try values.decodeIfPresent(String.self, forKey: .city)
//        activity_type = try values.decodeIfPresent(String.self, forKey: .activity_type)
//        comminisionAmt = try values.decodeIfPresent(String.self, forKey: .comminisionAmt)
//        supplier_vatNo = try values.decodeIfPresent(String.self, forKey: .supplier_vatNo)
//        contactInfo = try values.decodeIfPresent(String.self, forKey: .contactInfo)
//        supplier_name = try values.decodeIfPresent(String.self, forKey: .supplier_name)
        activity_code = try values.decodeIfPresent(String.self, forKey: .activity_code)
//        aminities = try values.decodeIfPresent(String.self, forKey: .aminities)
//        comminisionPercentage = try values.decodeIfPresent(String.self, forKey: .comminisionPercentage)
//        totalAmount = try values.decodeIfPresent(String.self, forKey: .totalAmount)
        booking_reference = try values.decodeIfPresent(String.self, forKey: .booking_reference)
//        comminisionVatPercentage = try values.decodeIfPresent(String.self, forKey: .comminisionVatPercentage)
//        address = try values.decodeIfPresent(String.self, forKey: .address)
//        description = try values.decodeIfPresent(String.self, forKey: .description)
    }

}
