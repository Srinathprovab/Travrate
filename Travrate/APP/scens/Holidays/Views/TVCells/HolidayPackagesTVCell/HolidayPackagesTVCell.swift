//
//  HolidayPackagesTVCell.swift
//  Travgate
//
//  Created by FCI on 26/02/24.
//

import UIKit
protocol HolidayPackagesTVCellDelegate:AnyObject {
    func didTapOnHolidayPackage(cell:HolidayPackagesTVCell)
}

class HolidayPackagesTVCell: TableViewCell {
    
    
    @IBOutlet weak var packageImage: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var holidaysTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    
    var holidayKey = String()
    weak var delegate:HolidayPackagesTVCellDelegate?
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
        titlelbl.text = cellInfo?.title ?? ""
        
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
                    //   print("Error loading image: \(error.localizedDescription)")
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
        
        
        
        updateHeight()
    }
    
    
    
    func setupUI() {
        setupTV()
        
    }
    
}



extension HolidayPackagesTVCell:UITableViewDelegate,UITableViewDataSource {
    
    
    
    func setupTV() {
        holidaysTV.register(UINib(nibName: "HolidaysInfoTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        holidaysTV.delegate = self
        holidaysTV.dataSource = self
        holidaysTV.tableFooterView = UIView()
        holidaysTV.showsHorizontalScrollIndicator = false
        holidaysTV.separatorStyle = .singleLine
        holidaysTV.isScrollEnabled = false
        holidaysTV.separatorStyle = .none
        
        holidaysTV.estimatedRowHeight = 260
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MySingleton.shared.holidaylist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? HolidaysInfoTVCell {
            
            cell.selectionStyle = .none
            let data = MySingleton.shared.holidaylist[indexPath.row]
            cell.titlelbl.text = data.heading ?? ""
            cell.subtitlelbl.text = data.subheading ?? ""
            cell.holidayKey = data.origin ?? ""
            
            let compressor = ImageCompressionTransformer(quality: 0.1) // Compress to 50% quality
            // Assume `compressor` is already defined and initialized
            let imageUrl = URL(string: data.image ?? "")
            
            
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
            
            
            c = cell
            
        }
        return c
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? HolidaysInfoTVCell {
            self.holidayKey = cell.holidayKey
        }
        delegate?.didTapOnHolidayPackage(cell: self)
    }
    
    
    
    //    func updateHeight() {
    //        var totalHeight: CGFloat = 0
    //        for index in 0..<MySingleton.shared.holidaylist.count {
    //            let indexPath = IndexPath(row: index, section: 0)
    //            if let cell = holidaysTV.cellForRow(at: indexPath) as? HolidaysInfoTVCell {
    //                totalHeight += cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
    //            }
    //        }
    //        tvHeight.constant = CGFloat((MySingleton.shared.holidaylist.count)) * totalHeight
    //        holidaysTV.reloadData()
    //    }
    
    
    func updateHeight() {
        tvHeight.constant = CGFloat(MySingleton.shared.holidaylist.count * 260)
        holidaysTV.reloadData()
    }
    
    
}
