

import Foundation
struct Content : Codable {
	let contentId : String?
	let description : String?

	enum CodingKeys: String, CodingKey {

		case contentId = "contentId"
		case description = "description"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		contentId = try values.decodeIfPresent(String.self, forKey: .contentId)
		description = try values.decodeIfPresent(String.self, forKey: .description)
	}

}
