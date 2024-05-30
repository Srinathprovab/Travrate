//
//  SportsDetailsModel.swift
//  Travrate
//
//  Created by FCI on 28/05/24.
//

import Foundation


struct SportsDetailsModel : Codable {
    let status : Bool?
    let data : [SportsDetailsData]?
    let search_id : String?
    let event_list : Event_list?
    let seating_arrangement : [Seating_arrangement]?
    let msg : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
        case search_id = "search_id"
        case event_list = "event_list"
        case seating_arrangement = "seating_arrangement"
        case msg = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        data = try values.decodeIfPresent([SportsDetailsData].self, forKey: .data)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        event_list = try values.decodeIfPresent(Event_list.self, forKey: .event_list)
        seating_arrangement = try values.decodeIfPresent([Seating_arrangement].self, forKey: .seating_arrangement)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
    }

}



struct SportsDetailsData : Codable {
    let id : Int?
    let categoryName : String?
    let splittedCategoryName : SplittedCategoryName?
    let purchaseAlert : String?
    let importantNotes : String?
    let price : Int?
    let serviceFee : Int?
    let priceComments : String?
    let currency : String?
    let availableSellingQuantities : [Int]?
    let tags : [Tags]?
    let immediateConfirmation : Int?
    let immediateConfirmationText : String?
    let requiredPurchaseFields : RequiredPurchaseFields?
    let deliveryMethods : [DeliveryMethods]?
    let onHold24Hours : OnHold24Hours?
    let ticket_value : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case categoryName = "categoryName"
        case splittedCategoryName = "splittedCategoryName"
        case purchaseAlert = "purchaseAlert"
        case importantNotes = "importantNotes"
        case price = "price"
        case serviceFee = "serviceFee"
        case priceComments = "priceComments"
        case currency = "currency"
        case availableSellingQuantities = "availableSellingQuantities"
        case tags = "tags"
        case immediateConfirmation = "immediateConfirmation"
        case immediateConfirmationText = "immediateConfirmationText"
        case requiredPurchaseFields = "requiredPurchaseFields"
        case deliveryMethods = "deliveryMethods"
        case onHold24Hours = "onHold24Hours"
        case ticket_value = "ticket_value"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        categoryName = try values.decodeIfPresent(String.self, forKey: .categoryName)
        splittedCategoryName = try values.decodeIfPresent(SplittedCategoryName.self, forKey: .splittedCategoryName)
        purchaseAlert = try values.decodeIfPresent(String.self, forKey: .purchaseAlert)
        importantNotes = try values.decodeIfPresent(String.self, forKey: .importantNotes)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        serviceFee = try values.decodeIfPresent(Int.self, forKey: .serviceFee)
        priceComments = try values.decodeIfPresent(String.self, forKey: .priceComments)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        availableSellingQuantities = try values.decodeIfPresent([Int].self, forKey: .availableSellingQuantities)
        tags = try values.decodeIfPresent([Tags].self, forKey: .tags)
        immediateConfirmation = try values.decodeIfPresent(Int.self, forKey: .immediateConfirmation)
        immediateConfirmationText = try values.decodeIfPresent(String.self, forKey: .immediateConfirmationText)
        requiredPurchaseFields = try values.decodeIfPresent(RequiredPurchaseFields.self, forKey: .requiredPurchaseFields)
        deliveryMethods = try values.decodeIfPresent([DeliveryMethods].self, forKey: .deliveryMethods)
        onHold24Hours = try values.decodeIfPresent(OnHold24Hours.self, forKey: .onHold24Hours)
        ticket_value = try values.decodeIfPresent(String.self, forKey: .ticket_value)
    }

}
