

import Foundation
struct OperationDates : Codable {
	let to : String?
	let cancellationPolicies : [CancellationPolicies]?
	let from : String?

	enum CodingKeys: String, CodingKey {

		case to = "to"
		case cancellationPolicies = "cancellationPolicies"
		case from = "from"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		to = try values.decodeIfPresent(String.self, forKey: .to)
		cancellationPolicies = try values.decodeIfPresent([CancellationPolicies].self, forKey: .cancellationPolicies)
		from = try values.decodeIfPresent(String.self, forKey: .from)
	}

}
