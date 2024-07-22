//
//  Booking_Activity_details.swift
//  Travrate
//
//  Created by Admin on 22/07/24.
//

import Foundation

struct Booking_Activity_details : Codable {
    let booking_source : String?
    let app_reference : String?
    let agentServiceTax : String?
    let search_id : String?
    let agent_payable : String?
    let sub_total_amt : Int?
    // let searchParam : SearchParam?
    let image : String?
    let currency : String?
    let token_mob : Token_mob?
    let resultToken : Bool?
    let pax_details : [String]?
    let total_amt : String?
    let activity_type : String?
    let agent_markup : String?
    let actual_netrate : String?
    let convinence : Int?
    let tokenKey : String?
    let activity_selecteddate : String?
    let admin_paymarkup : String?
 //   let data : Data?
    let service_tax : String?
    let rateKey : String?
    
    enum CodingKeys: String, CodingKey {
        
        case booking_source = "booking_source"
        case app_reference = "app_reference"
        case agentServiceTax = "AgentServiceTax"
        case search_id = "search_id"
        case agent_payable = "agent_payable"
        case sub_total_amt = "sub_total_amt"
        //   case searchParam = "searchParam"
        case image = "image"
        case currency = "currency"
        case token_mob = "token_mob"
        case resultToken = "resultToken"
        case pax_details = "pax_details"
        case total_amt = "total_amt"
        case activity_type = "activity_type"
        case agent_markup = "agent_markup"
        case actual_netrate = "actual_netrate"
        case convinence = "convinence"
        case tokenKey = "tokenKey"
        case activity_selecteddate = "activity_selecteddate"
        case admin_paymarkup = "admin_paymarkup"
  //      case data = "data"
        case service_tax = "service_tax"
        case rateKey = "rateKey"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
        agentServiceTax = try values.decodeIfPresent(String.self, forKey: .agentServiceTax)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        agent_payable = try values.decodeIfPresent(String.self, forKey: .agent_payable)
        sub_total_amt = try values.decodeIfPresent(Int.self, forKey: .sub_total_amt)
        //    searchParam = try values.decodeIfPresent(SearchParam.self, forKey: .searchParam)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        token_mob = try values.decodeIfPresent(Token_mob.self, forKey: .token_mob)
        resultToken = try values.decodeIfPresent(Bool.self, forKey: .resultToken)
        pax_details = try values.decodeIfPresent([String].self, forKey: .pax_details)
        total_amt = try values.decodeIfPresent(String.self, forKey: .total_amt)
        activity_type = try values.decodeIfPresent(String.self, forKey: .activity_type)
        agent_markup = try values.decodeIfPresent(String.self, forKey: .agent_markup)
        actual_netrate = try values.decodeIfPresent(String.self, forKey: .actual_netrate)
        convinence = try values.decodeIfPresent(Int.self, forKey: .convinence)
        tokenKey = try values.decodeIfPresent(String.self, forKey: .tokenKey)
        activity_selecteddate = try values.decodeIfPresent(String.self, forKey: .activity_selecteddate)
        admin_paymarkup = try values.decodeIfPresent(String.self, forKey: .admin_paymarkup)
   //     data = try values.decodeIfPresent(Data.self, forKey: .data)
        service_tax = try values.decodeIfPresent(String.self, forKey: .service_tax)
        rateKey = try values.decodeIfPresent(String.self, forKey: .rateKey)
    }
    
}
