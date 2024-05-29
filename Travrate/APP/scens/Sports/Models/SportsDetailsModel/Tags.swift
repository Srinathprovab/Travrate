

import Foundation
struct Tags : Codable {
	let non_plastic : Bool?

	enum CodingKeys: String, CodingKey {

		case non_plastic = "non_plastic"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		non_plastic = try values.decodeIfPresent(Bool.self, forKey: .non_plastic)
	}

}
