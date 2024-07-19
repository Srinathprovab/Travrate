

import Foundation
struct Cancelpolicy : Codable {
	let date : String?
	let data_text : String?

	enum CodingKeys: String, CodingKey {

		case date = "date"
		case data_text = "data_text"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		date = try values.decodeIfPresent(String.self, forKey: .date)
		data_text = try values.decodeIfPresent(String.self, forKey: .data_text)
	}

}
