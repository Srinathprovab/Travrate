

import Foundation
struct Contract : Codable {
	let code : Int?
	let name : String?
	let incomingOffice : Int?

	enum CodingKeys: String, CodingKey {

		case code = "code"
		case name = "name"
		case incomingOffice = "incomingOffice"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		code = try values.decodeIfPresent(Int.self, forKey: .code)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		incomingOffice = try values.decodeIfPresent(Int.self, forKey: .incomingOffice)
	}

}
