//
//  QuickLinkTableViewCell.swift
//  Travrun
//
//  Created by MA1882 on 15/11/23.
//

import UIKit


protocol QuickLinkTableViewCellDelegate: AnyObject {
    func didTaponCell(cell:SideMenuTitleTVCell)
}

class QuickLinkTableViewCell: TableViewCell, UITableViewDataSource, UITableViewDelegate, SideMenuTitleTVCellDelegate {
    

    
    @IBOutlet weak var holderViewHeight: NSLayoutConstraint!
    @IBOutlet weak var linkstv: UITableView!
    @IBOutlet weak var holderView: UIView!
    
    
    
    weak var delegate:QuickLinkTableViewCellDelegate?
    var bookings = ["My Bookings", "Free Cancellation", "Customer Support"]
    var tabNamesImages = ["flightIcon","hotelIcon","visaIcon", "payIcon"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        holderView.layer.cornerRadius = 12
        holderView.layer.borderColor = HexColor("#DADCDB").cgColor
        holderView.layer.borderWidth = 1
        linkstv.delegate = self
        linkstv.dataSource = self
        linkstv.register(UINib(nibName: "SideMenuTitleTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        linkstv.register(UINib(nibName: "SideMenuTitleTVCell", bundle: nil), forCellReuseIdentifier: "cell1")
        linkstv.register(UINib(nibName: "SideMenuTitleTVCell", bundle: nil), forCellReuseIdentifier: "cell2")
        linkstv.register(UINib(nibName: "SideMenuTitleTVCell", bundle: nil), forCellReuseIdentifier: "cell3")
        
        linkstv.register(UINib(nibName: "EmptyTVCell", bundle: nil), forCellReuseIdentifier: "cell3")
    }
    
    override func updateUI() {
        
        if cellInfo?.key == "links" {
            updateHeight(height: 5)
        } else {
            updateHeight(height: 3)
        }
        
    }
    
    
    func updateHeight(height:Int) {
        holderViewHeight.constant = CGFloat(height * 46)
        linkstv.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func didTaponCell(cell: SideMenuTitleTVCell) {
        delegate?.didTaponCell(cell: cell)
    }
}

extension QuickLinkTableViewCell {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cellInfo?.key == "links" {
            return 5
        } else {
            return 3
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if cellInfo?.key == "links" {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! SideMenuTitleTVCell
                cell.menuOptionImg.isHidden = true
                cell.menuTitlelbl.text = "Quick Links"
                cell.arrowImage.isHidden = true
                cell.delegate = self
                return cell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SideMenuTitleTVCell
                cell.menuTitlelbl.text = "Flight"
                cell.menuOptionImg.image = UIImage(named: "flight")
                cell.delegate = self
                return cell
            } else if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SideMenuTitleTVCell
                cell.menuTitlelbl.text = "Hotel"
                cell.menuOptionImg.image = UIImage(named: "hotel")
                cell.delegate = self
                return cell
            } else if indexPath.row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SideMenuTitleTVCell
                cell.menuTitlelbl.text = "Transfers"
                cell.menuOptionImg.image = UIImage(named: "transfer")
                cell.delegate = self
                return cell
            }else  {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SideMenuTitleTVCell
                cell.menuTitlelbl.text = "Sports"
                cell.menuOptionImg.image = UIImage(named: "sports")
                cell.delegate = self
                return cell
            }
        } else {
            if indexPath.row == 0 {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! SideMenuTitleTVCell
                cell.menuTitlelbl.text = "My Bookings"
                cell.menuOptionImg.isHidden = true
                cell.delegate = self
                return cell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! SideMenuTitleTVCell
                cell.menuTitlelbl.text = "Free Cancellation"
                cell.menuOptionImg.isHidden = true
                cell.delegate = self
                return cell
                
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! SideMenuTitleTVCell
                cell.menuTitlelbl.text = "Customer Support"
                cell.menuOptionImg.isHidden = true
                cell.delegate = self
                return cell
                
            }
        }
        
    }
}

