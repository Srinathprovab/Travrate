

import Foundation
struct Home_sliders : Codable {
	let module : String?
	let image : String?
	let text : String?

	enum CodingKeys: String, CodingKey {

		case module = "module"
		case image = "image"
		case text = "text"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		module = try values.decodeIfPresent(String.self, forKey: .module)
		image = try values.decodeIfPresent(String.self, forKey: .image)
		text = try values.decodeIfPresent(String.self, forKey: .text)
	}

}
