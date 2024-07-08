//
//  PaymentSelection.swift
//  Travrate
//
//  Created by Admin on 08/07/24.
//

import Foundation



struct Payment_selection : Codable {
    let img_url : String?
    let value : String?

    enum CodingKeys: String, CodingKey {

        case img_url = "img_url"
        case value = "value"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        img_url = try values.decodeIfPresent(String.self, forKey: .img_url)
        value = try values.decodeIfPresent(String.self, forKey: .value)
    }

}
