//
//  PopularHotelDestinationsTVCell.swift
//  Travrate
//
//  Created by Admin on 25/07/24.
//

import UIKit


struct TopHotelDetailsModel {
    
    let id: String
    let city_name: String
    let check_in: String
    let check_out: String
    let image: String
    let price: String?
    let rating: String
    let hotel_name: String?
    let country: String
    let hotel_code: String
}

protocol PopularHotelDestinationsTVCellDellegate {
    func didTapOnPopulardestination(cell:PopularHotelDestinationsTVCell)
}

class PopularHotelDestinationsTVCell: TableViewCell {
    
    
    @IBOutlet weak var citySelectCV: UICollectionView!
    @IBOutlet weak var selectDestCV: UICollectionView!
    
    
    // Define a variable to store the selected index path
    var countryBtnTapbool = false
    var selectedIndex: IndexPath?
    var filteredHotels: [TopHotelDetailsModel] = []
    var itemCount = Int()
    var autoScrollTimer: Timer?
    var hotellist = [TopHotelDetails]()
    var countryArray = [String]()
    var delegate:PopularHotelDestinationsTVCellDellegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupcitySelectCV()
        setupselectDestCV()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        hotellist = MySingleton.shared.topHotelDetails
        itemCount = hotellist.count
        
        countryArray.removeAll()
        hotellist.forEach { i in
            countryArray.append(i.country ?? "")
        }
        countryArray = countryArray.unique()
        
        
        // Filter flightlist based on selected city
        if countryArray.count > 0 {
            let selectedCity = countryArray[0]
            // Assuming TopFlightListModel and TopFlightDetails have similar properties
            filteredHotels = hotellist.filter { flight in
                if let airportCity = flight.country {
                    return airportCity.contains(selectedCity)
                }
                return false
            }.map { hotel in
                // TopFlightListModel(airport_city: flight.airport_city ?? "", image: flight.image)
                TopHotelDetailsModel(id: hotel.city ?? "",
                                     city_name: hotel.city_name ?? "",
                                     check_in: hotel.check_in ?? "",
                                     check_out: hotel.check_out ?? "",
                                     image: hotel.image ?? "",
                                     price: hotel.price ?? "",
                                     rating: hotel.rating ?? "",
                                     hotel_name: hotel.hotel_name ?? "",
                                     country: hotel.country ?? "",
                                     hotel_code: hotel.hotel_code ?? "")
            }
            
        }
        
        // startAutoScroll()
        selectDestCV.reloadData()
    }
    
    
    
    
    func setupcitySelectCV() {
        
        
        let nib = UINib(nibName: "SelectCityCVCell", bundle: nil)
        citySelectCV.register(nib, forCellWithReuseIdentifier: "cell1")
        citySelectCV.delegate = self
        citySelectCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 100, height: 34)
        //        layout.itemSize = CGSize(width: 100 , height: 34)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        layout.sectionInset = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)
        citySelectCV.collectionViewLayout = layout
        
        selectedIndex = IndexPath(item: 0, section: 0)
        citySelectCV.showsHorizontalScrollIndicator = false
        citySelectCV.bounces = false
        
    }
    
    
    
    func setupselectDestCV() {
        
        
        let nib = UINib(nibName: "SelectDestCVCell", bundle: nil)
        selectDestCV.register(nib, forCellWithReuseIdentifier: "cell2")
        selectDestCV.delegate = self
        selectDestCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 190, height: 125)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        // layout.sectionInset = UIEdgeInsets(top: 16, left: 10, bottom: 16, right: 10)
        selectDestCV.collectionViewLayout = layout
        
        selectDestCV.showsHorizontalScrollIndicator = false
        selectDestCV.bounces = false
        
    }
    
    
}



extension PopularHotelDestinationsTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        if collectionView == citySelectCV {
            return countryArray.count
        }else {
            return filteredHotels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        
        
        if collectionView == citySelectCV {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as? SelectCityCVCell {
                
                cell.titlelbl.text = countryArray[indexPath.row]
                
                if indexPath == selectedIndex {
                    cell.titlelbl.textColor = .WhiteColor
                    cell.holderView.backgroundColor = .Buttoncolor
                    citySelectCV.selectItem(at: indexPath, animated: false, scrollPosition: .left)
                    
                }else {
                    // Reset styling for other cells
                    cell.titlelbl.textColor = .TitleColor
                    cell.holderView.backgroundColor = .WhiteColor
                }
                
                
                
                commonCell = cell
            }
        }else {
            
            
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as? SelectDestCVCell {
                let flight = filteredHotels[indexPath.row]
                cell.titlelbl.text = flight.city_name
                
                if flight.image == nil || flight.image.isEmpty == true {
                    cell.img.image = UIImage(named: "noimage")
                } else {
                    cell.img.sd_setImage(with: URL(string: flight.image ?? ""), placeholderImage: UIImage(named: "placeholder.png"), completed: { (image, error, cacheType, imageURL) in
                        if let error = error {
                            print("Error loading image: \(error.localizedDescription)")
                            cell.img.image = UIImage(named: "noimage1")
                        }
                    })
                }
                
                commonCell = cell
            }
            
            
        }
        return commonCell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == citySelectCV {
            if let cell = collectionView.cellForItem(at: indexPath) as? SelectCityCVCell {
                cell.titlelbl.textColor = .WhiteColor
                cell.holderView.backgroundColor = .Buttoncolor
                countryBtnTapbool = true
                // Filter flightlist based on selected city
                let selectedCity = countryArray[indexPath.row]
                // Assuming TopFlightListModel and TopFlightDetails have similar properties
                filteredHotels = hotellist.filter { flight in
                    if let airportCity = flight.country {
                        return airportCity.contains(selectedCity)
                    }
                    return false
                }.map { hotel in
                    TopHotelDetailsModel(id: hotel.city ?? "",
                                         city_name: hotel.city_name ?? "",
                                         check_in: hotel.check_in ?? "",
                                         check_out: hotel.check_out ?? "",
                                         image: hotel.image ?? "",
                                         price: hotel.price ?? "",
                                         rating: hotel.rating ?? "",
                                         hotel_name: hotel.hotel_name ?? "",
                                         country: hotel.country ?? "",
                                         hotel_code: hotel.hotel_code ?? "")
                }
                
                // Update the selected index path
                selectedIndex = indexPath
                
                
                // Reload the collection view to update with filtered data
                selectDestCV.reloadData()
            }
        }else {
                
                let hotel = filteredHotels[indexPath.row]
                defaults.set("Hotel", forKey: UserDefaultsKeys.tabselect)
                
                defaults.set("\(hotel.city_name) (\(hotel.country))", forKey: UserDefaultsKeys.locationcity)
                defaults.set(hotel.id, forKey: UserDefaultsKeys.locationid)
                defaults.set(MySingleton.shared.convertDateFormat(inputDate: hotel.check_in, f1: "yyyy-MM-dd", f2: "dd-MM-yyyy"), forKey: UserDefaultsKeys.checkin)
                defaults.set(MySingleton.shared.convertDateFormat(inputDate: hotel.check_out, f1: "yyyy-MM-dd", f2: "dd-MM-yyyy"), forKey: UserDefaultsKeys.checkout)
                defaults.set("2", forKey: UserDefaultsKeys.roomcount)
                defaults.set("Kuwait", forKey: UserDefaultsKeys.hnationality)
                defaults.set("KW", forKey: UserDefaultsKeys.hnationalitycode)
                
                
                
                delegate?.didTapOnPopulardestination(cell: self)
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == citySelectCV {
            if let cell = collectionView.cellForItem(at: indexPath) as? SelectCityCVCell {
                
                cell.titlelbl.textColor = .TitleColor
                cell.holderView.backgroundColor = .WhiteColor
                
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == citySelectCV {
            // Get the text for the current indexPath
            let cityName = countryArray[indexPath.row]
            
            // Calculate the width required for the label text
            let size = (cityName as NSString).size(withAttributes: [NSAttributedString.Key.font: UIFont.InterSemiBold(size: 14)])
            
            // Add some padding to the calculated size
            let width = size.width + 20 // Adjust padding as needed
            
            return CGSize(width: width, height: 34)
        }else {
            return CGSize(width: 190, height: 125)
        }
    }
    
}


// MARK: - Auto Scrolling
extension PopularHotelDestinationsTVCell {
    
    
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
        
        let currentIndexPaths = selectDestCV.indexPathsForVisibleItems.sorted()
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
        
        selectDestCV.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
    }
}
