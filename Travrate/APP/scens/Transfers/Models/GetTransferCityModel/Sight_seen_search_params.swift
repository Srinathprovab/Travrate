
import Foundation
struct Sight_seen_search_params : Codable {
	let from_date : String?
	let from_time : String?
	let to_date : String?
	let to_time : String?
	let from_loc_id : String?
	let from_lat : String?
	let from_lng : String?
	let to_loc_id : String?
	let to_lat : String?
	let to_lng : String?
	let arrival : String?
	let destination : String?
	let trip_type : String?
	let adult : String?
	let child : String?
	let infant : String?
	let from_zone : String?
	let from_transfer_type : String?
	let to_zone : String?
	let to_transfer_type : String?
	let adult_ages : String?
	let category_id : Int?
	let search_id : Int?

	enum CodingKeys: String, CodingKey {

		case from_date = "from_date"
		case from_time = "from_time"
		case to_date = "to_date"
		case to_time = "to_time"
		case from_loc_id = "from_loc_id"
		case from_lat = "from_lat"
		case from_lng = "from_lng"
		case to_loc_id = "to_loc_id"
		case to_lat = "to_lat"
		case to_lng = "to_lng"
		case arrival = "arrival"
		case destination = "destination"
		case trip_type = "trip_type"
		case adult = "adult"
		case child = "child"
		case infant = "infant"
		case from_zone = "from_zone"
		case from_transfer_type = "from_transfer_type"
		case to_zone = "to_zone"
		case to_transfer_type = "to_transfer_type"
		case adult_ages = "adult_ages"
		case category_id = "category_id"
		case search_id = "search_id"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		from_date = try values.decodeIfPresent(String.self, forKey: .from_date)
		from_time = try values.decodeIfPresent(String.self, forKey: .from_time)
		to_date = try values.decodeIfPresent(String.self, forKey: .to_date)
		to_time = try values.decodeIfPresent(String.self, forKey: .to_time)
		from_loc_id = try values.decodeIfPresent(String.self, forKey: .from_loc_id)
		from_lat = try values.decodeIfPresent(String.self, forKey: .from_lat)
		from_lng = try values.decodeIfPresent(String.self, forKey: .from_lng)
		to_loc_id = try values.decodeIfPresent(String.self, forKey: .to_loc_id)
		to_lat = try values.decodeIfPresent(String.self, forKey: .to_lat)
		to_lng = try values.decodeIfPresent(String.self, forKey: .to_lng)
		arrival = try values.decodeIfPresent(String.self, forKey: .arrival)
		destination = try values.decodeIfPresent(String.self, forKey: .destination)
		trip_type = try values.decodeIfPresent(String.self, forKey: .trip_type)
		adult = try values.decodeIfPresent(String.self, forKey: .adult)
		child = try values.decodeIfPresent(String.self, forKey: .child)
		infant = try values.decodeIfPresent(String.self, forKey: .infant)
		from_zone = try values.decodeIfPresent(String.self, forKey: .from_zone)
		from_transfer_type = try values.decodeIfPresent(String.self, forKey: .from_transfer_type)
		to_zone = try values.decodeIfPresent(String.self, forKey: .to_zone)
		to_transfer_type = try values.decodeIfPresent(String.self, forKey: .to_transfer_type)
		adult_ages = try values.decodeIfPresent(String.self, forKey: .adult_ages)
		category_id = try values.decodeIfPresent(Int.self, forKey: .category_id)
		search_id = try values.decodeIfPresent(Int.self, forKey: .search_id)
	}

}
