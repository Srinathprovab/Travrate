

import Foundation
struct ProviderInformation : Codable {
	let name : String?

	enum CodingKeys: String, CodingKey {

		case name = "name"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		name = try values.decodeIfPresent(String.self, forKey: .name)
	}

}
