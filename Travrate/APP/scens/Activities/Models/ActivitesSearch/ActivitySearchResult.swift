

import Foundation
struct ActivitySearchResult : Codable {
	let activity : [Activity]?

	enum CodingKeys: String, CodingKey {

		case activity = "activity"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		activity = try values.decodeIfPresent([Activity].self, forKey: .activity)
	}

}
