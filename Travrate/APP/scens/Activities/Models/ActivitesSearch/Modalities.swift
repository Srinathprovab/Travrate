

import Foundation
struct Modalities : Codable {
    let code : String?
    let name : String?
    let duration : String?
    let amountUnitType : String?
    //	let amountsFrom : [AmountsFrom]?
    //	let markupList : [MarkupList]?
    //	let cancellationPolicies : [CancellationPolicies]?
    
    enum CodingKeys: String, CodingKey {
        
        case code = "code"
        case name = "name"
        case duration = "duration"
        case amountUnitType = "amountUnitType"
        //		case amountsFrom = "amountsFrom"
        //		case markupList = "MarkupList"
        //	case cancellationPolicies = "cancellationPolicies"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        duration = try values.decodeIfPresent(String.self, forKey: .duration)
        amountUnitType = try values.decodeIfPresent(String.self, forKey: .amountUnitType)
        //		amountsFrom = try values.decodeIfPresent([AmountsFrom].self, forKey: .amountsFrom)
        //		markupList = try values.decodeIfPresent([MarkupList].self, forKey: .markupList)
        //	cancellationPolicies = try values.decodeIfPresent([CancellationPolicies].self, forKey: .cancellationPolicies)
    }
    
}
