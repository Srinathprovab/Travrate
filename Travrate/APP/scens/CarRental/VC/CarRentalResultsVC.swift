//
//  CarRentalResultsVC.swift
//  Travrate
//
//  Created by FCI on 10/06/24.
//

import UIKit

class CarRentalResultsVC: BaseTableVC, CarrentalSearchVMDelegate, AppliedCarrentalFilters {
    
    
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var dateslbl: UILabel!
    @IBOutlet weak var carCountlbl: UILabel!
    
    static var newInstance: CarRentalResultsVC? {
        let storyboard = UIStoryboard(name: Storyboard.CarRental.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? CarRentalResultsVC
        return vc
    }
    
    var bookingSourceDataArrayCount = Int()
    var activeBookingArray = [CarActivebookingsource]()
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        addObserver()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        MySingleton.shared.carpresearchVM = CarrentalSearchVM(self)
    }
    
    
    
    
    //MARK: - didTapOnBackBtnAction
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        MySingleton.shared.callboolapi = true
        guard let vc = DashBoardTBVC.newInstance.self else {return}
        vc.selectedIndex = 0
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    
    
    //MARK: - didTapOnBackBtnAction
    @IBAction func didTapOnModifySearchBtnAction(_ sender: Any) {
        guard let vc = ModifySearchCarRentalVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: false)
    }
    
    
    //MARK: - didTapOnBackBtnAction
    @IBAction func didTapOnFilterBtnAction(_ sender: Any) {
        gotoFilterVC(strkey: "carfilter")
    }
    
    //MARK: - gotoFilterVC
    func gotoFilterVC(strkey:String) {
        guard let vc = FilterVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.carrentaldelegate = self
        vc.filterKey = strkey
        present(vc, animated: true)
    }
    
    
    //MARK: - didTapOnViewDetailsBtnAction CarRentalResultTVCell
    override func didTapOnViewDetailsBtnAction(cell: CarRentalResultTVCell) {
        
        MySingleton.shared.carproductcode = cell.product_code
        MySingleton.shared.carresultindex = cell.result_index
        MySingleton.shared.carresulttoken = cell.result_token
        
        gotoCarRentalChoosePackageVCC()
        
    }
    
    func gotoCarRentalChoosePackageVCC() {
        callapibool = true
        guard let vc = CarRentalChoosePackageVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
}



extension CarRentalResultsVC {
    
    
    func setupUI(){
        
        setuplabels(lbl: titlelbl, text: "", textcolor: .BackBtnColor, font: .InterBold(size: 14), align: .center)
        setuplabels(lbl: dateslbl, text: "", textcolor: .BackBtnColor, font: .InterRegular(size: 14), align: .center)

        
        commonTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Top left corner, Top right corner respectively
        commonTableView.layer.cornerRadius = 12
        commonTableView.clipsToBounds = true
        commonTableView.registerTVCells(["CarRentalResultTVCell",
                                         "EmptyTVCell"])
        
        
        
        
    }
    
    func callAPI() {
        
        
        MySingleton.shared.loderString = "fdetails"
        loderBool = true
        showLoadera()
        
        
        
        MySingleton.shared.carpresearchVM?.CALL_PRE_CAR_SEARCH_API(dictParam: MySingleton.shared.payload)
        
    }
    
    
    
    func carrentalPreserachRespons(response: CarrentalPreSearchModel) {
        
        
        DispatchQueue.main.async {
            MySingleton.shared.carpresearchVM?.CALL_CAR_SEARCH_API(dictParam: [:], url: response.hit_url ?? "")
        }
        
    }
    
    
    
    func carrentalserachRespons(response: CarSearchModel) {
        
    
        activeBookingArray = response.active_booking_source ?? []
        bookingSourceDataArrayCount = activeBookingArray.count
        
        titlelbl.text = response.car_search_params?.from_loc
        dateslbl.text = "\(MySingleton.shared.convertDateFormat(inputDate: response.car_search_params?.pickup_date ?? "", f1: "yyyy-MM-dd", f2: "MMM dd")) - \(MySingleton.shared.convertDateFormat(inputDate: response.car_search_params?.drop_date ?? "", f1: "yyyy-MM-dd", f2: "MMM dd"))"
        
        MySingleton.shared.carlist.removeAll()
        
        
        activeBookingArray.forEach { i in
            
            let seconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
                callCarListAPI(bookingsource: i.source_id ?? "",
                               searchid: response.search_id ?? "")
            }
            
        }
        
    }
    
    
    func callCarListAPI(bookingsource:String,searchid:String) {
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["search_id"] = searchid
        MySingleton.shared.payload["booking_source"] = bookingsource
        
        DispatchQueue.main.async {
            MySingleton.shared.carpresearchVM?.CALL_CAR_LIST_API(dictParam: MySingleton.shared.payload)
        }
    }
    
    
    func carListRespons(response: CarListModel) {
        
       
        bookingSourceDataArrayCount -= 1
        
        if let newResults = response.data?.raw_hotel_list, !newResults.isEmpty {
            // Append the new data to the existing data
            MySingleton.shared.carlist.append(contentsOf: newResults)
            
        } else {
            // No more items to load, update UI accordingly
            print("No more items to load.")
            // You can show a message or hide a loading indicator here
        }
        
        
        if bookingSourceDataArrayCount == 0 {
            if MySingleton.shared.carlist.count <= 0 {
                gotoNoInternetScreen(keystr: "noresult")
            }else {
                appendPriceAndDate(list: MySingleton.shared.carlist)
            }
        }
        
        
    }
    
    
    
    func appendPriceAndDate(list:[Raw_hotel_list]) {
        
        // Call this when you want to remove the child view controller
        hideLoadera()
        loderBool = false
        holderView.isHidden = false
        
        prices.removeAll()
        fuleArray.removeAll()
        carmanualArray.removeAll()
        doorcountArray.removeAll()
        
        list.forEach { i in
            carprices.append(i.product?[0].total ?? "")
            fuleArray.append(i.fuel ?? "")
            carmanualArray.append(i.transmission ?? "")
            doorcountArray.append("\(i.adults ?? "") Seat")
            
        }
        
        prices = carprices.unique()
        fuleArray = fuleArray.unique()
        carmanualArray = carmanualArray.unique()
        doorcountArray = doorcountArray.unique()
        
        
        DispatchQueue.main.async {
            self.setupTVCells(list: list)
        }
        
    }
    
    
    func setupTVCells(list:[Raw_hotel_list]) {
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.setAttributedTextnew(str1: "\(list.count)", str2: " car are Available", lbl: carCountlbl, str1font: .OpenSansBold(size: 16), str2font: .OpenSansRegular(size: 14), str1Color: .TitleColor, str2Color: .TitleColor)
        
        
        list.forEach { i in
    
            MySingleton.shared.tablerow.append(TableRow( key:"results", moreData: i,
                                                        cellType:.CarRentalResultTVCell))
        }
        
        
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType: .EmptyTVCell))
        
        if list.count == 0 {
            TableViewHelper.EmptyMessage(message: "No Data Found", tableview: commonTableView, vc: self)
        }
        
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
}




//MARK: - addObserver
extension CarRentalResultsVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(nointrnetreload), name: Notification.Name("nointrnetreload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        
        
        if MySingleton.shared.callboolapi == true {
            MySingleton.shared.carlist.removeAll()
            holderView.isHidden = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [unowned self] in
                callAPI()
            }
            
            
        }
    }
    
    
    
    @objc func reload() {
        DispatchQueue.main.async {[self] in
            commonTableView.reloadData()
        }
    }
    
    @objc func nointrnetreload() {
        
        DispatchQueue.main.async {[self] in
            commonTableView.reloadData()
        }
    }
    
    //MARK: - resultnil
    @objc func resultnil() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = "noresult"
        self.present(vc, animated: true)
    }
    
    
    func gotoNoInternetScreen(keystr:String) {
        callapibool = true
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.key = keystr
        self.present(vc, animated: false)
    }
    
    //MARK: - nointernet
    @objc func nointernet() {
        
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = "nointernet"
        self.present(vc, animated: true)
    }
    
    
}



extension CarRentalResultsVC {
    
   
    func sportFilterByApplied(minpricerange: Double, maxpricerange: Double, fuleArray: [String], carmanualArray: [String], doorcountArray: [String]) {
        
        print("minpricerange : \(minpricerange)")
        print("maxpricerange : \(maxpricerange)")
        print("fuleArray : \(fuleArray.joined(separator: ","))")
        print("carmanualArray : \(carmanualArray.joined(separator: ","))")
        print("doorcountArray : \(doorcountArray.joined(separator: ","))")
        
        
       
            
            // Filter the car rentals based on the specified criteria
            let filteredArray = MySingleton.shared.carlist.filter { car in
                guard let product = car.product?.first,
                      let totalString = product.total,
                      let total = Double(totalString) else { return false }

            // Check if the car's fuel type matches any selected fuel types or the array is empty
            let fuelMatches = fuleArray.isEmpty || fuleArray.contains(car.fuel ?? "")
            
            // Check if the car's transmission type matches any selected transmission types or the array is empty
            let transmissionMatches = carmanualArray.isEmpty || carmanualArray.contains(car.transmission ?? "")
            
            // Check if the car's door count matches any selected door counts or the array is empty
            let doorCountMatches = doorcountArray.isEmpty || doorcountArray.contains("\(car.adults ?? "0") Seat")

            // Check if the car's price falls within the specified range
            let priceInRange = total >= minpricerange && total <= maxpricerange

            return fuelMatches && transmissionMatches && doorCountMatches && priceInRange
        }

        setupTVCells(list: filteredArray)

        // Reload the table view with the filtered results
        commonTableView.reloadData()
        
       
        
    }
    
    
   

    
   
    
}
