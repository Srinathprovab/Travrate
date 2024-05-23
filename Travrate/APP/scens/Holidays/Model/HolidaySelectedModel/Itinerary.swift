
import Foundation
struct Itinerary : Codable {
	let title : String?
	let desc : String?
	let image : String?

	enum CodingKeys: String, CodingKey {

		case title = "title"
		case desc = "desc"
		case image = "image"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		desc = try values.decodeIfPresent(String.self, forKey: .desc)
		image = try values.decodeIfPresent(String.self, forKey: .image)
	}

}
