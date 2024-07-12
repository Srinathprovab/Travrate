

import Foundation
struct Location_info : Codable {
	let location_name : String?
	let location_id : String?
	let address_1 : String?
	let address_2 : String?
	let address_3 : String?
	let address_city : String?
	let address_county : String?
	let address_postcode : String?
	let country_id : String?
	let telephone : String?
	let fax : String?
	let email : String?
	let extra : String?
	let localinfo : String?
//	let opening_hours : Opening_hours?

	enum CodingKeys: String, CodingKey {

		case location_name = "location_name"
		case location_id = "location_id"
		case address_1 = "address_1"
		case address_2 = "address_2"
		case address_3 = "address_3"
		case address_city = "address_city"
		case address_county = "address_county"
		case address_postcode = "address_postcode"
		case country_id = "country_id"
		case telephone = "telephone"
		case fax = "fax"
		case email = "email"
		case extra = "extra"
		case localinfo = "localinfo"
	//	case opening_hours = "opening_hours"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		location_name = try values.decodeIfPresent(String.self, forKey: .location_name)
		location_id = try values.decodeIfPresent(String.self, forKey: .location_id)
		address_1 = try values.decodeIfPresent(String.self, forKey: .address_1)
		address_2 = try values.decodeIfPresent(String.self, forKey: .address_2)
		address_3 = try values.decodeIfPresent(String.self, forKey: .address_3)
		address_city = try values.decodeIfPresent(String.self, forKey: .address_city)
		address_county = try values.decodeIfPresent(String.self, forKey: .address_county)
		address_postcode = try values.decodeIfPresent(String.self, forKey: .address_postcode)
		country_id = try values.decodeIfPresent(String.self, forKey: .country_id)
		telephone = try values.decodeIfPresent(String.self, forKey: .telephone)
		fax = try values.decodeIfPresent(String.self, forKey: .fax)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		extra = try values.decodeIfPresent(String.self, forKey: .extra)
		localinfo = try values.decodeIfPresent(String.self, forKey: .localinfo)
	//	opening_hours = try values.decodeIfPresent(Opening_hours.self, forKey: .opening_hours)
	}

}
