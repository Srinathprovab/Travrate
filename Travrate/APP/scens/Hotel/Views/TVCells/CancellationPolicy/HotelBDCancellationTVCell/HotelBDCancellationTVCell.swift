//
//  HotelBDCancellationTVCell.swift
//  Travrate
//
//  Created by Admin on 20/08/24.
//

import UIKit

class HotelBDCancellationTVCell: TableViewCell {
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var contactinfolbl: UILabel!
    @IBOutlet weak var roomTitleTV: UITableView!
    @IBOutlet weak var tvheight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupUI() {
        setuplabels(lbl: titlelbl, text: "Cancellation Policy", textcolor: .TitleColor, font:.OpenSansBold(size: 16), align: .left)
        
        MySingleton.shared.setAttributedTextnew(str1: "For more information please contact us on the ",
                                                str2: "travrate.info@gmail.com",
                                                lbl: contactinfolbl,
                                                str1font: .InterMedium(size: 12),
                                                str2font: .InterMedium(size: 12),
                                                str1Color: .BooknowBtnColor,
                                                str2Color: .subtitleNewcolor)
        setupTV()
        updateHeight()
    }
    
    
    
}



extension HotelBDCancellationTVCell :UITableViewDataSource, UITableViewDelegate {
    
 
    func setupTV() {
        roomTitleTV.register(UINib(nibName: "BDCancellationStringTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        roomTitleTV.delegate = self
        roomTitleTV.dataSource = self
        roomTitleTV.tableFooterView = UIView()
        roomTitleTV.showsHorizontalScrollIndicator = false
        roomTitleTV.separatorStyle = .singleLine
        roomTitleTV.isScrollEnabled = true
        roomTitleTV.separatorStyle = .none
        
       
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MySingleton.shared.roompaxesdetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? BDCancellationStringTVCell {
            
            cell.selectionStyle = .none
            
            
            let data = MySingleton.shared.roompaxesdetails[indexPath.row]
            cell.titlelbl.text = "Room:\(indexPath.row + 1) \(data.room_name ?? "")"
            cell.cancellation_string = data.cancellation_string ?? []
            cell.updateHeight()
            
            
            c = cell
            
        }
        return c
    }
    
    
    
    
    
    func updateHeight() {
        var totalHeight: CGFloat = 0
        for index in 0..<MySingleton.shared.roompaxesdetails.count {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = roomTitleTV.cellForRow(at: indexPath) as? BDCancellationStringTVCell {
                totalHeight += cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            }
        }
        tvheight.constant = CGFloat((MySingleton.shared.roompaxesdetails.count)) * totalHeight
        roomTitleTV.reloadData()
    }
    
    
    
}
