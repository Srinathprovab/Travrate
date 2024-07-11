
import Foundation
struct Post_data : Codable {
	let product_code : String?
	let result_token : String?
	let result_index : String?

	enum CodingKeys: String, CodingKey {

		case product_code = "product_code"
		case result_token = "result_token"
		case result_index = "result_index"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		product_code = try values.decodeIfPresent(String.self, forKey: .product_code)
		result_token = try values.decodeIfPresent(String.self, forKey: .result_token)
		result_index = try values.decodeIfPresent(String.self, forKey: .result_index)
	}

}
