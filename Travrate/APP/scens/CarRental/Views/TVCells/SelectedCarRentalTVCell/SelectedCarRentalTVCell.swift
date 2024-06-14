//
//  SelectedCarRentalTVCell.swift
//  Travrate
//
//  Created by FCI on 14/06/24.
//

import UIKit

class SelectedCarRentalTVCell: TableViewCell {
    
    @IBOutlet weak var titlelbl: UILabel!
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
        
    }
    
    
    
}



extension SelectedCarRentalTVCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
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

