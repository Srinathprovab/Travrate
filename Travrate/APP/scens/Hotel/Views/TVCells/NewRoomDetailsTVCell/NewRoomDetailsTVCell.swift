//
//  NewRoomDetailsTVCell.swift
//  BabSafar
//
//  Created by FCI on 26/08/23.
//

import UIKit
protocol NewRoomDetailsTVCellDelegate:AnyObject {
    func didTapOnCancellationPolicyBtnAction(cell:NewRoomDetailsTVCell)
    func didTapOnSelectRoomBtnAction(cell:NewRoomDetailsTVCell)
    
}

class NewRoomDetailsTVCell: UITableViewCell {
    
    
    @IBOutlet weak var noofGuestlbl: UILabel!
    @IBOutlet weak var pricelbl: UILabel!
    @IBOutlet weak var selectRoomBtnView: BorderedView!
    
    @IBOutlet weak var leftview: BorderedView!
    @IBOutlet weak var rightview: BorderedView!
    
    
    var selectedindexPath:Int?
    var selectedRoomIndex = String()
    var cancellatonStringArray = [Cancellation_string]()
    var selectedRoom = String()
    var currency = ""
    var exactprice = ""
    var isSelectedCell: Bool = false {
        didSet {
            updateButtonColor()
        }
    }
    private var unselectedBackgroundColor: UIColor = .AppBtnColor

    var indexpathvalue : IndexPath?
    var fareTypeString = String()
    var CancellationPolicyAmount = String()
    var CancellationPolicyFromDate = String()
    var ratekey = String()
    var ratekeyNewArray = [String]()
    weak var delegate:NewRoomDetailsTVCellDelegate?
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
        
        selectRoomBtnView.backgroundColor = .AppBtnColor
        
//        leftview.layer.maskedCorners = [.layerMinXMaxYCorner]
//        leftview.layer.cornerRadius = 8
//
//        rightview.layer.maskedCorners = [.layerMaxXMaxYCorner]
//        rightview.layer.cornerRadius = 8
        
        
    }
    
    
    
    
    func updateButtonColor() {
        selectRoomBtnView.backgroundColor = isSelectedCell ? .BooknowBtnColor : .AppBtnColor
    }
    
    
    
    
    
    @IBAction func didTapOnCancellationPolicyBtnAction(_ sender: Any) {
        delegate?.didTapOnCancellationPolicyBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnSelectRoomBtnAction(_ sender: Any) {
        delegate?.didTapOnSelectRoomBtnAction(cell: self)
    }
    
    
}
