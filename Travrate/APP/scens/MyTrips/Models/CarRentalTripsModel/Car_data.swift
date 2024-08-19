

import Foundation
struct Car_data : Codable {
	let groupName : String?
	let adults : String?
	let children : String?
	let luggageSmall : String?
	let luggageMed : String?
	let luggageLarge : String?
	let smallImage : String?
	let largeImage : String?
	let fuel : String?
	let mpg : String?
	let acriss : String?
	let co2 : String?
	let carorvan : String?
	let airConditioning : String?
	let refrigerated : String?
	let keyngo : String?
	let transmission : String?
	let driveandgo : String?
	let car_name : String?
	let car_id : String?
	let car_image : String?
	let from_loc : String?
	let from_loc_id : String?
	let search_id : Int?

	enum CodingKeys: String, CodingKey {

		case groupName = "groupName"
		case adults = "adults"
		case children = "children"
		case luggageSmall = "luggageSmall"
		case luggageMed = "luggageMed"
		case luggageLarge = "luggageLarge"
		case smallImage = "smallImage"
		case largeImage = "largeImage"
		case fuel = "fuel"
		case mpg = "mpg"
		case acriss = "acriss"
		case co2 = "co2"
		case carorvan = "carorvan"
		case airConditioning = "airConditioning"
		case refrigerated = "refrigerated"
		case keyngo = "keyngo"
		case transmission = "transmission"
		case driveandgo = "driveandgo"
		case car_name = "car_name"
		case car_id = "car_id"
		case car_image = "car_image"
		case from_loc = "from_loc"
		case from_loc_id = "from_loc_id"
		case search_id = "search_id"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		groupName = try values.decodeIfPresent(String.self, forKey: .groupName)
		adults = try values.decodeIfPresent(String.self, forKey: .adults)
		children = try values.decodeIfPresent(String.self, forKey: .children)
		luggageSmall = try values.decodeIfPresent(String.self, forKey: .luggageSmall)
		luggageMed = try values.decodeIfPresent(String.self, forKey: .luggageMed)
		luggageLarge = try values.decodeIfPresent(String.self, forKey: .luggageLarge)
		smallImage = try values.decodeIfPresent(String.self, forKey: .smallImage)
		largeImage = try values.decodeIfPresent(String.self, forKey: .largeImage)
		fuel = try values.decodeIfPresent(String.self, forKey: .fuel)
		mpg = try values.decodeIfPresent(String.self, forKey: .mpg)
		acriss = try values.decodeIfPresent(String.self, forKey: .acriss)
		co2 = try values.decodeIfPresent(String.self, forKey: .co2)
		carorvan = try values.decodeIfPresent(String.self, forKey: .carorvan)
		airConditioning = try values.decodeIfPresent(String.self, forKey: .airConditioning)
		refrigerated = try values.decodeIfPresent(String.self, forKey: .refrigerated)
		keyngo = try values.decodeIfPresent(String.self, forKey: .keyngo)
		transmission = try values.decodeIfPresent(String.self, forKey: .transmission)
		driveandgo = try values.decodeIfPresent(String.self, forKey: .driveandgo)
		car_name = try values.decodeIfPresent(String.self, forKey: .car_name)
		car_id = try values.decodeIfPresent(String.self, forKey: .car_id)
		car_image = try values.decodeIfPresent(String.self, forKey: .car_image)
		from_loc = try values.decodeIfPresent(String.self, forKey: .from_loc)
		from_loc_id = try values.decodeIfPresent(String.self, forKey: .from_loc_id)
		search_id = try values.decodeIfPresent(Int.self, forKey: .search_id)
	}

}
