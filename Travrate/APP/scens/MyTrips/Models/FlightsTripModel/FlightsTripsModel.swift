//
//  FlightsTripsModel.swift
//  Travrate
//
//  Created by Admin on 02/08/24.
//

import Foundation


struct FlightsTripsModel : Codable {
    let upcoming_booking : [[Booking]]?
    let completed_booking : [[Booking]]?
    let cancelled_booking : [[Booking]]?

    enum CodingKeys: String, CodingKey {

        case upcoming_booking = "upcoming_booking"
        case completed_booking = "completed_booking"
        case cancelled_booking = "cancelled_booking"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        upcoming_booking = try values.decodeIfPresent([[Booking]].self, forKey: .upcoming_booking)
        completed_booking = try values.decodeIfPresent([[Booking]].self, forKey: .completed_booking)
        cancelled_booking = try values.decodeIfPresent([[Booking]].self, forKey: .cancelled_booking)
    }

}


struct Booking : Codable {
    let origin : Origin?
    let destination : Destination?
    let operator_code : String?
    let display_operator_code : String?
    let operator_name : String?
    let cabin_class : String?
    let cclass : FlightClass?
    let flight_number : String?
    let no_of_stops : Int?
    let duration_seconds : Int?
    let duration : String?
    let meal : String?
    let meal_description : String?
    let seatsRemaining : String?
    let weight_Allowance : String?
    let pcc_code : String?
    let pdf_url : String?

    enum CodingKeys: String, CodingKey {

        case origin = "origin"
        case destination = "destination"
        case operator_code = "operator_code"
        case display_operator_code = "display_operator_code"
        case operator_name = "operator_name"
        case cabin_class = "cabin_class"
       case cclass = "class"
        case flight_number = "flight_number"
        case no_of_stops = "no_of_stops"
        case duration_seconds = "duration_seconds"
        case duration = "duration"
        case meal = "Meal"
        case meal_description = "Meal_description"
        case seatsRemaining = "SeatsRemaining"
        case weight_Allowance = "Weight_Allowance"
        case pcc_code = "pcc_code"
        case pdf_url = "pdf_url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        origin = try values.decodeIfPresent(Origin.self, forKey: .origin)
        destination = try values.decodeIfPresent(Destination.self, forKey: .destination)
        operator_code = try values.decodeIfPresent(String.self, forKey: .operator_code)
        display_operator_code = try values.decodeIfPresent(String.self, forKey: .display_operator_code)
        operator_name = try values.decodeIfPresent(String.self, forKey: .operator_name)
        cabin_class = try values.decodeIfPresent(String.self, forKey: .cabin_class)
        cclass = try values.decodeIfPresent(FlightClass.self, forKey: .cclass)
        flight_number = try values.decodeIfPresent(String.self, forKey: .flight_number)
        no_of_stops = try values.decodeIfPresent(Int.self, forKey: .no_of_stops)
        duration_seconds = try values.decodeIfPresent(Int.self, forKey: .duration_seconds)
        duration = try values.decodeIfPresent(String.self, forKey: .duration)
        meal = try values.decodeIfPresent(String.self, forKey: .meal)
        meal_description = try values.decodeIfPresent(String.self, forKey: .meal_description)
        seatsRemaining = try values.decodeIfPresent(String.self, forKey: .seatsRemaining)
        weight_Allowance = try values.decodeIfPresent(String.self, forKey: .weight_Allowance)
        pcc_code = try values.decodeIfPresent(String.self, forKey: .pcc_code)
        pdf_url = try values.decodeIfPresent(String.self, forKey: .pdf_url)
    }

}
