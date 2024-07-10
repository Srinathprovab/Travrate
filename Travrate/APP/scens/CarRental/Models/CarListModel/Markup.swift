//
//  Markup.swift
//  Travrate
//
//  Created by Admin on 10/07/24.
//

import Foundation

struct Markup : Codable {
    let value : Int?

    enum CodingKeys: String, CodingKey {

        case value = "value"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        value = try values.decodeIfPresent(Int.self, forKey: .value)
    }

}
