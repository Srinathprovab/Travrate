

import Foundation
struct Activity : Codable {
    let code : String?
    let currencyName : String?
    let order : Int?
    let contentId : String?
    let type : String?
    let name : String?
    let currency : String?
    let modalities : [ActivityModalities]?
    //let segment : [Segment]?
    let activityDuration : String?
    //let amounts : [Amounts]?
    let amountStarts : String?
    //	let country : Country?
    let image : String?
    //	let endPoints : [EndPoints]?
    //	let startingPoints : [StartingPoints]?
    
    enum CodingKeys: String, CodingKey {
        
        case code = "code"
        case currencyName = "currencyName"
        case order = "order"
        case contentId = "contentId"
        case type = "type"
        case name = "name"
        case currency = "currency"
        		case modalities = "modalities"
        //		case segment = "segment"
        case activityDuration = "activityDuration"
        //		case amounts = "amounts"
        case amountStarts = "amountStarts"
        //	case country = "country"
        case image = "image"
        //		case endPoints = "endPoints"
        //		case startingPoints = "startingPoints"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        currencyName = try values.decodeIfPresent(String.self, forKey: .currencyName)
        order = try values.decodeIfPresent(Int.self, forKey: .order)
        contentId = try values.decodeIfPresent(String.self, forKey: .contentId)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        		modalities = try values.decodeIfPresent([ActivityModalities].self, forKey: .modalities)
        //		segment = try values.decodeIfPresent([Segment].self, forKey: .segment)
        activityDuration = try values.decodeIfPresent(String.self, forKey: .activityDuration)
        //	amounts = try values.decodeIfPresent([Amounts].self, forKey: .amounts)
        amountStarts = try values.decodeIfPresent(String.self, forKey: .amountStarts)
        //		country = try values.decodeIfPresent(Country.self, forKey: .country)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        //		endPoints = try values.decodeIfPresent([EndPoints].self, forKey: .endPoints)
        //		startingPoints = try values.decodeIfPresent([StartingPoints].self, forKey: .startingPoints)
    }
    
}



struct ActivityModalities : Codable {
   
    let name : String?
   
    
    enum CodingKeys: String, CodingKey {
        
      
        case name = "name"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
       
        name = try values.decodeIfPresent(String.self, forKey: .name)
        
    }
    
}
