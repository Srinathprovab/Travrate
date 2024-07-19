//
//  Activitiis_Booking_details.swift
//  Travrate
//
//  Created by Admin on 19/07/24.
//

import Foundation


struct Activitiis_Booking_details : Codable {
    let origin : String?
    let domain_origin : String?
    let booking_source : String?
    let booking_reference : String?
    let ratekey : String?
    let app_reference : String?
    let status : String?
    let currency : String?
    let clientReference : String?
    let creationDate : String?
    let creationUser : String?
    let paymentTypeCode : String?
    let invoicingCompany_code : String?
    let invoicingCompany_name : String?
    let invoicingCompany_registrationNumber : String?
    let pendingAmount : String?
    let total : String?
    let admin_markup : String?
    let agent_markup : String?
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
    let search_id : String?
    let payment_mode : String?
    let payment_invoice_id : String?
    let payment_invoice_ref : String?

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
        case search_id = "search_id"
        case payment_mode = "payment_mode"
        case payment_invoice_id = "payment_invoice_id"
        case payment_invoice_ref = "payment_invoice_ref"
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
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        clientReference = try values.decodeIfPresent(String.self, forKey: .clientReference)
        creationDate = try values.decodeIfPresent(String.self, forKey: .creationDate)
        creationUser = try values.decodeIfPresent(String.self, forKey: .creationUser)
        paymentTypeCode = try values.decodeIfPresent(String.self, forKey: .paymentTypeCode)
        invoicingCompany_code = try values.decodeIfPresent(String.self, forKey: .invoicingCompany_code)
        invoicingCompany_name = try values.decodeIfPresent(String.self, forKey: .invoicingCompany_name)
        invoicingCompany_registrationNumber = try values.decodeIfPresent(String.self, forKey: .invoicingCompany_registrationNumber)
        pendingAmount = try values.decodeIfPresent(String.self, forKey: .pendingAmount)
        total = try values.decodeIfPresent(String.self, forKey: .total)
        admin_markup = try values.decodeIfPresent(String.self, forKey: .admin_markup)
        agent_markup = try values.decodeIfPresent(String.self, forKey: .agent_markup)
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
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        payment_mode = try values.decodeIfPresent(String.self, forKey: .payment_mode)
        payment_invoice_id = try values.decodeIfPresent(String.self, forKey: .payment_invoice_id)
        payment_invoice_ref = try values.decodeIfPresent(String.self, forKey: .payment_invoice_ref)
    }

}
