//
//  TermsPopupTVCell.swift
//  Travgate
//
//  Created by FCI on 14/03/24.
//

import UIKit

class TermsPopupTVCell: TableViewCell {
    
    @IBOutlet weak var subtitlelbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        // Decode the HTML and set the text
        let decodedText = cellInfo?.subTitle?.replacingOccurrences(of: "\\r\\n", with: "<br>")
            .replacingOccurrences(of: "\\", with: "")
            .htmlToString
        
        subtitlelbl.text = decodedText
    }
    
}


extension String {
    var htmlToString1: String {
        guard let data = self.data(using: .utf8) else { return self }
        do {
            let attributedString = try NSAttributedString(data: data,
                                                          options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
                                                          documentAttributes: nil)
            return attributedString.string
        } catch {
            return self
        }
    }
}
