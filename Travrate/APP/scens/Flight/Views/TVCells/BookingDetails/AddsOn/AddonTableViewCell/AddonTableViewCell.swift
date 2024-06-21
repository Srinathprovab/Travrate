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
    var delegate: AddonTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
        setupUI()
    }
    
    override func updateUI() {
        
        
        if cellInfo?.key1 == "first" {
            displayFirstHalf = true
        }else {
            
            displayFirstHalf = false
        }
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setupUI() {
        setupTV()
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
    
    // Function to split the add-on services into two arrays
    func splitAddonServices() {
        let count = addon_services.count
        
        // Ensure there's something to split
        guard count > 0 else {
            print("No addon services to split.")
            return
        }
        
        // Calculate the midpoint
        let midpoint = (count + 1) / 2 // Rounded up to handle odd counts
        
        // Use slicing to create two arrays
        firstHalfAddonServices = Array(addon_services.prefix(midpoint))
        secondHalfAddonServices = Array(addon_services.suffix(from: midpoint))
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cellInfo?.key == "flight" {
            // addon_services.count
            if displayFirstHalf == true{
                return secondHalfAddonServices.count
            }else {
                return firstHalfAddonServices.count
            }
        } else {
            return hotel_Addservices.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AddonContentTVCell {
            
            cell.selectionStyle = .none
            
            if cellInfo?.key == "flight" {
                //let data = addon_services[indexPath.row]
                //                whatsAppPrice =  addon_services[0].price ?? "0"
                //                flexiblePrie =  addon_services[1].price ?? "0"
                //                priceChange =  addon_services[2].price ?? "0"
                //                notificationPrice = addon_services[3].price ?? "0"
                
                //                cell.leftICon.sd_setImage(with: URL(string: data.image ?? ""))
                //                cell.titleLabel.text = data.title
                //                cell.subTitleLabel.text = data.details
                //                cell.originValue = data.origin ?? ""
                //                cell.priceImage.text = "\(defaults.string(forKey:UserDefaultsKeys.selectedCurrency) ?? "KWD") \(data.price ?? "0")"
                
               // let data: Addon_services
                if displayFirstHalf == true{
                    let data = secondHalfAddonServices[indexPath.row]
                   
                    priceChange =  addon_services[0].price ?? "0"
                    notificationPrice = addon_services[1].price ?? "0"
                    cell.leftICon.sd_setImage(with: URL(string: data.image ?? ""))
                    cell.titleLabel.text = data.title
                    cell.subTitleLabel.text = data.details
                    cell.originValue = data.origin ?? ""
                    cell.priceImage.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD") \(data.price ?? "0")"
                    
                    print(data.title)
                    
                } else {
                    let data = firstHalfAddonServices[indexPath.row]
                    whatsAppPrice =  addon_services[0].price ?? "0"
                    flexiblePrie =  addon_services[1].price ?? "0"
                    
                    cell.leftICon.sd_setImage(with: URL(string: data.image ?? ""))
                    cell.titleLabel.text = data.title
                    cell.subTitleLabel.text = data.details
                    cell.originValue = data.origin ?? ""
                    cell.priceImage.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD") \(data.price ?? "0")"
                    
                    print(data.title)
                }
                
             
            } else {
                let data = hotel_Addservices[indexPath.row]
                //                hotelwhatsAppPrice =  hotel_Addservices[0].price ?? "0"
                //                hotelflexiblePrie =  hotel_Addservices[1].price ?? "0"
                hotelpriceChange =  hotel_Addservices[0].price ?? "0"
                hotelnotificationPrice = hotel_Addservices[1].price ?? "0"
                
                cell.leftICon.sd_setImage(with: URL(string: data.image ?? ""))
                cell.titleLabel.text = data.title
                cell.subTitleLabel.text = data.details
                cell.originValue = data.origin ?? ""
                cell.priceImage.text = "\(defaults.string(forKey:UserDefaultsKeys.selectedCurrency) ?? "KWD") \(data.price ?? "0")"
            }
            
            ccell = cell
        }
        return ccell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? AddonContentTVCell {
            cell.checkIMAGE.image = UIImage(named: "check")
            
            if cellInfo?.key == "flight" {
                
                origin_array.append(cell.originValue)
                print("value is \(origin_array.joined(separator: ",") )")
                
            }
            
            
            delegate?.didDeselectAddon(index: indexPath.row, origen: "")
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? AddonContentTVCell {
            
            cell.checkIMAGE.image = UIImage(named: "uncheck")
            if cellInfo?.key == "flight" {
                
                let unselectedItem = cell.originValue
                if let index = origin_array.firstIndex(of: unselectedItem) {
                    origin_array.remove(at: index)
                }
                
                print("value is \(origin_array.joined(separator: ",") )")
            }
            
            delegate?.didSelectAddon(index: indexPath.row, origen: "")
        }
    }
}
