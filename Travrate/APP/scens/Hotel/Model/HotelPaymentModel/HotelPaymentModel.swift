//
//  HotelPaymentModel.swift
//  Travrate
//
//  Created by Admin on 08/07/24.
//

import Foundation
struct HotelPaymentModel : Codable {
    let status : Bool?
    let message : String?
    let data : HotelPaymentData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(HotelPaymentData.self, forKey: .data)
    }

}



struct HotelPaymentData : Codable {
    let search_id : String?
    let booking_source:String?
    let url : String?
    let app_reference : String?

    enum CodingKeys: String, CodingKey {

        case search_id = "search_id"
        case booking_source = "booking_source"
        case url = "url"
        case app_reference = "app_reference"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
        
    }

}
