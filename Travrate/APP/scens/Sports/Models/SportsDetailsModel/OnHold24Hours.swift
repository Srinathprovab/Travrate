

import Foundation
struct OnHold24Hours : Codable {
	let status : Bool?
	let publicMessage : String?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case publicMessage = "publicMessage"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(Bool.self, forKey: .status)
		publicMessage = try values.decodeIfPresent(String.self, forKey: .publicMessage)
	}

}
