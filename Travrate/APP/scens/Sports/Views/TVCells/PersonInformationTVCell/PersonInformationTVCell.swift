//
//  PersonInformationTVCell.swift
//  Travrate
//
//  Created by FCI on 28/05/24.
//

import UIKit
import DropDown

protocol PersonInformationTVCellDelegate {
    func didTapOnSelectPersonsBtnAction(cell:PersonInformationTVCell)
    func didTapOnSelectTicketTypeBtnAction(cell:PersonInformationTVCell)
}

class PersonInformationTVCell: TableViewCell {
    
    @IBOutlet weak var personslbl: UILabel!
    @IBOutlet weak var tickettypelbl: UILabel!
    @IBOutlet weak var personsView: BorderedView!
    @IBOutlet weak var tickettypeView: BorderedView!
    
    
    
    var personsDropdown = DropDown()
    var tickettypeDropdown = DropDown()
    var delegate:PersonInformationTVCellDelegate?
    
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
        setuppersonsDropdown()
        setuptickettypeDropdown()
    }
    
    @IBAction func didTapOnSelectPersonsBtnAction(_ sender: Any) {
        personsDropdown.show()
    }
    
    
    
    
    @IBAction func didTapOnSelectTicketTypeBtnAction(_ sender: Any) {
        tickettypeDropdown.show()
    }
    
    
}


extension PersonInformationTVCell {
    
    func setuppersonsDropdown() {
        
        
        var noofpersonsArray = [String]()
        for i in 1 ... (MySingleton.shared.sportsBookingData?.event_list?.availableCategoriesQuantity ?? 0) {
            noofpersonsArray.append("\(i)")
        }
        
        personsDropdown.dataSource = noofpersonsArray
        personsDropdown.direction = .bottom
        personsDropdown.backgroundColor = .WhiteColor
        personsDropdown.anchorView = self.personsView
        personsDropdown.bottomOffset = CGPoint(x: 0, y: personsView.frame.size.height + 20)
        personsDropdown.selectionAction = { [weak self] (index: Int, item: String) in
            
            self?.personslbl.text = item
            self?.personslbl.textColor = .TitleColor
            self?.delegate?.didTapOnSelectPersonsBtnAction(cell: self!)
            
        }
        
    }
    
    
    func setuptickettypeDropdown() {
        
        var shippingnameArray = [String]()
        var shippingCostArray = [Int]()
        shippingnameArray.removeAll()
        shippingCostArray.removeAll()
        shippingnameArray.append("Select Shipping")
        shippingCostArray.append(0)
        MySingleton.shared.sportsBookingData?.ticket_value?.deliveryMethods?.forEach({ i in
            shippingnameArray.append("\(i.name ?? "") Delivery Charges \(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "") \(i.price ?? 0)")
            shippingCostArray.append(i.price ?? 0)
        })
        
        tickettypeDropdown.dataSource = shippingnameArray
        tickettypeDropdown.direction = .bottom
        tickettypeDropdown.backgroundColor = .WhiteColor
        tickettypeDropdown.anchorView = self.tickettypeView
        tickettypeDropdown.bottomOffset = CGPoint(x: 0, y: tickettypeView.frame.size.height + 20)
        tickettypeDropdown.selectionAction = { [weak self] (index: Int, item: String) in
            
            self?.tickettypelbl.text = item
            self?.tickettypelbl.textColor = .TitleColor
            MySingleton.shared.sportsShippingFees = shippingCostArray[index]
            self?.delegate?.didTapOnSelectTicketTypeBtnAction(cell: self!)
            
        }
        
    }
}
