/* 
Copyright (c) 2024 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Additional_services : Codable {
	let id : Int?
	let additional_service_id : Int?
	let price : Double?
	let name : String?
	let uid : String?
	let slug : String?
	let default_include : Bool?
	let currency : String?
	let category : String?
	let type : String?
	let service_provider_id : Int?
	let is_special : Bool?
	let price_rub : Int?
	let alternative_price : Double?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case additional_service_id = "additional_service_id"
		case price = "price"
		case name = "name"
		case uid = "uid"
		case slug = "slug"
		case default_include = "default_include"
		case currency = "currency"
		case category = "category"
		case type = "type"
		case service_provider_id = "service_provider_id"
		case is_special = "is_special"
		case price_rub = "price_rub"
		case alternative_price = "alternative_price"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		additional_service_id = try values.decodeIfPresent(Int.self, forKey: .additional_service_id)
		price = try values.decodeIfPresent(Double.self, forKey: .price)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		uid = try values.decodeIfPresent(String.self, forKey: .uid)
		slug = try values.decodeIfPresent(String.self, forKey: .slug)
		default_include = try values.decodeIfPresent(Bool.self, forKey: .default_include)
		currency = try values.decodeIfPresent(String.self, forKey: .currency)
		category = try values.decodeIfPresent(String.self, forKey: .category)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		service_provider_id = try values.decodeIfPresent(Int.self, forKey: .service_provider_id)
		is_special = try values.decodeIfPresent(Bool.self, forKey: .is_special)
		price_rub = try values.decodeIfPresent(Int.self, forKey: .price_rub)
		alternative_price = try values.decodeIfPresent(Double.self, forKey: .alternative_price)
	}

}