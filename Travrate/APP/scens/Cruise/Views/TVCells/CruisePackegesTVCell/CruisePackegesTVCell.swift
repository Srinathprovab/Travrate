//
//  CruisePackegesTVCell.swift
//  Travgate
//
//  Created by FCI on 26/02/24.
//

import UIKit
import SDWebImage

protocol CruisePackegesTVCellDelegate: AnyObject {
    func didTapOnCruisePackageBtnAction(cell:CruisePackegesTVCell)
}

class CruisePackegesTVCell: TableViewCell {
    
    
    @IBOutlet weak var packageImage: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var cruisePackagesTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    
    var cruiseKey = String()
    weak var delegate:CruisePackegesTVCellDelegate?
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
        
        
        titlelbl.text = MySingleton.shared.cruise?.cruise_package_text ?? ""
        updateHeight()
    }
    
    
    func updateHeight() {
        tvHeight.constant = CGFloat(MySingleton.shared.cruiseList.count * 260)
        cruisePackagesTV.reloadData()
    }
    
    
    func setupUI() {
        
        let compressor = ImageCompressionTransformer(quality: 0.1) // Compress to 50% quality
        let imageUrl = URL(string: cellInfo?.image ?? "")
        
        packageImage.sd_setImage(
            with: imageUrl,
            placeholderImage: UIImage(named: "placeholder.png"),
            options: [.retryFailed],
            context: [.imageTransformer: compressor],
            progress: { receivedSize, expectedSize, url in
                // Optionally handle progress updates here
                // Example: Update a progress indicator
//                let progress = Float(receivedSize) / Float(expectedSize)
//                print("Download Progress: \(progress)")
            },
            completed: { image, error, cacheType, url in
                if let error = error {
                    // Handle error loading image
               //     print("Error loading image: \(error.localizedDescription)")
                    // Check if the error is due to a 404 Not Found response
                    if (error as NSError).code == NSURLErrorFileDoesNotExist {
                        // Set placeholder image for 404 error
                        self.packageImage.image = UIImage(named: "noimage")
                    } else {
                        // Set placeholder image for other errors
                        self.packageImage.image = UIImage(named: "noimage")
                    }
                } else {
                    // Optionally handle success here
                   // print("Image loaded successfully")
                }
            }
        )
        
        
        setupTV()
    }
    
}



extension CruisePackegesTVCell:UITableViewDelegate,UITableViewDataSource {
    
    
    
    func setupTV() {
        cruisePackagesTV.register(UINib(nibName: "HolidaysInfoTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        cruisePackagesTV.delegate = self
        cruisePackagesTV.dataSource = self
        cruisePackagesTV.tableFooterView = UIView()
        cruisePackagesTV.showsHorizontalScrollIndicator = false
        cruisePackagesTV.separatorStyle = .singleLine
        cruisePackagesTV.isScrollEnabled = false
        cruisePackagesTV.separatorStyle = .none
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MySingleton.shared.cruiseList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? HolidaysInfoTVCell {
            
            cell.selectionStyle = .none
            let data = MySingleton.shared.cruiseList[indexPath.row]
            cell.titlelbl.text = data.heading ?? ""
            cell.subtitlelbl.text = data.subheading ?? ""
            
            
            //            cell.img.sd_setImage(with: URL(string:  data.image_url ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"), options: [.retryFailed], context: [.imageTransformer: compressor], progress: <#SDImageLoaderProgressBlock?#>, completed: { (image, error, cacheType, imageURL) in
            //                            if let error = error {
            //                                // Handle error loading image
            //                                print("Error loading image: \(error.localizedDescription)")
            //                                // Check if the error is due to a 404 Not Found response
            //                                if (error as NSError).code == NSURLErrorBadServerResponse {
            //                                    // Set placeholder image for 404 error
            //                                    cell.img.image = UIImage(named: "noimage")
            //                                } else {
            //                                    // Set placeholder image for other errors
            //                                    cell.img.image = UIImage(named: "noimage")
            //                                }
            //                            }
            //                        })
            
            
            
            
            let compressor = ImageCompressionTransformer(quality: 0.1) // Compress to 50% quality
            
            // Assume `compressor` is already defined and initialized
            let imageUrl = URL(string: data.image_url ?? "")
            
            
            // Set image with placeholder and transformers
            cell.img.sd_setImage(
                with: imageUrl,
                placeholderImage: UIImage(named: "placeholder.png"),
                options: [.retryFailed],
                context: [.imageTransformer: compressor],
                progress: { receivedSize, expectedSize, url in
                    // Optionally handle progress updates here
                    // Example: Update a progress indicator
//                    let progress = Float(receivedSize) / Float(expectedSize)
//                    print("Download Progress: \(progress)")
                },
                completed: { image, error, cacheType, url in
                    if let error = error {
                        // Handle error loading image
                     //   print("Error loading image: \(error.localizedDescription)")
                        // Check if the error is due to a 404 Not Found response
                        if (error as NSError).code == NSURLErrorFileDoesNotExist {
                            // Set placeholder image for 404 error
                            cell.img.image = UIImage(named: "noimage")
                        } else {
                            // Set placeholder image for other errors
                            cell.img.image = UIImage(named: "noimage")
                        }
                    } else {
                        // Optionally handle success here
                       // print("Image loaded successfully")
                    }
                }
            )
            
            cell.img.image = UIImage(named: "noimage")
            
            //            let imageUrl = URL(string: data.image_url ?? "")
            //
            //                    cell.img.sd_setImage(
            //                        with: imageUrl,
            //                        placeholderImage: UIImage(named: "placeholder.png"),
            //                        options: [.retryFailed, .lowPriority],
            //                        context: nil,
            //                        progress: { receivedSize, expectedSize, url in
            //                            // Optionally handle progress updates here
            //                        },
            //                        completed: { image, error, cacheType, url in
            //                            // Optionally handle completion here
            //                            if let error = error {
            //                                print("Error loading image: \(error.localizedDescription)")
            //                            }
            //                        }
            //                    )
            //
            //
            
            
            cell.cruiseKey = data.key ?? ""
            
            
            c = cell
            
        }
        return c
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? HolidaysInfoTVCell {
            self.cruiseKey = cell.cruiseKey
            delegate?.didTapOnCruisePackageBtnAction(cell: self)
        }
    }
    
    
    
    
    
}


class ImageCompressionTransformer: NSObject, SDImageTransformer {
    let compressionQuality: CGFloat
    
    init(quality: CGFloat) {
        self.compressionQuality = quality
    }
    
    func transformedImage(with image: UIImage, forKey key: String) -> UIImage? {
        // Compress the image to the specified quality
        guard let compressedData = image.jpegData(compressionQuality: compressionQuality),
              let compressedImage = UIImage(data: compressedData) else {
            return nil
        }
        return compressedImage
    }
    
    var transformerKey: String {
        // Unique identifier for caching purposes
        return "ImageCompressionTransformer-\(compressionQuality)"
    }
}


