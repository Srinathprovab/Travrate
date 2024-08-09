//
//  HeaderTableViewCell.swift
//  Travgate
//
//  Created by FCI on 01/03/24.
//

import UIKit
protocol HeaderTableViewCellDelegate: AnyObject {
    func didTapOnFacebookLinkBtnAction(cell:HeaderTableViewCell)
    func didTapOnTwitterLinkBtnAction(cell:HeaderTableViewCell)
    func didTapOnLinkedlnLinkBtnAction(cell:HeaderTableViewCell)
    func didTapOnInstagramLinkBtnAction(cell:HeaderTableViewCell)
    func didTapOnYoutubeBtnAction(cell:HeaderTableViewCell)
}

class HeaderTableViewCell: TableViewCell {
    
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var copyrightlbl: UILabel!
    @IBOutlet weak var facebookbtn: UIImageView!
    @IBOutlet weak var twitterbtn: UIImageView!
    @IBOutlet weak var linkedlnbtn: UIImageView!
    @IBOutlet weak var instbtn: UIImageView!
    @IBOutlet weak var youtubebtn: UIImageView!
    
    
    
    weak var delegate:HeaderTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
//        if let imageUrlString = social_linksArray[0].link_icon, let imageUrl = URL(string: imageUrlString) {
//            facebookbtn.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder.png"))
//        }
//        
//        if let imageUrlString = social_linksArray[1].link_icon, let imageUrl = URL(string: imageUrlString) {
//            twitterbtn.sd_setImage(with: imageUrl, for: .normal, placeholderImage: UIImage(named: "placeholder.png"))
//        }
//        
//        if let imageUrlString = social_linksArray[2].link_icon, let imageUrl = URL(string: imageUrlString) {
//            instbtn.sd_setImage(with: imageUrl, for: .normal, placeholderImage: UIImage(named: "placeholder.png"))
//        }
//        
//        if let imageUrlString = social_linksArray[3].link_icon, let imageUrl = URL(string: imageUrlString) {
//            youtubebtn.sd_setImage(with: imageUrl, for: .normal, placeholderImage: UIImage(named: "placeholder.png"))
//        }
//        
//        if let imageUrlString = social_linksArray[4].link_icon, let imageUrl = URL(string: imageUrlString) {
//            linkedlnbtn.sd_setImage(with: imageUrl, for: .normal, placeholderImage: UIImage(named: "placeholder.png"))
//        }
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        
        titlelbl.text = cellInfo?.title?.htmlToString22
        copyrightlbl.text = bottom_text_info[0].copy_right_text
        

        
    }
    
    
    
    @IBAction func didTapOnFacebookLinkBtnAction(_ sender: Any) {
        delegate?.didTapOnFacebookLinkBtnAction(cell: self)
    }
    
    @IBAction func didTapOnTwitterLinkBtnAction(_ sender: Any) {
        delegate?.didTapOnTwitterLinkBtnAction(cell: self)
    }
    
    @IBAction func didTapOnLinkedlnLinkBtnAction(_ sender: Any) {
        delegate?.didTapOnLinkedlnLinkBtnAction(cell: self)
    }
    
    @IBAction func didTapOnInstagramLinkBtnAction(_ sender: Any) {
        delegate?.didTapOnInstagramLinkBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnYoutubeBtnAction(_ sender: Any) {
        delegate?.didTapOnYoutubeBtnAction(cell: self)
    }
    
    
}


import UIKit

extension String {
    var htmlToAttributedString22: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("Error converting HTML to Attributed String: \(error)")
            return nil
        }
    }
    
    var htmlToString22: String {
        return htmlToAttributedString22?.string ?? ""
    }
}
