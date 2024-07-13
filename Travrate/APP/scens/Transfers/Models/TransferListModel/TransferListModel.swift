//
//  TransferListModel.swift
//  Travrate
//
//  Created by Admin on 13/07/24.
//

import Foundation


struct TransferListModel : Codable {
    // let filters : Filters?
    let data : TransferListData?
    let status : Int?
    let total_result_count : Int?
    let filter_result_count : Int?
    let offset : Int?
    
    enum CodingKeys: String, CodingKey {
        
        //  case filters = "filters"
        case data = "data"
        case status = "status"
        case total_result_count = "total_result_count"
        case filter_result_count = "filter_result_count"
        case offset = "offset"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        //     filters = try values.decodeIfPresent(Filters.self, forKey: .filters)
        data = try values.decodeIfPresent(TransferListData.self, forKey: .data)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        total_result_count = try values.decodeIfPresent(Int.self, forKey: .total_result_count)
        filter_result_count = try values.decodeIfPresent(Int.self, forKey: .filter_result_count)
        offset = try values.decodeIfPresent(Int.self, forKey: .offset)
    }
    
}



struct TransferListData : Codable {
    let currency_obj : Currency_obj?
    let raw_transfer_list : [Raw_transfer_list]?
    let search_hash : String?
    let search_id : String?
    let booking_source : String?
    //  let attr : Attr?
    let search_params : Transfer_Search_params?
    
    enum CodingKeys: String, CodingKey {
        
        case currency_obj = "currency_obj"
        case raw_transfer_list = "raw_transfer_list"
        case search_hash = "search_hash"
        case search_id = "search_id"
        case booking_source = "booking_source"
        //      case attr = "attr"
        case search_params = "search_params"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        currency_obj = try values.decodeIfPresent(Currency_obj.self, forKey: .currency_obj)
        raw_transfer_list = try values.decodeIfPresent([Raw_transfer_list].self, forKey: .raw_transfer_list)
        search_hash = try values.decodeIfPresent(String.self, forKey: .search_hash)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        //      attr = try values.decodeIfPresent(Attr.self, forKey: .attr)
        search_params = try values.decodeIfPresent(Transfer_Search_params.self, forKey: .search_params)
    }
    
}
