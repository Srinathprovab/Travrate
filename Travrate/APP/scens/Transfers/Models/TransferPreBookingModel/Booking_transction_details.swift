/* 
Copyright (c) 2024 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Booking_transction_details : Codable {
	let id : String?
	let app_reference : String?
	let base_fare : String?
	let discount_amt : String?
	let tax_amt : String?
	let total_amt : String?
	let additional_service_amt : String?
	let payment_type : String?
	let payment_invoice_id : String?
	let created_at : String?
	let agent_markup : String?
	let booking_id : String?
	let payment_status : String?
	let payment_mode : String?
	let updated_at : String?
	let admin_markup : String?
	let payment_invoice_ref : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case app_reference = "app_reference"
		case base_fare = "base_fare"
		case discount_amt = "discount_amt"
		case tax_amt = "tax_amt"
		case total_amt = "total_amt"
		case additional_service_amt = "additional_service_amt"
		case payment_type = "payment_type"
		case payment_invoice_id = "payment_invoice_id"
		case created_at = "created_at"
		case agent_markup = "agent_markup"
		case booking_id = "booking_id"
		case payment_status = "payment_status"
		case payment_mode = "payment_mode"
		case updated_at = "updated_at"
		case admin_markup = "admin_markup"
		case payment_invoice_ref = "payment_invoice_ref"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
		base_fare = try values.decodeIfPresent(String.self, forKey: .base_fare)
		discount_amt = try values.decodeIfPresent(String.self, forKey: .discount_amt)
		tax_amt = try values.decodeIfPresent(String.self, forKey: .tax_amt)
		total_amt = try values.decodeIfPresent(String.self, forKey: .total_amt)
		additional_service_amt = try values.decodeIfPresent(String.self, forKey: .additional_service_amt)
		payment_type = try values.decodeIfPresent(String.self, forKey: .payment_type)
		payment_invoice_id = try values.decodeIfPresent(String.self, forKey: .payment_invoice_id)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		agent_markup = try values.decodeIfPresent(String.self, forKey: .agent_markup)
		booking_id = try values.decodeIfPresent(String.self, forKey: .booking_id)
		payment_status = try values.decodeIfPresent(String.self, forKey: .payment_status)
		payment_mode = try values.decodeIfPresent(String.self, forKey: .payment_mode)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
		admin_markup = try values.decodeIfPresent(String.self, forKey: .admin_markup)
		payment_invoice_ref = try values.decodeIfPresent(String.self, forKey: .payment_invoice_ref)
	}

}