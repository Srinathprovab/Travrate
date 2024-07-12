

import Foundation
struct Api_response_data : Codable {
	let quoteid : String?
	let payment_ref : String?
	let start_date : String?
	let start_time : String?
	let end_date : String?
	let end_time : String?
	let vehicle_name : String?
	let vehicle_id : String?
	let grand_total : String?
	let deposit_paid : String?
	let currency : String?
	let options : String?
	let rentalCode : String?
	let grand_total_including_options : String?
	let location_info : Location_info?
	let cust_info : Cust_info?
	//let @attributes : @attributes?

	enum CodingKeys: String, CodingKey {

		case quoteid = "quoteid"
		case payment_ref = "payment_ref"
		case start_date = "start_date"
		case start_time = "start_time"
		case end_date = "end_date"
		case end_time = "end_time"
		case vehicle_name = "vehicle_name"
		case vehicle_id = "vehicle_id"
		case grand_total = "grand_total"
		case deposit_paid = "deposit_paid"
		case currency = "currency"
		case options = "options"
		case rentalCode = "rentalCode"
		case grand_total_including_options = "grand_total_including_options"
		case location_info = "location_info"
		case cust_info = "cust_info"
		//case @attributes = "@attributes"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		quoteid = try values.decodeIfPresent(String.self, forKey: .quoteid)
		payment_ref = try values.decodeIfPresent(String.self, forKey: .payment_ref)
		start_date = try values.decodeIfPresent(String.self, forKey: .start_date)
		start_time = try values.decodeIfPresent(String.self, forKey: .start_time)
		end_date = try values.decodeIfPresent(String.self, forKey: .end_date)
		end_time = try values.decodeIfPresent(String.self, forKey: .end_time)
		vehicle_name = try values.decodeIfPresent(String.self, forKey: .vehicle_name)
		vehicle_id = try values.decodeIfPresent(String.self, forKey: .vehicle_id)
		grand_total = try values.decodeIfPresent(String.self, forKey: .grand_total)
		deposit_paid = try values.decodeIfPresent(String.self, forKey: .deposit_paid)
		currency = try values.decodeIfPresent(String.self, forKey: .currency)
		options = try values.decodeIfPresent(String.self, forKey: .options)
		rentalCode = try values.decodeIfPresent(String.self, forKey: .rentalCode)
		grand_total_including_options = try values.decodeIfPresent(String.self, forKey: .grand_total_including_options)
		location_info = try values.decodeIfPresent(Location_info.self, forKey: .location_info)
		cust_info = try values.decodeIfPresent(Cust_info.self, forKey: .cust_info)
	//	@attributes = try values.decodeIfPresent(@attributes.self, forKey: .@attributes)
	}

}
