

import Foundation
struct Activity_search_params : Codable {
	let from_date : String?
	let to_date : String?
	let activity_destination : String?
	let activity_destination_id : String?
	let adult : String?
	let child : String?
	let infant : String?
	let location : String?
	let city_name : String?
	let country_name : String?
	let search_id : Int?

	enum CodingKeys: String, CodingKey {

		case from_date = "from_date"
		case to_date = "to_date"
		case activity_destination = "activity_destination"
		case activity_destination_id = "activity_destination_id"
		case adult = "adult"
		case child = "child"
		case infant = "infant"
		case location = "location"
		case city_name = "city_name"
		case country_name = "country_name"
		case search_id = "search_id"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		from_date = try values.decodeIfPresent(String.self, forKey: .from_date)
		to_date = try values.decodeIfPresent(String.self, forKey: .to_date)
		activity_destination = try values.decodeIfPresent(String.self, forKey: .activity_destination)
		activity_destination_id = try values.decodeIfPresent(String.self, forKey: .activity_destination_id)
		adult = try values.decodeIfPresent(String.self, forKey: .adult)
		child = try values.decodeIfPresent(String.self, forKey: .child)
		infant = try values.decodeIfPresent(String.self, forKey: .infant)
		location = try values.decodeIfPresent(String.self, forKey: .location)
		city_name = try values.decodeIfPresent(String.self, forKey: .city_name)
		country_name = try values.decodeIfPresent(String.self, forKey: .country_name)
		search_id = try values.decodeIfPresent(Int.self, forKey: .search_id)
	}

}
