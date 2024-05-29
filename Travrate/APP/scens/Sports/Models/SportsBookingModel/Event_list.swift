

import Foundation
struct Event_list : Codable {
	let id : Int?
	let dateOfEvent : String?
	let finalDate : Bool?
	let eventType : EventType?
	let homeTeam : HomeTeam?
	let timeOfEvent : String?
	let finalTime : Bool?
	let tournament : Tournament?
	let availableCategoriesQuantity : Int?
	let participants : [Participants]?
	let minTicketPrice : MinTicketPrice?
	let city : City?
	let dateTimeBoundaries : String?
	let venue : Venue?
	let eventUrl : String?
	let awayTeam : AwayTeam?
	let name : String?
	let country : Country?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case dateOfEvent = "dateOfEvent"
		case finalDate = "finalDate"
		case eventType = "eventType"
		case homeTeam = "homeTeam"
		case timeOfEvent = "timeOfEvent"
		case finalTime = "finalTime"
		case tournament = "tournament"
		case availableCategoriesQuantity = "availableCategoriesQuantity"
		case participants = "participants"
		case minTicketPrice = "minTicketPrice"
		case city = "city"
		case dateTimeBoundaries = "dateTimeBoundaries"
		case venue = "venue"
		case eventUrl = "eventUrl"
		case awayTeam = "awayTeam"
		case name = "name"
		case country = "country"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		dateOfEvent = try values.decodeIfPresent(String.self, forKey: .dateOfEvent)
		finalDate = try values.decodeIfPresent(Bool.self, forKey: .finalDate)
		eventType = try values.decodeIfPresent(EventType.self, forKey: .eventType)
		homeTeam = try values.decodeIfPresent(HomeTeam.self, forKey: .homeTeam)
		timeOfEvent = try values.decodeIfPresent(String.self, forKey: .timeOfEvent)
		finalTime = try values.decodeIfPresent(Bool.self, forKey: .finalTime)
		tournament = try values.decodeIfPresent(Tournament.self, forKey: .tournament)
		availableCategoriesQuantity = try values.decodeIfPresent(Int.self, forKey: .availableCategoriesQuantity)
		participants = try values.decodeIfPresent([Participants].self, forKey: .participants)
		minTicketPrice = try values.decodeIfPresent(MinTicketPrice.self, forKey: .minTicketPrice)
		city = try values.decodeIfPresent(City.self, forKey: .city)
		dateTimeBoundaries = try values.decodeIfPresent(String.self, forKey: .dateTimeBoundaries)
		venue = try values.decodeIfPresent(Venue.self, forKey: .venue)
		eventUrl = try values.decodeIfPresent(String.self, forKey: .eventUrl)
		awayTeam = try values.decodeIfPresent(AwayTeam.self, forKey: .awayTeam)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		country = try values.decodeIfPresent(Country.self, forKey: .country)
	}

}
