
import Foundation
struct Tour__2_data : Codable {
    let heading : String?
    let iti_desc : String?
    let dis_q : String?
    let tnc : String?
    let desc : String?
    let iti_tit : String?
    let itinerary : [Itinerary]?
    let subheading : String?
    let image : String?
    let origin : String?
    let iti_image : String?
    let tour_departure_details : Tour_departure_details?
    let more_image : [String]?

    enum CodingKeys: String, CodingKey {

        case heading = "heading"
        case iti_desc = "iti_desc"
        case dis_q = "dis_q"
        case tnc = "tnc"
        case desc = "desc"
        case iti_tit = "iti_tit"
        case itinerary = "itinerary"
        case subheading = "subheading"
        case image = "image"
        case origin = "origin"
        case iti_image = "iti_image"
        case tour_departure_details = "tour_departure_details"
        case more_image = "more_image"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        heading = try values.decodeIfPresent(String.self, forKey: .heading)
        iti_desc = try values.decodeIfPresent(String.self, forKey: .iti_desc)
        dis_q = try values.decodeIfPresent(String.self, forKey: .dis_q)
        tnc = try values.decodeIfPresent(String.self, forKey: .tnc)
        desc = try values.decodeIfPresent(String.self, forKey: .desc)
        iti_tit = try values.decodeIfPresent(String.self, forKey: .iti_tit)
        itinerary = try values.decodeIfPresent([Itinerary].self, forKey: .itinerary)
        subheading = try values.decodeIfPresent(String.self, forKey: .subheading)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        origin = try values.decodeIfPresent(String.self, forKey: .origin)
        iti_image = try values.decodeIfPresent(String.self, forKey: .iti_image)
        tour_departure_details = try values.decodeIfPresent(Tour_departure_details.self, forKey: .tour_departure_details)
        more_image = try values.decodeIfPresent([String].self, forKey: .more_image)
    }

}
