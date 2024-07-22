

import Foundation
struct Cancellation_details : Codable {
    let app_reference : String?
    let cancel_amount : String?
    let cancel_dateFrom : String?
    let origin : String?
    let booking_reference : String?

    enum CodingKeys: String, CodingKey {

        case app_reference = "app_reference"
        case cancel_amount = "cancel_amount"
        case cancel_dateFrom = "cancel_dateFrom"
        case origin = "origin"
        case booking_reference = "booking_reference"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
        cancel_amount = try values.decodeIfPresent(String.self, forKey: .cancel_amount)
        cancel_dateFrom = try values.decodeIfPresent(String.self, forKey: .cancel_dateFrom)
        origin = try values.decodeIfPresent(String.self, forKey: .origin)
        booking_reference = try values.decodeIfPresent(String.self, forKey: .booking_reference)
    }

}
