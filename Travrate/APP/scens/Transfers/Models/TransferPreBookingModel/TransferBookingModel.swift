//
//  TransferBookingModel.swift
//  Travrate
//
//  Created by Admin on 15/07/24.
//

import Foundation


struct TransferBookingModel : Codable {
    let status : Bool?
    let msg : String?
    let hit_url : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case msg = "msg"
        case hit_url = "hit_url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        hit_url = try values.decodeIfPresent(String.self, forKey: .hit_url)
    }

}
