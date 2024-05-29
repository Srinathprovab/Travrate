

import Foundation
struct DeliveryMethods : Codable {
	let id : Int?
	let name : String?
	let description : String?
	let price : Int?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
		case description = "description"
		case price = "price"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		price = try values.decodeIfPresent(Int.self, forKey: .price)
	}

}
