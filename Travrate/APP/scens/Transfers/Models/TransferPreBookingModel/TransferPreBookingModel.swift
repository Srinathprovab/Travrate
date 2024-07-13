//
//  TransferPreBookingModel.swift
//  Travrate
//
//  Created by Admin on 13/07/24.
//

import Foundation


struct TransferPreBookingModel : Codable {
    
    let advertise_top : Advertise_top?
    let bg_condition : [Bg_condition]?
    let search_id : String?
    let addon_services : [Addon_services]?
    let attr_token : String?
    let search_params : Transfer_Search_params?
    let transfer_data : Transfer_data?
    let status : Bool?
    let msg : String?

    enum CodingKeys: String, CodingKey {

        case advertise_top = "advertise_top"
        case bg_condition = "bg_condition"
        case search_id = "search_id"
        case addon_services = "addon_services"
        case attr_token = "attr_token"
        case search_params = "search_params"
        case transfer_data = "transfer_data"
        case status = "status"
        case msg = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        advertise_top = try values.decodeIfPresent(Advertise_top.self, forKey: .advertise_top)
        bg_condition = try values.decodeIfPresent([Bg_condition].self, forKey: .bg_condition)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        addon_services = try values.decodeIfPresent([Addon_services].self, forKey: .addon_services)
        attr_token = try values.decodeIfPresent(String.self, forKey: .attr_token)
        search_params = try values.decodeIfPresent(Transfer_Search_params.self, forKey: .search_params)
        transfer_data = try values.decodeIfPresent(Transfer_data.self, forKey: .transfer_data)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
    }

}
