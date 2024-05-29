
import Foundation
struct Ticket_value : Codable {
	let id : Int?
	let categoryName : String?
	let immediateConfirmationText : String?
	let deliveryMethods : [DeliveryMethods]?
	let splittedCategoryName : SplittedCategoryName?
	let tags : [Tags]?
	let requiredPurchaseFields : RequiredPurchaseFields?
	let importantNotes : String?
	let price : Int?
	let priceComments : String?
	let purchaseAlert : String?
	let serviceFee : Int?
	let immediateConfirmation : Int?
	let onHold24Hours : OnHold24Hours?
	let currency : String?
	let availableSellingQuantities : [Int]?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case categoryName = "categoryName"
		case immediateConfirmationText = "immediateConfirmationText"
		case deliveryMethods = "deliveryMethods"
		case splittedCategoryName = "splittedCategoryName"
		case tags = "tags"
		case requiredPurchaseFields = "requiredPurchaseFields"
		case importantNotes = "importantNotes"
		case price = "price"
		case priceComments = "priceComments"
		case purchaseAlert = "purchaseAlert"
		case serviceFee = "serviceFee"
		case immediateConfirmation = "immediateConfirmation"
		case onHold24Hours = "onHold24Hours"
		case currency = "currency"
		case availableSellingQuantities = "availableSellingQuantities"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		categoryName = try values.decodeIfPresent(String.self, forKey: .categoryName)
		immediateConfirmationText = try values.decodeIfPresent(String.self, forKey: .immediateConfirmationText)
		deliveryMethods = try values.decodeIfPresent([DeliveryMethods].self, forKey: .deliveryMethods)
		splittedCategoryName = try values.decodeIfPresent(SplittedCategoryName.self, forKey: .splittedCategoryName)
		tags = try values.decodeIfPresent([Tags].self, forKey: .tags)
		requiredPurchaseFields = try values.decodeIfPresent(RequiredPurchaseFields.self, forKey: .requiredPurchaseFields)
		importantNotes = try values.decodeIfPresent(String.self, forKey: .importantNotes)
		price = try values.decodeIfPresent(Int.self, forKey: .price)
		priceComments = try values.decodeIfPresent(String.self, forKey: .priceComments)
		purchaseAlert = try values.decodeIfPresent(String.self, forKey: .purchaseAlert)
		serviceFee = try values.decodeIfPresent(Int.self, forKey: .serviceFee)
		immediateConfirmation = try values.decodeIfPresent(Int.self, forKey: .immediateConfirmation)
		onHold24Hours = try values.decodeIfPresent(OnHold24Hours.self, forKey: .onHold24Hours)
		currency = try values.decodeIfPresent(String.self, forKey: .currency)
		availableSellingQuantities = try values.decodeIfPresent([Int].self, forKey: .availableSellingQuantities)
	}

}
