//
//  ActivityDetailsModel.swift
//  Travrate
//
//  Created by Admin on 17/07/24.
//

import Foundation


struct ActivityDetailsModel : Codable {
    let data : ActivityDetailsData?
    let status : Bool?
    let msg : String?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case status = "status"
        case msg = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(ActivityDetailsData.self, forKey: .data)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
    }

}


struct ActivityDetailsData : Codable {
    let currency_obj : Currency_obj?
    let activity_details : Activity_details?
    let activity_search_params : Activity_search_params?
    let active_booking_source : String?
    let params : Params?

    enum CodingKeys: String, CodingKey {

        case currency_obj = "currency_obj"
        case activity_details = "activity_details"
        case activity_search_params = "activity_search_params"
        case active_booking_source = "active_booking_source"
        case params = "params"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        currency_obj = try values.decodeIfPresent(Currency_obj.self, forKey: .currency_obj)
        activity_details = try values.decodeIfPresent(Activity_details.self, forKey: .activity_details)
        activity_search_params = try values.decodeIfPresent(Activity_search_params.self, forKey: .activity_search_params)
        active_booking_source = try values.decodeIfPresent(String.self, forKey: .active_booking_source)
        params = try values.decodeIfPresent(Params.self, forKey: .params)
    }

}
