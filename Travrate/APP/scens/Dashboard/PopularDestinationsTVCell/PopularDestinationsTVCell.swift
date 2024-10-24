//
//  PopularDestinationsTVCell.swift
//  TravgateApp
//
//  Created by FCI on 02/01/24.
//

import UIKit

struct TopFlightListModel {
    let airport_city: String
    let image: String?
    let traveldate: String?
    let returndate: String?
    let from_city: String?
    let to_city: String?
    let fromcityairportcode: String?
    let tocityairportcode: String?
    let triptype: String?
    let v_class: String?
    let from_loc: String?
    let to_loc: String?
    let airline_class:String?
    let from_airport_city: String?
    let to_airport_city:String?
    let airport_city_ar: String?
    // Add other properties as needed
}





protocol PopularDestinationsTVCellDelegate: AnyObject {
    func didTapOnPopulardestination(cell:PopularDestinationsTVCell)
}


class PopularDestinationsTVCell: TableViewCell {
    
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var citySelectCV: UICollectionView!
    @IBOutlet weak var selectDestCV: UICollectionView!
    
    
    // Define a variable to store the selected index path
    var countryBtnTapbool = false
    var selectedIndex: IndexPath?
    var filteredFlights: [TopFlightListModel] = []
    var itemCount = Int()
    var autoScrollTimer: Timer?
    var flightlist = [TopFlightDetails]()
    var countryArray = [String]()
    weak var delegate:PopularDestinationsTVCellDelegate?
    
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
        
        
        if LanguageManager.shared.currentLanguage() == "ar" {
            titlelbl.text = "وجهات الطيران الشهيرة"
        } else {
            titlelbl.text = "Popular Flight Destinations"
        }
        
        
        flightlist = MySingleton.shared.topFlightDetails
        itemCount = flightlist.count
        
        countryArray.removeAll()
        flightlist.forEach { i in
           // countryArray.append(i.country ?? "")
            if LanguageManager.shared.currentLanguage() == "ar" {
                countryArray.append(i.country_arabic ?? "")
            } else {
                countryArray.append(i.country ?? "")
            }
        }
        countryArray = countryArray.unique()
        
        
        // Filter flightlist based on selected city
        if countryArray.count > 0 {
            let selectedCity = countryArray[0]
            // Assuming TopFlightListModel and TopFlightDetails have similar properties
            filteredFlights = flightlist.filter { flight in
//                if let airportCity = flight.country {
//                    return airportCity.contains(selectedCity)
//                }
                
                if LanguageManager.shared.currentLanguage() == "ar" {
                    if let airportCity = flight.country_arabic {
                        return airportCity.contains(selectedCity)
                    }
                } else {
                    if let airportCity = flight.country {
                        return airportCity.contains(selectedCity)
                    }
                }
                
                
                return false
            }.map { flight in
                // TopFlightListModel(airport_city: flight.airport_city ?? "", image: flight.image)
                TopFlightListModel(airport_city: flight.airport_city ?? "",
                                   image: flight.image ?? "",
                                   traveldate: flight.travel_date ?? "",
                                   returndate: flight.return_date ?? "",
                                   from_city: flight.from_city ?? "",
                                   to_city: flight.to_city ?? "",
                                   fromcityairportcode: flight.from_city ?? "",
                                   tocityairportcode: flight.to_city ?? "",
                                   triptype: flight.trip_type ?? "",
                                   v_class: flight.airline_class ?? "",
                                   from_loc: flight.from_loc ?? "",
                                   to_loc: flight.to_loc ?? "",
                                   airline_class: flight.airline_class ?? "",
                                   from_airport_city:flight.from_airport_city,
                                   to_airport_city: flight.to_airport_city, 
                                   airport_city_ar: flight.to_airport_city_ar)
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
        // layout.itemSize = CGSize(width: 100 , height: 34)
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



extension PopularDestinationsTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        if collectionView == citySelectCV {
            return countryArray.count
        }else {
            return filteredFlights.count
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
                let flight = filteredFlights[indexPath.row]
               // cell.titlelbl.text = flight.airport_city
                
                if LanguageManager.shared.currentLanguage() == "ar" {
                    cell.titlelbl.text = flight.airport_city_ar
                } else {
                    cell.titlelbl.text = flight.airport_city
                }
                
                if flight.image == nil || flight.image?.isEmpty == true {
                    cell.img.image = UIImage(named: "noimage")
                } else {
                    cell.img.sd_setImage(with: URL(string: flight.image ?? ""), placeholderImage: UIImage(named: "placeholder.png"), completed: { (image, error, cacheType, imageURL) in
                        if let error = error {
                        //    print("Error loading image: \(error.localizedDescription)")
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
                filteredFlights = flightlist.filter { flight in
//                    if let airportCity = flight.country {
//                        return airportCity.contains(selectedCity)
//                    }
                    
                    if LanguageManager.shared.currentLanguage() == "ar" {
                        if let airportCity = flight.country_arabic {
                            return airportCity.contains(selectedCity)
                        }
                    } else {
                        if let airportCity = flight.country {
                            return airportCity.contains(selectedCity)
                        }
                    }
                    
                    
                    return false
                }.map { flight in
                    TopFlightListModel(airport_city: flight.airport_city ?? "",
                                       image: flight.image ?? "",
                                       traveldate: flight.travel_date ?? "",
                                       returndate: flight.return_date ?? "",
                                       from_city: flight.from_city ?? "",
                                       to_city: flight.to_city ?? "",
                                       fromcityairportcode: flight.from_city ?? "",
                                       tocityairportcode: flight.to_city ?? "",
                                       triptype: flight.trip_type ?? "",
                                       v_class: flight.airline_class ?? "",
                                       from_loc: flight.from_loc ?? "",
                                       to_loc: flight.to_loc ?? "",
                                       airline_class: flight.airline_class ?? "",
                                       from_airport_city:flight.from_airport_city,
                                       to_airport_city: flight.to_airport_city, 
                                       airport_city_ar: flight.to_airport_city_ar)
                }
                
                // Update the selected index path
                selectedIndex = indexPath
                
                
                // Reload the collection view to update with filtered data
                selectDestCV.reloadData()
            }
        }else {
            if let cell = collectionView.cellForItem(at: indexPath) as? SelectDestCVCell {
                
                let flight = filteredFlights[indexPath.row]
                
                defaults.setValue(MySingleton.shared.convertDateFormat(inputDate: flight.traveldate ?? "", f1: "dd/MM/yyyy", f2: "dd-MM-yyyy"), forKey: UserDefaultsKeys.calDepDate)
                defaults.setValue(MySingleton.shared.convertDateFormat(inputDate: flight.returndate ?? "", f1: "dd/MM/yyyy", f2: "dd-MM-yyyy"), forKey: UserDefaultsKeys.calRetDate)
                defaults.setValue(flight.airline_class, forKey: UserDefaultsKeys.selectClass)
                defaults.setValue(flight.airline_class, forKey: UserDefaultsKeys.rselectClass)
                defaults.setValue("1", forKey: UserDefaultsKeys.adultCount)
                defaults.setValue("0", forKey: UserDefaultsKeys.childCount)
                defaults.setValue("0", forKey: UserDefaultsKeys.infantsCount)
                defaults.setValue("1", forKey: UserDefaultsKeys.totalTravellerCount)
                defaults.setValue(flight.triptype, forKey: UserDefaultsKeys.journeyType)
                defaults.setValue("ALL", forKey: UserDefaultsKeys.fcariercode)
                
                
                defaults.set(flight.from_loc, forKey: UserDefaultsKeys.fromCity)
                defaults.set(flight.from_city, forKey: UserDefaultsKeys.fromlocid)
                defaults.set(flight.to_loc, forKey: UserDefaultsKeys.toCity)
                defaults.set(flight.to_city, forKey: UserDefaultsKeys.tolocid)
                
                
                
                defaults.set("Kuwait", forKey: UserDefaultsKeys.fromcitynameshow)
                defaults.set(flight.airport_city, forKey: UserDefaultsKeys.tocitynameshow)
                
                defaults.set(flight.from_airport_city, forKey: UserDefaultsKeys.fromcityname)
                defaults.set(flight.to_airport_city, forKey: UserDefaultsKeys.tocityname)
                defaults.set(flight.from_airport_city, forKey: UserDefaultsKeys.fcity)
                defaults.set(flight.to_airport_city, forKey: UserDefaultsKeys.tcity)
                
                defaults.set("Flight", forKey: UserDefaultsKeys.tabselect)
                
                delegate?.didTapOnPopulardestination(cell: self)
            }
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
extension PopularDestinationsTVCell {
    
    
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
