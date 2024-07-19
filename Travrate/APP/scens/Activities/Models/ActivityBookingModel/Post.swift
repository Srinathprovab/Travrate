

import Foundation
struct Post : Codable {
	let token : String?
	let booking_source : String?
	let app_reference : String?
	let resultToken : String?
	let rateKey : String?
	let activity_selecteddate : String?

	enum CodingKeys: String, CodingKey {

		case token = "token"
		case booking_source = "booking_source"
		case app_reference = "app_reference"
		case resultToken = "resultToken"
		case rateKey = "rateKey"
		case activity_selecteddate = "activity_selecteddate"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		token = try values.decodeIfPresent(String.self, forKey: .token)
		booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
		app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
		resultToken = try values.decodeIfPresent(String.self, forKey: .resultToken)
		rateKey = try values.decodeIfPresent(String.self, forKey: .rateKey)
		activity_selecteddate = try values.decodeIfPresent(String.self, forKey: .activity_selecteddate)
	}

}
