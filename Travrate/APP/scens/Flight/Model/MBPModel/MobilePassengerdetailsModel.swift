//
//  MobilePassengerdetailsModel.swift
//  TravgateApp
//
//  Created by FCI on 10/01/24.
//

import Foundation

struct MobilePassengerdetailsModel : Codable {
    let form_url : String?
    let message : String?
    let search_id : String?
    let app_reference : String?
    let booking_source : String?
    let status : Bool?
    let url : String?
    let data : String?
    
    enum CodingKeys: String, CodingKey {
        
        case form_url = "form_url"
        case message = "message"
        case search_id = "search_id"
        case app_reference = "app_reference"
        case booking_source = "booking_source"
        case status = "status"
        case url = "url"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        form_url = try values.decodeIfPresent(String.self, forKey: .form_url)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        data = try values.decodeIfPresent(String.self, forKey: .data)
    }
    
}



struct getPaymentgatewayUrlModel : Codable {
    
    let message : String?
    let status : Int?
    let data : String?
    
    enum CodingKeys: String, CodingKey {
        
        
        case message = "message"
        case status = "status"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        data = try values.decodeIfPresent(String.self, forKey: .data)
        
    }
    
}
