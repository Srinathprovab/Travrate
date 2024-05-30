//
//  CruiseDetailsModel.swift
//  Travgate
//
//  Created by FCI on 27/02/24.
//

import Foundation

struct CruiseDetailsModel : Codable {
    let cruise_data : Cruise_data?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case cruise_data = "cruise_data"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cruise_data = try values.decodeIfPresent(Cruise_data.self, forKey: .cruise_data)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}



struct Cruise_data : Codable {
    let heading : String?
    let iti_desc : String?
    let dis_q : String?
    let tnc : String?
    let image_url : String?
    let desc : String?
    let iti_tit : String?
    let itinerary : [Itinerary]?
    let subheading : String?
    let image : String?
    let origin : String?
    let iti_image : String?
    let more_url : [String]?
    let more_image : String?

    enum CodingKeys: String, CodingKey {

        case heading = "heading"
        case iti_desc = "iti_desc"
        case dis_q = "dis_q"
        case tnc = "tnc"
        case image_url = "image_url"
        case desc = "desc"
        case iti_tit = "iti_tit"
        case itinerary = "itinerary"
        case subheading = "subheading"
        case image = "image"
        case origin = "origin"
        case iti_image = "iti_image"
        case more_url = "more_url"
        case more_image = "more_image"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        heading = try values.decodeIfPresent(String.self, forKey: .heading)
        iti_desc = try values.decodeIfPresent(String.self, forKey: .iti_desc)
        dis_q = try values.decodeIfPresent(String.self, forKey: .dis_q)
        tnc = try values.decodeIfPresent(String.self, forKey: .tnc)
        image_url = try values.decodeIfPresent(String.self, forKey: .image_url)
        desc = try values.decodeIfPresent(String.self, forKey: .desc)
        iti_tit = try values.decodeIfPresent(String.self, forKey: .iti_tit)
        itinerary = try values.decodeIfPresent([Itinerary].self, forKey: .itinerary)
        subheading = try values.decodeIfPresent(String.self, forKey: .subheading)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        origin = try values.decodeIfPresent(String.self, forKey: .origin)
        iti_image = try values.decodeIfPresent(String.self, forKey: .iti_image)
        more_url = try values.decodeIfPresent([String].self, forKey: .more_url)
        more_image = try values.decodeIfPresent(String.self, forKey: .more_image)
    }

}
