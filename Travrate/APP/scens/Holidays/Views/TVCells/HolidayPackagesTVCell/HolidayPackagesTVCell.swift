//
//  HolidayPackagesTVCell.swift
//  Travgate
//
//  Created by FCI on 26/02/24.
//

import UIKit
protocol HolidayPackagesTVCellDelegate:AnyObject {
    func didTapOnHolidayPackage(cell:HolidayPackagesTVCell)
}

class HolidayPackagesTVCell: TableViewCell {
    
    
    @IBOutlet weak var packageImage: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var holidaysTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    
    var holidayKey = String()
    weak var delegate:HolidayPackagesTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title ?? ""
        
        updateHeight()
    }
    
    
    func updateHeight() {
        tvHeight.constant = CGFloat(MySingleton.shared.holidaylist.count * 260)
        holidaysTV.reloadData()
    }
    
    
    func setupUI() {
        setupTV()
    }
    
}



extension HolidayPackagesTVCell:UITableViewDelegate,UITableViewDataSource {
    
    
    
    func setupTV() {
        holidaysTV.register(UINib(nibName: "HolidaysInfoTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        holidaysTV.delegate = self
        holidaysTV.dataSource = self
        holidaysTV.tableFooterView = UIView()
        holidaysTV.showsHorizontalScrollIndicator = false
        holidaysTV.separatorStyle = .singleLine
        holidaysTV.isScrollEnabled = false
        holidaysTV.separatorStyle = .none
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MySingleton.shared.holidaylist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? HolidaysInfoTVCell {
            
            cell.selectionStyle = .none
            let data = MySingleton.shared.holidaylist[indexPath.row]
            cell.titlelbl.text = data.heading ?? ""
            cell.subtitlelbl.text = data.subheading ?? ""
            cell.holidayKey = data.origin ?? ""
            
            cell.img.sd_setImage(with: URL(string: data.image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            
            
            c = cell
            
        }
        return c
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? HolidaysInfoTVCell {
            self.holidayKey = cell.holidayKey
        }
        delegate?.didTapOnHolidayPackage(cell: self)
    }
    
    
}
