

import Foundation
struct Questions : Codable {
	let required : Bool?
	let text : String?
	let code : String?

	enum CodingKeys: String, CodingKey {

		case required = "required"
		case text = "text"
		case code = "code"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		required = try values.decodeIfPresent(Bool.self, forKey: .required)
		text = try values.decodeIfPresent(String.self, forKey: .text)
		code = try values.decodeIfPresent(String.self, forKey: .code)
	}

}
