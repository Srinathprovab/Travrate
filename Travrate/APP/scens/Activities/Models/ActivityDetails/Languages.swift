
import Foundation
struct Languages : Codable {
	let description : String?
	let code : String?

	enum CodingKeys: String, CodingKey {

		case description = "description"
		case code = "code"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		code = try values.decodeIfPresent(String.self, forKey: .code)
	}

}
