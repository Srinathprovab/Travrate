//
//  PaymentModel.swift
//  Travgate
//
//  Created by FCI on 03/04/24.
//

import Foundation

struct PaymentModel : Codable {
    let status : Bool?
    let message : String?
    let data : PaymentData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(PaymentData.self, forKey: .data)
    }

}



struct PaymentData : Codable {
    let search_id : String?
    let payment_selection : [Payment_selection]?
    let flight_details : FlightDetails?
    let search_data : Search_data?
    let url : String?
    let booking_customer_details : [Booking_customer_details]?
    let app_reference : String?

    enum CodingKeys: String, CodingKey {

        case search_id = "search_id"
        case payment_selection = "payment_selection"
        case flight_details = "flight_details"
        case search_data = "search_data"
        case url = "Url"
        case booking_customer_details = "booking_customer_details"
        case app_reference = "app_reference"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        payment_selection = try values.decodeIfPresent([Payment_selection].self, forKey: .payment_selection)
        flight_details = try values.decodeIfPresent(FlightDetails.self, forKey: .flight_details)
        search_data = try values.decodeIfPresent(Search_data.self, forKey: .search_data)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        booking_customer_details = try values.decodeIfPresent([Booking_customer_details].self, forKey: .booking_customer_details)
        app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
    }

}
