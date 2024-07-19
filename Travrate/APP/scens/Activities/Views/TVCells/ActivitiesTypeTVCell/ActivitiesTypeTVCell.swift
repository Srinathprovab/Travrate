//
//  ActivitiesTypeTVCell.swift
//  Travrate
//
//  Created by Admin on 17/07/24.
//

import UIKit

protocol ActivitiesTypeTVCellDelegate {
    func didTapOnBookNowBtnAction(cell:ActivitiesTypeInfoTVCell)
}

class ActivitiesTypeTVCell: UITableViewCell, ActivitiesTypeInfoTVCellDelegate {
    
    
    @IBOutlet weak var typeTV: UITableView!
    @IBOutlet weak var tvheight: NSLayoutConstraint!
    
    
    var delegate:ActivitiesTypeTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupTV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func didTapOnBookNowBtnAction(cell: ActivitiesTypeInfoTVCell) {
        delegate?.didTapOnBookNowBtnAction(cell: cell)
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
        tvheight.constant = calculateTableViewHeight()
        typeTV.reloadData()
    }
    
    func calculateTableViewHeight() -> CGFloat {
        let numberOfCells = MySingleton.shared.activity_details?.modalities?.count ?? 0
        let sampleIndexPath = IndexPath(row: 0, section: 0)
        
        guard let sampleCell = typeTV.dequeueReusableCell(withIdentifier: "cell") as? ActivitiesTypeInfoTVCell else {
            return 0
        }
        
        // Configure the sample cell with sample data to calculate the height
        if let data = MySingleton.shared.activity_details?.modalities?.first {
            sampleCell.activitiesTypeNamelbl.text = data.name
            MySingleton.shared.setAttributedTextnew(str1: "\(MySingleton.shared.activites_currency) ",
                                                    str2: "250.00",
                                                    lbl: sampleCell.kedlbl,
                                                    str1font: .InterSemiBold(size: 12),
                                                    str2font: .InterSemiBold(size: 22),
                                                    str1Color: .TitleColor,
                                                    str2Color: .TitleColor)
            
            
            sampleCell.img.image = UIImage(named: "car")
        }
        
        
        
        
        // Ensure the sample cell is fully laid out
        sampleCell.setNeedsLayout()
        sampleCell.layoutIfNeeded()
        
        // Calculate the height of the sample cell using sizeThatFits method
        let targetSize = CGSize(width: typeTV.frame.width, height: UIView.layoutFittingCompressedSize.height)
        let cellHeight = sampleCell.contentView.systemLayoutSizeFitting(targetSize).height
        
        // Add a small padding to avoid cutting off the cell
        let padding: CGFloat = 0
        
        return CGFloat(numberOfCells) * (cellHeight + padding)
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MySingleton.shared.activity_details?.modalities?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ActivitiesTypeInfoTVCell {
            
            cell.delegate = self
            
            let data = MySingleton.shared.activity_details?.modalities?[indexPath.row]
            
            cell.activitiesTypeNamelbl.text = data?.name
            cell.rateKeySring = data?.rates?[0].rateDetails?[0].rateKey ?? ""
            cell.agentpayable = String(format: "%.2f",  data?.amountsFrom?[0].amount?.default_value ?? 0.0)
            
            MySingleton.shared.setAttributedTextnew(str1: "\(MySingleton.shared.activites_currency) ",
                                                    str2: String(format: "%.2f",  data?.amountsFrom?[0].amount?.default_value ?? 0.0),
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
