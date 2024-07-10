//
//  Extra_option.swift
//  Travrate
//
//  Created by Admin on 10/07/24.
//

import Foundation


struct Extra_option : Codable {
    let option_id : String?
    let option_name : String?
    let option_desc : String?
    let org_option_price : String?
    let org_option_currency : String?
    let option_price : String?
    let option_currency : String?
    let option_daily_rate : String?
    let option_total_rate : String?
    let option_category : String?
    let option_code : String?

    enum CodingKeys: String, CodingKey {

        case option_id = "option_id"
        case option_name = "option_name"
        case option_desc = "option_desc"
        case org_option_price = "org_option_price"
        case org_option_currency = "org_option_currency"
        case option_price = "option_price"
        case option_currency = "option_currency"
        case option_daily_rate = "option_daily_rate"
        case option_total_rate = "option_total_rate"
        case option_category = "option_category"
        case option_code = "option_code"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        option_id = try values.decodeIfPresent(String.self, forKey: .option_id)
        option_name = try values.decodeIfPresent(String.self, forKey: .option_name)
        option_desc = try values.decodeIfPresent(String.self, forKey: .option_desc)
        org_option_price = try values.decodeIfPresent(String.self, forKey: .org_option_price)
        org_option_currency = try values.decodeIfPresent(String.self, forKey: .org_option_currency)
        option_price = try values.decodeIfPresent(String.self, forKey: .option_price)
        option_currency = try values.decodeIfPresent(String.self, forKey: .option_currency)
        option_daily_rate = try values.decodeIfPresent(String.self, forKey: .option_daily_rate)
        option_total_rate = try values.decodeIfPresent(String.self, forKey: .option_total_rate)
        option_category = try values.decodeIfPresent(String.self, forKey: .option_category)
        option_code = try values.decodeIfPresent(String.self, forKey: .option_code)
    }

}
