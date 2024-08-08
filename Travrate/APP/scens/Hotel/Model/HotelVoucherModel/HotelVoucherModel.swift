//
//  HotelVoucherModel.swift
//  Travrate
//
//  Created by Admin on 08/08/24.
//

import Foundation



struct HotelVoucherModel : Codable {
    let status : Int?
    let msg : String?
    let data : HotelVoucherData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case msg = "msg"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        data = try values.decodeIfPresent(HotelVoucherData.self, forKey: .data)
    }

}


struct HotelVoucherData : Codable {
    let booking_details : [Hotel_Booking_details]?
    let agent_details : String?
    let mail_status : Int?

    enum CodingKeys: String, CodingKey {

        case booking_details = "booking_details"
        case agent_details = "agent_details"
        case mail_status = "mail_status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        booking_details = try values.decodeIfPresent([Hotel_Booking_details].self, forKey: .booking_details)
        agent_details = try values.decodeIfPresent(String.self, forKey: .agent_details)
        mail_status = try values.decodeIfPresent(Int.self, forKey: .mail_status)
    }

}
