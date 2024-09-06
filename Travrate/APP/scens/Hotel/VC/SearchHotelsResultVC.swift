//
//  SearchHotelsResultVC.swift
//  BabSafar
//
//  Created by MA673 on 29/07/22.
//

import UIKit
import DropDown

class SearchHotelsResultVC: BaseTableVC, UITextFieldDelegate, HotelSearchViewModelDelegate, HotelsTVCellelegate, TimerManagerDelegate {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var cvHolderView: UIView!
    @IBOutlet weak var recommandedView: UIView!
    @IBOutlet weak var recommandedlbl: UILabel!
    @IBOutlet weak var recommandedbtn: UIButton!
    @IBOutlet weak var filterBtnView: UIView!
    @IBOutlet weak var filterImg: UIImageView!
    @IBOutlet weak var filterlbl: UILabel!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var cittlbl: UILabel!
    @IBOutlet weak var dateslbl: UILabel!
    @IBOutlet weak var paxlbl: UILabel!
    @IBOutlet weak var viewMapBtn: UIButton!
    @IBOutlet weak var sessionTimelbl: UILabel!
    @IBOutlet weak var hotelsCountlbl: UILabel!
    @IBOutlet weak var searchbtn: UIButton!
    @IBOutlet weak var hotelNameSearchTF: UITextField!
    @IBOutlet weak var hotelNameSearchTFView: UIView!
    @IBOutlet weak var closeHotelNameSearchViewBtn: UIButton!
    
    // var loaderVC: LoderVC!
    var bookingSourceDataArrayCount = Int()
    let dropDown = DropDown()
    var lastContentOffset: CGFloat = 0
    var tablerow = [TableRow]()
    var filtered = [HotelSearchResult]()
    var totalcount = 0
    var searchText = String()
    var isvcfrom = String()
    var payload = [String:Any]()
    var payload1 = [String:Any]()
    var countrycode = String()
    
    var noofnights = String()
    var bsDataArray = [ABSData]()
    var viewModel:HotelSearchViewModel?
    
    static var newInstance: SearchHotelsResultVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SearchHotelsResultVC
        return vc
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
        
        
        if callapibool == true{
            holderView.isHidden = true
            callActiveBookingSourceAPI()
        }
    }
    
    
    func setupinitialView() {
        
        setupUI()
        commonTableView.register(UINib(nibName: "HotelsTVCell", bundle: nil), forCellReuseIdentifier: "cell44")
        commonTableView.register(UINib(nibName: "EmptyTVCell", bundle: nil), forCellReuseIdentifier: "emptyTVCell")
        commonTableView.backgroundColor = .AppHolderViewColor
        
        filtered = hotelSearchResult
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("nointernet"), object: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupinitialView()
        viewModel = HotelSearchViewModel(self)
        MySingleton.shared.delegate = self
        
        
    }
    
    //MARK: - setupRefreshControl
    
    func setupUI() {
        
        searchbtn.layer.cornerRadius = 4
        searchbtn.layer.borderWidth = 1
        searchbtn.layer.borderColor = UIColor.BorderColor.cgColor
        searchbtn.addTarget(self, action: #selector(didTapOnSearcHotelshBtnAction(_:)), for: .touchUpInside)
        closeHotelNameSearchViewBtn.addTarget(self, action: #selector(didTapOnCloseSearcHotelshBtnAction(_:)), for: .touchUpInside)
        hotelNameSearchTF.setLeftPaddingPoints(15)
        hotelNameSearchTF.font = .InterRegular(size: 14)
        hotelNameSearchTF.addTarget(self, action: #selector(editingTextField1(_:)), for: .editingChanged)
        
        
        setuplabels(lbl: cittlbl, text: "", textcolor: .BackBtnColor, font: .InterBold(size: 14), align: .center)
        setuplabels(lbl: dateslbl, text: "", textcolor: .BackBtnColor, font: .InterRegular(size: 14), align: .center)
        setuplabels(lbl: paxlbl, text: "", textcolor: .BackBtnColor, font: .InterRegular(size: 14), align: .center)
        
        self.cittlbl.text = defaults.string(forKey: UserDefaultsKeys.locationcity) ?? ""
        self.dateslbl.text = "\(MySingleton.shared.convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.checkin) ?? "", f1: "dd-MM-yyyy", f2: "MMM dd")) - \(MySingleton.shared.convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.checkout) ?? "", f1: "dd-MM-yyyy", f2: "MMM dd"))"
        
        
        let roomscount = defaults.integer(forKey: UserDefaultsKeys.roomcount)
        let adultcount = defaults.integer(forKey: UserDefaultsKeys.hoteladultscount)
        let childcount = defaults.integer(forKey: UserDefaultsKeys.hotelchildcount)
        
        
        let roomcount = roomscount > 1 ? "\(roomscount) Rooms" : "\(roomscount) Room"
        let adultsCoutntStr = adultcount > 1 ? "\(roomcount) | \(adultcount) Adults" : "\(roomcount) | \(adultcount) Adult"
        
        var labelText = adultsCoutntStr
        //  var labelText = adultcount > 1 ? "Room \(roomscount) | Adults \(adultcount)" : "Adult \(adultcount)"
        if childcount > 0 {
            let newchildcount = childcount > 1 ? "\(childcount) Children" : "\(childcount) Child"
            labelText += ", \(newchildcount)"
        }
        paxlbl.text = labelText
        
        
        cvHolderView.isHidden = true
        
        holderView.layer.borderWidth = 1
        holderView.layer.borderColor = UIColor.AppBorderColor.cgColor
        cvHolderView.backgroundColor = .WhiteColor
        cvHolderView.addBottomBorderWithColor(color: .AppBorderColor, width: 1)
        recommandedbtn.setTitle("", for: .normal)
        
        setuplabels(lbl: recommandedlbl, text: "SORT", textcolor: .AppLabelColor, font: .LatoRegular(size: 16), align: .right)
        setuplabels(lbl: filterlbl, text: "FILTER", textcolor: .AppLabelColor, font: .LatoRegular(size: 16), align: .left)
        
        commonTableView.backgroundColor = .WhiteColor
        
        filterBtn.addTarget(self, action: #selector(didTapOnFilterBtnAction(_:)), for: .touchUpInside)
        recommandedbtn.addTarget(self, action: #selector(didTapOnSortBtnAction(_:)), for: .touchUpInside)
        setupDropDown()
        
        viewMapBtn.backgroundColor = .black.withAlphaComponent(0.5)
        viewMapBtn.layer.cornerRadius = 4
        viewMapBtn.addTarget(self, action: #selector(didTapOnViewMapBtnAction(_:)), for: .touchUpInside)
    }
    
    
    func setupDropDown() {
        
        dropDown.direction = .any
        dropDown.backgroundColor = .WhiteColor
        dropDown.dataSource = ["Price (Low to High)","Price (High to Low)","Hotel Name(A to Z)","Hotel Name(Z to A)"]
        dropDown.anchorView = self.recommandedbtn
        dropDown.bottomOffset = CGPoint(x: 0, y: recommandedbtn.frame.size.height + 10)
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            print(item)
            
            switch item {
            case "Price (Low to High)":
                self?.filtersSortByApplied(sortBy: .PriceLow)
                break
                
            case "Price (High to Low)":
                self?.filtersSortByApplied(sortBy: .PriceHigh)
                break
                
            case "Hotel Name(A to Z)":
                self?.filtersSortByApplied(sortBy: .airlinessortatoz)
                break
                
            case "Hotel Name(Z to A)":
                self?.filtersSortByApplied(sortBy: .airlinessortztoa)
                break
                
            default:
                break
            }
        }
    }
    
    
    
    
    
    
    @objc func didTapOnSearcHotelshBtnAction(_ sender:UIButton) {
        hotelNameSearchTFView.isHidden = false
        hotelNameSearchTF.becomeFirstResponder()
    }
    
    @objc func didTapOnCloseSearcHotelshBtnAction(_ sender:UIButton) {
        hotelNameSearchTFView.isHidden = true
        hotelNameSearchTF.resignFirstResponder()
        hotelNameSearchTF.text = ""
        
        searchText = ""
        isSearchBool = false
        filterContentForSearchText(searchText)
        commonTableView.reloadData()
    }
    
    @objc func didTapOnFilterBtnAction(_ sender:UIButton) {
        gotoFilterVC(strkey: "hotelfilter")
    }
    
    
    @objc func didTapOnSortBtnAction(_ sender:UIButton) {
        dropDown.show()
    }
    
    func gotoFilterVC(strkey:String) {
        guard let vc = FilterVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self
        vc.filterKey = strkey
        present(vc, animated: true)
    }
    
    
    
    func setAttributedText1(str1:String,str2:String,lbl:UILabel)  {
        
        let atter1 = [NSAttributedString.Key.foregroundColor:UIColor.AppTabSelectColor,
                      NSAttributedString.Key.font:UIFont.LatoBold(size: 12)] as [NSAttributedString.Key : Any]
        let atter2 = [NSAttributedString.Key.foregroundColor:UIColor.AppTabSelectColor,
                      NSAttributedString.Key.font:UIFont.LatoBold(size: 18)] as [NSAttributedString.Key : Any]
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        let atterStr2 = NSMutableAttributedString(string: str2, attributes: atter2)
        
        
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        combination.append(atterStr2)
        
        lbl.attributedText = combination
        
    }
    
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        guard let vc = SearchHotelVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    
    
    @IBAction func didTaponEditBtnAction(_ sender: Any) {
        guard let vc = ModifyHotelSearchVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    
    //MARK: -  didTapOnViewMapBtnAction
    @objc func didTapOnViewMapBtnAction(_ sender:UIButton) {
        mapModelArray.removeAll()
        //        hotelSearchResult.forEach { i in
        //            let mapModel = MapModel(
        //                longitude: i.longitude ?? "",
        //                latitude: i.latitude ?? "",
        //                hotelname: i.name ?? ""
        //            )
        //            mapModelArray.append(mapModel)
        //        }
        
        mapModelArray.removeAll()
        if isSearchBool == false {
            
            hotelSearchResult.forEach { i in
                let mapModel = MapModel(
                    longitude: i.longitude ?? "",
                    latitude: i.latitude ?? "",
                    hotelname: i.name ?? ""
                )
                mapModelArray.append(mapModel)
            }
            
            
        } else {
            filtered.forEach { i in
                let mapModel = MapModel(
                    longitude: i.longitude ?? "",
                    latitude: i.latitude ?? "",
                    hotelname: i.name ?? ""
                )
                mapModelArray.append(mapModel)
            }
            
        }
        gotoMapViewVC(keystr: "viewmap")
    }
    
    
    //MARK: -  HotelsTVCell Delegate Methods
    func didTapOnTermsAndConditionBtn(cell: HotelsTVCell) {
        print(cell.hotel_DescLabel)
        goToTermsPopupVC(titlestr: cell.hotelNamelbl.text ?? "",
                         hoteldesc: cell.hotel_DescLabel)
    }
    
    
    func goToTermsPopupVC(titlestr:String,hoteldesc:String) {
        guard let vc = TermsPopupVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.titlestr = titlestr
        vc.subtitlestr = hoteldesc
        present(vc, animated: false)
    }
    
    
    
    func didTapOnBookNowBtnAction(cell: HotelsTVCell) {
        
        goToHotelDetailsVC(hid: cell.hotelid,
                           bs: cell.bookingsource,
                           kwdprice: cell.kwdlbl.text ?? "")
        
    }
    
    
    func goToHotelDetailsVC(hid:String,bs:String,kwdprice:String) {
        hotelDetailsTapBool = false
        guard let vc = HotelDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.hotelid = hid
        vc.bookingsource = bs
        vc.kwdprice = kwdprice
        callapibool = true
        present(vc, animated: true)
    }
    
    
    //MARK: - didTapOnLocationBtnAction
    func didTapOnLocationBtnAction(cell: HotelsTVCell) {
        mapModelArray.removeAll()
        let mapModel = MapModel(
            longitude: cell.long,
            latitude: cell.lat,
            hotelname: cell.hotelNamelbl.text ?? ""
        )
        mapModelArray.append(mapModel)
        gotoMapViewVC(keystr: "show")
    }
    
    func gotoMapViewVC(keystr:String) {
        guard let vc = MapViewVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.key = keystr
        present(vc, animated: true)
    }
    
    
    //MARK: - didTapOnShareResultBtnAction
    override func didTapOnShareResultBtnAction(cell: HotelsTVCell)  {
        gotoShareResultVC()
    }
    
    func gotoShareResultVC() {
        guard let vc = ShareResultVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}


extension SearchHotelsResultVC {
    
    
    func callActiveBookingSourceAPI() {
        
        loderBool = true
        showLoadera()
        
        viewModel?.CALL_GET_ACTIVE_BOOKING_SOURCE_API(dictParam: [:])
    }
    
    func activebookingSourceResult(response: ActiveBookingSourceModel) {
        
        bsDataArray = response.data ?? []
        bookingSourceDataArrayCount = response.data?.count ?? 0
        
        
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
            callHotelPreSearchAPI()
        }
    }
    
    
    func callHotelPreSearchAPI() {
        
        do {
            
            let arrJson = try JSONSerialization.data(withJSONObject: payload, options: JSONSerialization.WritingOptions.prettyPrinted)
            let theJSONText = NSString(data: arrJson, encoding: String.Encoding.utf8.rawValue)
            print(theJSONText ?? "")
            payload1["search_params"] = theJSONText
            payload1["offset"] = "0"
            payload1["limit"] = "10"
            
            viewModel?.CallHotelPreSearchAPI(dictParam: payload1)
            
        }catch let error as NSError{
            print(error.description)
        }
        
    }
    
    func hoteSearchPreResult(response: HotelSearchNewModel) {
        bsDataArray.forEach { i in
            
            let seconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
                callHotelSearchAPI(bookingsource: i.source_id ?? "",
                                   searchid: "\(response.search_id ?? 0)")
            }
            
        }
    }
    
    
    func callHotelSearchAPI(bookingsource:String,searchid:String){
        payload.removeAll()
        payload["offset"] = "0"
        payload["limit"] = "10"
        payload["booking_source"] = bookingsource
        payload["search_id"] = searchid
        payload["ResultIndex"] = "1"
        
        hbookingsource = bookingsource
        viewModel?.CallHotelSearchAPI(dictParam: payload)
    }
    
    
    
    func hoteSearchResult(response: HotelSearchModel) {
        
        bookingSourceDataArrayCount -= 1
        //  isfilterApplied = false
        filterBtnView.isHidden = false
        commonTableView.isHidden = false
        cvHolderView.isHidden = false
        loderBool = false
        holderView.isHidden = false
        isfilterApplied = false
        
        hsearchid = response.search_id ?? ""
        
        
        // Stop the timer if it's running
        MySingleton.shared.stopTimer()
        MySingleton.shared.startTimer(time: 1500) // Set your desired total time
        
        if let newResults = response.data?.hotelSearchResult, !newResults.isEmpty {
            // Append the new data to the existing data
            hotelSearchResult.append(contentsOf: newResults)
            totalcount = hotelSearchResult.count
        } else {
            // No more items to load, update UI accordingly
            print("No more items to load.")
            // You can show a message or hide a loading indicator here
        }
        
        
        if bookingSourceDataArrayCount == 0 {
            
            holderView.isHidden = true
            if hotelSearchResult.count <= 0 {
                gotoNoInternetScreen(keystr: "noresult")
                // holderView.isHidden = true
            }else {
                DispatchQueue.main.async {
                    self.appendValues(list: hotelSearchResult)
                }
            }
        }
        
        
        
        
    }
    
    
    func appendValues(list:[HotelSearchResult]) {
        
        // Call this when you want to remove the child view controller
        hideLoadera()
        loderBool = false
        
        filtered = list
        holderView.isHidden = false
        prices.removeAll()
        neighbourwoodArray.removeAll()
        nearBylocationsArray.removeAll()
        faretypeArray .removeAll()
        amenitiesArray.removeAll()
        mapModelArray.removeAll()
        hotelstarratingArray.removeAll()
        
        hotelfiltermodel.starRatingNew = starRatingInputArray
        
        hotelsCountlbl.text = "\(list.count)"
        totalcount = list.count
        
        
        list.forEach { i in
            
            noofnights = "\(i.no_of_nights ?? 0)"
            prices.append(i.price ?? "0")
            hotelstarratingArray.append("\(i.star_rating ?? 0)")
            neighbourwoodArray.append(i.location ?? "")
            if let refund = i.refund, !refund.isEmpty {
                faretypeArray.append(refund)
            }
            
            i.facility?.forEach { j in
                if let facilityName = j.name, !facilityName.isEmpty {
                    amenitiesArray.append(facilityName)
                }
            }
            
            i.near_by?.forEach { k in
                if let distance = k.distance, let poiName = k.poiName {
                    let nearbyname = "\(distance) metres for \(poiName)"
                    if !nearbyname.isEmpty {
                        nearBylocationsArray.append(nearbyname)
                    }
                }
            }
            
            
            
        }
        
        prices = Array(Set(prices))
        nearBylocationsArray = Array(Set(nearBylocationsArray))
        faretypeArray = Array(Set(faretypeArray))
        amenitiesArray = Array(Set(amenitiesArray))
        hotelstarratingArray = Array(Set(hotelstarratingArray))
        neighbourwoodArray = Array(Set(neighbourwoodArray))
        
        
        
        DispatchQueue.main.async {[self] in
            commonTableView.reloadData()
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //check search text & original text
        if( isSearchBool == true){
            return filtered.count + 1
        }else{
            return hotelSearchResult.count + 1
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        let rowCount = isSearchBool ? filtered.count : hotelSearchResult.count
        
        
        if indexPath.row == rowCount {
            // Dequeue the empty cell
            if let cell = tableView.dequeueReusableCell(withIdentifier: "emptyTVCell", for: indexPath) as? EmptyTVCell{
                // Configure the empty cell as needed, or leave it empty
                cell.backgroundColor = .AppHolderViewColor // Example configuration
                ccell = cell
            }
        } else {
            
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell44", for: indexPath) as? HotelsTVCell{
                cell.selectionStyle = .none
                cell.delegate = self
                
                if(isSearchBool == true){
                    
                    let dict = filtered[indexPath.row]
                    
                    cell.hotelNamelbl.text = dict.name
                    
                    cell.hotelImg.sd_setImage(with: URL(string: dict.image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"), options: [.retryFailed], completed: { (image, error, cacheType, imageURL) in
                        if let error = error {
                            // Handle error loading image
                            //    print("Error loading image: \(error.localizedDescription)")
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
                    
                    
                    cell.locationlbl.text = dict.address
                    MySingleton.shared.setAttributedTextnew(str1: "\(dict.currency ?? "") ",
                                                            str2: dict.price ?? "",
                                                            lbl: cell.kwdlbl,
                                                            str1font: .InterBold(size: 12),
                                                            str2font: .InterBold(size: 20),
                                                            str1Color: .BackBtnColor,
                                                            str2Color: .BackBtnColor)
                    
                    cell.bookingsource = dict.booking_source ?? ""
                    cell.hotelid = String(dict.hotel_code ?? "0")
                    cell.lat = dict.latitude ?? ""
                    cell.long = dict.longitude ?? ""
                    
                    
                    if MySingleton.shared.totalnights == "0" || MySingleton.shared.totalnights == "1" {
                        cell.totalpricefornightslbl.text = "Total Price For 1 Night"
                    }else {
                        cell.totalpricefornightslbl.text = "Total Price For \(MySingleton.shared.totalnights) Nights"
                    }
                    
                    //   cell.setAttributedString1(str1:dict.currency ?? "", str2: dict.price ?? "")
                    cell.ratingView.value = CGFloat(dict.star_rating ?? 0)
                    cell.hotel_DescLabel = dict.hotel_desc ?? "bbbbb"
                    
                    
                    if let facilities = dict.facility, !facilities.isEmpty {
                        cell.facilityArray = facilities
                    } else {
                        // Handle the case when facility is empty or nil
                        print("Facility array is empty or nil")
                    }
                    
                    
                    if dict.star_rating == 0 {
                        cell.ratingView.isHidden = true
                    }else {
                        cell.ratingView.isHidden = false
                    }
                    
                    ccell = cell
                    
                    
                    
                }else{
                    
                    
                    
                    let dict = hotelSearchResult[indexPath.row]
                    
                    
                    hotelsCountlbl.text = "\(hotelSearchResult.count)"
                    
                    cell.hotelNamelbl.text = dict.name
                    cell.hotelImg.sd_setImage(with: URL(string: dict.image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"), options: [.retryFailed], completed: { (image, error, cacheType, imageURL) in
                        if let error = error {
                            // Handle error loading image
                            //   print("Error loading image: \(error.localizedDescription)")
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
                    
                    cell.ratingView.value = CGFloat(dict.star_rating ?? 0)
                    cell.locationlbl.text = dict.address
                    MySingleton.shared.setAttributedTextnew(str1: "\(dict.currency ?? "") ",
                                                            str2: dict.price ?? "",
                                                            lbl: cell.kwdlbl,
                                                            str1font: .InterBold(size: 12),
                                                            str2font: .InterBold(size: 20),
                                                            str1Color: .BackBtnColor,
                                                            str2Color: .BackBtnColor)
                    
                    
                    cell.bookingsource = dict.booking_source ?? ""
                    cell.hotelid = String(dict.hotel_code ?? "0")
                    cell.lat = dict.latitude ?? ""
                    cell.long = dict.longitude ?? ""
                    
                    if MySingleton.shared.totalnights == "0" || MySingleton.shared.totalnights == "1" {
                        cell.totalpricefornightslbl.text = "Total Price For 1 Night"
                    }else {
                        cell.totalpricefornightslbl.text = "Total Price For \(MySingleton.shared.totalnights) Nights"
                    }
                    //      cell.setAttributedString1(str1:dict.currency ?? "", str2: dict.price ?? "")
                    
                    
                    cell.hotel_DescLabel = dict.hotel_desc ?? "bbbbb"
                    
                    if let facilities = dict.facility, !facilities.isEmpty {
                        cell.facilityArray = facilities
                    } else {
                        // Handle the case when facility is empty or nil
                        print("Facility array is empty or nil")
                    }
                    
                    
                    
                    if dict.star_rating == 0 {
                        cell.ratingView.isHidden = true
                    }else {
                        cell.ratingView.isHidden = false
                    }
                    
                    
                    
                    
                    ccell = cell
                }
            }
        }
        
        return ccell
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}




extension SearchHotelsResultVC {
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRowIndex = tableView.numberOfRows(inSection: 0) - 1
        
        
        if indexPath.row == lastRowIndex && !isLoadingData && lastRowIndex != 0{
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
                
                if isSearchBool == false {
                    callHotelSearchPaginationAPI()
                }
            }
            
        }
    }
    
    func callHotelSearchPaginationAPI() {
        
        print("You've reached the last cell, trigger the API call.")
        loderBool = false
        
        payload.removeAll()
        payload["booking_source"] = hbookingsource
        payload["search_id"] = hsearchid
        payload["offset"] = "\(totalcount + 1)"
        payload["limit"] = "10"
        payload["no_of_nights"] = noofnights
        
        viewModel?.CallHotelSearchPagenationAPI(dictParam: payload)
        
    }
    
    func hoteSearchPagenationResult(response: HotelSearchModel) {
        
        loderBool = true
        mapModelArray.removeAll()
        response.data?.hotelSearchResult?.forEach { i in
            
            hotelprices.append(i.price ?? "")
            
            let mapModel = MapModel(
                longitude: i.longitude ?? "",
                latitude: i.latitude ?? "",
                hotelname: i.name ?? ""
            )
            mapModelArray.append(mapModel)
        }
        
        
        if let newResults = response.data?.hotelSearchResult, !newResults.isEmpty {
            // Append the new data to the existing data
            hotelSearchResult.append(contentsOf: newResults)
            totalcount = hotelSearchResult.count
            DispatchQueue.main.async {
                self.appendValues(list: hotelSearchResult)
            }
        } else {
            // No more items to load, update UI accordingly
            print("No more items to load.")
            // You can show a message or hide a loading indicator here
        }
        
    }
    
    
    
}




extension SearchHotelsResultVC:AppliedFilters{
    func filtersByApplied(minpricerange: Double, maxpricerange: Double, noofStopsArray: [String], refundableTypeArray: [String], departureTime: [String], arrivalTime: [String], noOvernightFlight: [String], airlinesFilterArray: [String], luggageFilterArray: [String], connectingFlightsFilterArray: [String], ConnectingAirportsFilterArray: [String], mindurationrange: Double, maxdurationrange: Double, minTransitTimerange: Double, maxransitTimerange: Double) {
        
    }
    
    
    
    
    //MARK: - hotelFilterByApplied
    
    func hotelFilterByApplied(minpricerange: Double, maxpricerange: Double, starRating: String, starRatingNew: [String], refundableTypeArray: [String], nearByLocA: [String], niberhoodA: [String], aminitiesA: [String]) {
        
        // Set the filter flag to true
        
        //  isSearchBool = filterresettapbool == true ? false : true
        
        
        if filterresettapbool == true {
            isSearchBool = false
        }else{
            isSearchBool = true
        }
        
        
        // Filter the hotels based on the specified criteria
        let filteredArray = hotelSearchResult.filter { hotel in
            guard let totalString = Double(hotel.price ?? "0.0") else { return false }
            
            let priceInRange = totalString >= minpricerange && totalString <= maxpricerange
            let ratingMatches = starRatingNew.isEmpty || starRatingNew.contains("\(hotel.star_rating ?? 0)")
            //    let refundableMatch = refundableTypeArray.isEmpty || refundableTypeArray.contains(hotel.refund ?? "")
            let niberhoodMatch = niberhoodA.isEmpty || niberhoodA.contains(hotel.location ?? "")
            
            
            
            // Check if the hotel's amenities match any selected amenities or the array is empty
            let aminitiesMatch = aminitiesA.isEmpty || (hotel.facility?.contains { facility in
                aminitiesA.contains(facility.name ?? "")
            } ?? false)
            
            
            // Check if the hotel's nearby location matches any selected locations or the array is empty
            let nearByLocAMatch = nearByLocA.isEmpty || (hotel.near_by?.contains { nearby in
                let nearbyLocation = "\(nearby.distance ?? "") metres for \(nearby.poiName ?? "")"
                return nearByLocA.contains(nearbyLocation)
            } ?? false)
            
            
            
            return priceInRange && ratingMatches && niberhoodMatch && aminitiesMatch && nearByLocAMatch
        }
        
        // Update the filtered results
        filtered = filteredArray
        hotelsCountlbl.text = "\(filtered.count)"
        // Display a message if no hotels match the criteria
        
        mapModelArray.removeAll()
        if filteredArray.count == 0 {
            TableViewHelper.EmptyMessage(message: "No Data Found", tableview: commonTableView, vc: self)
        } else {
            TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
            
        }
        
        
        
        // Reload the table view with the filtered results
        commonTableView.reloadData()
    }
    
    
    
    //MARK: - SORT BY FILTER
    func filtersSortByApplied(sortBy: SortParameter) {
        
        
        commonTableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        switch sortBy {
            
        case .PriceLow:
            
            isSearchBool = true
            
            // Sort the hotelSearchResult array by price in ascending order
            filtered = hotelSearchResult.sorted { (item1, item2) in
                let price1 = Double(item1.price ?? "0") ?? 0
                let price2 = Double(item2.price ?? "0") ?? 0
                return price1 < price2
            }
            
            
            DispatchQueue.main.async {[self] in
                commonTableView.reloadData()
            }
            break
            
            
        case .PriceHigh:
            
            isSearchBool = true
            // Sort the hotelSearchResult array by price in ascending order
            filtered = hotelSearchResult.sorted { (item1, item2) in
                let price1 = Double(item1.price ?? "0") ?? 0
                let price2 = Double(item2.price ?? "0") ?? 0
                return price1 > price2
            }
            
            DispatchQueue.main.async {[self] in
                commonTableView.reloadData()
            }
            break
            
            
        case .airlinessortatoz:
            
            isSearchBool = true
            filtered = hotelSearchResult.sorted { $0.name ?? "" < $1.name ?? "" }
            DispatchQueue.main.async {[self] in
                commonTableView.reloadData()
            }
            break
            
            
        case .airlinessortztoa:
            isSearchBool = true
            
            filtered = hotelSearchResult.sorted { $0.name ?? "" > $1.name ?? "" }
            DispatchQueue.main.async {[self] in
                commonTableView.reloadData()
            }
            break
            
            
        default:
            break
        }
        
        
        if sortBy == .nothing {
            isSearchBool = false
        }
    }
    
    
    
}



extension SearchHotelsResultVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(nointrnetreload), name: Notification.Name("nointrnetreload"), object: nil)
        
    }
    
    
    @objc func reload() {
        commonTableView.reloadData()
    }
    
    //MARK: - resultnil
    @objc func resultnil() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = "noresult"
        self.present(vc, animated: true)
    }
    
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = "nointernet"
        self.present(vc, animated: true)
    }
    
    
    func gotoNoInternetScreen(keystr:String) {
        callapibool = true
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.key = keystr
        self.present(vc, animated: false)
    }
    
    
    @objc func nointrnetreload() {
        
        DispatchQueue.main.async {[self] in
            commonTableView.reloadData()
        }
    }
    
    
    
    //MARK: - updateTimer
    func updateTimer() {
        
        let totalTime = MySingleton.shared.totalTime
        let minutes =  totalTime / 60
        let seconds = totalTime % 60
        let formattedTime = String(format: "%02d:%02d", minutes, seconds)
        
        
        MySingleton.shared.setAttributedTextnew(str1: "\(formattedTime)",
                                                str2: "",
                                                lbl: sessionTimelbl,
                                                str1font: .OpenSansMedium(size: 12),
                                                str2font: .OpenSansMedium(size: 12),
                                                str1Color: .BooknowBtnColor,
                                                str2Color: .BooknowBtnColor)
        
        
    }
    
    
    func timerDidFinish() {
        gotoPopupScreen()
    }
    
    
    func gotoPopupScreen() {
        guard let vc = PopupVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
}




extension SearchHotelsResultVC {
    
    
    @objc func editingTextField1(_ tf: UITextField) {
        searchText = tf.text ?? ""
        
        if searchText == "" {
            isSearchBool = false
            filterContentForSearchText(searchText)
        }else {
            isSearchBool = true
            filterContentForSearchText(searchText)
            
        }
    }
    
    
    func filterContentForSearchText(_ searchText: String) {
        print("Filterin with:", searchText)
        filtered.removeAll()
        filtered = hotelSearchResult.filter { thing in
            return "\(thing.name?.lowercased() ?? "")".contains(searchText.lowercased())
        }
        
        commonTableView.reloadData()
    }
    
    
}
