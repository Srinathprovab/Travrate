//
//  TopcityGuidesTVCell.swift
//  TravgateApp
//
//  Created by FCI on 02/01/24.
//

import UIKit

class TopcityGuidesTVCell: TableViewCell {
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var topcitysCV: UICollectionView!
    
    
    var itemCount = Int()
    var autoScrollTimer: Timer?
    var hotellist = [City_guides]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setuptopcitysCV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        
        if LanguageManager.shared.currentLanguage() == "ar" {
            titlelbl.text = NSLocalizedString("popular_hotel_destinations_en", comment: "")
        } else {
            titlelbl.text = NSLocalizedString("popular_hotel_destinations_en", comment: "")
        }
        
        hotellist = MySingleton.shared.topCityGuides
        itemCount = hotellist.count
      //  startAutoScroll()
        topcitysCV.reloadData()
    }
    
    
    func setuptopcitysCV() {
        
        
        let nib = UINib(nibName: "TopcityGuidesCVCell", bundle: nil)
        topcitysCV.register(nib, forCellWithReuseIdentifier: "cell1")
        topcitysCV.delegate = self
        topcitysCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 190, height: 214)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        // layout.sectionInset = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 6)
        topcitysCV.collectionViewLayout = layout
        
        topcitysCV.showsHorizontalScrollIndicator = false
        topcitysCV.bounces = false
        
    }
    
}



extension TopcityGuidesTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hotellist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as? TopcityGuidesCVCell {
            
            cell.titlelbl.text = hotellist[indexPath.row].airport_city
       
            
            if hotellist[indexPath.row].image == nil || hotellist[indexPath.row].image!.isEmpty {
                // If the image URL is nil or empty, set placeholder image
                cell.img.image = UIImage(named: "noimage")
            } else {
                // If the image URL is not nil or empty, attempt to load the image using SDWebImage
                cell.img.sd_setImage(with: URL(string: hotellist[indexPath.row].image!), placeholderImage: UIImage(named: "placeholder.png"), options: [.retryFailed], completed: { (image, error, cacheType, imageURL) in
                    if let error = error {
                        // Handle error loading image
                   //     print("Error loading image: \(error.localizedDescription)")
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
            }

            
            commonCell = cell
        }
        return commonCell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
     
        
        print(hotellist[indexPath.row].city)
        print(hotellist[indexPath.row].city_id_fal)
        
//        "id": "73", //
//                   "title": "",
//                   "city_name": "SHARJAH",// city
//                   "city": "404", hotel_destination
//                   "check_in": "2024-10-10",//hotel_checkin
//                   "check_out": "2024-10-15", hotel_checkout
//                   "image": "https://provab.net/travrate/extras/uploads/hotel_top_destination_thumb/top-dest-hotel-404.jpg",
//                   "voucher_status": "INACTIVE",
//                   "voucher": "NO",
//                   "price": null,
//                   "status": "1",
//                   "created_at": "2024-04-15 10:07:23",
//                   "updated_at": "2024-04-15 10:08:55",
//                   "ar_title": "",
//                   "hotel_code": null,
//                   "country": "United Arab Emirates",
//                   "rating": "5",
//                   "hotel_name": null
    }
    
    
}


// MARK: - Auto Scrolling
extension TopcityGuidesTVCell {
    
    
    func startAutoScroll() {
        autoScrollTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(scrollToNextItem), userInfo: nil, repeats: true)
    }
    
    func stopAutoScroll() {
        autoScrollTimer?.invalidate()
        autoScrollTimer = nil
    }
    
    @objc func scrollToNextItem() {
        
        
        guard itemCount > 0 else {
            return // No items in the collection view
        }
        
        let currentIndexPaths = topcitysCV.indexPathsForVisibleItems.sorted()
        let lastIndexPath = currentIndexPaths.last ?? IndexPath(item: 0, section: 0)
        
        var nextIndexPath: IndexPath
        
        if lastIndexPath.item == itemCount - 1 {
            nextIndexPath = IndexPath(item: 0, section: lastIndexPath.section)
        } else {
            nextIndexPath = IndexPath(item: lastIndexPath.item + 1, section: lastIndexPath.section)
        }
        
        if nextIndexPath.item >= itemCount {
            nextIndexPath = IndexPath(item: 0, section: nextIndexPath.section) // Adjust the index path if it exceeds the bounds
        }
        
        topcitysCV.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
    }
}
