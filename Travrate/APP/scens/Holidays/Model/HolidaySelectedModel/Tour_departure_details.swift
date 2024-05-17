

import Foundation
struct Tour_departure_details : Codable {
	let dep_date : String?
	let dep_time : String?
	let airline_name : String?
	let flight_airline : String?
	let flight_no : String?
	let airport_name : String?
	let from_airport_code : String?
	let terminal : String?
	let expiry_date : String?

	enum CodingKeys: String, CodingKey {

		case dep_date = "dep_date"
		case dep_time = "dep_time"
		case airline_name = "airline_name"
		case flight_airline = "flight_airline"
		case flight_no = "flight_no"
		case airport_name = "airport_name"
		case from_airport_code = "from_airport_code"
		case terminal = "terminal"
		case expiry_date = "expiry_date"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		dep_date = try values.decodeIfPresent(String.self, forKey: .dep_date)
		dep_time = try values.decodeIfPresent(String.self, forKey: .dep_time)
		airline_name = try values.decodeIfPresent(String.self, forKey: .airline_name)
		flight_airline = try values.decodeIfPresent(String.self, forKey: .flight_airline)
		flight_no = try values.decodeIfPresent(String.self, forKey: .flight_no)
		airport_name = try values.decodeIfPresent(String.self, forKey: .airport_name)
		from_airport_code = try values.decodeIfPresent(String.self, forKey: .from_airport_code)
		terminal = try values.decodeIfPresent(String.self, forKey: .terminal)
		expiry_date = try values.decodeIfPresent(String.self, forKey: .expiry_date)
	}

}
