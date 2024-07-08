//
//  PaymentTypeTVCell.swift
//  Travgate
//
//  Created by FCI on 27/04/24.
//

import UIKit

protocol PaymentTypeTVCellDelegate {
    func didTapOnPayNowBtnAction(cell:PaymentTypeTVCell)
}

class PaymentTypeTVCell: TableViewCell {

    @IBOutlet weak var paymentTypeCV: UICollectionView!
    @IBOutlet weak var kwdlbl: UILabel!
    @IBOutlet weak var paynowBtn: UIButton!
    
    
    var paymentTypeImageArray = ["knetpay","visapay","masterpay"]
    var delegate:PaymentTypeTVCellDelegate?
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
        
        
        paynowBtn.layer.cornerRadius = 4
        setupCV()
    }
    
    override func updateUI() {
        MySingleton.shared.setAttributedTextnew(str1: "You will Pay: ",
                                                str2: " \(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? ""):\(totlConvertedGrand)",
                                                lbl: kwdlbl,
                                                str1font: .OpenSansMedium(size: 16),
                                                str2font: .OpenSansBold(size: 16),
                                                str1Color: .TitleColor,
                                                str2Color: .TitleColor)
    }
    
    
    @IBAction func didTapOnPayNowBtnAction(_ sender: Any) {
        delegate?.didTapOnPayNowBtnAction(cell: self)
    }
    
}


extension PaymentTypeTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func setupCV() {
        
        
        let nib = UINib(nibName: "PaymentTypeCVCell", bundle: nil)
        paymentTypeCV.register(nib, forCellWithReuseIdentifier: "cell")
        paymentTypeCV.delegate = self
        paymentTypeCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 110, height: 50)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        paymentTypeCV.collectionViewLayout = layout
        paymentTypeCV.bounces = false
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect)
        if tabselect == "Sports" {
            return MySingleton.shared.SportsPaymentSelectionArray.count
        }else {
            return MySingleton.shared.PaymentSelectionArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? PaymentTypeCVCell {
            
            cell.tag = indexPath.row
            
        
            
            let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect)
            if tabselect == "Sports" {
                if indexPath.row == 0 {
                    paymentTypeCV.selectItem(at: indexPath, animated: false, scrollPosition: .bottom)
                    MySingleton.shared.paymenttype = MySingleton.shared.SportsPaymentSelectionArray[indexPath.row].value ?? ""
                    cell.titleValue = MySingleton.shared.SportsPaymentSelectionArray[indexPath.row].value ?? ""
                    cell.radioImg.image = UIImage(named: "radioSelected")?.withRenderingMode(.alwaysOriginal).withTintColor(.Buttoncolor)
                }
                
                var dict = MySingleton.shared.SportsPaymentSelectionArray[indexPath.row]
                cell.titleValue = dict.value ?? ""
                
                cell.payTypeImg.sd_setImage(with: URL(string: dict.img_url ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"), options: [.retryFailed], completed: { (image, error, cacheType, imageURL) in
                    if let error = error {
                        // Handle error loading image
                        print("Error loading image: \(error.localizedDescription)")
                        // Check if the error is due to a 404 Not Found response
                        if (error as NSError).code == NSURLErrorBadServerResponse {
                            // Set placeholder image for 404 error
                            cell.radioImg.image = UIImage(named: "noimage")
                        } else {
                            // Set placeholder image for other errors
                            cell.radioImg.image = UIImage(named: "noimage")
                        }
                    }
                })
            }else {
                
                if indexPath.row == 0 {
                    paymentTypeCV.selectItem(at: indexPath, animated: false, scrollPosition: .bottom)
                    MySingleton.shared.paymenttype = MySingleton.shared.PaymentSelectionArray[indexPath.row].value ?? ""
                    cell.titleValue = MySingleton.shared.PaymentSelectionArray[indexPath.row].value ?? ""
                    cell.radioImg.image = UIImage(named: "radioSelected")?.withRenderingMode(.alwaysOriginal).withTintColor(.Buttoncolor)
                }
                
                var dict = MySingleton.shared.PaymentSelectionArray[indexPath.row]
                cell.titleValue = dict.value ?? ""
                
                cell.payTypeImg.sd_setImage(with: URL(string: dict.img_url ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"), options: [.retryFailed], completed: { (image, error, cacheType, imageURL) in
                    if let error = error {
                        // Handle error loading image
                        print("Error loading image: \(error.localizedDescription)")
                        // Check if the error is due to a 404 Not Found response
                        if (error as NSError).code == NSURLErrorBadServerResponse {
                            // Set placeholder image for 404 error
                            cell.radioImg.image = UIImage(named: "noimage")
                        } else {
                            // Set placeholder image for other errors
                            cell.radioImg.image = UIImage(named: "noimage")
                        }
                    }
                })
            }
            
            
            commonCell = cell
        }
        return commonCell
    }
    
    
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if let cell = collectionView.cellForItem(at: indexPath) as? PaymentTypeCVCell {
                
                cell.radioImg.image = UIImage(named: "radioSelected")?.withRenderingMode(.alwaysOriginal).withTintColor(.Buttoncolor)
                
              
                let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect)
                if tabselect == "Sports" {
                    MySingleton.shared.paymenttype = MySingleton.shared.SportsPaymentSelectionArray[indexPath.row].value ?? ""
                }else {
                    MySingleton.shared.paymenttype = MySingleton.shared.PaymentSelectionArray[indexPath.row].value ?? ""
                }
                print(MySingleton.shared.paymenttype)
                
            }
            
            
        }
    
    
        func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
            if let cell = collectionView.cellForItem(at: indexPath) as? PaymentTypeCVCell {
                cell.radioImg.image = UIImage(named: "radiounselected")
            }
        }
    
    
}
