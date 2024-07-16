//
//  TransferPrePaymentConfModel.swift
//  Travrate
//
//  Created by Admin on 15/07/24.
//

import Foundation


struct TransferPrePaymentConfModel : Codable {
    let msg : String?
    let status : Bool?
    let currency_symbol : String?
    let hit_url : String?
    let sd : String?
    let search_id : String?
    let payment_selection : [Payment_selection]?
   // let booking_details : Booking_details?
    let ar : String?
    let search_params : Transfer_Search_params?
    let conversion_rate : Int?
    let advertise_top : Advertise_top?

    enum CodingKeys: String, CodingKey {

        case msg = "msg"
        case status = "status"
        case currency_symbol = "currency_symbol"
        case hit_url = "hit_url"
        case sd = "sd"
        case search_id = "search_id"
        case payment_selection = "payment_selection"
    //    case booking_details = "booking_details"
        case ar = "ar"
        case search_params = "search_params"
        case conversion_rate = "conversion_rate"
        case advertise_top = "advertise_top"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        currency_symbol = try values.decodeIfPresent(String.self, forKey: .currency_symbol)
        hit_url = try values.decodeIfPresent(String.self, forKey: .hit_url)
        sd = try values.decodeIfPresent(String.self, forKey: .sd)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        payment_selection = try values.decodeIfPresent([Payment_selection].self, forKey: .payment_selection)
   //     booking_details = try values.decodeIfPresent(Booking_details.self, forKey: .booking_details)
        ar = try values.decodeIfPresent(String.self, forKey: .ar)
        search_params = try values.decodeIfPresent(Transfer_Search_params.self, forKey: .search_params)
        conversion_rate = try values.decodeIfPresent(Int.self, forKey: .conversion_rate)
        advertise_top = try values.decodeIfPresent(Advertise_top.self, forKey: .advertise_top)
    }

}
