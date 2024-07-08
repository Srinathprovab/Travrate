//
//  SportsPrePaymentConfirmationModel.swift
//  Travrate
//
//  Created by Admin on 08/07/24.
//

import Foundation



struct SportsPrePaymentConfirmationModel : Codable {
    let data : [PrePaymentConfirmationData]?
    let sports_passengers : [SportsPassengers]?
    let payment_selection : [SportsPaymentSelection]?
    let url : String?
    let book_id : String?
    let search_id : String?
    let msg : String?
    let status : Bool?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case sports_passengers = "sports_passengers"
        case payment_selection = "payment_selection"
        case url = "url"
        case book_id = "book_id"
        case search_id = "search_id"
        case msg = "msg"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([PrePaymentConfirmationData].self, forKey: .data)
        sports_passengers = try values.decodeIfPresent([SportsPassengers].self, forKey: .sports_passengers)
        payment_selection = try values.decodeIfPresent([SportsPaymentSelection].self, forKey: .payment_selection)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        book_id = try values.decodeIfPresent(String.self, forKey: .book_id)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }

}



struct PrePaymentConfirmationData : Codable {
    let id : String?
    let app_reference : String?
    let c_name : String?
    let c_email : String?
    let c_country : String?
    let pax_count : String?
    let cost_code_cost : String?
    let shipping_code_cost : String?
    let totel_amount : String?
    let search_id : String?
    let creat_at : String?
    let event_list : String?
    let ticket_value : String?
    let admin_markup : String?
    let agent_markup : String?
    let discount : String?
    let status : String?
    let hotelname : String?
    let hotelAddress : String?
    let check_in : String?
    let totel_delivery : String?
    let homeAddress_country : String?
    let recipientName : String?
    let homeAddress : String?
    let zipCode : String?
    let dateOfEvent : String?
    let timeOfEvent : String?
    let event_name : String?
    let eventType_name : String?
    let tournament_name : String?
    let user_type : String?
    let user_id : String?
    let contact_number : String?
    let payment_status : String?
    let payment_invoice_id : String?
    let payment_invoice_ref : String?
    let payment_mode : String?
    let book_id : String?
    let app_currency : String?
    let app_currency_rate : String?
    let language : String?
    let ip : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case app_reference = "app_reference"
        case c_name = "c_name"
        case c_email = "c_email"
        case c_country = "c_country"
        case pax_count = "pax_count"
        case cost_code_cost = "cost_code_cost"
        case shipping_code_cost = "shipping_code_cost"
        case totel_amount = "totel_amount"
        case search_id = "search_id"
        case creat_at = "creat_at"
        case event_list = "event_list"
        case ticket_value = "ticket_value"
        case admin_markup = "admin_markup"
        case agent_markup = "agent_markup"
        case discount = "discount"
        case status = "status"
        case hotelname = "hotelname"
        case hotelAddress = "hotelAddress"
        case check_in = "check_in"
        case totel_delivery = "totel_delivery"
        case homeAddress_country = "homeAddress_country"
        case recipientName = "recipientName"
        case homeAddress = "homeAddress"
        case zipCode = "zipCode"
        case dateOfEvent = "dateOfEvent"
        case timeOfEvent = "timeOfEvent"
        case event_name = "event_name"
        case eventType_name = "eventType_name"
        case tournament_name = "tournament_name"
        case user_type = "user_type"
        case user_id = "user_id"
        case contact_number = "contact_number"
        case payment_status = "payment_status"
        case payment_invoice_id = "payment_invoice_id"
        case payment_invoice_ref = "payment_invoice_ref"
        case payment_mode = "payment_mode"
        case book_id = "book_id"
        case app_currency = "app_currency"
        case app_currency_rate = "app_currency_rate"
        case language = "language"
        case ip = "ip"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
        c_name = try values.decodeIfPresent(String.self, forKey: .c_name)
        c_email = try values.decodeIfPresent(String.self, forKey: .c_email)
        c_country = try values.decodeIfPresent(String.self, forKey: .c_country)
        pax_count = try values.decodeIfPresent(String.self, forKey: .pax_count)
        cost_code_cost = try values.decodeIfPresent(String.self, forKey: .cost_code_cost)
        shipping_code_cost = try values.decodeIfPresent(String.self, forKey: .shipping_code_cost)
        totel_amount = try values.decodeIfPresent(String.self, forKey: .totel_amount)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        creat_at = try values.decodeIfPresent(String.self, forKey: .creat_at)
        event_list = try values.decodeIfPresent(String.self, forKey: .event_list)
        ticket_value = try values.decodeIfPresent(String.self, forKey: .ticket_value)
        admin_markup = try values.decodeIfPresent(String.self, forKey: .admin_markup)
        agent_markup = try values.decodeIfPresent(String.self, forKey: .agent_markup)
        discount = try values.decodeIfPresent(String.self, forKey: .discount)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        hotelname = try values.decodeIfPresent(String.self, forKey: .hotelname)
        hotelAddress = try values.decodeIfPresent(String.self, forKey: .hotelAddress)
        check_in = try values.decodeIfPresent(String.self, forKey: .check_in)
        totel_delivery = try values.decodeIfPresent(String.self, forKey: .totel_delivery)
        homeAddress_country = try values.decodeIfPresent(String.self, forKey: .homeAddress_country)
        recipientName = try values.decodeIfPresent(String.self, forKey: .recipientName)
        homeAddress = try values.decodeIfPresent(String.self, forKey: .homeAddress)
        zipCode = try values.decodeIfPresent(String.self, forKey: .zipCode)
        dateOfEvent = try values.decodeIfPresent(String.self, forKey: .dateOfEvent)
        timeOfEvent = try values.decodeIfPresent(String.self, forKey: .timeOfEvent)
        event_name = try values.decodeIfPresent(String.self, forKey: .event_name)
        eventType_name = try values.decodeIfPresent(String.self, forKey: .eventType_name)
        tournament_name = try values.decodeIfPresent(String.self, forKey: .tournament_name)
        user_type = try values.decodeIfPresent(String.self, forKey: .user_type)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        contact_number = try values.decodeIfPresent(String.self, forKey: .contact_number)
        payment_status = try values.decodeIfPresent(String.self, forKey: .payment_status)
        payment_invoice_id = try values.decodeIfPresent(String.self, forKey: .payment_invoice_id)
        payment_invoice_ref = try values.decodeIfPresent(String.self, forKey: .payment_invoice_ref)
        payment_mode = try values.decodeIfPresent(String.self, forKey: .payment_mode)
        book_id = try values.decodeIfPresent(String.self, forKey: .book_id)
        app_currency = try values.decodeIfPresent(String.self, forKey: .app_currency)
        app_currency_rate = try values.decodeIfPresent(String.self, forKey: .app_currency_rate)
        language = try values.decodeIfPresent(String.self, forKey: .language)
        ip = try values.decodeIfPresent(String.self, forKey: .ip)
    }

}
