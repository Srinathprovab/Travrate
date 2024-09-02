

import Foundation
struct Arr_data : Codable {
    let psscarrier : String?
    let to_custom : String?
    let direct_flight : String?
    let v_class : String?
    let rreturn : String?
    let user_id : String?
    let search_source : String?
    let ret_jrn : String?
    let currency : String?
    let origin : String?
    let trip_type : String?
    let to : String?
    let depature : String?
    let carrier : String?
    let from_custom : String?
    let from : String?
    let to_loc_id : String?
    let out_jrn : String?
    let infant : String?
    let from_loc_id : String?
    let search_flight : String?
    let adult : String?
    let child : String?
    let from_city : String?
    let to_city : String?
    
    

    enum CodingKeys: String, CodingKey {

        case psscarrier = "psscarrier"
        case to_custom = "to_custom"
        case direct_flight = "direct_flight"
        case v_class = "v_class"
        case rreturn = "return"
        case user_id = "user_id"
        case search_source = "search_source"
        case ret_jrn = "ret_jrn"
        case currency = "currency"
        case origin = "origin"
        case trip_type = "trip_type"
        case to = "to"
        case depature = "depature"
        case carrier = "carrier"
        case from_custom = "from_custom"
        case from = "from"
        case to_loc_id = "to_loc_id"
        case out_jrn = "out_jrn"
        case infant = "infant"
        case from_loc_id = "from_loc_id"
        case search_flight = "search_flight"
        case adult = "adult"
        case child = "child"
        
        case from_city = "from_city"
        case to_city = "to_city"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        psscarrier = try values.decodeIfPresent(String.self, forKey: .psscarrier)
        to_custom = try values.decodeIfPresent(String.self, forKey: .to_custom)
        direct_flight = try values.decodeIfPresent(String.self, forKey: .direct_flight)
        v_class = try values.decodeIfPresent(String.self, forKey: .v_class)
        rreturn = try values.decodeIfPresent(String.self, forKey: .rreturn)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        search_source = try values.decodeIfPresent(String.self, forKey: .search_source)
        ret_jrn = try values.decodeIfPresent(String.self, forKey: .ret_jrn)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        origin = try values.decodeIfPresent(String.self, forKey: .origin)
        trip_type = try values.decodeIfPresent(String.self, forKey: .trip_type)
        to = try values.decodeIfPresent(String.self, forKey: .to)
        depature = try values.decodeIfPresent(String.self, forKey: .depature)
        carrier = try values.decodeIfPresent(String.self, forKey: .carrier)
        from_custom = try values.decodeIfPresent(String.self, forKey: .from_custom)
        from = try values.decodeIfPresent(String.self, forKey: .from)
        to_loc_id = try values.decodeIfPresent(String.self, forKey: .to_loc_id)
        out_jrn = try values.decodeIfPresent(String.self, forKey: .out_jrn)
        infant = try values.decodeIfPresent(String.self, forKey: .infant)
        from_loc_id = try values.decodeIfPresent(String.self, forKey: .from_loc_id)
        search_flight = try values.decodeIfPresent(String.self, forKey: .search_flight)
        adult = try values.decodeIfPresent(String.self, forKey: .adult)
        child = try values.decodeIfPresent(String.self, forKey: .child)
        
        from_city = try values.decodeIfPresent(String.self, forKey: .from_city)
        to_city = try values.decodeIfPresent(String.self, forKey: .to_city)
        
    }

}
