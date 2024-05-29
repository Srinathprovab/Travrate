

import Foundation
struct SplittedCategoryName : Codable {
	let main : String?
	let secondary : String?
	let packageDetails : String?

	enum CodingKeys: String, CodingKey {

		case main = "main"
		case secondary = "secondary"
		case packageDetails = "packageDetails"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		main = try values.decodeIfPresent(String.self, forKey: .main)
		secondary = try values.decodeIfPresent(String.self, forKey: .secondary)
		packageDetails = try values.decodeIfPresent(String.self, forKey: .packageDetails)
	}

}
