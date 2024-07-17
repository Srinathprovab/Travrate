//
//  Activity_images.swift
//  Travrate
//
//  Created by Admin on 17/07/24.
//

import Foundation

struct Activity_images : Codable {
    let mediumimage : String?
    let image : String?

    enum CodingKeys: String, CodingKey {

        case mediumimage = "mediumimage"
        case image = "image"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        mediumimage = try values.decodeIfPresent(String.self, forKey: .mediumimage)
        image = try values.decodeIfPresent(String.self, forKey: .image)
    }

}
