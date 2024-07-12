

import Foundation
struct Cust_info : Codable {
	let name : String?
	let telephone : String?
	let mobile : String?
	let email : String?
	let address1 : String?
	let address2 : String?
	let address3 : String?
	let city : String?
	let county : String?
	let postcode : String?
	let country : String?

	enum CodingKeys: String, CodingKey {

		case name = "name"
		case telephone = "telephone"
		case mobile = "mobile"
		case email = "email"
		case address1 = "address1"
		case address2 = "address2"
		case address3 = "address3"
		case city = "city"
		case county = "county"
		case postcode = "postcode"
		case country = "country"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		telephone = try values.decodeIfPresent(String.self, forKey: .telephone)
		mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		address1 = try values.decodeIfPresent(String.self, forKey: .address1)
		address2 = try values.decodeIfPresent(String.self, forKey: .address2)
		address3 = try values.decodeIfPresent(String.self, forKey: .address3)
		city = try values.decodeIfPresent(String.self, forKey: .city)
		county = try values.decodeIfPresent(String.self, forKey: .county)
		postcode = try values.decodeIfPresent(String.self, forKey: .postcode)
		country = try values.decodeIfPresent(String.self, forKey: .country)
	}

}
