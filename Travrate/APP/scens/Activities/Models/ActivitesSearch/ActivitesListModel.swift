//
//  ActivitesListModel.swift
//  Travrate
//
//  Created by Admin on 17/07/24.
//

import Foundation

struct ActivitesListModel : Codable {
    let data : ActivitesListData?
    let msg : String?
    let status : Bool?
    let total_result_count : Int?
    let source_result_count : Int?
    let filter_result_count : Int?
    let offset : String?
    let timeline : String?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case msg = "msg"
        case status = "status"
        case total_result_count = "total_result_count"
        case source_result_count = "source_result_count"
        case filter_result_count = "filter_result_count"
        case offset = "offset"
        case timeline = "timeline"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(ActivitesListData.self, forKey: .data)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        total_result_count = try values.decodeIfPresent(Int.self, forKey: .total_result_count)
        source_result_count = try values.decodeIfPresent(Int.self, forKey: .source_result_count)
        filter_result_count = try values.decodeIfPresent(Int.self, forKey: .filter_result_count)
        offset = try values.decodeIfPresent(String.self, forKey: .offset)
        timeline = try values.decodeIfPresent(String.self, forKey: .timeline)
    }

}


struct ActivitesListData : Codable {
    
    let currency_obj : Currency_obj?
    let raw_activity_list : Raw_activity_list?
    let search_id : Int?
    let booking_source : String?

    enum CodingKeys: String, CodingKey {

        case currency_obj = "currency_obj"
        case raw_activity_list = "raw_activity_list"
        case search_id = "search_id"
        case booking_source = "booking_source"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        currency_obj = try values.decodeIfPresent(Currency_obj.self, forKey: .currency_obj)
        raw_activity_list = try values.decodeIfPresent(Raw_activity_list.self, forKey: .raw_activity_list)
        search_id = try values.decodeIfPresent(Int.self, forKey: .search_id)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
    }

}
