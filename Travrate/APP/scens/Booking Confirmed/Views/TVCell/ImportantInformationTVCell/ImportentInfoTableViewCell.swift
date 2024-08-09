//
//  ImportentInfoTableViewCell.swift
//  Travrun
//
//  Created by MA1882 on 27/11/23.
//

import UIKit

class ImportentInfoTableViewCell: TableViewCell {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tvheight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        setupUI()
    }
    
    func setupTV() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ImportentInfoSubTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        updateHeight()
    }
    
    
    func setupUI() {
        
        holderView.layer.cornerRadius = 8
        holderView.layer.borderWidth = 1
        holderView.layer.borderColor = HexColor("#E6E8E7").cgColor
        
       
        setupTV()
    }
    
    
    func updateHeight() {
        tvheight.constant = CGFloat(MySingleton.shared.bookedbaggageDetails.count * 52)
        tableView.reloadData()
    }
    
}


extension ImportentInfoTableViewCell: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MySingleton.shared.bookedbaggageDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var commonCell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ImportentInfoSubTableViewCell {
            
            
            cell.departurelbl.text = "oneward"            
            if let convertedString = MySingleton.shared.convertToPC(input: MySingleton.shared.bookedbaggageDetails[indexPath.row].weight_Allowance ?? "") {
                cell.baggarelbl.text = convertedString
            } else {
                print("Invalid input format")
            }
            
            cell.durationlbl.text = MySingleton.shared.bookedbaggageDetails[indexPath.row].duration
            cell.classlbl.text = defaults.string(forKey: UserDefaultsKeys.selectClass)
            
            if tableView.isLast(for: indexPath) {
                if MySingleton.shared.bookedbaggageDetails.count == 2 {
                    cell.departurelbl.text = "backward"
                }
            }
            
            commonCell = cell
        }
        return commonCell
    }
}
