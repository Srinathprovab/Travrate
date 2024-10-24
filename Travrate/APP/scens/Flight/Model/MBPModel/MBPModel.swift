//
//  MBPModel.swift
//  TravgateApp
//
//  Created by FCI on 10/01/24.
//

import Foundation
struct MBPModel : Codable {
    let status : Bool?
    let message : String?
    let data : MBPData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(MBPData.self, forKey: .data)
    }

}



struct HotelMBPModel : Codable {
    let status : Bool?
    let message : String?
    let data : MBPData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(MBPData.self, forKey: .data)
    }

}

//struct MBPData : Codable {
//    let post_data : Post_data?
//
//    enum CodingKeys: String, CodingKey {
//
//        case post_data = "post_data"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        post_data = try values.decodeIfPresent(Post_data.self, forKey: .post_data)
//    }
//
//}


struct MBPData : Codable {
    let search_id : String?
    let app_reference : String?
    let promocode_val : String?
    let url : String?
    let booking_source : String?
    let apicurrency : String?
    let pg_record : String?
    let booking_status : String?

    enum CodingKeys: String, CodingKey {

        case search_id = "search_id"
        case app_reference = "app_reference"
        case promocode_val = "promocode_val"
        case url = "url"
        case booking_source = "booking_source"
        case apicurrency = "apicurrency"
        case pg_record = "pg_record"
        case booking_status = "booking_status"
        
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
        promocode_val = try values.decodeIfPresent(String.self, forKey: .promocode_val)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        apicurrency = try values.decodeIfPresent(String.self, forKey: .apicurrency)
        pg_record = try values.decodeIfPresent(String.self, forKey: .pg_record)
        booking_status = try values.decodeIfPresent(String.self, forKey: .booking_status)
    }

}


