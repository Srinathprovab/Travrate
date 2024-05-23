//
//  HotelBookingCancellationpolicyTVCell.swift
//  Travgate
//
//  Created by FCI on 19/03/24.
//

import UIKit

class HotelBookingCancellationpolicyTVCell: TableViewCell {

    
    @IBOutlet weak var roomTypelbl: UILabel!
    @IBOutlet weak var cancellationTV: UITableView!
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
        setupTV()
    }
    
    
    override func updateUI() {
        roomTypelbl.text = "Room \(defaults.string(forKey: UserDefaultsKeys.roomcount) ?? ""): \(MySingleton.shared.cancellationRoomStringArray[0].room_name ?? "")"
        
        tvheight.constant = CGFloat(MySingleton.shared.cancellationRoomStringArray.count * 43)
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
        return MySingleton.shared.cancellationRoomStringArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CancellationStringTVCell {
            
            cell.cancellationStringlbl.text = MySingleton.shared.cancellationRoomStringArray[indexPath.row].policy
            
            c = cell
            
        }
        return c
    }

    
    
    
}
