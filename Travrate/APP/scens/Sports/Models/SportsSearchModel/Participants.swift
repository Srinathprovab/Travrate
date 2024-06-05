//
import Foundation
struct Participants : Codable {
	let id : Int?
	let name : String?
	let name_ar : String?
    let participants_img : String?
    
	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
		case name_ar = "name_ar"
        case participants_img = "participants_img"
        
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		name_ar = try values.decodeIfPresent(String.self, forKey: .name_ar)
        participants_img = try values.decodeIfPresent(String.self, forKey: .participants_img)
	}

}
