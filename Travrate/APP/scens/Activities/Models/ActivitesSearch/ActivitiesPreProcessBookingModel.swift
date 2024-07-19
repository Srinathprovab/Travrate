//
//  ActivitiesPreProcessBookingModel.swift
//  Travrate
//
//  Created by Admin on 18/07/24.
//

import Foundation



struct ActivitiesPreProcessBookingModel : Codable {
    let form_params : Form_params?
    let hit_url : String?

    enum CodingKeys: String, CodingKey {

        case form_params = "form_params"
        case hit_url = "hit_url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        form_params = try values.decodeIfPresent(Form_params.self, forKey: .form_params)
        hit_url = try values.decodeIfPresent(String.self, forKey: .hit_url)
    }

}
