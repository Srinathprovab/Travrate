
import Foundation
struct TopFlightDetails : Codable {
    let from_city : String?
    let return_date : String?
    let status : String?
    let country : String?
    let image : String?
    let airline_id : String?
    let to_city : String?
    let updated_at : String?
    let to_loc : String?
    let airport_city : String?
    let id : String?
    let country_name : String?
    let country_arabic : String?
    let trip_type : String?
    let from_loc_ar : String?
    let airport_city_arabic : String?
    let travel_date : String?
    let airline_class : String?
    let created_at : String?
    let voucher : String?
    let price : String?
    let from_loc : String?
    let voucher_status : String?
    let to_loc_ar : String?

    enum CodingKeys: String, CodingKey {

        case from_city = "from_city"
        case return_date = "return_date"
        case status = "status"
        case country = "country"
        case image = "image"
        case airline_id = "airline_id"
        case to_city = "to_city"
        case updated_at = "updated_at"
        case to_loc = "to_loc"
        case airport_city = "airport_city"
        case id = "id"
        case country_name = "country_name"
        case country_arabic = "country_arabic"
        case trip_type = "trip_type"
        case from_loc_ar = "from_loc_ar"
        case airport_city_arabic = "airport_city_arabic"
        case travel_date = "travel_date"
        case airline_class = "airline_class"
        case created_at = "created_at"
        case voucher = "voucher"
        case price = "price"
        case from_loc = "from_loc"
        case voucher_status = "voucher_status"
        case to_loc_ar = "to_loc_ar"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        from_city = try values.decodeIfPresent(String.self, forKey: .from_city)
        return_date = try values.decodeIfPresent(String.self, forKey: .return_date)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        airline_id = try values.decodeIfPresent(String.self, forKey: .airline_id)
        to_city = try values.decodeIfPresent(String.self, forKey: .to_city)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        to_loc = try values.decodeIfPresent(String.self, forKey: .to_loc)
        airport_city = try values.decodeIfPresent(String.self, forKey: .airport_city)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        country_name = try values.decodeIfPresent(String.self, forKey: .country_name)
        country_arabic = try values.decodeIfPresent(String.self, forKey: .country_arabic)
        trip_type = try values.decodeIfPresent(String.self, forKey: .trip_type)
        from_loc_ar = try values.decodeIfPresent(String.self, forKey: .from_loc_ar)
        airport_city_arabic = try values.decodeIfPresent(String.self, forKey: .airport_city_arabic)
        travel_date = try values.decodeIfPresent(String.self, forKey: .travel_date)
        airline_class = try values.decodeIfPresent(String.self, forKey: .airline_class)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        voucher = try values.decodeIfPresent(String.self, forKey: .voucher)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        from_loc = try values.decodeIfPresent(String.self, forKey: .from_loc)
        voucher_status = try values.decodeIfPresent(String.self, forKey: .voucher_status)
        to_loc_ar = try values.decodeIfPresent(String.self, forKey: .to_loc_ar)
    }

}
