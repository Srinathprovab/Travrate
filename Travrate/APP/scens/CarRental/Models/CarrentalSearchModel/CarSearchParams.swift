//
//  CarSearchParams.swift
//  Travrate
//
//  Created by Admin on 10/07/24.
//

import Foundation


struct CarSearchParams : Codable {
    let from_loc : String?
    let from_loc_id : String?
    let pickup_date : String?
    let pickup_time : String?
    let drop_date : String?
    let drop_time : String?
    let age : String?
    let search_id : String?

    enum CodingKeys: String, CodingKey {

        case from_loc = "from_loc"
        case from_loc_id = "from_loc_id"
        case pickup_date = "pickup_date"
        case pickup_time = "pickup_time"
        case drop_date = "drop_date"
        case drop_time = "drop_time"
        case age = "age"
        case search_id = "search_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        from_loc = try values.decodeIfPresent(String.self, forKey: .from_loc)
        from_loc_id = try values.decodeIfPresent(String.self, forKey: .from_loc_id)
        pickup_date = try values.decodeIfPresent(String.self, forKey: .pickup_date)
        pickup_time = try values.decodeIfPresent(String.self, forKey: .pickup_time)
        drop_date = try values.decodeIfPresent(String.self, forKey: .drop_date)
        drop_time = try values.decodeIfPresent(String.self, forKey: .drop_time)
        age = try values.decodeIfPresent(String.self, forKey: .age)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
    }

}
