

import Foundation
struct RateDetails : Codable {
    //	let minimumDuration : MinimumDuration?
    //	let agencyCommission : AgencyCommission?
    let rateKey : String?
    //	let sessions : [String]?
    //	let paxAmounts : [PaxAmounts]?
    //	let totalAmount : TotalAmount?
    //	let operationDates : [OperationDates]?
    //	let maximumDuration : MaximumDuration?
    //	let languages : [Languages]?
    
    enum CodingKeys: String, CodingKey {
        
        //		case minimumDuration = "minimumDuration"
        //		case agencyCommission = "agencyCommission"
        case rateKey = "rateKey"
        //		case sessions = "sessions"
        //		case paxAmounts = "paxAmounts"
        //		case totalAmount = "totalAmount"
        //		case operationDates = "operationDates"
        //		case maximumDuration = "maximumDuration"
        //		case languages = "languages"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        //		minimumDuration = try values.decodeIfPresent(MinimumDuration.self, forKey: .minimumDuration)
        //		agencyCommission = try values.decodeIfPresent(AgencyCommission.self, forKey: .agencyCommission)
        rateKey = try values.decodeIfPresent(String.self, forKey: .rateKey)
        //		sessions = try values.decodeIfPresent([String].self, forKey: .sessions)
        //		paxAmounts = try values.decodeIfPresent([PaxAmounts].self, forKey: .paxAmounts)
        //		totalAmount = try values.decodeIfPresent(TotalAmount.self, forKey: .totalAmount)
        //		operationDates = try values.decodeIfPresent([OperationDates].self, forKey: .operationDates)
        //		maximumDuration = try values.decodeIfPresent(MaximumDuration.self, forKey: .maximumDuration)
        //		languages = try values.decodeIfPresent([Languages].self, forKey: .languages)
    }
    
}
