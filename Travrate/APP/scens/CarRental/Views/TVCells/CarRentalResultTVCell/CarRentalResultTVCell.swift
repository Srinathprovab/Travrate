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
    
    var itemsArray = ["4 Seats","0 Medium Bags","Manual","1 Large bags","Istanbul Airport","500","1 Small Bags"]
    var delegate:CarRentalResultTVCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupCV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        
        
        titlelbl.text = cellInfo?.title ?? ""
        
        
        carimg.sd_setImage(with: URL(string: cellInfo?.image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"), options: [.retryFailed], completed: { (image, error, cacheType, imageURL) in
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
        
        viewDetailsBtn.layer.cornerRadius = 4
        MySingleton.shared.setAttributedTextnew(str1: cellInfo?.currency ?? "",
                                                str2: cellInfo?.price ?? "",
                                                lbl: kwdlbl,
                                                str1font: .InterSemiBold(size: 12),
                                                str2font: .InterSemiBold(size: 22),
                                                str1Color: .TitleColor,
                                                str2Color: .TitleColor)
        
        
        
        depositeAmountlbl.text = "Deposit Amount: \(cellInfo?.currency ?? "") \(cellInfo?.text ?? "")"
       
    }
    
    
    @IBAction func didTapOnViewDetailsBtnAction(_ sender: Any) {
        delegate?.didTapOnViewDetailsBtnAction(cell: self)
    }
    
    
}



extension CarRentalResultTVCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func setupCV() {
        
        let nib = UINib(nibName: "CarRentalTSeatsCVCell", bundle: nil)
        itemscv.register(nib, forCellWithReuseIdentifier: "cell")
        itemscv.delegate = self
        itemscv.dataSource = self
        let layout = UICollectionViewFlowLayout()
        // layout.itemSize = CGSize(width: 90, height: 30)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        itemscv.collectionViewLayout = layout
        itemscv.bounces = false
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CarRentalTSeatsCVCell {
            
            cell.titlelbl.text = itemsArray[indexPath.row]
            
            commonCell = cell
        }
        return commonCell
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.text = itemsArray[indexPath.item]
        label.sizeToFit()
        return CGSize(width: label.frame.width, height: 16)
    }
    
    
}
