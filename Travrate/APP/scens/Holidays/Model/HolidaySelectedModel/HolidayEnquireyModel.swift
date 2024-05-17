//
//  HolidayEnquireyModel.swift
//  Travrate
//
//  Created by FCI on 17/05/24.
//

import Foundation

struct HolidayEnquireyModel : Codable {
    let status : Bool?
    let data : HolidayEnquireyData?
    let msg : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
        case msg = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        data = try values.decodeIfPresent(HolidayEnquireyData.self, forKey: .data)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
    }

}


struct HolidayEnquireyData : Codable {
    let status : Int?
    let insert_id : Int?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case insert_id = "insert_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        insert_id = try values.decodeIfPresent(Int.self, forKey: .insert_id)
    }

}
