//
//  GetTransferCityModel.swift
//  Travrate
//
//  Created by Admin on 13/07/24.
//

import Foundation



struct GetTransferCityModel : Codable {
    let label : String?
    let value : String?
    let latitude : String?
    let longitude : String?
    let description : String?
    let place_id : String?
    let iata : String?
    let city_en : String?
    let country : String?
    let category : [String]?

    enum CodingKeys: String, CodingKey {

        case label = "label"
        case value = "value"
        case latitude = "latitude"
        case longitude = "longitude"
        case description = "description"
        case place_id = "place_id"
        case iata = "iata"
        case city_en = "city_en"
        case country = "country"
        case category = "category"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decodeIfPresent(String.self, forKey: .label)
        value = try values.decodeIfPresent(String.self, forKey: .value)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        place_id = try values.decodeIfPresent(String.self, forKey: .place_id)
        iata = try values.decodeIfPresent(String.self, forKey: .iata)
        city_en = try values.decodeIfPresent(String.self, forKey: .city_en)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        category = try values.decodeIfPresent([String].self, forKey: .category)
    }

}
