//
//  GetActivitesDestinationListModel.swift
//  Travrate
//
//  Created by Admin on 17/07/24.
//

import Foundation


struct GetActivitesDestinationListModel : Codable {
    let label : String?
    let value : String?
    let category : String?
    let type : String?
    let id : String?

    enum CodingKeys: String, CodingKey {

        case label = "label"
        case value = "value"
        case category = "category"
        case type = "type"
        case id = "id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decodeIfPresent(String.self, forKey: .label)
        value = try values.decodeIfPresent(String.self, forKey: .value)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        id = try values.decodeIfPresent(String.self, forKey: .id)
    }

}
