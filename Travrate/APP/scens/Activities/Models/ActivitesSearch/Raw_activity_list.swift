

import Foundation
struct Raw_activity_list : Codable {
	let activitySearchResult : ActivitySearchResult?
	let totalItems : Int?
	let source_result_count : Int?
	let filter_result_count : Int?

	enum CodingKeys: String, CodingKey {

		case activitySearchResult = "activitySearchResult"
		case totalItems = "totalItems"
		case source_result_count = "source_result_count"
		case filter_result_count = "filter_result_count"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		activitySearchResult = try values.decodeIfPresent(ActivitySearchResult.self, forKey: .activitySearchResult)
		totalItems = try values.decodeIfPresent(Int.self, forKey: .totalItems)
		source_result_count = try values.decodeIfPresent(Int.self, forKey: .source_result_count)
		filter_result_count = try values.decodeIfPresent(Int.self, forKey: .filter_result_count)
	}

}
