//
//  RecentSearches.swift
//  TravgateApp
//
//  Created by FCI on 08/02/24.
//

import Foundation


struct SearchDataModel : Codable {
    
    let status : Int?
    let recent_searches : [Recent_searches]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case recent_searches = "recent_searches"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        recent_searches = try values.decodeIfPresent([Recent_searches].self, forKey: .recent_searches)
    }

}



struct Recent_searches : Codable {
    let arr_data : Arr_data?

    enum CodingKeys: String, CodingKey {

        case arr_data = "arr_data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        arr_data = try values.decodeIfPresent(Arr_data.self, forKey: .arr_data)
    }

}
