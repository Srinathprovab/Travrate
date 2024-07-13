/* 
Copyright (c) 2024 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Car_detail : Codable {
	let title : String?
	let models : [String]?
	let image : String?
	let passenger_capacity : Int?
	let luggage_capacity : Int?

	enum CodingKeys: String, CodingKey {

		case title = "title"
		case models = "models"
		case image = "image"
		case passenger_capacity = "passenger_capacity"
		case luggage_capacity = "luggage_capacity"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		models = try values.decodeIfPresent([String].self, forKey: .models)
		image = try values.decodeIfPresent(String.self, forKey: .image)
		passenger_capacity = try values.decodeIfPresent(Int.self, forKey: .passenger_capacity)
		luggage_capacity = try values.decodeIfPresent(Int.self, forKey: .luggage_capacity)
	}

}