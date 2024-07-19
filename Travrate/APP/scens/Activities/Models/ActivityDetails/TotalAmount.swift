
import Foundation
struct TotalAmount : Codable {
	let markup_addedamt : Int?
	let amount : Int?
	let mandatoryApplyAmount : Bool?
	let xMLPrice : Int?
	let service_tax : String?
	let actual_netrate : String?
	let boxOfficeAmount : String?
	let agent_markup : Int?
	let actual_boxOfficeAmount : Double?
	let admin_markup : Int?
	let agent_payable : Double?
	let agentServiceTax : Int?
	let currency : String?

	enum CodingKeys: String, CodingKey {

		case markup_addedamt = "markup_addedamt"
		case amount = "amount"
		case mandatoryApplyAmount = "mandatoryApplyAmount"
		case xMLPrice = "XMLPrice"
		case service_tax = "service_tax"
		case actual_netrate = "actual_netrate"
		case boxOfficeAmount = "boxOfficeAmount"
		case agent_markup = "agent_markup"
		case actual_boxOfficeAmount = "actual_boxOfficeAmount"
		case admin_markup = "admin_markup"
		case agent_payable = "agent_payable"
		case agentServiceTax = "AgentServiceTax"
		case currency = "currency"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		markup_addedamt = try values.decodeIfPresent(Int.self, forKey: .markup_addedamt)
		amount = try values.decodeIfPresent(Int.self, forKey: .amount)
		mandatoryApplyAmount = try values.decodeIfPresent(Bool.self, forKey: .mandatoryApplyAmount)
		xMLPrice = try values.decodeIfPresent(Int.self, forKey: .xMLPrice)
		service_tax = try values.decodeIfPresent(String.self, forKey: .service_tax)
		actual_netrate = try values.decodeIfPresent(String.self, forKey: .actual_netrate)
		boxOfficeAmount = try values.decodeIfPresent(String.self, forKey: .boxOfficeAmount)
		agent_markup = try values.decodeIfPresent(Int.self, forKey: .agent_markup)
		actual_boxOfficeAmount = try values.decodeIfPresent(Double.self, forKey: .actual_boxOfficeAmount)
		admin_markup = try values.decodeIfPresent(Int.self, forKey: .admin_markup)
		agent_payable = try values.decodeIfPresent(Double.self, forKey: .agent_payable)
		agentServiceTax = try values.decodeIfPresent(Int.self, forKey: .agentServiceTax)
		currency = try values.decodeIfPresent(String.self, forKey: .currency)
	}

}
