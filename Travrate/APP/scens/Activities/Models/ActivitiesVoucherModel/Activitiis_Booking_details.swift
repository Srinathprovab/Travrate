//
//  Activitiis_Booking_details.swift
//  Travrate
//
//  Created by Admin on 19/07/24.
//

import Foundation


struct Activitiis_Booking_details : Codable {
    let pendingAmount : String?
//    let agent_payable : String?
//    let booking_source : String?
//    let created_by_id : String?
//    let pre_confirmation_response : String?
//    let currency : String?
//    let country : String?
//    let search_id : String?
//    let payment_mode : String?
//    let addon_services_name : String?
//    let addon_services_ids : String?
//    let addon_price_total : String?
//    let invoicingCompany_registrationNumber : String?
//    let paymentTypeCode : String?
//    let service_tax : String?
//    let convinence : String?
//    let payment_invoice_ref : String?
//    let created_datetime : String?
//    let holder_contact : String?
//    let creationUser : String?
//    let agentServiceTax : String?
//    let payment_status : String?
//    let booking_reference : String?
//    let ratekey : String?
//    let payment_invoice_id : String?
//    let origin : String?
//    let status : String?
//    let total : String?
//    let invoicingCompany_code : String?
//    let admin_markup : String?
//    let holder_email : String?
//    let clientReference : String?
//    let invoicingCompany_name : String?
//    let creationDate : String?
//    let agent_markup : String?
//    let holder_name : String?
//    let search_data : String?
//    let domain_origin : String?
//    let app_reference : String?
//    let totalNet : String?

    enum CodingKeys: String, CodingKey {

        case pendingAmount = "pendingAmount"
//        case agent_payable = "agent_payable"
//        case booking_source = "booking_source"
//        case created_by_id = "created_by_id"
//        case pre_confirmation_response = "pre_confirmation_response"
//        case currency = "currency"
//        case country = "country"
//        case search_id = "search_id"
//        case payment_mode = "payment_mode"
//        case addon_services_name = "addon_services_name"
//        case addon_services_ids = "addon_services_ids"
//        case addon_price_total = "addon_price_total"
//        case invoicingCompany_registrationNumber = "invoicingCompany_registrationNumber"
//        case paymentTypeCode = "paymentTypeCode"
//        case service_tax = "service_tax"
//        case convinence = "convinence"
//        case payment_invoice_ref = "payment_invoice_ref"
//        case created_datetime = "created_datetime"
//        case holder_contact = "holder_contact"
//        case creationUser = "creationUser"
//        case agentServiceTax = "AgentServiceTax"
//        case payment_status = "payment_status"
//        case booking_reference = "booking_reference"
//        case ratekey = "ratekey"
//        case payment_invoice_id = "payment_invoice_id"
//        case origin = "origin"
//        case status = "status"
//        case total = "total"
//        case invoicingCompany_code = "invoicingCompany_code"
//        case admin_markup = "admin_markup"
//        case holder_email = "holder_email"
//        case clientReference = "clientReference"
//        case invoicingCompany_name = "invoicingCompany_name"
//        case creationDate = "creationDate"
//        case agent_markup = "agent_markup"
//        case holder_name = "holder_name"
//        case search_data = "search_data"
//        case domain_origin = "domain_origin"
//        case app_reference = "app_reference"
//        case totalNet = "totalNet"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        pendingAmount = try values.decodeIfPresent(String.self, forKey: .pendingAmount)
//        agent_payable = try values.decodeIfPresent(String.self, forKey: .agent_payable)
//        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
//        created_by_id = try values.decodeIfPresent(String.self, forKey: .created_by_id)
//        pre_confirmation_response = try values.decodeIfPresent(String.self, forKey: .pre_confirmation_response)
//        currency = try values.decodeIfPresent(String.self, forKey: .currency)
//        country = try values.decodeIfPresent(String.self, forKey: .country)
//        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
//        payment_mode = try values.decodeIfPresent(String.self, forKey: .payment_mode)
//        addon_services_name = try values.decodeIfPresent(String.self, forKey: .addon_services_name)
//        addon_services_ids = try values.decodeIfPresent(String.self, forKey: .addon_services_ids)
//        addon_price_total = try values.decodeIfPresent(String.self, forKey: .addon_price_total)
//        invoicingCompany_registrationNumber = try values.decodeIfPresent(String.self, forKey: .invoicingCompany_registrationNumber)
//        paymentTypeCode = try values.decodeIfPresent(String.self, forKey: .paymentTypeCode)
//        service_tax = try values.decodeIfPresent(String.self, forKey: .service_tax)
//        convinence = try values.decodeIfPresent(String.self, forKey: .convinence)
//        payment_invoice_ref = try values.decodeIfPresent(String.self, forKey: .payment_invoice_ref)
//        created_datetime = try values.decodeIfPresent(String.self, forKey: .created_datetime)
//        holder_contact = try values.decodeIfPresent(String.self, forKey: .holder_contact)
//        creationUser = try values.decodeIfPresent(String.self, forKey: .creationUser)
//        agentServiceTax = try values.decodeIfPresent(String.self, forKey: .agentServiceTax)
//        payment_status = try values.decodeIfPresent(String.self, forKey: .payment_status)
//        booking_reference = try values.decodeIfPresent(String.self, forKey: .booking_reference)
//        ratekey = try values.decodeIfPresent(String.self, forKey: .ratekey)
//        payment_invoice_id = try values.decodeIfPresent(String.self, forKey: .payment_invoice_id)
//        origin = try values.decodeIfPresent(String.self, forKey: .origin)
//        status = try values.decodeIfPresent(String.self, forKey: .status)
//        total = try values.decodeIfPresent(String.self, forKey: .total)
//        invoicingCompany_code = try values.decodeIfPresent(String.self, forKey: .invoicingCompany_code)
//        admin_markup = try values.decodeIfPresent(String.self, forKey: .admin_markup)
//        holder_email = try values.decodeIfPresent(String.self, forKey: .holder_email)
//        clientReference = try values.decodeIfPresent(String.self, forKey: .clientReference)
//        invoicingCompany_name = try values.decodeIfPresent(String.self, forKey: .invoicingCompany_name)
//        creationDate = try values.decodeIfPresent(String.self, forKey: .creationDate)
//        agent_markup = try values.decodeIfPresent(String.self, forKey: .agent_markup)
//        holder_name = try values.decodeIfPresent(String.self, forKey: .holder_name)
//        search_data = try values.decodeIfPresent(String.self, forKey: .search_data)
//        domain_origin = try values.decodeIfPresent(String.self, forKey: .domain_origin)
//        app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
//        totalNet = try values.decodeIfPresent(String.self, forKey: .totalNet)
    }

}
