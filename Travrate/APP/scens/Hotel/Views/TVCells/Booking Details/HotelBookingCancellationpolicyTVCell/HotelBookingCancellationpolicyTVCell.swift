//
//  HotelBookingCancellationpolicyTVCell.swift
//  Travgate
//
//  Created by FCI on 19/03/24.
//

import UIKit


protocol HotelBookingCancellationpolicyTVCellDelegate:AnyObject {
    func didTapOnContactInfoTapAction(cell:HotelBookingCancellationpolicyTVCell)
}

class HotelBookingCancellationpolicyTVCell: TableViewCell {

    @IBOutlet weak var contactinfolbl: UILabel!
    @IBOutlet weak var cancellationTV: UITableView!
    @IBOutlet weak var tvheight: NSLayoutConstraint!
    
    
    
    weak var delegate:HotelBookingCancellationpolicyTVCellDelegate?
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
        
        MySingleton.shared.setAttributedTextnew(str1: "For more information please contact us on the ",
                                                str2: "travrate.info@gmail.com",
                                                lbl: contactinfolbl,
                                                str1font: .InterMedium(size: 12),
                                                str2font: .InterMedium(size: 12),
                                                str1Color: .BooknowBtnColor,
                                                str2Color: .subtitleNewcolor)
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        contactinfolbl.addGestureRecognizer(tapGesture)
        contactinfolbl.isUserInteractionEnabled = true
        
        setupTV()
    }

    override func updateUI() {
        
        tvheight.constant = CGFloat(MySingleton.shared.roompaxesdetails.count * 78)
        cancellationTV.reloadData()
    }
    
    
    
    @objc func labelTapped(gesture:UITapGestureRecognizer) {
        if gesture.didTapAttributedString("travrate.info@gmail.com", in: contactinfolbl) {
            delegate?.didTapOnContactInfoTapAction(cell: self)
        }
    
        
    }
    
}



extension HotelBookingCancellationpolicyTVCell:UITableViewDelegate,UITableViewDataSource {
    

    
    func setupTV() {
        cancellationTV.register(UINib(nibName: "CancellationStringTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        cancellationTV.delegate = self
        cancellationTV.dataSource = self
        cancellationTV.tableFooterView = UIView()
        cancellationTV.showsHorizontalScrollIndicator = false
        cancellationTV.separatorStyle = .singleLine
        cancellationTV.isScrollEnabled = false
        cancellationTV.separatorStyle = .none
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MySingleton.shared.roompaxesdetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CancellationStringTVCell {
            
            
            let data = MySingleton.shared.roompaxesdetails[indexPath.row]
            
            if cellInfo?.key == "booking" {
                cell.titlelbl.isHidden = false
            }
            cell.titlelbl.text = "Room \(indexPath.row + 1): \(data.room_name ?? "")"
            cell.cancellationStringlbl.text = data.cancellation_string?[0].policy
            
            c = cell
            
        }
        return c
    }

    
    
    
}
