

import Foundation
struct Car_passengers : Codable {
	let origin : String?
	let app_reference : String?
	let booking_source : String?
	let status : String?
	let booking_id : String?
	let title : String?
	let first_name : String?
	let last_name : String?
	let phone_code : String?
	let phone : String?
	let email : String?
	let address : String?
	let country : String?
	let city : String?
	let postalcode : String?
	let creation_date : String?

	enum CodingKeys: String, CodingKey {

		case origin = "origin"
		case app_reference = "app_reference"
		case booking_source = "booking_source"
		case status = "status"
		case booking_id = "booking_id"
		case title = "title"
		case first_name = "first_name"
		case last_name = "last_name"
		case phone_code = "phone_code"
		case phone = "phone"
		case email = "email"
		case address = "address"
		case country = "country"
		case city = "city"
		case postalcode = "postalcode"
		case creation_date = "creation_date"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		origin = try values.decodeIfPresent(String.self, forKey: .origin)
		app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
		booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		booking_id = try values.decodeIfPresent(String.self, forKey: .booking_id)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
		last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
		phone_code = try values.decodeIfPresent(String.self, forKey: .phone_code)
		phone = try values.decodeIfPresent(String.self, forKey: .phone)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		country = try values.decodeIfPresent(String.self, forKey: .country)
		city = try values.decodeIfPresent(String.self, forKey: .city)
		postalcode = try values.decodeIfPresent(String.self, forKey: .postalcode)
		creation_date = try values.decodeIfPresent(String.self, forKey: .creation_date)
	}

}
