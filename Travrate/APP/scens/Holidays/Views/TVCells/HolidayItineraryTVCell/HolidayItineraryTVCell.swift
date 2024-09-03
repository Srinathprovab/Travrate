//
//  HolidayItineraryTVCell.swift
//  Travgate
//
//  Created by FCI on 26/02/24.
//

import UIKit

protocol HolidayItineraryTVCellDelegate:AnyObject {
    func didTapOnContactusBtnAction(cell:HolidayItineraryTVCell)
    func didTapOnImage()
    func didTapOnTitleDropDownBtnAction(cell:CruiseAddItineraryTVCell)
}

class HolidayItineraryTVCell: TableViewCell, CruiseAddItineraryTVCellDelegate {
    
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var packegeImagesCV: UICollectionView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    @IBOutlet weak var itineraryTV: UITableView!
    @IBOutlet weak var desclbl: UILabel!
    @IBOutlet weak var contactusBtn: UIButton!
    
    
    // Prototype cell for height calculation
    private var prototypeCell: CruiseAddItineraryTVCell?
    weak var delegate : HolidayItineraryTVCellDelegate?
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
        
        self.img.sd_setImage(with: URL(string: MySingleton.shared.holidaySelectedData?.tour__2_data?[0].image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
        
        
        desclbl.attributedText = MySingleton.shared.holidaySelectedData?.tour__2_data?[0].desc?.htmlToAttributedString
        updateHeight()
        
    }
    
    
    
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
    
    //MARK: - didTapOnTitleDropDownBtnAction
    func didTapOnTitleDropDownBtnAction(cell: CruiseAddItineraryTVCell) {
        
        itineraryTV.beginUpdates()
        itineraryTV.endUpdates()
        
        updateUI()
        delegate?.didTapOnTitleDropDownBtnAction(cell: cell)
    }
    
    
    
    
    
}


extension HolidayItineraryTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func setupCV() {
        
        
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
        return MySingleton.shared.holidaySelectedData?.tour__2_data?[0].more_image?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HolidaysImagesCVCell {
            
            let data = MySingleton.shared.holidaySelectedData?.tour__2_data?[0].more_image?[indexPath.row]
            
            cell.img.sd_setImage(with: URL(string: data ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            
            
            commonCell = cell
        }
        return commonCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTapOnImage()
    }
    
    
}


extension HolidayItineraryTVCell:UITableViewDelegate,UITableViewDataSource {
    
    
    
    func updateHeight() {
        var totalHeight: CGFloat = 0
        for index in 0..<MySingleton.shared.holidayItinerary.count {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = itineraryTV.cellForRow(at: indexPath) as? CruiseAddItineraryTVCell {
                totalHeight += cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            }
        }
        
        tvHeight.constant = CGFloat((MySingleton.shared.holidayItinerary.count)) * totalHeight + 150
        itineraryTV.reloadData()
    }
    
    
    func setupTV() {
        itineraryTV.register(UINib(nibName: "CruiseAddItineraryTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        itineraryTV.delegate = self
        itineraryTV.dataSource = self
        itineraryTV.tableFooterView = UIView()
        itineraryTV.showsHorizontalScrollIndicator = false
        itineraryTV.separatorStyle = .singleLine
        itineraryTV.isScrollEnabled = false
        itineraryTV.separatorStyle = .none
        
        itineraryTV.rowHeight = UITableView.automaticDimension
        itineraryTV.estimatedRowHeight = 500
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  MySingleton.shared.holidayItinerary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CruiseAddItineraryTVCell {
            cell.delegate = self
            cell.selectionStyle = .none
            cell.tag = indexPath.row
            let data =  MySingleton.shared.holidayItinerary[indexPath.row]
            configureCell(cell, with: data)
            
            c = cell
            
        }
        return c
    }
    
    
    
    
    // Helper function to configure the cell
    private func configureCell(_ cell: CruiseAddItineraryTVCell, with data: Itinerary) {
        
        
        cell.daylbl.text = "Day \((cell.tag) + 1)"
        cell.titlelbl.text = data.title ?? ""
        cell.subtitlelbl.text = data.desc ?? ""
        
        cell.img.sd_setImage(with: URL(string: data.image ?? ""),
                             placeholderImage: UIImage(named: "placeholder.png"), options: [.retryFailed], completed: { (image, error, cacheType, imageURL) in
            if let error = error {
                print("Error loading banner image: \(error.localizedDescription)")
                if (error as NSError).code == NSURLErrorBadServerResponse {
                    cell.img.image = UIImage(named: "noimage")
                } else {
                    cell.img.image = UIImage(named: "noimage")
                }
            }
        })
    }
    
    
    
}



