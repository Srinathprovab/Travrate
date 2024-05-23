//
//  OTPSucessModel.swift
//  Travrate
//
//  Created by FCI on 20/05/24.
//

import Foundation
struct OTPSucessModel : Codable {
    let data : OTPData?
    let msg : String?
    let status : Bool?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case msg = "msg"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(OTPData.self, forKey: .data)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }

}

struct OTPData : Codable {
    let un_id : String?

    enum CodingKeys: String, CodingKey {

        case un_id = "un_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        un_id = try values.decodeIfPresent(String.self, forKey: .un_id)
    }

}

