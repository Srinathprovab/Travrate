//
//  CarRentalResultsVC.swift
//  Travrate
//
//  Created by FCI on 10/06/24.
//

import UIKit

class CarRentalResultsVC: BaseTableVC, CarrentalSearchVMDelegate {
    
    
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
        print("didTapOnFilterBtnAction")
    }
    
    
    //MARK: - didTapOnViewDetailsBtnAction CarRentalResultTVCell
    override func didTapOnViewDetailsBtnAction(cell: CarRentalResultTVCell) {
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
        
        
        
        commonTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Top left corner, Top right corner respectively
        commonTableView.layer.cornerRadius = 12
        commonTableView.clipsToBounds = true
        commonTableView.registerTVCells(["CarRentalResultTVCell",
                                         "EmptyTVCell"])
        
        
        
        
    }
    
    func callAPI() {
        
        MySingleton.shared.loderString = "loder"
        loderBool = true
        showLoadera()
        holderView.isHidden = true
        
        
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
         
      
        MySingleton.shared.setAttributedTextnew(str1: "\(list.count)", str2: " car are Available", lbl: carCountlbl, str1font: .OpenSansBold(size: 16), str2font: .OpenSansRegular(size: 14), str1Color: .TitleColor, str2Color: .TitleColor)
        
        
        DispatchQueue.main.async {
            self.setupTVCells(list: list)
        }
        
    }
    
    
    func setupTVCells(list:[Raw_hotel_list]) {
        MySingleton.shared.tablerow.removeAll()
        
        
        list.forEach { i in
            MySingleton.shared.tablerow.append(TableRow(title:i.car_name,
                                                        price: i.product?[0].total,
                                                        currency: i.product?[0].currency,
                                                        text: i.product?[0].deposit,
                                                        image: i.car_image,
                                                        cellType:.CarRentalResultTVCell))
        }
        
        
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType: .EmptyTVCell))
        
        
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
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
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
