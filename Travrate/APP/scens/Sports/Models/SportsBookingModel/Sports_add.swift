

import Foundation
struct Sports_add : Codable {
	let id : String?
	let name : String?
	let page : String?
	let status : String?
	let ad_image_width : String?
	let ad_image_height : String?
	let created_at : String?
	let updated_at : String?
	let category_id : String?
	let image : String?
	let image_ar : String?
	let alt_text : String?
	let alt_text_ar : String?
	let link : String?
	let link_target : String?
	let banner_image : String?
	let title : String?
	let ar_title : String?
	let pdesc : String?
	let ar_pdesc : String?
	let mpdesc : String?
	let ar_mpdesc : String?
	let tnc : String?
	let tnc_ar : String?
	let link_status : String?
	let status_updated_at : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
		case page = "page"
		case status = "status"
		case ad_image_width = "ad_image_width"
		case ad_image_height = "ad_image_height"
		case created_at = "created_at"
		case updated_at = "updated_at"
		case category_id = "category_id"
		case image = "image"
		case image_ar = "image_ar"
		case alt_text = "alt_text"
		case alt_text_ar = "alt_text_ar"
		case link = "link"
		case link_target = "link_target"
		case banner_image = "banner_image"
		case title = "title"
		case ar_title = "ar_title"
		case pdesc = "pdesc"
		case ar_pdesc = "ar_pdesc"
		case mpdesc = "mpdesc"
		case ar_mpdesc = "ar_mpdesc"
		case tnc = "tnc"
		case tnc_ar = "tnc_ar"
		case link_status = "link_status"
		case status_updated_at = "status_updated_at"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		page = try values.decodeIfPresent(String.self, forKey: .page)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		ad_image_width = try values.decodeIfPresent(String.self, forKey: .ad_image_width)
		ad_image_height = try values.decodeIfPresent(String.self, forKey: .ad_image_height)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
		category_id = try values.decodeIfPresent(String.self, forKey: .category_id)
		image = try values.decodeIfPresent(String.self, forKey: .image)
		image_ar = try values.decodeIfPresent(String.self, forKey: .image_ar)
		alt_text = try values.decodeIfPresent(String.self, forKey: .alt_text)
		alt_text_ar = try values.decodeIfPresent(String.self, forKey: .alt_text_ar)
		link = try values.decodeIfPresent(String.self, forKey: .link)
		link_target = try values.decodeIfPresent(String.self, forKey: .link_target)
		banner_image = try values.decodeIfPresent(String.self, forKey: .banner_image)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		ar_title = try values.decodeIfPresent(String.self, forKey: .ar_title)
		pdesc = try values.decodeIfPresent(String.self, forKey: .pdesc)
		ar_pdesc = try values.decodeIfPresent(String.self, forKey: .ar_pdesc)
		mpdesc = try values.decodeIfPresent(String.self, forKey: .mpdesc)
		ar_mpdesc = try values.decodeIfPresent(String.self, forKey: .ar_mpdesc)
		tnc = try values.decodeIfPresent(String.self, forKey: .tnc)
		tnc_ar = try values.decodeIfPresent(String.self, forKey: .tnc_ar)
		link_status = try values.decodeIfPresent(String.self, forKey: .link_status)
		status_updated_at = try values.decodeIfPresent(String.self, forKey: .status_updated_at)
	}

}
