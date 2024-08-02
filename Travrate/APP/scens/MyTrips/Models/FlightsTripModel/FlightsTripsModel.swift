//
//  FlightsTripsModel.swift
//  Travrate
//
//  Created by Admin on 02/08/24.
//

import Foundation


struct FlightsTripsModel : Codable {
  //  let completed : FlightCompleted?
    let cancelled : String?
    let upcoming : String?

    enum CodingKeys: String, CodingKey {

     //   case completed = "completed"
        case cancelled = "cancelled"
        case upcoming = "upcoming"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
      //  completed = try values.decodeIfPresent(FlightCompleted.self, forKey: .completed)
        cancelled = try values.decodeIfPresent(String.self, forKey: .cancelled)
        upcoming = try values.decodeIfPresent(String.self, forKey: .upcoming)
    }

}


//struct FlightCompleted : Codable {
//    let booking_details : [Booking_details]?
//
//    enum CodingKeys: String, CodingKey {
//
//        case booking_details = "booking_details"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        booking_details = try values.decodeIfPresent([Booking_details].self, forKey: .booking_details)
//    }
//
//}
