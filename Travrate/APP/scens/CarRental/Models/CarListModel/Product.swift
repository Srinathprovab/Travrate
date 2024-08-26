//
//  Product.swift
//  Travrate
//
//  Created by Admin on 10/07/24.
//

import Foundation

struct Product : Codable {
    let total : String?
    let currency : String?
    let org_total : String?
    let org_currency : String?
    let deposit : String?
    let excess : String?
    let fuelpolicy : String?
    let purpose : String?
    let mileage : String?
    let costperextradistance : String?
    let minage : String?
    let product_type : String?
    let pro_index : String?

    enum CodingKeys: String, CodingKey {

        case total = "total"
        case currency = "currency"
        case org_total = "org_total"
        case org_currency = "org_currency"
        case deposit = "deposit"
        case excess = "excess"
        case fuelpolicy = "fuelpolicy"
        case purpose = "purpose"
        case mileage = "mileage"
        case costperextradistance = "costperextradistance"
        case minage = "minage"
        case product_type = "product_type"
        case pro_index = "pro_index"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        total = try values.decodeIfPresent(String.self, forKey: .total)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        org_total = try values.decodeIfPresent(String.self, forKey: .org_total)
        org_currency = try values.decodeIfPresent(String.self, forKey: .org_currency)
        deposit = try values.decodeIfPresent(String.self, forKey: .deposit)
        excess = try values.decodeIfPresent(String.self, forKey: .excess)
        fuelpolicy = try values.decodeIfPresent(String.self, forKey: .fuelpolicy)
        purpose = try values.decodeIfPresent(String.self, forKey: .purpose)
        mileage = try values.decodeIfPresent(String.self, forKey: .mileage)
        costperextradistance = try values.decodeIfPresent(String.self, forKey: .costperextradistance)
        minage = try values.decodeIfPresent(String.self, forKey: .minage)
        product_type = try values.decodeIfPresent(String.self, forKey: .product_type)
        pro_index = try values.decodeIfPresent(String.self, forKey: .pro_index)
    }

}
