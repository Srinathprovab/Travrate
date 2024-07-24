//
//  AddonTableViewCell.swift
//  Burhantrips
//
//  Created by MA1882 on 20/01/24.  
//

import UIKit

protocol AddonTableViewCellDelegate {
    func didSelectAddon(index: Int, origen: String,price:String)
    func didDeselectAddon(index: Int, origen: String)
}

class AddonTableViewCell: TableViewCell, UITableViewDelegate, UITableViewDataSource {
    
    //    @IBOutlet weak var tvheight: NSLayoutConstraint!
    @IBOutlet weak var addonTV: UITableView!
    
    var displayFirstHalf: Bool = true
    var firstHalfAddonServices: [Addon_services] = []
    var secondHalfAddonServices: [Addon_services] = []
    
    var selectedFirstHalfIndexPathArray = [IndexPath]()
    var selectedSecondIndexPathArray = [IndexPath(item: 1, section: 0)]
    var hotelselectedIndexPathArray = [IndexPath]()
    
    var selectedAddonPrices: [Double] = [] // Track selected prices
    var totalPrice: Double = 0.0 {
        didSet {
            print("Total Price: \(totalPrice)") // Print the total price
        }
    }
    
    
    var caraddon = [Addon_services]()
    var transferaddon = [Addon_services]()
    var activitiesAddon = [Addon_services]()
    var firstHalfSelectionState: [Bool] = []
    var secondHalfSelectionState: [Bool] = []
    // var hotelSelectionState: [Bool] = []
    
    
    //MARK - for hotel
    var totalHotelGrand: Double = 0.0
    
    
    var delegate: AddonTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
        setupUI()
    }
    
    override func updateUI() {
        
        activitiesAddon = MySingleton.shared.activitiesAddonServices
        caraddon = MySingleton.shared.carAddonServices
        transferaddon = MySingleton.shared.transferAddonServices
        
        
        
        
        if cellInfo?.key == "flight" {
            if cellInfo?.key1 == "first" {
                displayFirstHalf = true
            } else {
                displayFirstHalf = false
            }
        } else if cellInfo?.key == "car" {
            
        } else{
            
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
        } else if cellInfo?.key == "car" {
            return caraddon.count
        }else if cellInfo?.key == "transfer" {
            return transferaddon.count
        }else if cellInfo?.key == "activities" {
            return activitiesAddon.count
        } else{
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
            
        } else if cellInfo?.key == "car"{
            let data = caraddon[indexPath.row]
            // Display data in the cell
            cell.leftICon.sd_setImage(with: URL(string: data.images ?? ""))
            cell.titleLabel.text = data.title
            cell.subTitleLabel.text = data.details
            cell.originValue = data.origin ?? ""
            cell.priceImage.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD") \(data.price ?? "0")"
        }else if cellInfo?.key == "transfer"{
            let data = transferaddon[indexPath.row]
            // Display data in the cell
            cell.leftICon.sd_setImage(with: URL(string: data.images ?? ""))
            cell.titleLabel.text = data.title
            cell.subTitleLabel.text = data.details
            cell.originValue = data.origin ?? ""
            cell.priceImage.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD") \(data.price ?? "0")"
            
            if hotelflexibleCheck == true && hotelwhatsAppCheck == true {
                cell.checkIMAGE.image = UIImage(named: "check")
                MySingleton.shared.addonServicesOrigenArray.append(data.origin ?? "")
                tableView.selectAllRows(animated: true)
            }
            
            
        }else if cellInfo?.key == "activities"{
            let data = activitiesAddon[indexPath.row]
            // Display data in the cell
            cell.leftICon.sd_setImage(with: URL(string: data.images ?? ""))
            cell.titleLabel.text = data.title
            cell.subTitleLabel.text = data.details
            cell.originValue = data.origin ?? ""
            cell.priceImage.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD") \(data.price ?? "0")"
            
            
            
        }else {
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
                selectedFirstHalfIndexPathArray.append(indexPath)
                updateFlightTotal(for: firstHalfAddonServices[indexPath.row], isSelected: true)
                
                
                delegate?.didSelectAddon(index: indexPath.row, origen: "first", price: firstHalfAddonServices[indexPath.row].price ?? "")
            } else {
                secondHalfSelectionState[indexPath.row] = true
                selectedSecondIndexPathArray.append(indexPath)
                updateFlightTotal(for: secondHalfAddonServices[indexPath.row], isSelected: true)
                
                delegate?.didSelectAddon(index: indexPath.row, origen: "second", price: secondHalfAddonServices[indexPath.row].price ?? "")
            }
            
            
            MySingleton.shared.addonServicesOrigenArray.append(cell.originValue)
        }else if cellInfo?.key == "car" {
            let carService = caraddon[indexPath.row] as Addon_services
            hotelselectedIndexPathArray.append(indexPath)
            updateCarTotal(for: carService, isSelected: true)
            
            MySingleton.shared.addonServicesOrigenArray.append(cell.originValue)
            delegate?.didSelectAddon(index: indexPath.row, origen: "", price: carService.price ?? "")
        }else if cellInfo?.key == "transfer" {
            let carService = transferaddon[indexPath.row] as Addon_services
            hotelselectedIndexPathArray.append(indexPath)
            updateTransferTotal(for: carService, isSelected: true)
            
            MySingleton.shared.addonServicesOrigenArray.append(cell.originValue)
            delegate?.didSelectAddon(index: indexPath.row, origen: "", price: carService.price ?? "")
        }else if cellInfo?.key == "activities" {
            let carService = activitiesAddon[indexPath.row] as Addon_services
            hotelselectedIndexPathArray.append(indexPath)
            updateActivitiesTotal(for: carService, isSelected: true)
            
            MySingleton.shared.addonServicesOrigenArray.append(cell.originValue)
            delegate?.didSelectAddon(index: indexPath.row, origen: "", price: carService.price ?? "")
        }else {
            
            let hotelService = hotel_Addservices[indexPath.row] as HotelAddonModel
            hotelselectedIndexPathArray.append(indexPath)
            updateHotelTotal(for: hotelService, isSelected: true)
            
            MySingleton.shared.addonServicesOrigenArray.append(cell.originValue)
            delegate?.didSelectAddon(index: indexPath.row, origen: "", price: hotelService.price ?? "")
        }
        
        cell.checkIMAGE.image = UIImage(named: "check")
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? AddonContentTVCell else { return }
        
        if cellInfo?.key == "flight" {
            if displayFirstHalf {
                firstHalfSelectionState[indexPath.row] = false
                removeIndexPath(&selectedFirstHalfIndexPathArray, indexPath: indexPath)
                updateFlightTotal(for: firstHalfAddonServices[indexPath.row], isSelected: false)
                
                delegate?.didDeselectAddon(index: indexPath.row, origen: "first")
            } else {
                secondHalfSelectionState[indexPath.row] = false
                removeIndexPath(&selectedSecondIndexPathArray, indexPath: indexPath)
                updateFlightTotal(for: secondHalfAddonServices[indexPath.row], isSelected: false)
                
                delegate?.didDeselectAddon(index: indexPath.row, origen: "second")
            }
        }else if cellInfo?.key == "car" {
            
            let carService = caraddon[indexPath.row] as Addon_services
            removeIndexPath(&hotelselectedIndexPathArray, indexPath: indexPath)
            updateCarTotal(for: carService, isSelected: false)
            
            delegate?.didDeselectAddon(index: indexPath.row, origen: "")
            
        }else if cellInfo?.key == "transfer" {
            
            let carService = transferaddon[indexPath.row] as Addon_services
            removeIndexPath(&hotelselectedIndexPathArray, indexPath: indexPath)
            updateTransferTotal(for: carService, isSelected: false)
            
            
            if let index = MySingleton.shared.addonServicesOrigenArray.firstIndex(of: cell.originValue)  {
                MySingleton.shared.addonServicesOrigenArray.remove(at: index)
            }
            
            
            delegate?.didDeselectAddon(index: indexPath.row, origen: "")
            
        }else if cellInfo?.key == "activities" {
            
            let carService = activitiesAddon[indexPath.row] as Addon_services
            removeIndexPath(&hotelselectedIndexPathArray, indexPath: indexPath)
            updateActivitiesTotal(for: carService, isSelected: false)
            
            
            if let index = MySingleton.shared.addonServicesOrigenArray.firstIndex(of: cell.originValue)  {
                MySingleton.shared.addonServicesOrigenArray.remove(at: index)
            }
            
            
            delegate?.didDeselectAddon(index: indexPath.row, origen: "")
            
        }else {
            let hotelService = hotel_Addservices[indexPath.row] as HotelAddonModel
            removeIndexPath(&hotelselectedIndexPathArray, indexPath: indexPath)
            updateHotelTotal(for: hotelService, isSelected: false)
            
            delegate?.didDeselectAddon(index: indexPath.row, origen: "")
        }
        
        cell.checkIMAGE.image = UIImage(named: "uncheck")
    }
    
    
    //MARK: - updateFlightTotal
    private func updateFlightTotal(for service: Addon_services, isSelected: Bool) {
        let amount = Double(service.price ?? "0") ?? 0
        if isSelected {
            totlConvertedGrand += amount
        } else {
            totlConvertedGrand -= amount
        }
        
        // Optionally update your UI with the new total
        // updateTotalLabel()
        
        
    }
    
    private func removeIndexPath(_ array: inout [IndexPath], indexPath: IndexPath) {
        if let index = array.firstIndex(of: indexPath) {
            array.remove(at: index)
        }
    }
    
    
    //MARK: - updateHotelTotal
    
    private func updateHotelTotal(for service: HotelAddonModel, isSelected: Bool) {
        let amount = Double(service.price ?? "0") ?? 0
        if isSelected {
            totlConvertedGrand += amount
        } else {
            totlConvertedGrand -= amount
        }
        
        // Optionally update your UI with the new total
        // updateTotalLabel()
        
        print("Updated Hotel Total: \(totlConvertedGrand)")
    }
    
    
    
    
    //MARK: - updateCarTotal Car Rental
    
    private func updateCarTotal(for service: Addon_services, isSelected: Bool) {
        let amount = Double(service.price ?? "0") ?? 0
        if isSelected {
            totlConvertedGrand += amount
        } else {
            totlConvertedGrand -= amount
        }
        
        // Optionally update your UI with the new total
        // updateTotalLabel()
        
        print("Updated Hotel Total: \(totlConvertedGrand)")
    }
    
    
    //MARK: - updateCarTotal transfer
    
    private func updateTransferTotal(for service: Addon_services, isSelected: Bool) {
        let amount = Double(service.price ?? "0") ?? 0
        if isSelected {
            totlConvertedGrand += amount
        } else {
            totlConvertedGrand -= amount
        }
        
        // Optionally update your UI with the new total
        // updateTotalLabel()
        
        print("Updated Hotel Total: \(totlConvertedGrand)")
    }
    
    
    //MARK: - updateCarTotal Activities
    
    private func updateActivitiesTotal(for service: Addon_services, isSelected: Bool) {
        let amount = Double(service.price ?? "0") ?? 0
        if isSelected {
            totlConvertedGrand += amount
        } else {
            totlConvertedGrand -= amount
        }
        
        // Optionally update your UI with the new total
        // updateTotalLabel()
        
        print("Updated Hotel Total: \(totlConvertedGrand)")
    }
    
    
}



extension UITableView {
    func selectAllRows(animated: Bool, scrollPosition: UITableView.ScrollPosition = .none) {
        for section in 0..<self.numberOfSections {
            for row in 0..<self.numberOfRows(inSection: section) {
                let indexPath = IndexPath(row: row, section: section)
                self.selectRow(at: indexPath, animated: animated, scrollPosition: scrollPosition)
            }
        }
    }
}
