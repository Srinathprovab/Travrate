

import Foundation
struct Search_data : Codable {
	let from : String?
	let destination_id : String?
	let from_type : String?
	let to : String?
	let event_id : String?
	let venue_type : String?
	let form_date : String?
	let to_date : String?
	let special_events_id : String?

	enum CodingKeys: String, CodingKey {

		case from = "from"
		case destination_id = "destination_id"
		case from_type = "from_type"
		case to = "to"
		case event_id = "event_id"
		case venue_type = "venue_type"
		case form_date = "form_date"
		case to_date = "to_date"
		case special_events_id = "special_events_id"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		from = try values.decodeIfPresent(String.self, forKey: .from)
		destination_id = try values.decodeIfPresent(String.self, forKey: .destination_id)
		from_type = try values.decodeIfPresent(String.self, forKey: .from_type)
		to = try values.decodeIfPresent(String.self, forKey: .to)
		event_id = try values.decodeIfPresent(String.self, forKey: .event_id)
		venue_type = try values.decodeIfPresent(String.self, forKey: .venue_type)
		form_date = try values.decodeIfPresent(String.self, forKey: .form_date)
		to_date = try values.decodeIfPresent(String.self, forKey: .to_date)
		special_events_id = try values.decodeIfPresent(String.self, forKey: .special_events_id)
	}

}
