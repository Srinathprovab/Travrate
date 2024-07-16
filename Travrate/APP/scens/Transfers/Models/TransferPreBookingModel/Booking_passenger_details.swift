

import Foundation
struct Booking_passenger_details : Codable {
	let id : String?
	let app_reference : String?
	let passport_issuing_country : String?
	let lastname : String?
	let dob : String?
	let created_at : String?
	let phone_no : String?
	let firstname : String?
	let booking_id : String?
	let title : String?
	let passport_number : String?
	let passport_expiry : String?
	let phone_code : String?
	let updated_at : String?
	let email : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case app_reference = "app_reference"
		case passport_issuing_country = "passport_issuing_country"
		case lastname = "lastname"
		case dob = "dob"
		case created_at = "created_at"
		case phone_no = "phone_no"
		case firstname = "firstname"
		case booking_id = "booking_id"
		case title = "title"
		case passport_number = "passport_number"
		case passport_expiry = "passport_expiry"
		case phone_code = "phone_code"
		case updated_at = "updated_at"
		case email = "email"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
		passport_issuing_country = try values.decodeIfPresent(String.self, forKey: .passport_issuing_country)
		lastname = try values.decodeIfPresent(String.self, forKey: .lastname)
		dob = try values.decodeIfPresent(String.self, forKey: .dob)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		phone_no = try values.decodeIfPresent(String.self, forKey: .phone_no)
		firstname = try values.decodeIfPresent(String.self, forKey: .firstname)
		booking_id = try values.decodeIfPresent(String.self, forKey: .booking_id)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		passport_number = try values.decodeIfPresent(String.self, forKey: .passport_number)
		passport_expiry = try values.decodeIfPresent(String.self, forKey: .passport_expiry)
		phone_code = try values.decodeIfPresent(String.self, forKey: .phone_code)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
		email = try values.decodeIfPresent(String.self, forKey: .email)
	}

}
