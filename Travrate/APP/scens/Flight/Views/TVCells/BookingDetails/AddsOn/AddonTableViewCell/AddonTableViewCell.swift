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
    
    
    var delegate: AddonTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        
     
        // Initialization code
        setupUI()
    }
    
    override func updateUI() {
    
       
//        if cellInfo?.key == "flight" {
//            tvheight.constant = CGFloat(addon_services.count * 74)
//        } else {
//            tvheight.constant = CGFloat(hotel_Addservices.count * 74)
//        }
//        
//        addonTV.reloadData()
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
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cellInfo?.key == "flight" {
            addon_services.count
        } else {
            hotel_Addservices.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AddonContentTVCell {
            
            cell.selectionStyle = .none
            
            if cellInfo?.key == "flight" {
                let data = addon_services[indexPath.row]
                whatsAppPrice =  addon_services[0].price ?? "0"
                flexiblePrie =  addon_services[1].price ?? "0"
                priceChange =  addon_services[2].price ?? "0"
                notificationPrice = addon_services[3].price ?? "0"
               
                cell.leftICon.sd_setImage(with: URL(string: data.image ?? ""))
                cell.titleLabel.text = data.title
                cell.subTitleLabel.text = data.details
                cell.originValue = data.origin ?? ""
                cell.priceImage.text = "\(defaults.string(forKey:UserDefaultsKeys.selectedCurrency) ?? "KWD") \(data.price ?? "0")"
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
