//
//  CRFareSummaryTVCell.swift
//  Travrate
//
//  Created by FCI on 14/06/24.
//

import UIKit

protocol CRFareSummaryTVCelldelegate {
    func didTapOnDeleteOptionsBtnAction(cell:CRFareSummaryTVCell)
}

class CRFareSummaryTVCell: TableViewCell {
    
    
    @IBOutlet weak var topview: UIView!
    @IBOutlet weak var carrentalPrice: UILabel!
    @IBOutlet weak var subtotalprice: UILabel!
    @IBOutlet weak var totalprice: UILabel!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var notificationkwdlbl: UILabel!
    @IBOutlet weak var priceChangekwdlbl: UILabel!
    @IBOutlet weak var extraView: UIView!
    @IBOutlet weak var extratv: UITableView!
    @IBOutlet weak var tvheight: NSLayoutConstraint!
    
    
    var delegate : CRFareSummaryTVCelldelegate?
    var carproductDetails :Product?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupTV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        
        
        notificationView.isHidden = true
        priceView.isHidden = true
        extraView.isHidden = true
        
        
        if  hotelpriceCheck == true {
            priceView.isHidden = false
        } else {
            priceView.isHidden = true
        }
        
        if  hotelnotificationCheck == true {
            notificationView.isHidden = false
        } else {
            notificationView.isHidden = true
        }
        
        
        //        if hotelpriceCheck  == false && hotelnotificationCheck == false  {
        //            priceView.isHidden = true
        //            notificationView.isHidden = true
        //        } else {
        //            priceView.isHidden = false
        //            notificationView.isHidden = false
        //        }
        
        
        carproductDetails = cellInfo?.moreData as? Product
        topview.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        topview.layer.cornerRadius = 8
        
        MySingleton.shared.setAttributedTextnew(str1: carproductDetails?.currency ?? "",
                                                str2: String(format: "%.2f", Double(carproductDetails?.total ?? "") ?? 0.0),
                                                lbl: carrentalPrice,
                                                str1font: .InterSemiBold(size: 16),
                                                str2font: .InterSemiBold(size: 16),
                                                str1Color: .TitleColor,
                                                str2Color: .TitleColor)
        
        MySingleton.shared.setAttributedTextnew(str1: carproductDetails?.currency ?? "",
                                                str2: String(format: "%.2f", Double(carproductDetails?.total ?? "") ?? 0.0),
                                                lbl: subtotalprice,
                                                str1font: .InterSemiBold(size: 16),
                                                str2font: .InterSemiBold(size: 16),
                                                str1Color: .TitleColor,
                                                str2Color: .TitleColor)
        
        
        MySingleton.shared.setAttributedTextnew(str1: carproductDetails?.currency ?? "",
                                                str2: String(format: "%.2f", totlConvertedGrand),
                                                lbl: totalprice,
                                                str1font: .InterSemiBold(size: 16),
                                                str2font: .InterSemiBold(size: 16),
                                                str1Color: .TitleColor,
                                                str2Color: .TitleColor)
        
        
        
        
        
        notificationkwdlbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD") \(hotelnotificationPrice)"
        priceChangekwdlbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD") \(hotelpriceChange)"
        
        updateHeight()
        
    }
    
    
    func updateHeight() {
        if selectedOptions.count > 0 {
            extraView.isHidden = false
            tvheight.constant = CGFloat(selectedOptions.count * 45)
            extratv.reloadData()
        }
    }
    
    
    @objc func didTapOnDeleteOptionsBtnAction(_ sender:UIButton) {
        totlConvertedGrand -= Double(selectedOptions[sender.tag].price ?? "") ?? 0.0
        selectedOptions.remove(at: sender.tag)
        extratv.deleteRows(at: [IndexPath(item: sender.tag, section: 0)], with: .automatic)
        delegate?.didTapOnDeleteOptionsBtnAction(cell: self)
    }
    
    
}



extension CRFareSummaryTVCell:UITableViewDelegate,UITableViewDataSource {
    
    
    
    func setupTV() {
        extratv.register(UINib(nibName: "AdditionalDriverInfoTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        extratv.delegate = self
        extratv.dataSource = self
        extratv.tableFooterView = UIView()
        extratv.showsHorizontalScrollIndicator = false
        extratv.separatorStyle = .singleLine
        extratv.isScrollEnabled = false
        extratv.separatorStyle = .none
        extratv.allowsMultipleSelection = true
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AdditionalDriverInfoTVCell {
            
            cell.deleteBtn.tag = indexPath.row
            cell.deleteBtn.addTarget(self, action: #selector(didTapOnDeleteOptionsBtnAction(_:)), for: .touchUpInside)
            cell.optionNamelbl.text = selectedOptions[indexPath.row].title ?? ""
            MySingleton.shared.setAttributedTextnew(str1: selectedOptions[indexPath.row].currency ?? "",
                                                    str2: String(format: "%.2f", Double(selectedOptions[indexPath.row].price ?? "") ?? 0.0) ,
                                                    lbl: cell.pricelbl,
                                                    str1font: .InterRegular(size: 16),
                                                    str2font: .InterRegular(size: 16),
                                                    str1Color: .TitleColor,
                                                    str2Color: .TitleColor)
            
            
            
            if cellInfo?.key == "selectpayment" {
                cell.deleteBtn.isHidden = false
            }
            
            
            c = cell
            
        }
        return c
    }
    
    
    
    
}
