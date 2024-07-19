//
//  ActivitiesImagesTVCell.swift
//  Travrate
//
//  Created by Admin on 17/07/24.
//

import UIKit

protocol ActivitiesImagesTVCellDelegate {
    func didTapOnMoreBtnAction(cell:ActivitiesImagesTVCell)
}

class ActivitiesImagesTVCell: TableViewCell {
    
    @IBOutlet weak var activityImage: UIImageView!
    @IBOutlet weak var activityImagesCV: UICollectionView!
    @IBOutlet weak var activityNamelbl: UILabel!
    @IBOutlet weak var locNamelbl: UILabel!
    
    
    
    var itemCount = Int()
    var autoScrollTimer: Timer?
    var hotelImagesArray = [String]()
    var delegate:ActivitiesImagesTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    
    override func updateUI() {
        
        
        activityNamelbl.text = MySingleton.shared.activity_details?.activity_name
        locNamelbl.text = MySingleton.shared.activity_details?.location?.address
        MySingleton.shared.activity_loc = MySingleton.shared.activity_details?.location?.address ?? ""
       
       
        if MySingleton.shared.activitiesImagesArray.count > 0 {
            
            activityImage.sd_setImage(with: URL(string:  MySingleton.shared.activitiesImagesArray[0].image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"), options: [.retryFailed], completed: { (image, error, cacheType, imageURL) in
                if let error = error {
                    // Handle error loading image
                    print("Error loading image: \(error.localizedDescription)")
                    // Check if the error is due to a 404 Not Found response
                    if (error as NSError).code == NSURLErrorBadServerResponse {
                        // Set placeholder image for 404 error
                        self.activityImage.image = UIImage(named: "noimage")
                    } else {
                        // Set placeholder image for other errors
                        self.activityImage.image = UIImage(named: "noimage")
                    }
                }
            })
            
            
            itemCount =  MySingleton.shared.activitiesImagesArray.count
            activityImagesCV.reloadData()
            
        }
        
       
    }
    
    func setupUI() {
        activityImage.layer.cornerRadius = 8
        setupCV()
        //  setupSCrollImagesCV()
    }
    
    
    
    
    func setupCV() {
        let nib = UINib(nibName: "HotelImagesCVCell", bundle: nil)
        activityImagesCV.register(nib, forCellWithReuseIdentifier: "cell")
        
        let nib1 = UINib(nibName: "ButtonCollectionViewCell", bundle: nil)
        activityImagesCV.register(nib1, forCellWithReuseIdentifier: "buttonCell")
        
        
        activityImagesCV.delegate = self
        activityImagesCV.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 6
        layout.minimumLineSpacing = 6
        
        // Calculate the cell width dynamically based on the collection view width
        let collectionViewWidth = activityImagesCV.frame.width
        let cellWidth = (collectionViewWidth - 6 * 3) / 4 // Assuming 4 cells with 6 spacing in between
        layout.itemSize = CGSize(width: cellWidth, height: 80)
        
        activityImagesCV.collectionViewLayout = layout
        activityImagesCV.backgroundColor = .clear
        activityImagesCV.layer.cornerRadius = 4
        activityImagesCV.clipsToBounds = true
        activityImagesCV.showsHorizontalScrollIndicator = false
        activityImagesCV.bounces = false
    }
    
    
}




extension ActivitiesImagesTVCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // If there are more than 4 images, return 5 (4 images + 1 button)
        return min( MySingleton.shared.activitiesImagesArray.count, 3) + ( MySingleton.shared.activitiesImagesArray.count > 3 ? 1 : 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < 3 { // For the first 4 images
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HotelImagesCVCell
            cell.hotelImg.sd_setImage(with: URL(string:  MySingleton.shared.activitiesImagesArray[indexPath.row].image ?? ""), placeholderImage: UIImage(named: "placeholder"), options: [.retryFailed], completed: { (image, error, cacheType, imageURL) in
                if let error = error {
                    // Handle error loading image
                    print("Error loading image: \(error.localizedDescription)")
                    // Check if the error is due to a 404 Not Found response
                    if (error as NSError).code == NSURLErrorBadServerResponse {
                        // Set placeholder image for 404 error
                        cell.hotelImg.image = UIImage(named: "noimage")
                    } else {
                        // Set placeholder image for other errors
                        cell.hotelImg.image = UIImage(named: "noimage")
                    }
                }
            })
            return cell
        } else { // For the button cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "buttonCell", for: indexPath) as! ButtonCollectionViewCell
            // Set the thumbnail image for the button
            cell.moreBtn.setImage(UIImage(named: "thumbImage"), for: .normal)
            cell.img.sd_setImage(with: URL(string:  MySingleton.shared.activitiesImagesArray[3].image ?? ""), placeholderImage: UIImage(named: "placeholder"), options: [.retryFailed], completed: { (image, error, cacheType, imageURL) in
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
            cell.moreBtn.backgroundColor = .black.withAlphaComponent(0.5)
            cell.moreBtn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row < 3 {
            self.activityImage.sd_setImage(with: URL(string:  MySingleton.shared.activitiesImagesArray[indexPath.row].image ?? ""), placeholderImage: UIImage(named: "placeholder"))
        } else {
            // Handle button tap action if needed
            buttonTapped()
        }
    }
    
    @objc func buttonTapped() {
        delegate?.didTapOnMoreBtnAction(cell: self)
    }
}




