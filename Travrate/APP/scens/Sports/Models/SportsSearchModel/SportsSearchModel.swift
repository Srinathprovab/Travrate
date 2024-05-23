//
//  SportsSearchModel.swift
//  Travrate
//
//  Created by FCI on 20/05/24.
//

import Foundation
struct SportsServiceModel : Codable {
    let data : [SportsServiceData]?
    let msg : String?
    let status : Bool?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case msg = "msg"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([SportsServiceData].self, forKey: .data)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }

}

struct SportsServiceData : Codable {
    let id : String?
    let label : String?
    let value : String?
    let type : String?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case label = "label"
        case value = "value"
        case type = "type"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        label = try values.decodeIfPresent(String.self, forKey: .label)
        value = try values.decodeIfPresent(String.self, forKey: .value)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}
