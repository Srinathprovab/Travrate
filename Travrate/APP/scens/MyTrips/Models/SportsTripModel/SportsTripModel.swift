//
//  SportsTripModel.swift
//  Travrate
//
//  Created by Admin on 03/08/24.
//

import Foundation

//struct SportsTripModel : Codable {
//    let data : SportsTripData?
//    
//    enum CodingKeys: String, CodingKey {
//        
//        case data = "data"
//    }
//    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        data = try values.decodeIfPresent(SportsTripData.self, forKey: .data)
//    }
//    
//}


struct SportsTripModel : Codable {
    let completed : [SportsCompleted]?
    let upcoming : [SportsCompleted]?
    
    enum CodingKeys: String, CodingKey {
        
        case completed = "completed"
        case upcoming = "upcoming"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        completed = try values.decodeIfPresent([SportsCompleted].self, forKey: .completed)
        upcoming = try values.decodeIfPresent([SportsCompleted].self, forKey: .upcoming)
    }
    
}
