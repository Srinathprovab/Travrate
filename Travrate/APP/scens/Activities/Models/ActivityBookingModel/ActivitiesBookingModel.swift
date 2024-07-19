//
//  ActivitiesBookingModel.swift
//  Travrate
//
//  Created by Admin on 19/07/24.
//

import Foundation



struct ActivitiesBookingModel : Codable {
    let data : ActivitiesBookingDate?
    let msg : String?
    let status : Bool?
    let hit_url : String?
    let post : Post?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case msg = "msg"
        case status = "status"
        case hit_url = "hit_url"
        case post = "post"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(ActivitiesBookingDate.self, forKey: .data)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        hit_url = try values.decodeIfPresent(String.self, forKey: .hit_url)
        post = try values.decodeIfPresent(Post.self, forKey: .post)
    }

}



struct ActivitiesBookingDate : Codable {
    let activity_details : Activity_details?
    let activity_search_params : Activity_search_params?

    enum CodingKeys: String, CodingKey {

        case activity_details = "activity_details"
        case activity_search_params = "activity_search_params"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        activity_details = try values.decodeIfPresent(Activity_details.self, forKey: .activity_details)
        activity_search_params = try values.decodeIfPresent(Activity_search_params.self, forKey: .activity_search_params)
    }

}
