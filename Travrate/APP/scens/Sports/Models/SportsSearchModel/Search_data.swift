/* 
Copyright (c) 2024 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Search_data : Codable {
	let from : String?
	let destination_id : String?
	let from_type : String?
	let to : String?
	let event_id : String?
	let venue_type : String?
	let form_date : String?
	let to_date : String?
	let special_events_id : String?

	enum CodingKeys: String, CodingKey {

		case from = "from"
		case destination_id = "destination_id"
		case from_type = "from_type"
		case to = "to"
		case event_id = "event_id"
		case venue_type = "venue_type"
		case form_date = "form_date"
		case to_date = "to_date"
		case special_events_id = "special_events_id"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		from = try values.decodeIfPresent(String.self, forKey: .from)
		destination_id = try values.decodeIfPresent(String.self, forKey: .destination_id)
		from_type = try values.decodeIfPresent(String.self, forKey: .from_type)
		to = try values.decodeIfPresent(String.self, forKey: .to)
		event_id = try values.decodeIfPresent(String.self, forKey: .event_id)
		venue_type = try values.decodeIfPresent(String.self, forKey: .venue_type)
		form_date = try values.decodeIfPresent(String.self, forKey: .form_date)
		to_date = try values.decodeIfPresent(String.self, forKey: .to_date)
		special_events_id = try values.decodeIfPresent(String.self, forKey: .special_events_id)
	}

}