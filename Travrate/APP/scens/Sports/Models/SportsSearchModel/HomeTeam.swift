
import Foundation
struct HomeTeam : Codable {
	let id : Int?
	let name : String?
	let name_ar : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
		case name_ar = "name_ar"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		name_ar = try values.decodeIfPresent(String.self, forKey: .name_ar)
	}

}
