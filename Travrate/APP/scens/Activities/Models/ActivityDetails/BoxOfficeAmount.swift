

import Foundation
struct BoxOfficeAmount : Codable {
	let default_currency : String?
	let default_value : Double?

	enum CodingKeys: String, CodingKey {

		case default_currency = "default_currency"
		case default_value = "default_value"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		default_currency = try values.decodeIfPresent(String.self, forKey: .default_currency)
		default_value = try values.decodeIfPresent(Double.self, forKey: .default_value)
	}

}
