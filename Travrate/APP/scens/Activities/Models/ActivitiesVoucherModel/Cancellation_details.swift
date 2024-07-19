

import Foundation
struct Cancellation_details : Codable {
	let origin : String?
	let booking_reference : String?
	let app_reference : String?
	let cancel_dateFrom : String?
	let cancel_amount : String?

	enum CodingKeys: String, CodingKey {

		case origin = "origin"
		case booking_reference = "booking_reference"
		case app_reference = "app_reference"
		case cancel_dateFrom = "cancel_dateFrom"
		case cancel_amount = "cancel_amount"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		origin = try values.decodeIfPresent(String.self, forKey: .origin)
		booking_reference = try values.decodeIfPresent(String.self, forKey: .booking_reference)
		app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
		cancel_dateFrom = try values.decodeIfPresent(String.self, forKey: .cancel_dateFrom)
		cancel_amount = try values.decodeIfPresent(String.self, forKey: .cancel_amount)
	}

}
