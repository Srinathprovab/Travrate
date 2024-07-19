
import Foundation
struct Rates : Codable {
    //	let rateClass : String?
    //	let freeCancellation : Bool?
    //	let rateCode : String?
    let rateDetails : [RateDetails]?
    //	let name : String?
    
    enum CodingKeys: String, CodingKey {
        
        //		case rateClass = "rateClass"
        //		case freeCancellation = "freeCancellation"
        //		case rateCode = "rateCode"
        case rateDetails = "rateDetails"
        //	case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        //		rateClass = try values.decodeIfPresent(String.self, forKey: .rateClass)
        //		freeCancellation = try values.decodeIfPresent(Bool.self, forKey: .freeCancellation)
        //		rateCode = try values.decodeIfPresent(String.self, forKey: .rateCode)
        rateDetails = try values.decodeIfPresent([RateDetails].self, forKey: .rateDetails)
        //	name = try values.decodeIfPresent(String.self, forKey: .name)
    }
    
}
