//
//  SportsBookingModel.swift
//  Travrate
//
//  Created by FCI on 28/05/24.
//

import Foundation

struct SportsBookingModel : Codable {
    let data : SportsBookingData?
    let msg : String?
    let status : Bool?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case msg = "msg"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(SportsBookingData.self, forKey: .data)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }

}



struct SportsBookingData : Codable {
    let ticket_value : Ticket_value?
    let search_id : String?
    let event_list : Event_list?
    let sports_add : [Sports_add]?

    enum CodingKeys: String, CodingKey {

        case ticket_value = "ticket_value"
        case search_id = "search_id"
        case event_list = "event_list"
        case sports_add = "sports_add"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        ticket_value = try values.decodeIfPresent(Ticket_value.self, forKey: .ticket_value)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        event_list = try values.decodeIfPresent(Event_list.self, forKey: .event_list)
        sports_add = try values.decodeIfPresent([Sports_add].self, forKey: .sports_add)
    }

}
