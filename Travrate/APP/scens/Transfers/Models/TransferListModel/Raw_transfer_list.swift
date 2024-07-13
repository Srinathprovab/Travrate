

import Foundation
struct Raw_transfer_list : Codable {
	let price_uid : String?
	let price_id : Int?
	let api_currency : String?
	let currency : String?
	let api_price : Double?
	let price : Double?
	let sys_price : Double?
	let reverse_price : Reverse_price?
	let car_detail : Car_detail?
	let cancellation_time : Int?
	let allowable_time : Int?
	let additional_services : [Additional_services]?
	let additional_services_revert : [Additional_services_revert]?
	let class_services : [Class_services]?
	let travel_time : Int?
	let start_place : Start_place?
	let finish_place : Finish_place?
	let final_price : Double?
	let final_api_price : Double?
	let final_sys_price : Double?
	let token : String?

	enum CodingKeys: String, CodingKey {

		case price_uid = "price_uid"
		case price_id = "price_id"
		case api_currency = "api_currency"
		case currency = "currency"
		case api_price = "api_price"
		case price = "price"
		case sys_price = "sys_price"
		case reverse_price = "reverse_price"
		case car_detail = "car_detail"
		case cancellation_time = "cancellation_time"
		case allowable_time = "allowable_time"
		case additional_services = "additional_services"
		case additional_services_revert = "additional_services_revert"
		case class_services = "class_services"
		case travel_time = "travel_time"
		case start_place = "start_place"
		case finish_place = "finish_place"
		case final_price = "final_price"
		case final_api_price = "final_api_price"
		case final_sys_price = "final_sys_price"
		case token = "token"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		price_uid = try values.decodeIfPresent(String.self, forKey: .price_uid)
		price_id = try values.decodeIfPresent(Int.self, forKey: .price_id)
		api_currency = try values.decodeIfPresent(String.self, forKey: .api_currency)
		currency = try values.decodeIfPresent(String.self, forKey: .currency)
		api_price = try values.decodeIfPresent(Double.self, forKey: .api_price)
		price = try values.decodeIfPresent(Double.self, forKey: .price)
		sys_price = try values.decodeIfPresent(Double.self, forKey: .sys_price)
		reverse_price = try values.decodeIfPresent(Reverse_price.self, forKey: .reverse_price)
		car_detail = try values.decodeIfPresent(Car_detail.self, forKey: .car_detail)
		cancellation_time = try values.decodeIfPresent(Int.self, forKey: .cancellation_time)
		allowable_time = try values.decodeIfPresent(Int.self, forKey: .allowable_time)
		additional_services = try values.decodeIfPresent([Additional_services].self, forKey: .additional_services)
		additional_services_revert = try values.decodeIfPresent([Additional_services_revert].self, forKey: .additional_services_revert)
		class_services = try values.decodeIfPresent([Class_services].self, forKey: .class_services)
		travel_time = try values.decodeIfPresent(Int.self, forKey: .travel_time)
		start_place = try values.decodeIfPresent(Start_place.self, forKey: .start_place)
		finish_place = try values.decodeIfPresent(Finish_place.self, forKey: .finish_place)
		final_price = try values.decodeIfPresent(Double.self, forKey: .final_price)
		final_api_price = try values.decodeIfPresent(Double.self, forKey: .final_api_price)
		final_sys_price = try values.decodeIfPresent(Double.self, forKey: .final_sys_price)
		token = try values.decodeIfPresent(String.self, forKey: .token)
	}

}
