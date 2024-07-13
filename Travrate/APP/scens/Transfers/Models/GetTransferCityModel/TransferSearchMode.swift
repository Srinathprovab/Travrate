//
//  TransferSearchMode.swift
//  Travrate
//
//  Created by Admin on 13/07/24.
//

import Foundation


struct TransferSearchMode : Codable {
    let data : TransferSearchdata?
    let msg : String?
    let status : Bool?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case msg = "msg"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(TransferSearchdata.self, forKey: .data)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }

}


struct TransferSearchdata : Codable {
    let sight_seen_search_params : Sight_seen_search_params?
    let destination_city : [String]?
    let active_booking_source : [Active_booking_source]?
    let from_currency : String?
    let to_currency : String?
    let loader_image : String?
    let to_air_code : String?
    let advertise_top : Advertise_top?

    enum CodingKeys: String, CodingKey {

        case sight_seen_search_params = "sight_seen_search_params"
        case destination_city = "destination_city"
        case active_booking_source = "active_booking_source"
        case from_currency = "from_currency"
        case to_currency = "to_currency"
        case loader_image = "loader_image"
        case to_air_code = "to_air_code"
        case advertise_top = "advertise_top"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        sight_seen_search_params = try values.decodeIfPresent(Sight_seen_search_params.self, forKey: .sight_seen_search_params)
        destination_city = try values.decodeIfPresent([String].self, forKey: .destination_city)
        active_booking_source = try values.decodeIfPresent([Active_booking_source].self, forKey: .active_booking_source)
        from_currency = try values.decodeIfPresent(String.self, forKey: .from_currency)
        to_currency = try values.decodeIfPresent(String.self, forKey: .to_currency)
        loader_image = try values.decodeIfPresent(String.self, forKey: .loader_image)
        to_air_code = try values.decodeIfPresent(String.self, forKey: .to_air_code)
        advertise_top = try values.decodeIfPresent(Advertise_top.self, forKey: .advertise_top)
    }

}
