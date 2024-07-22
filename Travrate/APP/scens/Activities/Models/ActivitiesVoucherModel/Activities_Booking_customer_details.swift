//
//  Activities_Booking_customer_details.swift
//  Travrate
//
//  Created by Admin on 19/07/24.
//

import Foundation


struct Activities_Booking_customer_details : Codable {
    let app_reference : String?
//    let pax_index : String?
//    let age : String?
//    let contact : String?
//    let booking_reference : String?
//    let title : String?
//    let address : String?
//    let first_name : String?
//    let origin : String?
//    let pax_type : String?
//    let last_name : String?
//    let email : String?

    enum CodingKeys: String, CodingKey {

        case app_reference = "app_reference"
//        case pax_index = "pax_index"
//        case age = "age"
//        case contact = "contact"
//        case booking_reference = "booking_reference"
//        case title = "title"
//        case address = "address"
//        case first_name = "first_name"
//        case origin = "origin"
//        case pax_type = "pax_type"
//        case last_name = "last_name"
//        case email = "email"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
//        pax_index = try values.decodeIfPresent(String.self, forKey: .pax_index)
//        age = try values.decodeIfPresent(String.self, forKey: .age)
//        contact = try values.decodeIfPresent(String.self, forKey: .contact)
//        booking_reference = try values.decodeIfPresent(String.self, forKey: .booking_reference)
//        title = try values.decodeIfPresent(String.self, forKey: .title)
//        address = try values.decodeIfPresent(String.self, forKey: .address)
//        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
//        origin = try values.decodeIfPresent(String.self, forKey: .origin)
//        pax_type = try values.decodeIfPresent(String.self, forKey: .pax_type)
//        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
//        email = try values.decodeIfPresent(String.self, forKey: .email)
    }

}
