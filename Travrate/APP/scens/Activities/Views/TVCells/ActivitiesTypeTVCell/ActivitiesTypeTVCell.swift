//
//  ActivitiesTypeTVCell.swift
//  Travrate
//
//  Created by Admin on 17/07/24.
//

import UIKit

class ActivitiesTypeTVCell: UITableViewCell {
    
    @IBOutlet weak var typeTV: UITableView!
    @IBOutlet weak var tvheight: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupTV()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}



extension ActivitiesTypeTVCell:UITableViewDelegate,UITableViewDataSource {
    
    
    
    func setupTV() {
        typeTV.register(UINib(nibName: "ActivitiesTypeInfoTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        typeTV.delegate = self
        typeTV.dataSource = self
        typeTV.tableFooterView = UIView()
        typeTV.showsHorizontalScrollIndicator = false
        typeTV.separatorStyle = .singleLine
        typeTV.isScrollEnabled = false
        typeTV.separatorStyle = .none
        typeTV.allowsMultipleSelection = true
        
    }
    
    
    func updateHeight() {
        tvheight.constant = 10 * 146
        typeTV.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ActivitiesTypeInfoTVCell {
            
            
            
            cell.activitiesTypeNamelbl.text = "Private Transfer"
            
            MySingleton.shared.setAttributedTextnew(str1: "\(MySingleton.shared.activites_currency) ",
                                                    str2: "250.00",
                                                    lbl: cell.kedlbl,
                                                    str1font: .InterSemiBold(size: 12),
                                                    str2font: .InterSemiBold(size: 22),
                                                    str1Color: .TitleColor,
                                                    str2Color: .TitleColor)
            
            c = cell
            
        }
        return c
    }
    

    
}
