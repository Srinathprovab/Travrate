//
//  NewRoomTVCell.swift
//  BabSafar
//
//  Created by FCI on 25/08/23.
//

import UIKit

protocol NewRoomTVCellDelegate:AnyObject {
    func didTapOnCancellationPolicyBtnAction(cell:NewRoomDetailsTVCell)
    func didTapOnSelectRoomBtnAction(cell:NewRoomDetailsTVCell)
}

class NewRoomTVCell: TableViewCell, NewRoomDetailsTVCellDelegate {
    
    
    @IBOutlet weak var tvheight: NSLayoutConstraint!
    @IBOutlet weak var roomInfoTV: UITableView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var topView: BorderedView!
    
    
   
    var indexArray = [IndexPath]()
    var newRoomindexPath: Int?
    var room = [Rooms]()
    weak var delegate:NewRoomTVCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setuTV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        
        room = cellInfo?.moreData as! [Rooms]
        tvheight.constant = CGFloat(room.count * 101)
        roomInfoTV.reloadData()
    }
    
    
    
    func setuTV() {
        
        roomInfoTV.register(UINib(nibName: "NewRoomDetailsTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        roomInfoTV.delegate = self
        roomInfoTV.dataSource = self
        roomInfoTV.tableFooterView = UIView()
        roomInfoTV.separatorStyle = .none
        roomInfoTV.showsHorizontalScrollIndicator = false
        
        roomInfoTV.layer.borderColor = UIColor.AppBorderColor.cgColor
        roomInfoTV.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner] // Bottom left corner, Bottom right corner respectively
        roomInfoTV.layer.cornerRadius = 10
        roomInfoTV.clipsToBounds = true
        roomInfoTV.isScrollEnabled = false
        
        topView.layer.borderColor = UIColor.AppBorderColor.cgColor
        topView.layer.borderWidth = 1
        
        topView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top right corner, Top left corner respectively
        topView.layer.cornerRadius = 10
        topView.clipsToBounds = true
        
        roomInfoTV.layer.borderWidth = 1
        roomInfoTV.layer.borderColor = UIColor.AppBorderColor.cgColor
        
        roomInfoTV.layer.cornerRadius = 10
        roomInfoTV.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
    }
    
    
    func didTapOnCancellationPolicyBtnAction(cell: NewRoomDetailsTVCell) {
        delegate?.didTapOnCancellationPolicyBtnAction(cell: cell)
    }
    
    func didTapOnSelectRoomBtnAction(cell: NewRoomDetailsTVCell) {
        
        newRoomindexPath = Int(cellInfo?.title ?? "0")
        
        if let indexPath = roomInfoTV.indexPath(for: cell) {
            // Toggle the selected state
            selectedCellStates[indexPath] = !selectedCellStates[indexPath, default: false]
            
            // Update the button color
            cell.updateButtonColor()
            
            // Deselect the previously selected cell, if any
            for (index, isSelected) in selectedCellStates {
                if index != indexPath && isSelected {
                    selectedCellStates[index] = false
                    if let previouslySelectedCell = roomInfoTV.cellForRow(at: index) as? NewRoomDetailsTVCell {
                        previouslySelectedCell.updateButtonColor()
                    }
                }
            }
            
            
        }
        
        
        delegate?.didTapOnSelectRoomBtnAction(cell: cell)
    }
    
    
    
    
}


extension NewRoomTVCell: UITableViewDataSource ,UITableViewDelegate {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return room.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? NewRoomDetailsTVCell {
            cell.selectionStyle = .none
            cell.delegate = self
            cell.selectedindexPath = indexPath.row
            
            let data = room[indexPath.row]
            self.titlelbl.text = data.name ?? ""
            
            
            MySingleton.shared.setAttributedTextnew(str1: "\(data.currency ?? "") ",
                                 str2: "\(data.net ?? "")",
                                 lbl: cell.pricelbl,
                                 str1font: .InterBold(size: 12),
                                 str2font: .InterBold(size: 20),
                                 str1Color: .BackBtnColor,
                                 str2Color: .BackBtnColor)
            
            cell.cancellatonStringArray = data.cancellation_string ?? []
            cell.exactprice = data.net ?? ""
            cell.currency = data.currency ?? ""
            
            
    
            
            // Access the cancellationPolicies array
            if let cancellationPolicies1 = data.cancellationPolicies {
                // Iterate over the cancellationPolicies array
                for policy in cancellationPolicies1 {
                    let amount = policy.amount
                    let fromDate = policy.from
                    cell.CancellationPolicyAmount = amount ?? ""
                    cell.CancellationPolicyFromDate = fromDate ?? ""
                    
                }
            }
            
            
            // Set the selected state based on isSelectedCell property
            cell.isSelectedCell = selectedCellIndices.contains(indexPath)
            
           
            
            cell.ratekey = data.rateKey ?? ""
            cell.selectedRoom = "\(data.room_selected ?? 0)"
            
            
            let guestcount = defaults.integer(forKey: UserDefaultsKeys.guestcount)
            cell.noofGuestlbl.text = "\(guestcount) Guest"
           
            
            ccell = cell
        }
        
        return ccell
    }
    
    
    
}
