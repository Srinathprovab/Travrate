//
//  CarPreBookingMode.swift
//  Travrate
//
//  Created by Admin on 11/07/24.
//

import Foundation


struct CarPreBookingMode : Codable {
    
    let product_code : String?
    let result_token : Result_token?
    let result_index : Int?
    let extra_option_price : String?
    let car_search_params : Car_search_params?
    let addon_services : [Addon_services]?
    let post_data : Post_data?
    let message : String?
    let status : Int?

    enum CodingKeys: String, CodingKey {

        case product_code = "product_code"
        case result_token = "result_token"
        case result_index = "result_index"
        case extra_option_price = "extra_option_price"
        case car_search_params = "car_search_params"
        case addon_services = "addon_services"
        case post_data = "post_data"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        product_code = try values.decodeIfPresent(String.self, forKey: .product_code)
        result_token = try values.decodeIfPresent(Result_token.self, forKey: .result_token)
        result_index = try values.decodeIfPresent(Int.self, forKey: .result_index)
        extra_option_price = try values.decodeIfPresent(String.self, forKey: .extra_option_price)
        car_search_params = try values.decodeIfPresent(Car_search_params.self, forKey: .car_search_params)
        addon_services = try values.decodeIfPresent([Addon_services].self, forKey: .addon_services)
        post_data = try values.decodeIfPresent(Post_data.self, forKey: .post_data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }

}
