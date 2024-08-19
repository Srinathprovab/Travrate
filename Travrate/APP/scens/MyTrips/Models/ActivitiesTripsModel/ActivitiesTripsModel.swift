//
//  ActivitiesTripsModel.swift
//  Travrate
//
//  Created by Admin on 14/08/24.
//

import Foundation


struct ActivitiesTripsModel : Codable {
    let upcoming_booking : [Activities_Completed_booking]?
    let completed_booking : [Activities_Completed_booking]?
    let cancelled_booking : [Activities_Completed_booking]?
    
    enum CodingKeys: String, CodingKey {
        
        case upcoming_booking = "upcoming_booking"
        case completed_booking = "completed_booking"
        case cancelled_booking = "cancelled_booking"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        upcoming_booking = try values.decodeIfPresent([Activities_Completed_booking].self, forKey: .upcoming_booking)
        completed_booking = try values.decodeIfPresent([Activities_Completed_booking].self, forKey: .completed_booking)
        cancelled_booking = try values.decodeIfPresent([Activities_Completed_booking].self, forKey: .cancelled_booking)
    }
    
}



struct Activities_Completed_booking : Codable {
    
    let origin : String?
    let domain_origin : String?
    let booking_source : String?
    let booking_reference : String?
    let ratekey : String?
    let app_reference : String?
    let status : String?
    let currency : Bool?
    let clientReference : String?
    let creationDate : String?
    let creationUser : String?
    let paymentTypeCode : String?
    let invoicingCompany_code : String?
    let invoicingCompany_name : String?
    let invoicingCompany_registrationNumber : String?
    let pendingAmount : String?
    let total : String?
    let admin_markup : Int?
    let agent_markup : Int?
    let convinence : String?
    let totalNet : String?
    let agent_payable : String?
    let agentServiceTax : String?
    let service_tax : String?
    let country : String?
    let created_by_id : String?
    let created_datetime : String?
    let holder_name : String?
    let holder_contact : String?
    let holder_email : String?
    let payment_status : String?
    let pre_confirmation_response : String?
    let search_data : String?
    let search_id : String?
    let payment_mode : String?
    let payment_invoice_id : String?
    let payment_invoice_ref : String?
    let addon_services_ids : String?
    let addon_services_name : String?
    let addon_price_total : String?
    let old_data : String?
    let hotel_image : String?
    let hotel_location : String?
    let hotel_address : String?
    let cancellation_policy : [String]?
    let total_nights : Int?
    let total_rooms : Int?
    let adult_count : Int?
    let child_count : Int?
    let fare : Int?
    let admin_buying_price : Int?
    let agent_buying_price : Int?
    let grand_total : Int?
    let voucher_date : String?
    let cutomer_city : String?
    let cutomer_zipcode : String?
    let cutomer_address : String?
    let cutomer_country : String?
    let lead_pax_name : String?
    let admin_lead_pax_name : String?
    let lead_pax_phone_number : String?
    let lead_pax_email : String?
    let domain_name : String?
    let domain_ip : String?
    let domain_key : String?
    let theme_id : String?
    let domain_logo : String?
    let itinerary_details : [Activitis_Itinerary_details]?
    let voucher_url : String?
    
    enum CodingKeys: String, CodingKey {
        
        case origin = "origin"
        case domain_origin = "domain_origin"
        case booking_source = "booking_source"
        case booking_reference = "booking_reference"
        case ratekey = "ratekey"
        case app_reference = "app_reference"
        case status = "status"
        case currency = "currency"
        case clientReference = "clientReference"
        case creationDate = "creationDate"
        case creationUser = "creationUser"
        case paymentTypeCode = "paymentTypeCode"
        case invoicingCompany_code = "invoicingCompany_code"
        case invoicingCompany_name = "invoicingCompany_name"
        case invoicingCompany_registrationNumber = "invoicingCompany_registrationNumber"
        case pendingAmount = "pendingAmount"
        case total = "total"
        case admin_markup = "admin_markup"
        case agent_markup = "agent_markup"
        case convinence = "convinence"
        case totalNet = "totalNet"
        case agent_payable = "agent_payable"
        case agentServiceTax = "AgentServiceTax"
        case service_tax = "service_tax"
        case country = "country"
        case created_by_id = "created_by_id"
        case created_datetime = "created_datetime"
        case holder_name = "holder_name"
        case holder_contact = "holder_contact"
        case holder_email = "holder_email"
        case payment_status = "payment_status"
        case pre_confirmation_response = "pre_confirmation_response"
        case search_data = "search_data"
        case search_id = "search_id"
        case payment_mode = "payment_mode"
        case payment_invoice_id = "payment_invoice_id"
        case payment_invoice_ref = "payment_invoice_ref"
        case addon_services_ids = "addon_services_ids"
        case addon_services_name = "addon_services_name"
        case addon_price_total = "addon_price_total"
        case old_data = "old_data"
        case hotel_image = "hotel_image"
        case hotel_location = "hotel_location"
        case hotel_address = "hotel_address"
        case cancellation_policy = "cancellation_policy"
        case total_nights = "total_nights"
        case total_rooms = "total_rooms"
        case adult_count = "adult_count"
        case child_count = "child_count"
        case fare = "fare"
        case admin_buying_price = "admin_buying_price"
        case agent_buying_price = "agent_buying_price"
        case grand_total = "grand_total"
        case voucher_date = "voucher_date"
        case cutomer_city = "cutomer_city"
        case cutomer_zipcode = "cutomer_zipcode"
        case cutomer_address = "cutomer_address"
        case cutomer_country = "cutomer_country"
        case lead_pax_name = "lead_pax_name"
        case admin_lead_pax_name = "admin_lead_pax_name"
        case lead_pax_phone_number = "lead_pax_phone_number"
        case lead_pax_email = "lead_pax_email"
        case domain_name = "domain_name"
        case domain_ip = "domain_ip"
        case domain_key = "domain_key"
        case theme_id = "theme_id"
        case domain_logo = "domain_logo"
        case itinerary_details = "itinerary_details"
        case voucher_url = "voucher_url"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        origin = try values.decodeIfPresent(String.self, forKey: .origin)
        domain_origin = try values.decodeIfPresent(String.self, forKey: .domain_origin)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        booking_reference = try values.decodeIfPresent(String.self, forKey: .booking_reference)
        ratekey = try values.decodeIfPresent(String.self, forKey: .ratekey)
        app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        currency = try values.decodeIfPresent(Bool.self, forKey: .currency)
        clientReference = try values.decodeIfPresent(String.self, forKey: .clientReference)
        creationDate = try values.decodeIfPresent(String.self, forKey: .creationDate)
        creationUser = try values.decodeIfPresent(String.self, forKey: .creationUser)
        paymentTypeCode = try values.decodeIfPresent(String.self, forKey: .paymentTypeCode)
        invoicingCompany_code = try values.decodeIfPresent(String.self, forKey: .invoicingCompany_code)
        invoicingCompany_name = try values.decodeIfPresent(String.self, forKey: .invoicingCompany_name)
        invoicingCompany_registrationNumber = try values.decodeIfPresent(String.self, forKey: .invoicingCompany_registrationNumber)
        pendingAmount = try values.decodeIfPresent(String.self, forKey: .pendingAmount)
        total = try values.decodeIfPresent(String.self, forKey: .total)
        admin_markup = try values.decodeIfPresent(Int.self, forKey: .admin_markup)
        agent_markup = try values.decodeIfPresent(Int.self, forKey: .agent_markup)
        convinence = try values.decodeIfPresent(String.self, forKey: .convinence)
        totalNet = try values.decodeIfPresent(String.self, forKey: .totalNet)
        agent_payable = try values.decodeIfPresent(String.self, forKey: .agent_payable)
        agentServiceTax = try values.decodeIfPresent(String.self, forKey: .agentServiceTax)
        service_tax = try values.decodeIfPresent(String.self, forKey: .service_tax)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        created_by_id = try values.decodeIfPresent(String.self, forKey: .created_by_id)
        created_datetime = try values.decodeIfPresent(String.self, forKey: .created_datetime)
        holder_name = try values.decodeIfPresent(String.self, forKey: .holder_name)
        holder_contact = try values.decodeIfPresent(String.self, forKey: .holder_contact)
        holder_email = try values.decodeIfPresent(String.self, forKey: .holder_email)
        payment_status = try values.decodeIfPresent(String.self, forKey: .payment_status)
        pre_confirmation_response = try values.decodeIfPresent(String.self, forKey: .pre_confirmation_response)
        search_data = try values.decodeIfPresent(String.self, forKey: .search_data)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        payment_mode = try values.decodeIfPresent(String.self, forKey: .payment_mode)
        payment_invoice_id = try values.decodeIfPresent(String.self, forKey: .payment_invoice_id)
        payment_invoice_ref = try values.decodeIfPresent(String.self, forKey: .payment_invoice_ref)
        addon_services_ids = try values.decodeIfPresent(String.self, forKey: .addon_services_ids)
        addon_services_name = try values.decodeIfPresent(String.self, forKey: .addon_services_name)
        addon_price_total = try values.decodeIfPresent(String.self, forKey: .addon_price_total)
        old_data = try values.decodeIfPresent(String.self, forKey: .old_data)
        hotel_image = try values.decodeIfPresent(String.self, forKey: .hotel_image)
        hotel_location = try values.decodeIfPresent(String.self, forKey: .hotel_location)
        hotel_address = try values.decodeIfPresent(String.self, forKey: .hotel_address)
        cancellation_policy = try values.decodeIfPresent([String].self, forKey: .cancellation_policy)
        total_nights = try values.decodeIfPresent(Int.self, forKey: .total_nights)
        total_rooms = try values.decodeIfPresent(Int.self, forKey: .total_rooms)
        adult_count = try values.decodeIfPresent(Int.self, forKey: .adult_count)
        child_count = try values.decodeIfPresent(Int.self, forKey: .child_count)
        fare = try values.decodeIfPresent(Int.self, forKey: .fare)
        admin_buying_price = try values.decodeIfPresent(Int.self, forKey: .admin_buying_price)
        agent_buying_price = try values.decodeIfPresent(Int.self, forKey: .agent_buying_price)
        grand_total = try values.decodeIfPresent(Int.self, forKey: .grand_total)
        voucher_date = try values.decodeIfPresent(String.self, forKey: .voucher_date)
        cutomer_city = try values.decodeIfPresent(String.self, forKey: .cutomer_city)
        cutomer_zipcode = try values.decodeIfPresent(String.self, forKey: .cutomer_zipcode)
        cutomer_address = try values.decodeIfPresent(String.self, forKey: .cutomer_address)
        cutomer_country = try values.decodeIfPresent(String.self, forKey: .cutomer_country)
        lead_pax_name = try values.decodeIfPresent(String.self, forKey: .lead_pax_name)
        admin_lead_pax_name = try values.decodeIfPresent(String.self, forKey: .admin_lead_pax_name)
        lead_pax_phone_number = try values.decodeIfPresent(String.self, forKey: .lead_pax_phone_number)
        lead_pax_email = try values.decodeIfPresent(String.self, forKey: .lead_pax_email)
        domain_name = try values.decodeIfPresent(String.self, forKey: .domain_name)
        domain_ip = try values.decodeIfPresent(String.self, forKey: .domain_ip)
        domain_key = try values.decodeIfPresent(String.self, forKey: .domain_key)
        theme_id = try values.decodeIfPresent(String.self, forKey: .theme_id)
        domain_logo = try values.decodeIfPresent(String.self, forKey: .domain_logo)
        itinerary_details = try values.decodeIfPresent([Activitis_Itinerary_details].self, forKey: .itinerary_details)
        voucher_url = try values.decodeIfPresent(String.self, forKey: .voucher_url)
    }
    
}
