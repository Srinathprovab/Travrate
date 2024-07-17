//
//  ActivityDetailsModalities.swift
//  Travrate
//
//  Created by Admin on 17/07/24.
//

import Foundation


struct ActivityDetailsModalities : Codable {
    let code : String?
    let name : String?
    let duration : Duration?
//    let questions : [String]?
//    let comments : [Comments]?
//    let supplierInformation : SupplierInformation?
//    let providerInformation : ProviderInformation?
//    let destinationCode : String?
//    let contract : Contract?
//    let languages : [String]?
//    let amountsFrom : [AmountsFrom]?
//    let rates : [Rates]?
//    let amountUnitType : String?
//    let uniqueIdentifier : String?
//    let markupList : [MarkupList]?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case name = "name"
        case duration = "duration"
//        case questions = "questions"
//        case comments = "comments"
//        case supplierInformation = "supplierInformation"
//        case providerInformation = "providerInformation"
//        case destinationCode = "destinationCode"
//        case contract = "contract"
//        case languages = "languages"
//        case amountsFrom = "amountsFrom"
//        case rates = "rates"
//        case amountUnitType = "amountUnitType"
//        case uniqueIdentifier = "uniqueIdentifier"
//        case markupList = "MarkupList"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        duration = try values.decodeIfPresent(Duration.self, forKey: .duration)
//        questions = try values.decodeIfPresent([String].self, forKey: .questions)
//        comments = try values.decodeIfPresent([Comments].self, forKey: .comments)
//        supplierInformation = try values.decodeIfPresent(SupplierInformation.self, forKey: .supplierInformation)
//        providerInformation = try values.decodeIfPresent(ProviderInformation.self, forKey: .providerInformation)
//        destinationCode = try values.decodeIfPresent(String.self, forKey: .destinationCode)
//        contract = try values.decodeIfPresent(Contract.self, forKey: .contract)
//        languages = try values.decodeIfPresent([String].self, forKey: .languages)
//        amountsFrom = try values.decodeIfPresent([AmountsFrom].self, forKey: .amountsFrom)
//        rates = try values.decodeIfPresent([Rates].self, forKey: .rates)
//        amountUnitType = try values.decodeIfPresent(String.self, forKey: .amountUnitType)
//        uniqueIdentifier = try values.decodeIfPresent(String.self, forKey: .uniqueIdentifier)
//        markupList = try values.decodeIfPresent([MarkupList].self, forKey: .markupList)
    }

}
