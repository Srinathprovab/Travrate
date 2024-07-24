

import Foundation
struct Tournament : Codable {
	let id : Int?
	let name : String?
	let isGroupEvent : Bool?
	let name_ar : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
		case isGroupEvent = "isGroupEvent"
		case name_ar = "name_ar"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		isGroupEvent = try values.decodeIfPresent(Bool.self, forKey: .isGroupEvent)
		name_ar = try values.decodeIfPresent(String.self, forKey: .name_ar)
	}

}
