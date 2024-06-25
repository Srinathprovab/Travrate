//
//  AddonTableViewCell.swift
//  Burhantrips
//
//  Created by MA1882 on 20/01/24.
//

import UIKit

protocol AddonTableViewCellDelegate {
    func didSelectAddon(index: Int, origen: String)
    func didDeselectAddon(index: Int, origen: String )
}

class AddonTableViewCell: TableViewCell, UITableViewDelegate, UITableViewDataSource {
    
    //    @IBOutlet weak var tvheight: NSLayoutConstraint!
    @IBOutlet weak var addonTV: UITableView!
    
    var displayFirstHalf: Bool = true
    var firstHalfAddonServices: [Addon_services] = []
    var secondHalfAddonServices: [Addon_services] = []
    var selectedFirstHalfIndexPathArray = [IndexPath]()
    var selectedSecondIndexPathArray = [IndexPath]()
    var selectedAddonPrices: [Double] = [] // Track selected prices
    var totalPrice: Double = 0.0 {
        didSet {
            print("Total Price: \(totalPrice)") // Print the total price
        }
    }
    
    var firstHalfSelectionState: [Bool] = []
    var secondHalfSelectionState: [Bool] = []

    var delegate: AddonTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
        setupUI()
    }
    
    override func updateUI() {
        
        
        if cellInfo?.key1 == "first" {
            displayFirstHalf = true
        } else {
            displayFirstHalf = false
        }
        
        setupTV()
        addonTV.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setupUI() {
        //setupTV()
    }
    
    
    
}

extension AddonTableViewCell {
    
    func setupTV() {
        addonTV.delegate = self
        addonTV.dataSource = self
        addonTV.separatorStyle = .none
        addonTV.allowsMultipleSelection = true
        let nib = UINib(nibName: "AddonContentTVCell", bundle: nil)
        addonTV.register(nib, forCellReuseIdentifier: "cell")
        
        splitAddonServices() // Split the add-on services
        
        
        
    }
    
    func splitAddonServices() {
        let count = addon_services.count
        guard count > 0 else {
            print("No addon services to split.")
            return
        }
        
        let midpoint = (count + 1) / 2
        firstHalfAddonServices = Array(addon_services.prefix(midpoint))
        secondHalfAddonServices = Array(addon_services.suffix(from: midpoint))
        
        firstHalfSelectionState = Array(repeating: false, count: firstHalfAddonServices.count)
        secondHalfSelectionState = Array(repeating: false, count: secondHalfAddonServices.count)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cellInfo?.key == "flight" {
            return displayFirstHalf ? firstHalfAddonServices.count : secondHalfAddonServices.count
        } else {
            return hotel_Addservices.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AddonContentTVCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        
        if cellInfo?.key == "flight" {
            let data: Addon_services
            
            
            if displayFirstHalf {
                data = firstHalfAddonServices[indexPath.row]
               
                
                if selectedFirstHalfIndexPathArray.contains(indexPath) {
                       cell.checkIMAGE.image = UIImage(named: "check")
                    tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
                }else {
                    cell.checkIMAGE.image = UIImage(named: "uncheck")
                    tableView.deselectRow(at: indexPath, animated: false)
                }
                
            } else {
                data = secondHalfAddonServices[indexPath.row]
               
                
                if selectedSecondIndexPathArray.contains(indexPath) {
                       cell.checkIMAGE.image = UIImage(named: "check")
                    tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
                }else {
                    cell.checkIMAGE.image = UIImage(named: "uncheck")
                    tableView.deselectRow(at: indexPath, animated: false)
                }
                
            }
            
            // Display data in the cell
            cell.leftICon.sd_setImage(with: URL(string: data.image ?? ""))
            cell.titleLabel.text = data.title
            cell.subTitleLabel.text = data.details
            cell.originValue = data.origin ?? ""
            cell.priceImage.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD") \(data.price ?? "0")"
            
           
            
            
        } else {
            let data = hotel_Addservices[indexPath.row]
            // Display data in the cell
            cell.leftICon.sd_setImage(with: URL(string: data.image ?? ""))
            cell.titleLabel.text = data.title
            cell.subTitleLabel.text = data.details
            cell.originValue = data.origin ?? ""
            cell.priceImage.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD") \(data.price ?? "0")"
        }
        
        return cell
    }
    
    
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? AddonContentTVCell else { return }
        
        if cellInfo?.key == "flight" {
            if displayFirstHalf {
                firstHalfSelectionState[indexPath.row] = true
                let selectedAddon = firstHalfAddonServices[indexPath.row]
                if let price = Double(selectedAddon.price ?? "0") {
                    totalWhatsAppPrice += price
                    print("Total WhatsApp Price: \(totalWhatsAppPrice)")
                }
                selectedFirstHalfIndexPathArray.append(indexPath)
            } else {
                secondHalfSelectionState[indexPath.row] = true
                let selectedAddon = secondHalfAddonServices[indexPath.row]
                if let price = Double(selectedAddon.price ?? "0") {
                    totalPriceChange += price
                    print("Total Price Change: \(totalPriceChange)")
                }
                selectedSecondIndexPathArray.append(indexPath)
            }
        }
        
        // Update UI
        cell.checkIMAGE.image = UIImage(named: "check")
        
        
       // delegate?.didSelectAddon(index: indexPath.row, origen: "")
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? AddonContentTVCell else { return }
        
        if cellInfo?.key == "flight" {
            if displayFirstHalf {
                firstHalfSelectionState[indexPath.row] = false
                let deselectedAddon = firstHalfAddonServices[indexPath.row]
                if let price = Double(deselectedAddon.price ?? "0") {
                    totalWhatsAppPrice -= price
                    print("Total WhatsApp Price: \(totalWhatsAppPrice)")
                }
                
                if let indexpath1 = selectedFirstHalfIndexPathArray.firstIndex(of: indexPath) {
                    selectedFirstHalfIndexPathArray.remove(at: indexpath1)
                }
                
            } else {
                secondHalfSelectionState[indexPath.row] = false
                let deselectedAddon = secondHalfAddonServices[indexPath.row]
                if let price = Double(deselectedAddon.price ?? "0") {
                    totalPriceChange -= price
                    print("Total Price Change: \(totalPriceChange)")
                }
                
                if let indexpath1 = selectedSecondIndexPathArray.firstIndex(of: indexPath) {
                    selectedSecondIndexPathArray.remove(at: indexpath1)
                }
            }
        }
        
        // Update UI
        cell.checkIMAGE.image = UIImage(named: "uncheck")
        
        
       // delegate?.didDeselectAddon(index: indexPath.row, origen: "")
    }

    
}



