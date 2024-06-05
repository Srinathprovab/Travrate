//
//  CruiseItineraryTVCell.swift
//  Travgate
//
//  Created by FCI on 27/02/24.
//

import UIKit

protocol CruiseItineraryTVCellDelegate {
    func didTapOnContactusBtnAction(cell:CruiseItineraryTVCell)
    func didTapOnImage()
}

class CruiseItineraryTVCell: TableViewCell {
    
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var contactusBtn: UIButton!
    @IBOutlet weak var packegeImagesCV: UICollectionView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    @IBOutlet weak var itineraryTV: UITableView!
    @IBOutlet weak var desclbl: UILabel!
    
    var imagesArray = [String]()
    var delegate:CruiseItineraryTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        
        imagesArray = cellInfo?.moreData as! [String]
        packegeImagesCV.reloadData()
        
        
        desclbl.attributedText = MySingleton.shared.cruiseDetails?.cruise_data?.desc?.htmlToAttributedString
        
        // Load banner image
        self.bannerImage.sd_setImage(with: URL(string: MySingleton.shared.cruiseDetails?.cruise_data?.image_url ?? ""),
                                     placeholderImage: UIImage(named: "placeholder.png"), options: [.retryFailed], completed: { (image, error, cacheType, imageURL) in
            if let error = error {
                // Handle error loading image
                print("Error loading banner image: \(error.localizedDescription)")
                // Check if the error is due to a 404 Not Found response
                if (error as NSError).code == NSURLErrorBadServerResponse {
                    // Set placeholder image for 404 error
                    self.bannerImage.image = UIImage(named: "noimage")
                } else {
                    // Set placeholder image for other errors
                    self.bannerImage.image = UIImage(named: "noimage")
                }
            }
        })
        
        updateHeight()
    }
    
    func updateHeight() {
        tvHeight.constant = CGFloat(MySingleton.shared.cruiseItinerary.count * 206)
        itineraryTV.reloadData()
    }
    
    
    //    func updateHeight() {
    //        // Reload the table view to ensure the height calculations are accurate
    //        itineraryTV.reloadData()
    //
    //        // Force layout to calculate the correct content size
    //        itineraryTV.layoutIfNeeded()
    //
    //        // Update the table view height constraint based on the content size
    //        let contentHeight = itineraryTV.contentSize.height
    //        tvHeight.constant = CGFloat(MySingleton.shared.cruiseItinerary.count * contentHeight)
    //    }
    
    
    func setupUI() {
        
        contactusBtn.layer.borderWidth = 1.5
        contactusBtn.layer.borderColor = UIColor.BooknowBtnColor.cgColor
        contactusBtn.layer.cornerRadius = 15
        contactusBtn.addTarget(self, action: #selector(didTapOnContactusBtnAction(_:)), for: .touchUpInside)
        
        
        setupCV()
        setupTV()
    }
    
    
    @objc func didTapOnContactusBtnAction(_ sender:UIButton) {
        delegate?.didTapOnContactusBtnAction(cell: self)
    }
    
}


extension CruiseItineraryTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func setupCV() {
        
        print("MySingleton.shared.cruiseDetails?.cruise_data?.more_url?.count")
        print(MySingleton.shared.cruiseDetails?.cruise_data?.more_url?.count ?? 0)
        
        let nib = UINib(nibName: "HolidaysImagesCVCell", bundle: nil)
        packegeImagesCV.register(nib, forCellWithReuseIdentifier: "cell")
        packegeImagesCV.delegate = self
        packegeImagesCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 130, height: 130)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        packegeImagesCV.collectionViewLayout = layout
        packegeImagesCV.bounces = false
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HolidaysImagesCVCell {
            
            let data = imagesArray[indexPath.row]
            cell.img.sd_setImage(with: URL(string: data), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            
            
            commonCell = cell
        }
        return commonCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTapOnImage()
    }
    
    
    
}


extension CruiseItineraryTVCell:UITableViewDelegate,UITableViewDataSource {
    
    
    
    func setupTV() {
        itineraryTV.register(UINib(nibName: "CruiseAddItineraryTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        itineraryTV.delegate = self
        itineraryTV.dataSource = self
        itineraryTV.tableFooterView = UIView()
        itineraryTV.showsHorizontalScrollIndicator = false
        itineraryTV.separatorStyle = .singleLine
        itineraryTV.isScrollEnabled = false
        itineraryTV.separatorStyle = .none
        
        // Enable automatic dimension
        //           itineraryTV.estimatedRowHeight = 200
        //           itineraryTV.rowHeight = UITableView.automaticDimension
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MySingleton.shared.cruiseItinerary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CruiseAddItineraryTVCell {
            
            cell.selectionStyle = .none
            let data =  MySingleton.shared.cruiseItinerary[indexPath.row]
            cell.daylbl.text = "Day \(indexPath.row + 1)"
            cell.titlelbl.text = data.title ?? ""
            cell.subtitlelbl.text = data.desc ?? ""
            c = cell
            
        }
        return c
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return UITableView.automaticDimension
    //    }
    
}
