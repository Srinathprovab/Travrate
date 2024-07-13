
import Foundation
struct Start_place : Codable {
	let place_id : Int?
	let title : String?
	let type : Int?
	let type_title : String?
	let terminal : [String]?
	let declension_titles : Declension_titles?

	enum CodingKeys: String, CodingKey {

		case place_id = "place_id"
		case title = "title"
		case type = "type"
		case type_title = "type_title"
		case terminal = "terminal"
		case declension_titles = "declension_titles"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		place_id = try values.decodeIfPresent(Int.self, forKey: .place_id)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		type = try values.decodeIfPresent(Int.self, forKey: .type)
		type_title = try values.decodeIfPresent(String.self, forKey: .type_title)
		terminal = try values.decodeIfPresent([String].self, forKey: .terminal)
		declension_titles = try values.decodeIfPresent(Declension_titles.self, forKey: .declension_titles)
	}

}
