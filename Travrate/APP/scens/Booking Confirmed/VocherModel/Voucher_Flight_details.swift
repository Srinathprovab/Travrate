//
//  Voucher_Flight_details.swift
//  Travrate
//
//  Created by Admin on 09/08/24.
//

import Foundation

struct Voucher_Flight_details : Codable {
    let summary : [Summary]?
  //  let details : [[Details]]?

    enum CodingKeys: String, CodingKey {

        case summary = "summary"
    //    case details = "details"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        summary = try values.decodeIfPresent([Summary].self, forKey: .summary)
      //  details = try values.decodeIfPresent([[Details]].self, forKey: .details)
    }

}
