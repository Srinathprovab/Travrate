//
//  Activities_Booking_itinerary_details.swift
//  Travrate
//
//  Created by Admin on 19/07/24.
//

import Foundation

struct Activities_Booking_itinerary_details : Codable {
    let origin : String?
    let booking_source : String?
    let booking_reference : String?
    let app_reference : String?
    let activity_name : String?
    let activity_code : String?
    let activity_type : String?
    let dateFrom : String?
    let dateTo : String?
    let address : String?
    let city : String?
    let country : String?
    let status : String?
    let totalAmount : String?
    let contactInfo : String?
    let supplier_name : String?
    let supplier_vatNo : String?
    let comminisionPercentage : String?
    let comminisionAmt : String?
    let pickup : String?
    let comminisionVateAmt : String?
    let comminisionVatPercentage : String?

    enum CodingKeys: String, CodingKey {

        case origin = "origin"
        case booking_source = "booking_source"
        case booking_reference = "booking_reference"
        case app_reference = "app_reference"
        case activity_name = "activity_name"
        case activity_code = "activity_code"
        case activity_type = "activity_type"
        case dateFrom = "dateFrom"
        case dateTo = "dateTo"
        case address = "address"
        case city = "city"
        case country = "country"
        case status = "status"
        case totalAmount = "totalAmount"
        case contactInfo = "contactInfo"
        case supplier_name = "supplier_name"
        case supplier_vatNo = "supplier_vatNo"
        case comminisionPercentage = "comminisionPercentage"
        case comminisionAmt = "comminisionAmt"
        case pickup = "pickup"
        case comminisionVateAmt = "comminisionVateAmt"
        case comminisionVatPercentage = "comminisionVatPercentage"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        origin = try values.decodeIfPresent(String.self, forKey: .origin)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        booking_reference = try values.decodeIfPresent(String.self, forKey: .booking_reference)
        app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
        activity_name = try values.decodeIfPresent(String.self, forKey: .activity_name)
        activity_code = try values.decodeIfPresent(String.self, forKey: .activity_code)
        activity_type = try values.decodeIfPresent(String.self, forKey: .activity_type)
        dateFrom = try values.decodeIfPresent(String.self, forKey: .dateFrom)
        dateTo = try values.decodeIfPresent(String.self, forKey: .dateTo)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        totalAmount = try values.decodeIfPresent(String.self, forKey: .totalAmount)
        contactInfo = try values.decodeIfPresent(String.self, forKey: .contactInfo)
        supplier_name = try values.decodeIfPresent(String.self, forKey: .supplier_name)
        supplier_vatNo = try values.decodeIfPresent(String.self, forKey: .supplier_vatNo)
        comminisionPercentage = try values.decodeIfPresent(String.self, forKey: .comminisionPercentage)
        comminisionAmt = try values.decodeIfPresent(String.self, forKey: .comminisionAmt)
        pickup = try values.decodeIfPresent(String.self, forKey: .pickup)
        comminisionVateAmt = try values.decodeIfPresent(String.self, forKey: .comminisionVateAmt)
        comminisionVatPercentage = try values.decodeIfPresent(String.self, forKey: .comminisionVatPercentage)
    }

}
