

import Foundation
struct Activity_details : Codable {
    let activityCode : String?
    let activity_name : String?
    let currency : String?
    let type : String?
    //let amountsFrom : [AmountsFrom]?
    let min_amount : Double?
    //	let operationDays : OperationDays?
  //  let modalities : [Modalities]?
    //	let content : Content?
    let location : Location?
    let images : [Activity_images]?
    let segmentationGroups : String?
    let feature : String?
    let cONTRACT_REMARKS : String?
    //	let cancelpolicy : [[Cancelpolicy]]?
    
    enum CodingKeys: String, CodingKey {
        
        case activityCode = "activityCode"
        case activity_name = "activity_name"
        case currency = "currency"
        case type = "type"
        //	case amountsFrom = "amountsFrom"
        case min_amount = "min_amount"
        //	case operationDays = "operationDays"
 //       case modalities = "modalities"
        //	case content = "content"
        case location = "location"
        case images = "images"
        case segmentationGroups = "segmentationGroups"
        case feature = "feature"
        case cONTRACT_REMARKS = "CONTRACT_REMARKS"
        //	case cancelpolicy = "cancelpolicy"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        activityCode = try values.decodeIfPresent(String.self, forKey: .activityCode)
        activity_name = try values.decodeIfPresent(String.self, forKey: .activity_name)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        //	amountsFrom = try values.decodeIfPresent([AmountsFrom].self, forKey: .amountsFrom)
        min_amount = try values.decodeIfPresent(Double.self, forKey: .min_amount)
        //	operationDays = try values.decodeIfPresent(OperationDays.self, forKey: .operationDays)
  //      modalities = try values.decodeIfPresent([Modalities].self, forKey: .modalities)
        //	content = try values.decodeIfPresent(Content.self, forKey: .content)
        location = try values.decodeIfPresent(Location.self, forKey: .location)
        images = try values.decodeIfPresent([Activity_images].self, forKey: .images)
        segmentationGroups = try values.decodeIfPresent(String.self, forKey: .segmentationGroups)
        feature = try values.decodeIfPresent(String.self, forKey: .feature)
        cONTRACT_REMARKS = try values.decodeIfPresent(String.self, forKey: .cONTRACT_REMARKS)
        //	cancelpolicy = try values.decodeIfPresent([[Cancelpolicy]].self, forKey: .cancelpolicy)
    }
    
}
