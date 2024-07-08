//
//  SportsSndtopaymentModel.swift
//  Travrate
//
//  Created by Admin on 08/07/24.
//

import Foundation

struct SportsSndtopaymentModel : Codable {
    let data : SportsSndtopaymentData?
    let msg : String?
    let status : Bool?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case msg = "msg"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(SportsSndtopaymentData.self, forKey: .data)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }

}



struct SportsSndtopaymentData : Codable {
    
    let url : String?
    let book_id : String?
    let search_id : String?

    enum CodingKeys: String, CodingKey {

        case url = "url"
        case book_id = "book_id"
        case search_id = "search_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        book_id = try values.decodeIfPresent(String.self, forKey: .book_id)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
    }

}
