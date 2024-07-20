//
//  SendToPaymentModel.swift
//  Travrate
//
//  Created by Admin on 20/07/24.
//

import Foundation


struct SendToPaymentModel : Codable {
    let msg : String?
    let status : Bool?
    let hit_url : String?

    enum CodingKeys: String, CodingKey {

        case msg = "msg"
        case status = "status"
        case hit_url = "hit_url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        hit_url = try values.decodeIfPresent(String.self, forKey: .hit_url)
    }

}
