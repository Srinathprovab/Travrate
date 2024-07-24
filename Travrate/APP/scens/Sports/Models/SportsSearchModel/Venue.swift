

import Foundation
struct Venue : Codable {
	let id : Int?
	let name : String?
	let mapUrl : String?
	let address : String?
//	let latitude : Double?
//	let longitude : Double?
	let name_ar : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
		case mapUrl = "mapUrl"
		case address = "address"
//		case latitude = "latitude"
//		case longitude = "longitude"
		case name_ar = "name_ar"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		mapUrl = try values.decodeIfPresent(String.self, forKey: .mapUrl)
		address = try values.decodeIfPresent(String.self, forKey: .address)
//		latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
//		longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
		name_ar = try values.decodeIfPresent(String.self, forKey: .name_ar)
	}

}
