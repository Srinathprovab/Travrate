//
//  MoreDetailsModel.swift
//  Travgate
//
//  Created by FCI on 07/03/24.
//

import Foundation

struct MoreDetailsModel : Codable {
    let data : MoreDetailsData?

    enum CodingKeys: String, CodingKey {

        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(MoreDetailsData.self, forKey: .data)
    }

}


struct MoreDetailsData : Codable {
    let page_status : String?
    let page_id : String?
    let page_keyword : String?
    let page_description : String?
    let page_description_ar : String?
    let image_ar : String?
    let image : String?
    let page_title : String?
    let page_title_ar : String?
    let page_seo_description : String?
    let page_seo_title : String?
    let module_type : String?
    let page_position : String?
    let page_seo_keyword : String?
    let module_name : String?

    enum CodingKeys: String, CodingKey {

        case page_status = "page_status"
        case page_id = "page_id"
        case page_keyword = "page_keyword"
        case page_description = "page_description"
        case page_description_ar = "page_description_ar"
        case image_ar = "image_ar"
        case image = "image"
        case page_title = "page_title"
        case page_title_ar = "page_title_ar"
        case page_seo_description = "page_seo_description"
        case page_seo_title = "page_seo_title"
        case module_type = "module_type"
        case page_position = "page_position"
        case page_seo_keyword = "page_seo_keyword"
        case module_name = "module_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page_status = try values.decodeIfPresent(String.self, forKey: .page_status)
        page_id = try values.decodeIfPresent(String.self, forKey: .page_id)
        page_keyword = try values.decodeIfPresent(String.self, forKey: .page_keyword)
        page_description = try values.decodeIfPresent(String.self, forKey: .page_description)
        page_description_ar = try values.decodeIfPresent(String.self, forKey: .page_description_ar)
        image_ar = try values.decodeIfPresent(String.self, forKey: .image_ar)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        page_title = try values.decodeIfPresent(String.self, forKey: .page_title)
        page_title_ar = try values.decodeIfPresent(String.self, forKey: .page_title_ar)
        page_seo_description = try values.decodeIfPresent(String.self, forKey: .page_seo_description)
        page_seo_title = try values.decodeIfPresent(String.self, forKey: .page_seo_title)
        module_type = try values.decodeIfPresent(String.self, forKey: .module_type)
        page_position = try values.decodeIfPresent(String.self, forKey: .page_position)
        page_seo_keyword = try values.decodeIfPresent(String.self, forKey: .page_seo_keyword)
        module_name = try values.decodeIfPresent(String.self, forKey: .module_name)
    }

}
