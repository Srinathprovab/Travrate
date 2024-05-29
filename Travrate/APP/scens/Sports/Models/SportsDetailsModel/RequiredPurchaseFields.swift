

import Foundation
struct RequiredPurchaseFields : Codable {
	let fullName : Bool?
	let birthDate : Bool?
	let nationalityCountryId : Bool?
	let passportNumber : Bool?
	let cityOfBirth : Bool?

	enum CodingKeys: String, CodingKey {

		case fullName = "fullName"
		case birthDate = "birthDate"
		case nationalityCountryId = "nationalityCountryId"
		case passportNumber = "passportNumber"
		case cityOfBirth = "cityOfBirth"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		fullName = try values.decodeIfPresent(Bool.self, forKey: .fullName)
		birthDate = try values.decodeIfPresent(Bool.self, forKey: .birthDate)
		nationalityCountryId = try values.decodeIfPresent(Bool.self, forKey: .nationalityCountryId)
		passportNumber = try values.decodeIfPresent(Bool.self, forKey: .passportNumber)
		cityOfBirth = try values.decodeIfPresent(Bool.self, forKey: .cityOfBirth)
	}

}
