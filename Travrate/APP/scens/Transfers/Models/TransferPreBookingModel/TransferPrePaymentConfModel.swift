//
//  TransferPrePaymentConfModel.swift
//  Travrate
//
//  Created by Admin on 15/07/24.
//

import Foundation


struct TransferPrePaymentConfModel : Codable {
    let booking_details : Booking_details?
    let search_params : Transfer_Search_params?
    let hit_url : String?
    let search_id : String?
    let currency_symbol : String?
    let conversion_rate : Int?
    let ar : String?
    let sd : String?
    let advertise_top : Advertise_top?
    let status : Bool?
    let msg : String?
    let payment_selection : [Payment_selection]?

    enum CodingKeys: String, CodingKey {

        case booking_details = "booking_details"
        case search_params = "search_params"
        case hit_url = "hit_url"
        case search_id = "search_id"
        case currency_symbol = "currency_symbol"
        case conversion_rate = "conversion_rate"
        case ar = "ar"
        case sd = "sd"
        case advertise_top = "advertise_top"
        case status = "status"
        case msg = "msg"
        case payment_selection = "payment_selection"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        booking_details = try values.decodeIfPresent(Booking_details.self, forKey: .booking_details)
        search_params = try values.decodeIfPresent(Transfer_Search_params.self, forKey: .search_params)
        hit_url = try values.decodeIfPresent(String.self, forKey: .hit_url)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        currency_symbol = try values.decodeIfPresent(String.self, forKey: .currency_symbol)
        conversion_rate = try values.decodeIfPresent(Int.self, forKey: .conversion_rate)
        ar = try values.decodeIfPresent(String.self, forKey: .ar)
        sd = try values.decodeIfPresent(String.self, forKey: .sd)
        advertise_top = try values.decodeIfPresent(Advertise_top.self, forKey: .advertise_top)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        payment_selection = try values.decodeIfPresent([Payment_selection].self, forKey: .payment_selection)
    }

}
