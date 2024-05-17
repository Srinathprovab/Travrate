
import Foundation
struct Tour__2_data : Codable {
	let origin : String?
	let heading : String?
	let subheading : String?
	let image : String?
	let desc : String?
	let dis_q : String?
	let tnc : String?
	let more_image : [String]?
	let iti_image : String?
	let iti_tit : String?
	let iti_desc : String?
	let tour_departure_details : Tour_departure_details?

	enum CodingKeys: String, CodingKey {

		case origin = "origin"
		case heading = "heading"
		case subheading = "subheading"
		case image = "image"
		case desc = "desc"
		case dis_q = "dis_q"
		case tnc = "tnc"
		case more_image = "more_image"
		case iti_image = "iti_image"
		case iti_tit = "iti_tit"
		case iti_desc = "iti_desc"
		case tour_departure_details = "tour_departure_details"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		origin = try values.decodeIfPresent(String.self, forKey: .origin)
		heading = try values.decodeIfPresent(String.self, forKey: .heading)
		subheading = try values.decodeIfPresent(String.self, forKey: .subheading)
		image = try values.decodeIfPresent(String.self, forKey: .image)
		desc = try values.decodeIfPresent(String.self, forKey: .desc)
		dis_q = try values.decodeIfPresent(String.self, forKey: .dis_q)
		tnc = try values.decodeIfPresent(String.self, forKey: .tnc)
		more_image = try values.decodeIfPresent([String].self, forKey: .more_image)
		iti_image = try values.decodeIfPresent(String.self, forKey: .iti_image)
		iti_tit = try values.decodeIfPresent(String.self, forKey: .iti_tit)
		iti_desc = try values.decodeIfPresent(String.self, forKey: .iti_desc)
		tour_departure_details = try values.decodeIfPresent(Tour_departure_details.self, forKey: .tour_departure_details)
	}

}
