

import Foundation
struct SupplierInformation : Codable {
	let name : String?
	let vatNumber : String?

	enum CodingKeys: String, CodingKey {

		case name = "name"
		case vatNumber = "vatNumber"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		vatNumber = try values.decodeIfPresent(String.self, forKey: .vatNumber)
	}

}
