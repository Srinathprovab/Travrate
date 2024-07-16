//
//  CarSearchModel.swift
//  Travrate
//
//  Created by Admin on 10/07/24.
//

import Foundation

struct CarSearchModel : Codable {
    let car_search_params : CarSearchParams?
    let search_id : String?
    let active_booking_source : [CarActivebookingsource]?
    let hit_url : String?
    let status : Bool?
    let message : String?
    
    enum CodingKeys: String, CodingKey {
        
        case car_search_params = "car_search_params"
        case search_id = "search_id"
        case active_booking_source = "active_booking_source"
        case hit_url = "hit_url"
        case status = "status"
        case message = "message"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        car_search_params = try values.decodeIfPresent(CarSearchParams.self, forKey: .car_search_params)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        active_booking_source = try values.decodeIfPresent([CarActivebookingsource].self, forKey: .active_booking_source)
        hit_url = try values.decodeIfPresent(String.self, forKey: .hit_url)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
    
}



struct CarSecureBookingMode : Codable {
    
    let hit_url : String?
    let status : Bool?
    let message : String?
    
    enum CodingKeys: String, CodingKey {
        
        
        case hit_url = "hit_url"
        case status = "status"
        case message = "message"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        hit_url = try values.decodeIfPresent(String.self, forKey: .hit_url)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
    
}
