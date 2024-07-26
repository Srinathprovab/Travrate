//
//  AddFareRulesTVCell.swift
//  Travrate
//
//  Created by FCI on 25/05/24.
//

import UIKit


protocol AddFareRulesTVCellDelegate: AnyObject {
    func didTapOnMoreFareRulesBtnAction(cell:AddFareRulesTVCell)
    func showContentBtnAction(cell:FareRulesTVCell)
}
class AddFareRulesTVCell: TableViewCell {
    
    
    @IBOutlet weak var farerulesTV: UITableView!
    @IBOutlet weak var seemorelbl: UILabel!
    @IBOutlet weak var arrowimg: UIImageView!
    @IBOutlet weak var tvheight: NSLayoutConstraint!
    
    weak var delegate:AddFareRulesTVCellDelegate?
    var morebool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setuUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setuUI() {
        arrowimg.image = UIImage(named: "downarrow")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        
        setupTV()
    }
    
    override func updateUI() {
        
        if morebool {
            tvheight.constant = CGFloat(MySingleton.shared.fareRulesData.count * 46)
        } else {
            tvheight.constant = CGFloat(MySingleton.shared.penalityArray.count * 46)
        }
        
        farerulesTV.reloadData()
        updateParentTableView()
        
    }
    
    @IBAction func didTapOnMoreFareRulesBtnAction(_ sender: Any) {
        morebool.toggle()
        seemorelbl.text = morebool ? "See Less Rules" : "See More Rules"
        arrowimg.image = UIImage(named: morebool ? "dropup" : "downarrow")?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
        delegate?.didTapOnMoreFareRulesBtnAction(cell: self)
    }
    
    func updateParentTableView() {
        guard let parentTableView = self.superview as? UITableView else { return }
        UIView.setAnimationsEnabled(false)
        parentTableView.beginUpdates()
        parentTableView.endUpdates()
        UIView.setAnimationsEnabled(true)
    }
    
}


extension AddFareRulesTVCell:UITableViewDelegate,UITableViewDataSource {
    
    
    
    func setupTV() {
        farerulesTV.register(UINib(nibName: "FareRulesTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        farerulesTV.delegate = self
        farerulesTV.dataSource = self
        farerulesTV.tableFooterView = UIView()
        farerulesTV.showsHorizontalScrollIndicator = false
        farerulesTV.separatorStyle = .singleLine
        farerulesTV.isScrollEnabled = false
        farerulesTV.separatorStyle = .none
        farerulesTV.rowHeight = UITableView.automaticDimension
        farerulesTV.estimatedRowHeight = 120
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if morebool == true{
            return MySingleton.shared.fareRulesData.count
        }else {
            return MySingleton.shared.penalityArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? FareRulesTVCell {
            //  cell.delegate = self
            
            if morebool == true{
                let data = MySingleton.shared.fareRulesData[indexPath.row]
                
                if data.rule_heading != "PENALTIES" {
                    cell.titlelbl.text = data.rule_heading
                    cell.subTitlelbl.text = data.rule_content
                    cell.subTitlelbl.numberOfLines = 0
                    cell.show()
                }
                
                
            }else {
                let data = MySingleton.shared.penalityArray[indexPath.row]
                cell.titlelbl.text = data.rule_heading
                cell.subTitlelbl.text = data.rule_content
                cell.subTitlelbl.numberOfLines = 0
            }
            
            
            c = cell
            
        }
        return c
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        farerulesTV.deselectRow(at: indexPath, animated: true)
        
        
        //        if let cell = tableView.cellForRow(at: indexPath) as? FareRulesTVCell {
        //
        //                // Toggle the visibility of subtitlelbl
        //                cell.subTitlelbl.isHidden.toggle()
        //
        //                // Update the layout of the cell
        //                farerulesTV.beginUpdates()
        //                farerulesTV.endUpdates()
        //
        //
        //
        //           // delegate?.showContentBtnAction(cell: cell)
        //        }
        
        if let cell = tableView.cellForRow(at: indexPath) as? FareRulesTVCell {
            cell.subTitlelbl.isHidden.toggle()
            farerulesTV.beginUpdates()
            farerulesTV.endUpdates()
            updateParentTableView()
           // delegate?.showContentBtnAction(cell: cell)
        }
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return UITableView.automaticDimension
    //    }
    
    
    //    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    //
    //        if morebool == true{
    //
    //            let data = MySingleton.shared.fareRulesData[indexPath.row]
    //            let titleHeight: CGFloat = 20 // Set the estimated height of the titlelbl
    //            let subtitleHeight = heightForText(data.rule_content ?? "", font: UIFont.systemFont(ofSize: 17), width: tableView.bounds.width - 16) // Adjust the font size if needed
    //
    //            // Add any additional padding or spacing as needed
    //            let padding: CGFloat = 16
    //
    //            // Estimate the total cell height based on the title and subtitle
    //            return titleHeight + subtitleHeight + padding
    //        }else {
    //            let data = MySingleton.shared.penalityArray[indexPath.row]
    //            let titleHeight: CGFloat = 20 // Set the estimated height of the titlelbl
    //            let subtitleHeight = heightForText(data.rule_content ?? "", font: UIFont.systemFont(ofSize: 17), width: tableView.bounds.width - 16) // Adjust the font size if needed
    //
    //            // Add any additional padding or spacing as needed
    //            let padding: CGFloat = 16
    //
    //            // Estimate the total cell height based on the title and subtitle
    //            return titleHeight + subtitleHeight + padding
    //        }
    //
    //
    //    }
    //
    //    func heightForText(_ text: String, font: UIFont, width: CGFloat) -> CGFloat {
    //        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
    //        let boundingBox = text.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
    //
    //        return ceil(boundingBox.height)
    //    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
