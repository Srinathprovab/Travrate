

import Foundation
struct Bg_condition : Codable {
	let id : String?
	let name : String?
	let module : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
		case module = "module"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		module = try values.decodeIfPresent(String.self, forKey: .module)
	}

}
