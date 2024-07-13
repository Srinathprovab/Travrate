//
//  PreTransfersearchModel.swift
//  Travrate
//
//  Created by Admin on 13/07/24.
//

import Foundation


struct PreTransfersearchModel : Codable {
    let hit_url : String?
    let status : Bool?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case hit_url = "hit_url"
        case status = "status"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        hit_url = try values.decodeIfPresent(String.self, forKey: .hit_url)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}
