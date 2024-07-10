//
//  CarActivebookingsource.swift
//  Travrate
//
//  Created by Admin on 10/07/24.
//

import Foundation

struct CarActivebookingsource : Codable {
    let source_id : String?
    let origin : String?

    enum CodingKeys: String, CodingKey {

        case source_id = "source_id"
        case origin = "origin"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        source_id = try values.decodeIfPresent(String.self, forKey: .source_id)
        origin = try values.decodeIfPresent(String.self, forKey: .origin)
    }

}
