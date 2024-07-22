

import Foundation
struct Token_mob : Codable {
    //	let operationDays : OperationDays?
    let activity_name : String?
  //  let amountsFrom : [AmountsFrom]?
    let feature : String?
    let activityCode : String?
    let type : String?
    let cONTRACT_REMARKS : String?
    let location : Location?
    let segmentationGroups : String?
    let images : [Images]?
    let min_amount : Double?
    let currency : String?
    let modalities : [ActivityDetailsModalities]?
    let content : Content?
    
    enum CodingKeys: String, CodingKey {
        
        //	case operationDays = "operationDays"
        case activity_name = "activity_name"
     //   case amountsFrom = "amountsFrom"
        case feature = "feature"
        case activityCode = "activityCode"
        case type = "type"
        case cONTRACT_REMARKS = "CONTRACT_REMARKS"
        case location = "location"
        case segmentationGroups = "segmentationGroups"
        case images = "images"
        case min_amount = "min_amount"
        case currency = "currency"
        case modalities = "modalities"
        case content = "content"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        //	operationDays = try values.decodeIfPresent(OperationDays.self, forKey: .operationDays)
        activity_name = try values.decodeIfPresent(String.self, forKey: .activity_name)
   //     amountsFrom = try values.decodeIfPresent([AmountsFrom].self, forKey: .amountsFrom)
        feature = try values.decodeIfPresent(String.self, forKey: .feature)
        activityCode = try values.decodeIfPresent(String.self, forKey: .activityCode)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        cONTRACT_REMARKS = try values.decodeIfPresent(String.self, forKey: .cONTRACT_REMARKS)
        location = try values.decodeIfPresent(Location.self, forKey: .location)
        segmentationGroups = try values.decodeIfPresent(String.self, forKey: .segmentationGroups)
        images = try values.decodeIfPresent([Images].self, forKey: .images)
        min_amount = try values.decodeIfPresent(Double.self, forKey: .min_amount)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        modalities = try values.decodeIfPresent([ActivityDetailsModalities].self, forKey: .modalities)
        content = try values.decodeIfPresent(Content.self, forKey: .content)
    }
    
}
