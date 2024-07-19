

import Foundation
struct PaxAmounts : Codable {
	let amount : String?
	let ageTo : Int?
	let paxType : String?
	let ageFrom : Int?
	let boxOfficeAmount : String?
	let mandatoryApplyAmount : Bool?

	enum CodingKeys: String, CodingKey {

		case amount = "amount"
		case ageTo = "ageTo"
		case paxType = "paxType"
		case ageFrom = "ageFrom"
		case boxOfficeAmount = "boxOfficeAmount"
		case mandatoryApplyAmount = "mandatoryApplyAmount"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		amount = try values.decodeIfPresent(String.self, forKey: .amount)
		ageTo = try values.decodeIfPresent(Int.self, forKey: .ageTo)
		paxType = try values.decodeIfPresent(String.self, forKey: .paxType)
		ageFrom = try values.decodeIfPresent(Int.self, forKey: .ageFrom)
		boxOfficeAmount = try values.decodeIfPresent(String.self, forKey: .boxOfficeAmount)
		mandatoryApplyAmount = try values.decodeIfPresent(Bool.self, forKey: .mandatoryApplyAmount)
	}

}
