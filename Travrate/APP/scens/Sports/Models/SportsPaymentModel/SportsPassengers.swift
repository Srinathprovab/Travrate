//
//  SportsPassengers.swift
//  Travrate
//
//  Created by Admin on 08/07/24.
//

import Foundation

struct SportsPassengers : Codable {
    let id : String?
    let app_reference : String?
    let first_name : String?
    let last_name : String?
    let passportNumber : String?
    let country : String?
    let city_of_birth : String?
    let date_of_brith : String?
    let create_at : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case app_reference = "app_reference"
        case first_name = "first_name"
        case last_name = "last_name"
        case passportNumber = "passportNumber"
        case country = "Country"
        case city_of_birth = "city_of_birth"
        case date_of_brith = "date_of_brith"
        case create_at = "create_at"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        passportNumber = try values.decodeIfPresent(String.self, forKey: .passportNumber)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        city_of_birth = try values.decodeIfPresent(String.self, forKey: .city_of_birth)
        date_of_brith = try values.decodeIfPresent(String.self, forKey: .date_of_brith)
        create_at = try values.decodeIfPresent(String.self, forKey: .create_at)
    }

}
