//
//  HolidayListModel.swift
//  Travrate
//
//  Created by FCI on 17/05/24.
//

import Foundation
struct HolidayListModel : Codable {
    let home_sliders : Home_sliders?
    let data : [HolidayListData]?
    let msg : String?
    let status : Bool?

    enum CodingKeys: String, CodingKey {

        case home_sliders = "home_sliders"
        case data = "data"
        case msg = "msg"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        home_sliders = try values.decodeIfPresent(Home_sliders.self, forKey: .home_sliders)
        data = try values.decodeIfPresent([HolidayListData].self, forKey: .data)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }

}



struct HolidayListData : Codable {
    let origin : String?
    let heading : String?
    let subheading : String?
    let image : String?
    let desc : String?

    enum CodingKeys: String, CodingKey {

        case origin = "origin"
        case heading = "heading"
        case subheading = "subheading"
        case image = "image"
        case desc = "desc"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        origin = try values.decodeIfPresent(String.self, forKey: .origin)
        heading = try values.decodeIfPresent(String.self, forKey: .heading)
        subheading = try values.decodeIfPresent(String.self, forKey: .subheading)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        desc = try values.decodeIfPresent(String.self, forKey: .desc)
    }

}
