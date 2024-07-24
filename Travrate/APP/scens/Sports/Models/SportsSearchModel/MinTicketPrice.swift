

import Foundation
struct MinTicketPrice : Codable {
	let price : Int?
	let currency : String?

	enum CodingKeys: String, CodingKey {

		case price = "price"
		case currency = "currency"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		price = try values.decodeIfPresent(Int.self, forKey: .price)
		currency = try values.decodeIfPresent(String.self, forKey: .currency)
	}

}
