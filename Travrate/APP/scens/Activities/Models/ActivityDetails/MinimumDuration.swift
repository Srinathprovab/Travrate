

import Foundation
struct MinimumDuration : Codable {
	let value : Int?
	let metric : String?

	enum CodingKeys: String, CodingKey {

		case value = "value"
		case metric = "metric"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		value = try values.decodeIfPresent(Int.self, forKey: .value)
		metric = try values.decodeIfPresent(String.self, forKey: .metric)
	}

}
