//
//  CarVoucherModel.swift
//  Travrate
//
//  Created by Admin on 12/07/24.
//

import Foundation


struct CarVoucherModel : Codable {
    let data : CarVoucherData?
    let car_passengers : [Car_passengers]?
    let app_reference : String?
    let booking_status : String?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case car_passengers = "car_passengers"
        case app_reference = "app_reference"
        case booking_status = "booking_status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(CarVoucherData.self, forKey: .data)
        car_passengers = try values.decodeIfPresent([Car_passengers].self, forKey: .car_passengers)
        app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
        booking_status = try values.decodeIfPresent(String.self, forKey: .booking_status)
    }

}



struct CarVoucherData : Codable {
    
    let origin : String?
    let app_reference : String?
    let booking_source : String?
    let car_name : String?
    let car_id : String?
    let car_image : String?
    let from_loc : String?
    let from_loc_id : String?
    let search_id : String?
    let api_token : String?
    let result_index : String?
    let product_code : String?
    let extra_option_price : String?
    let total_amount : String?
    let currency : String?
    let selected_option : String?
    let api_response : String?
    let payment_status : String?
    let payment_invoice_id : String?
    let payment_invoice_ref : String?
    let payment_mode : String?
    let creation_date : String?
    let addon_services : String?
    let addon_price : String?
    let total_amount_origin : String?
    let markup_value : String?
    let discount_value : String?
    let pickup_date : String?
    let drop_date : String?
    let api_response_data : Api_response_data?
    let api_token_data : Api_token_data?

    enum CodingKeys: String, CodingKey {

        case origin = "origin"
        case app_reference = "app_reference"
        case booking_source = "booking_source"
        case car_name = "car_name"
        case car_id = "car_id"
        case car_image = "car_image"
        case from_loc = "from_loc"
        case from_loc_id = "from_loc_id"
        case search_id = "search_id"
        case api_token = "api_token"
        case result_index = "result_index"
        case product_code = "product_code"
        case extra_option_price = "extra_option_price"
        case total_amount = "total_amount"
        case currency = "currency"
        case selected_option = "selected_option"
        case api_response = "api_response"
        case payment_status = "payment_status"
        case payment_invoice_id = "payment_invoice_id"
        case payment_invoice_ref = "payment_invoice_ref"
        case payment_mode = "payment_mode"
        case creation_date = "creation_date"
        case addon_services = "addon_services"
        case addon_price = "addon_price"
        case total_amount_origin = "total_amount_origin"
        case markup_value = "markup_value"
        case discount_value = "discount_value"
        case pickup_date = "pickup_date"
        case drop_date = "drop_date"
        case api_response_data = "api_response_data"
        case api_token_data = "api_token_data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        origin = try values.decodeIfPresent(String.self, forKey: .origin)
        app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        car_name = try values.decodeIfPresent(String.self, forKey: .car_name)
        car_id = try values.decodeIfPresent(String.self, forKey: .car_id)
        car_image = try values.decodeIfPresent(String.self, forKey: .car_image)
        from_loc = try values.decodeIfPresent(String.self, forKey: .from_loc)
        from_loc_id = try values.decodeIfPresent(String.self, forKey: .from_loc_id)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        api_token = try values.decodeIfPresent(String.self, forKey: .api_token)
        result_index = try values.decodeIfPresent(String.self, forKey: .result_index)
        product_code = try values.decodeIfPresent(String.self, forKey: .product_code)
        extra_option_price = try values.decodeIfPresent(String.self, forKey: .extra_option_price)
        total_amount = try values.decodeIfPresent(String.self, forKey: .total_amount)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        selected_option = try values.decodeIfPresent(String.self, forKey: .selected_option)
        api_response = try values.decodeIfPresent(String.self, forKey: .api_response)
        payment_status = try values.decodeIfPresent(String.self, forKey: .payment_status)
        payment_invoice_id = try values.decodeIfPresent(String.self, forKey: .payment_invoice_id)
        payment_invoice_ref = try values.decodeIfPresent(String.self, forKey: .payment_invoice_ref)
        payment_mode = try values.decodeIfPresent(String.self, forKey: .payment_mode)
        creation_date = try values.decodeIfPresent(String.self, forKey: .creation_date)
        addon_services = try values.decodeIfPresent(String.self, forKey: .addon_services)
        addon_price = try values.decodeIfPresent(String.self, forKey: .addon_price)
        total_amount_origin = try values.decodeIfPresent(String.self, forKey: .total_amount_origin)
        markup_value = try values.decodeIfPresent(String.self, forKey: .markup_value)
        discount_value = try values.decodeIfPresent(String.self, forKey: .discount_value)
        pickup_date = try values.decodeIfPresent(String.self, forKey: .pickup_date)
        drop_date = try values.decodeIfPresent(String.self, forKey: .drop_date)
        api_response_data = try values.decodeIfPresent(Api_response_data.self, forKey: .api_response_data)
        api_token_data = try values.decodeIfPresent(Api_token_data.self, forKey: .api_token_data)
    }

}
