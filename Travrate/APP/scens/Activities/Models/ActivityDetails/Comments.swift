
import Foundation
struct Comments : Codable {
	let type : String?
	let text : String?

	enum CodingKeys: String, CodingKey {

		case type = "type"
		case text = "text"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		text = try values.decodeIfPresent(String.self, forKey: .text)
	}

}
