//
//  SportListModel.swift
//  Travrate
//
//  Created by FCI on 21/05/24.
//

import Foundation

struct SportListModel : Codable {
    let data : [SportListData]?
    let search_id : String?
    let search_data : Search_data?
    let msg : String?
    let status : Bool?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case search_id = "search_id"
        case search_data = "search_data"
        case msg = "msg"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([SportListData].self, forKey: .data)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        search_data = try values.decodeIfPresent(Search_data.self, forKey: .search_data)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }

}



struct SportListData : Codable {
    
    let id : Int?
    let name : String?
    let homeTeam : HomeTeam?
    let awayTeam : AwayTeam?
    let participants : [Participants]?
    let eventType : EventType?
    let tournament : Tournament?
    let dateOfEvent : String?
    let timeOfEvent : String?
    let finalDate : Bool?
    let finalTime : Bool?
    let dateTimeBoundaries : String?
    let country : Country?
    let city : City?
    let venue : Venue?
    let eventUrl : String?
    let availableCategoriesQuantity : Int?
    let minTicketPrice : MinTicketPrice?
    let token : String?
    let search_id : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case homeTeam = "homeTeam"
        case awayTeam = "awayTeam"
        case participants = "participants"
        case eventType = "eventType"
        case tournament = "tournament"
        case dateOfEvent = "dateOfEvent"
        case timeOfEvent = "timeOfEvent"
        case finalDate = "finalDate"
        case finalTime = "finalTime"
        case dateTimeBoundaries = "dateTimeBoundaries"
        case country = "country"
        case city = "city"
        case venue = "venue"
        case eventUrl = "eventUrl"
        case availableCategoriesQuantity = "availableCategoriesQuantity"
        case minTicketPrice = "minTicketPrice"
        case token = "token"
        case search_id = "search_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        homeTeam = try values.decodeIfPresent(HomeTeam.self, forKey: .homeTeam)
        awayTeam = try values.decodeIfPresent(AwayTeam.self, forKey: .awayTeam)
        participants = try values.decodeIfPresent([Participants].self, forKey: .participants)
        eventType = try values.decodeIfPresent(EventType.self, forKey: .eventType)
        tournament = try values.decodeIfPresent(Tournament.self, forKey: .tournament)
        dateOfEvent = try values.decodeIfPresent(String.self, forKey: .dateOfEvent)
        timeOfEvent = try values.decodeIfPresent(String.self, forKey: .timeOfEvent)
        finalDate = try values.decodeIfPresent(Bool.self, forKey: .finalDate)
        finalTime = try values.decodeIfPresent(Bool.self, forKey: .finalTime)
        dateTimeBoundaries = try values.decodeIfPresent(String.self, forKey: .dateTimeBoundaries)
        country = try values.decodeIfPresent(Country.self, forKey: .country)
        city = try values.decodeIfPresent(City.self, forKey: .city)
        venue = try values.decodeIfPresent(Venue.self, forKey: .venue)
        eventUrl = try values.decodeIfPresent(String.self, forKey: .eventUrl)
        availableCategoriesQuantity = try values.decodeIfPresent(Int.self, forKey: .availableCategoriesQuantity)
        minTicketPrice = try values.decodeIfPresent(MinTicketPrice.self, forKey: .minTicketPrice)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
    }

}
