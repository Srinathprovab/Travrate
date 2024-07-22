//
//  ActivitiesVoucherModel.swift
//  Travrate
//
//  Created by Admin on 19/07/24.
//

import Foundation

struct ActivitiesVoucherModel : Codable {
    let data : ActivitiesVoucherData?

    enum CodingKeys: String, CodingKey {

        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(ActivitiesVoucherData.self, forKey: .data)
    }

}



struct ActivitiesVoucherData : Codable {
    let booking_details : [Activitiis_Booking_details]?
    let booking_itinerary_details : [Activities_Booking_itinerary_details]?
    let booking_customer_details : [Activities_Booking_customer_details]?
 //   let cancellation_details : [Cancellation_details]?
  //  let agent_details : String?

    enum CodingKeys: String, CodingKey {

        case booking_details = "booking_details"
        case booking_itinerary_details = "booking_itinerary_details"
        case booking_customer_details = "booking_customer_details"
//        case cancellation_details = "cancellation_details"
//        case agent_details = "agent_details"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        booking_details = try values.decodeIfPresent([Activitiis_Booking_details].self, forKey: .booking_details)
        booking_itinerary_details = try values.decodeIfPresent([Activities_Booking_itinerary_details].self, forKey: .booking_itinerary_details)
        booking_customer_details = try values.decodeIfPresent([Activities_Booking_customer_details].self, forKey: .booking_customer_details)
//        cancellation_details = try values.decodeIfPresent([Cancellation_details].self, forKey: .cancellation_details)
//        agent_details = try values.decodeIfPresent(String.self, forKey: .agent_details)
    }

}
