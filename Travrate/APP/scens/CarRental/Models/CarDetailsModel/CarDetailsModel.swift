//
//  CarDetailsModel.swift
//  Travrate
//
//  Created by Admin on 11/07/24.
//

import Foundation


struct CarDetailsModel : Codable {
    
    let product_code : String?
    let result_token : Result_token?
    let result_index : Int?
    let post_data : Post_data?
    let car_search_params : Car_search_params?
    let message : String?
    let status : Int?

    enum CodingKeys: String, CodingKey {

        case product_code = "product_code"
        case result_token = "result_token"
        case result_index = "result_index"
        case post_data = "post_data"
        case car_search_params = "car_search_params"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        product_code = try values.decodeIfPresent(String.self, forKey: .product_code)
        result_token = try values.decodeIfPresent(Result_token.self, forKey: .result_token)
        result_index = try values.decodeIfPresent(Int.self, forKey: .result_index)
        post_data = try values.decodeIfPresent(Post_data.self, forKey: .post_data)
        car_search_params = try values.decodeIfPresent(Car_search_params.self, forKey: .car_search_params)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }

}
