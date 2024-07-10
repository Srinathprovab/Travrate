//
//  CarListModel.swift
//  Travrate
//
//  Created by Admin on 10/07/24.
//

import Foundation

struct CarListModel : Codable {
    let data : CarListData?
    let msg : [String]?
    let status : Int?
    // let filters : Filters?
    let message : String?
    let total_result_count : Int?
    let filter_result_count : Int?
    let offset : Int?
    let booking_source : String?
    //   let session_expiry_details : Session_expiry_details?
    
    enum CodingKeys: String, CodingKey {
        
        case data = "data"
        case msg = "msg"
        case status = "status"
        //   case filters = "filters"
        case message = "message"
        case total_result_count = "total_result_count"
        case filter_result_count = "filter_result_count"
        case offset = "offset"
        case booking_source = "booking_source"
        //     case session_expiry_details = "session_expiry_details"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(CarListData.self, forKey: .data)
        msg = try values.decodeIfPresent([String].self, forKey: .msg)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        //     filters = try values.decodeIfPresent(Filters.self, forKey: .filters)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        total_result_count = try values.decodeIfPresent(Int.self, forKey: .total_result_count)
        filter_result_count = try values.decodeIfPresent(Int.self, forKey: .filter_result_count)
        offset = try values.decodeIfPresent(Int.self, forKey: .offset)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        //     session_expiry_details = try values.decodeIfPresent(Session_expiry_details.self, forKey: .session_expiry_details)
    }
    
}


struct CarListData : Codable {
    let currency_obj : Currency_obj?
    let raw_hotel_list : [Raw_hotel_list]?
    let search_id : String?
    let booking_source : String?
    let attr : CarAttr?
    let view_type : String?
    
    enum CodingKeys: String, CodingKey {
        
        case currency_obj = "currency_obj"
        case raw_hotel_list = "raw_hotel_list"
        case search_id = "search_id"
        case booking_source = "booking_source"
        case attr = "attr"
        case view_type = "view_type"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        currency_obj = try values.decodeIfPresent(Currency_obj.self, forKey: .currency_obj)
        raw_hotel_list = try values.decodeIfPresent([Raw_hotel_list].self, forKey: .raw_hotel_list)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        attr = try values.decodeIfPresent(CarAttr.self, forKey: .attr)
        view_type = try values.decodeIfPresent(String.self, forKey: .view_type)
    }
    
}
