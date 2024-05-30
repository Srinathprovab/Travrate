

import Foundation
struct Seating_arrangement : Codable {
	let title : String?
	let desc : String?

	enum CodingKeys: String, CodingKey {

		case title = "title"
		case desc = "desc"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		desc = try values.decodeIfPresent(String.self, forKey: .desc)
	}

}
