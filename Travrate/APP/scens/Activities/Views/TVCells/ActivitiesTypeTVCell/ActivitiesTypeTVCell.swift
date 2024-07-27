//
//  ActivitiesTypeTVCell.swift
//  Travrate
//
//  Created by Admin on 17/07/24.
//

import UIKit

protocol ActivitiesTypeTVCellDelegate:AnyObject {
    func didTapOnBookNowBtnAction(cell:ActivitiesTypeInfoTVCell)
}

class ActivitiesTypeTVCell: UITableViewCell, ActivitiesTypeInfoTVCellDelegate {
    
    
    @IBOutlet weak var typeTV: UITableView!
    @IBOutlet weak var tvheight: NSLayoutConstraint!
    @IBOutlet weak var activityTypelbl: UILabel!
    @IBOutlet weak var totalPricelbl: UILabel!
    
    var cancelPolicy = [Cancelpolicy]()
    weak var delegate:ActivitiesTypeTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setupUI() {
        setuplabels(lbl: activityTypelbl, text: "Activities Type", textcolor: .TitleColor, font: .InterSemiBold(size: 14), align: .center)
        setuplabels(lbl: totalPricelbl, text: "Total price", textcolor: .TitleColor, font: .InterSemiBold(size: 14), align: .center)

        setupTV()
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
            
            
            sampleCell.setupDropDown()
            
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
            cell.setupDropDown()
           
            
            MySingleton.shared.setAttributedTextnew(str1: "\(MySingleton.shared.activites_currency) ",
                                                    str2: String(format: "%.2f",  data?.amountsFrom?[0].amount?.default_value ?? 0.0),
                                                    lbl: cell.kedlbl,
                                                    str1font: .InterMedium(size: 12),
                                                    str2font: .InterBold(size: 22),
                                                    str1Color: .TitleColor,
                                                    str2Color: HexColor("#3C627A"))
            
            
            
            // Set image
            if indexPath.row < MySingleton.shared.activitiesImagesArray.count {
                let imageUrl = MySingleton.shared.activitiesImagesArray[indexPath.row].image
                cell.img.sd_setImage(with: URL(string: imageUrl ?? ""), placeholderImage: UIImage(named: "placeholder.png"), options: [.retryFailed], completed: { (image, error, cacheType, imageURL) in
                    if let error = error {
                        // Handle error loading image
                        print("Error loading image: \(error.localizedDescription)")
                        // Check if the error is due to a 404 Not Found response
                        if (error as NSError).code == NSURLErrorBadServerResponse {
                            // Set placeholder image for 404 error
                            cell.img.image = UIImage(named: "noimage")
                        } else {
                            // Set placeholder image for other errors
                            cell.img.image = UIImage(named: "noimage")
                        }
                    }
                })
            } else {
                // Use placeholder image if no image is available
                cell.img.image = UIImage(named: "placeholder.png")
            }
            
            
            //            cell.chooselbl.text = cancelPolicy[indexPath.row].data_text ?? ""
            
            
            if tableView.isLast(for: indexPath) {
                cell.holderView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                cell.holderView.layer.cornerRadius = 8
            }
            
            
            c = cell
            
        }
        return c
    }
    
    
    
}
