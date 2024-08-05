//
//  AmenitiesTVCell.swift
//  BabSafar
//
//  Created by MA673 on 02/08/22.
//

import UIKit

class AmenitiesTVCell: UITableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var amenitiesCV: UICollectionView!
    
    
    var namseArray = [String]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state amenitiesCV
    }
    
    func setupUI() {
        holderView.backgroundColor = .white
        namseArray.removeAll()
        formatAmeArray.forEach { i in
            if i.ame != "" {
                namseArray.append(i.ame ?? "")
            }
        }
        
        namseArray = namseArray.unique()
        setupCV()
    }
    
    
    
    
}


extension AmenitiesTVCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
//    func setupCV() {
//        
//        
//        let nib = UINib(nibName: "AmenitiesCVCell", bundle: nil)
//        amenitiesCV.register(nib, forCellWithReuseIdentifier: "cell")
//        amenitiesCV.delegate = self
//        amenitiesCV.dataSource = self
//        let layout = UICollectionViewFlowLayout()
//       // layout.itemSize = CGSize(width: 200, height: 34)
//        layout.scrollDirection = .horizontal
//        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 0
//        // layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        amenitiesCV.collectionViewLayout = layout
//        amenitiesCV.backgroundColor = .clear
//        amenitiesCV.layer.cornerRadius = 4
//        amenitiesCV.clipsToBounds = true
//        amenitiesCV.showsHorizontalScrollIndicator = false
//        amenitiesCV.bounces = false
//        
//    }
    
    
    func setupCV() {
        
        let nib = UINib(nibName: "AmenitiesCVCell", bundle: nil)
        amenitiesCV.register(nib, forCellWithReuseIdentifier: "cell")
        amenitiesCV.delegate = self
        amenitiesCV.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        amenitiesCV.collectionViewLayout = layout
        amenitiesCV.backgroundColor = .clear
        amenitiesCV.layer.cornerRadius = 4
        amenitiesCV.clipsToBounds = true
        amenitiesCV.showsHorizontalScrollIndicator = false
        amenitiesCV.bounces = false
    }

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return namseArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? AmenitiesCVCell {
            
            cell.titlelbl.text = namseArray[indexPath.row]
            cell.titlelbl.numberOfLines = 0
            
            
            commonCell = cell
        }
        return commonCell
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      //  let text = namseArray[indexPath.row]
        let width: CGFloat = 200 // Your desired width
        let height = calculateTableViewHeight()
        
        return CGSize(width: width, height: height + 16) // Adding padding if necessary
    }
    
    
   
    
        func calculateTableViewHeight() -> CGFloat {
            var totalHeight: CGFloat = 0
    
            if let sampleCell = amenitiesCV.dequeueReusableCell(withReuseIdentifier: "cell", for: IndexPath(item: 0, section: 0)) as? AmenitiesCVCell {
               
                
                sampleCell.titlelbl.numberOfLines = 0
                
                sampleCell.setNeedsLayout()
                sampleCell.layoutIfNeeded()
                
                let height = sampleCell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
                totalHeight = height
            }
    
            // Add a small padding to avoid cutting off the cell
            let padding: CGFloat = 0
            totalHeight += padding
    
            return totalHeight
        }
    
    
}

