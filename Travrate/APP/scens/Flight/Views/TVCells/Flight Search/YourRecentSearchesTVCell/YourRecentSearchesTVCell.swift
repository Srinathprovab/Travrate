//
//  YourRecentSearchesTVCell.swift
//  TravgateApp
//
//  Created by FCI on 07/02/24.
//

import UIKit
protocol YourRecentSearchesTVCellDelegate: AnyObject {
    func didTapOnCloserecentSearchBtnAction(cell:YourRecentSearchesCVCell)
    func didTapOnSearchRecentFlightsBtnAction(cell:YourRecentSearchesCVCell)
}

class YourRecentSearchesTVCell: TableViewCell, YourRecentSearchesCVCellDelegate {
    
    
    
    @IBOutlet weak var recentsearchCV: UICollectionView!
    
    
    var itemCount = Int()
    var autoScrollTimer: Timer?
    weak  var delegate:YourRecentSearchesTVCellDelegate?
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
        
        stopAutoScroll()
    }
    
    func setupUI() {
        setupCV()
    }
    
    override func updateUI() {
        
        
        if MySingleton.shared.recentData?.count == 0 {
            recentsearchCV.setEmptyMessage("No Data Found")
        }else {
            recentsearchCV.restore()
            itemCount = MySingleton.shared.recentData?.count ?? 0
           // startAutoScroll()
        }
        
        recentsearchCV.reloadData()
        
        
    }
    


    
    func didTapOnCloserecentSearchBtnAction(cell: YourRecentSearchesCVCell) {
        let indexToRemove = cell.cellindex

        // Ensure there is a valid index and at least one item to remove
        guard let recentData = MySingleton.shared.recentData, recentData.count > 0 else {
            print("No items to remove.")
            return
        }

        // Validate the indexToRemove is within the bounds
        guard indexToRemove >= 0 && indexToRemove < recentData.count else {
            print("Invalid index. Index is out of bounds.")
            return
        }

        // Safely remove the item from data source
        MySingleton.shared.recentData?.remove(at: indexToRemove)

        // Check if the collection view is empty after removal
        if MySingleton.shared.recentData?.isEmpty ?? true {
            // Reload data instead of deleting to avoid inconsistency
            recentsearchCV.reloadData()
        } else {
            // Delete item from collection view
            recentsearchCV.deleteItems(at: [IndexPath(item: indexToRemove, section: 0)])

            // Scroll to the previous item if it exists
            if indexToRemove > 0 {
                let previousIndexPath = IndexPath(item: indexToRemove - 1, section: 0)
                recentsearchCV.scrollToItem(at: previousIndexPath, at: .centeredHorizontally, animated: true)
            } else if recentsearchCV.numberOfItems(inSection: 0) > 0 {
                // If deleting the first item, scroll to the new first item
                let firstIndexPath = IndexPath(item: 0, section: 0)
                recentsearchCV.scrollToItem(at: firstIndexPath, at: .centeredHorizontally, animated: true)
            }
        }

        print(" ==== origin ==== ")
        print(cell.origin)

        delegate?.didTapOnCloserecentSearchBtnAction(cell: cell)
    }

    
    
    func didTapOnSearchRecentFlightsBtnAction(cell: YourRecentSearchesCVCell) {
        delegate?.didTapOnSearchRecentFlightsBtnAction(cell: cell)
    }
    
}



extension YourRecentSearchesTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func setupCV() {
        
        
        let nib = UINib(nibName: "YourRecentSearchesCVCell", bundle: nil)
        recentsearchCV.register(nib, forCellWithReuseIdentifier: "cell")
        recentsearchCV.delegate = self
        recentsearchCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 310, height: 95)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        recentsearchCV.collectionViewLayout = layout
        recentsearchCV.bounces = false
        recentsearchCV.showsHorizontalScrollIndicator = true
        recentsearchCV.showsVerticalScrollIndicator = true
        
        
        
        // Select the first item (cell) in the collection view
        let indexPath = IndexPath(item: 0, section: 0)
        recentsearchCV.selectItem(at: indexPath, animated: false, scrollPosition: .left)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MySingleton.shared.recentData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        
        
//        guard let recentData = MySingleton.shared.recentData, indexPath.row < MySingleton.shared.recentData?.count ?? 0 else {
//                return commonCell
//            }
        
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? YourRecentSearchesCVCell {
            cell.delegate = self

            cell.cellindex = indexPath.row
            cell.origin = MySingleton.shared.recentData?[indexPath.row].arr_data?.origin ?? ""
            
            cell.tripTypelbl.text = MySingleton.shared.recentData?[indexPath.row].arr_data?.trip_type ?? ""
            cell.tripTypelbl.text  = cell.tripTypelbl.text == "circle" ? "RoundTrip":"Oneway"
            
            cell.citylbl.text = "\(MySingleton.shared.recentData?[indexPath.row].arr_data?.from_custom ?? "") to \(MySingleton.shared.recentData?[indexPath.row].arr_data?.to_custom ?? "")"
            cell.datelbl.text = "\(MySingleton.shared.convertDateFormat(inputDate: MySingleton.shared.recentData?[indexPath.row].arr_data?.depature ?? "", f1: "dd-MM-yyyy", f2: "EEE, dd MMM"))"
            
            
            if MySingleton.shared.recentData?[indexPath.row].arr_data?.trip_type != "oneway" {
                cell.datelbl.text = "\(MySingleton.shared.convertDateFormat(inputDate: MySingleton.shared.recentData?[indexPath.row].arr_data?.depature ?? "", f1: "dd-MM-yyyy", f2: "EEE, dd MMM")) - \(MySingleton.shared.convertDateFormat(inputDate: MySingleton.shared.recentData?[indexPath.row].arr_data?.rreturn ?? "", f1: "dd-MM-yyyy", f2: "EEE, dd MMM"))"
            }
            
            
            cell.classlbl.text = "\(MySingleton.shared.recentData?[indexPath.row].arr_data?.v_class ?? "") - \(defaults.string(forKey: UserDefaultsKeys.totalTravellerCount) ?? "") Travellers"
            
            
            cell.carrier = MySingleton.shared.recentData?[indexPath.row].arr_data?.carrier ?? ""
            cell.adult = MySingleton.shared.recentData?[indexPath.row].arr_data?.adult ?? "1"
            cell.child = MySingleton.shared.recentData?[indexPath.row].arr_data?.child ?? "0"
            cell.from_loc_id = MySingleton.shared.recentData?[indexPath.row].arr_data?.from_loc_id ?? ""
            cell.currency = MySingleton.shared.recentData?[indexPath.row].arr_data?.currency ?? ""
            cell.trip_type = MySingleton.shared.recentData?[indexPath.row].arr_data?.trip_type ?? ""
            cell.to_loc_id = MySingleton.shared.recentData?[indexPath.row].arr_data?.to_loc_id ?? ""
            cell.to_custom = MySingleton.shared.recentData?[indexPath.row].arr_data?.to_custom ?? ""
            cell.from = MySingleton.shared.recentData?[indexPath.row].arr_data?.from ?? ""
            cell.user_id = MySingleton.shared.recentData?[indexPath.row].arr_data?.user_id ?? ""
            cell.from_custom = MySingleton.shared.recentData?[indexPath.row].arr_data?.from_custom ?? ""
            cell.sreturn = MySingleton.shared.recentData?[indexPath.row].arr_data?.rreturn ?? ""
            cell.search_source = MySingleton.shared.recentData?[indexPath.row].arr_data?.search_source ?? ""
            cell.psscarrier = MySingleton.shared.recentData?[indexPath.row].arr_data?.psscarrier ?? ""
            cell.infant = MySingleton.shared.recentData?[indexPath.row].arr_data?.infant ?? "0"
            cell.search_flight = MySingleton.shared.recentData?[indexPath.row].arr_data?.search_flight ?? ""
            cell.depature = MySingleton.shared.recentData?[indexPath.row].arr_data?.depature ?? ""
            cell.to = MySingleton.shared.recentData?[indexPath.row].arr_data?.to ?? ""
            cell.v_class = MySingleton.shared.recentData?[indexPath.row].arr_data?.v_class ?? ""
            cell.fcityname = MySingleton.shared.recentData?[indexPath.row].arr_data?.from_custom ?? ""
            cell.tcityname = MySingleton.shared.recentData?[indexPath.row].arr_data?.to_custom ?? ""
       
       
            
            commonCell = cell
        }
        return commonCell
    }
    
    
    
}



// MARK: - Auto Scrolling
extension YourRecentSearchesTVCell {
    
    
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
        
        let currentIndexPaths = recentsearchCV.indexPathsForVisibleItems.sorted()
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
        
        recentsearchCV.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
    }
}
