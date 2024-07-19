

import Foundation
struct AgencyCommission : Codable {
	let amount : Int?
	let vatAmount : Int?
	let percentage : Int?
	let vatPercentage : Int?

	enum CodingKeys: String, CodingKey {

		case amount = "amount"
		case vatAmount = "vatAmount"
		case percentage = "percentage"
		case vatPercentage = "vatPercentage"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		amount = try values.decodeIfPresent(Int.self, forKey: .amount)
		vatAmount = try values.decodeIfPresent(Int.self, forKey: .vatAmount)
		percentage = try values.decodeIfPresent(Int.self, forKey: .percentage)
		vatPercentage = try values.decodeIfPresent(Int.self, forKey: .vatPercentage)
	}

}
