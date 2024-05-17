//
//  HolidaySelectedModel.swift
//  Travrate
//
//  Created by FCI on 17/05/24.
//

import Foundation



struct HolidaySelectedModel : Codable {
    let data : HolidaySelectedData?
    let msg : String?
    let status : Bool?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case msg = "msg"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(HolidaySelectedData.self, forKey: .data)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }

}



struct HolidaySelectedData : Codable {
    let tour__2_data : [Tour__2_data]?

    enum CodingKeys: String, CodingKey {

        case tour__2_data = "tour__2_data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        tour__2_data = try values.decodeIfPresent([Tour__2_data].self, forKey: .tour__2_data)
    }

}
