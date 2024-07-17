

import Foundation
struct Location : Codable {
	let description : String?
	let address : String?

	enum CodingKeys: String, CodingKey {

		case description = "description"
		case address = "address"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		address = try values.decodeIfPresent(String.self, forKey: .address)
	}

}
