//
//  Activities_Booking_customer_details.swift
//  Travrate
//
//  Created by Admin on 19/07/24.
//

import Foundation


struct Activities_Booking_customer_details : Codable {
    let origin : String?
    let booking_reference : String?
    let app_reference : String?
    let pax_index : String?
    let first_name : String?
    let last_name : String?
    let age : String?
    let contact : String?
    let address : String?
    let email : String?
    let title : String?
    let pax_type : String?

    enum CodingKeys: String, CodingKey {

        case origin = "origin"
        case booking_reference = "booking_reference"
        case app_reference = "app_reference"
        case pax_index = "pax_index"
        case first_name = "first_name"
        case last_name = "last_name"
        case age = "age"
        case contact = "contact"
        case address = "address"
        case email = "email"
        case title = "title"
        case pax_type = "pax_type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        origin = try values.decodeIfPresent(String.self, forKey: .origin)
        booking_reference = try values.decodeIfPresent(String.self, forKey: .booking_reference)
        app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
        pax_index = try values.decodeIfPresent(String.self, forKey: .pax_index)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        age = try values.decodeIfPresent(String.self, forKey: .age)
        contact = try values.decodeIfPresent(String.self, forKey: .contact)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        pax_type = try values.decodeIfPresent(String.self, forKey: .pax_type)
    }

}
