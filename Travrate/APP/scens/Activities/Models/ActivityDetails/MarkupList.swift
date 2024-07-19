

import Foundation
struct MarkupList : Codable {
	let adminMarkup : Int?
	let agentServiceTax : Int?
	let xMLPrice : Int?
	let serviceTax : String?
	let agentMarkup : Int?

	enum CodingKeys: String, CodingKey {

		case adminMarkup = "AdminMarkup"
		case agentServiceTax = "AgentServiceTax"
		case xMLPrice = "XMLPrice"
		case serviceTax = "ServiceTax"
		case agentMarkup = "AgentMarkup"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		adminMarkup = try values.decodeIfPresent(Int.self, forKey: .adminMarkup)
		agentServiceTax = try values.decodeIfPresent(Int.self, forKey: .agentServiceTax)
		xMLPrice = try values.decodeIfPresent(Int.self, forKey: .xMLPrice)
		serviceTax = try values.decodeIfPresent(String.self, forKey: .serviceTax)
		agentMarkup = try values.decodeIfPresent(Int.self, forKey: .agentMarkup)
	}

}
