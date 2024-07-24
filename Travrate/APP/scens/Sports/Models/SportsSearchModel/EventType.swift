

import Foundation
struct EventType : Codable {
	let id : Int?
	let name : String?
	let isTeamSport : Int?
	let concert : Int?
	let name_ar : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
		case isTeamSport = "isTeamSport"
		case concert = "concert"
		case name_ar = "name_ar"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		isTeamSport = try values.decodeIfPresent(Int.self, forKey: .isTeamSport)
		concert = try values.decodeIfPresent(Int.self, forKey: .concert)
		name_ar = try values.decodeIfPresent(String.self, forKey: .name_ar)
	}

}
