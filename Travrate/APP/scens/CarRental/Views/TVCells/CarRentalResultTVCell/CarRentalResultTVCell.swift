//
//  CarRentalResultTVCell.swift
//  Travrate
//
//  Created by FCI on 10/06/24.
//

import UIKit

protocol CarRentalResultTVCellDelegate {
    func didTapOnViewDetailsBtnAction(cell:CarRentalResultTVCell)
}

class CarRentalResultTVCell: TableViewCell {
    
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var carimg: UIImageView!
    @IBOutlet weak var depositeAmountlbl: UILabel!
    @IBOutlet weak var perdaylbl: UILabel!
    @IBOutlet weak var viewDetailsBtn: UIButton!
    @IBOutlet weak var kwdlbl: UILabel!
    @IBOutlet weak var itemscv: UICollectionView!
    @IBOutlet weak var seatslbl: UILabel!
    @IBOutlet weak var caroption2: UILabel!
    @IBOutlet weak var caroption3: UILabel!
    @IBOutlet weak var caroption4: UILabel!
    @IBOutlet weak var caroption5: UILabel!
    @IBOutlet weak var caroption6: UILabel!
    @IBOutlet weak var caroption7: UILabel!
    @IBOutlet weak var markuplbl: UILabel!
    
    
    var product_code = String()
    var result_token = String()
    var result_index = String()
    var carlist:Raw_hotel_list?
    
    var delegate:CarRentalResultTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       // setupCV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state   10.265 : 0 : 0
    }
    
    
    override func updateUI() {
        
        
        
        
        if cellInfo?.key == "results" {
            carlist = cellInfo?.moreData as? Raw_hotel_list
            
            carimg.sd_setImage(with: URL(string: carlist?.car_image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"), options: [.retryFailed], completed: { (image, error, cacheType, imageURL) in
                if let error = error {
                    // Handle error loading image
                    print("Error loading image: \(error.localizedDescription)")
                    // Check if the error is due to a 404 Not Found response
                    if (error as NSError).code == NSURLErrorBadServerResponse {
                        // Set placeholder image for 404 error
                        self.carimg.image = UIImage(named: "noimage")
                    } else {
                        // Set placeholder image for other errors
                        self.carimg.image = UIImage(named: "noimage")
                    }
                }
            })
            
            
            
            product_code = carlist?.product?[0].product_type ?? ""
            result_token = carlist?.result_token ?? ""
            result_index = carlist?.result_index ?? ""
        
           
            titlelbl.text = carlist?.car_name ?? ""
            seatslbl.text = "\(carlist?.adults ?? "") Seats"
            caroption2.text = "\(carlist?.luggageMed ?? "") Medium Bags"
            caroption3.text = carlist?.transmission ?? ""
            caroption4.text = "\(carlist?.luggageLarge ?? "") Large Bags"
            caroption5.text = carlist?.from_loc ?? ""
            caroption6.text = carlist?.product?[0].mileage ?? ""
            caroption7.text = "\(carlist?.luggageSmall ?? "") Small Bags"
            
            depositeAmountlbl.text = "Excluded Security Deposit: \(carlist?.product?[0].currency ?? "") \(carlist?.product?[0].deposit ?? "")"
            
            
            markuplbl.text = "Total or markup and discount : \(carlist?.product?[0].currency ?? "") \(carlist?.markup?.value ?? 0)"
            
            
            viewDetailsBtn.layer.cornerRadius = 4
            MySingleton.shared.setAttributedTextnew(str1: carlist?.product?[0].currency ?? "",
                                                    str2: carlist?.product?[0].total ?? "",
                                                    lbl: kwdlbl,
                                                    str1font: .InterSemiBold(size: 12),
                                                    str2font: .InterSemiBold(size: 22),
                                                    str1Color: .TitleColor,
                                                    str2Color: .TitleColor)
            
        }else {
            
            
            let carlist1 = MySingleton.shared.carvoucherdetail
            
            carimg.sd_setImage(with: URL(string: carlist1?.car_image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"), options: [.retryFailed], completed: { (image, error, cacheType, imageURL) in
                if let error = error {
                    // Handle error loading image
                    print("Error loading image: \(error.localizedDescription)")
                    // Check if the error is due to a 404 Not Found response
                    if (error as NSError).code == NSURLErrorBadServerResponse {
                        // Set placeholder image for 404 error
                        self.carimg.image = UIImage(named: "noimage")
                    } else {
                        // Set placeholder image for other errors
                        self.carimg.image = UIImage(named: "noimage")
                    }
                }
            })
            
            titlelbl.text = carlist1?.car_name ?? ""
            seatslbl.text = "\(carlist1?.adults ?? "") Seats"
            caroption2.text = "\(carlist1?.luggageMed ?? "") Medium Bags"
            caroption3.text = carlist1?.transmission ?? ""
            caroption4.text = "\(carlist1?.luggageLarge ?? "") Large Bags"
            caroption5.text = carlist1?.from_loc ?? ""
            caroption6.text = carlist1?.product?[0].mileage ?? ""
            caroption7.text = "\(carlist1?.luggageSmall ?? "") Small Bags"
            
            depositeAmountlbl.text = "Excluded Security Deposit: \(carlist1?.product?[0].currency ?? "") \(carlist?.product?[0].deposit ?? "")"
            markuplbl.text = "Total or markup and discount : \(carlist1?.product?[0].currency ?? "") \(carlist?.markup?.value ?? 0)"
            
            self.viewDetailsBtn.isHidden = true
            self.kwdlbl.isHidden = true
            
        }
        
    }
    
    
    @IBAction func didTapOnViewDetailsBtnAction(_ sender: Any) {
        delegate?.didTapOnViewDetailsBtnAction(cell: self)
    }
    
    
}



//extension CarRentalResultTVCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
//    
//    func setupCV() {
//        
//        let nib = UINib(nibName: "CarRentalTSeatsCVCell", bundle: nil)
//        itemscv.register(nib, forCellWithReuseIdentifier: "cell")
//        itemscv.delegate = self
//        itemscv.dataSource = self
//        let layout = UICollectionViewFlowLayout()
//        // layout.itemSize = CGSize(width: 90, height: 30)
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        layout.scrollDirection = .vertical
//        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 0
//        itemscv.collectionViewLayout = layout
//        itemscv.bounces = false
//        
//    }
//    
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return itemsArray.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        var commonCell = UICollectionViewCell()
//        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CarRentalTSeatsCVCell {
//            
//            cell.titlelbl.text = itemsArray[indexPath.row]
//            
//            commonCell = cell
//        }
//        return commonCell
//    }
//    
//    
//    
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let label = UILabel(frame: CGRect.zero)
//        label.text = itemsArray[indexPath.item]
//        label.sizeToFit()
//        return CGSize(width: label.frame.width, height: 16)
//    }
//    
//    
//}
