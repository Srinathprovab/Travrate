//
//  TransfersListVC.swift
//  Travgate
//
//  Created by FCI on 08/05/24.
//

import UIKit

class TransfersListVC: BaseTableVC, PreTransfersearchVMDelegate, AppliedTransferFilters {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var fromcitylbl: UILabel!
    @IBOutlet weak var tocitylbl: UILabel!
    @IBOutlet weak var dateslbl: UILabel!
    @IBOutlet weak var modifybtn: UIButton!
    
    static var newInstance: TransfersListVC? {
        let storyboard = UIStoryboard(name: Storyboard.Transfers.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? TransfersListVC
        return vc
    }
    
    
    var bookingSourceDataArrayCount = Int()
    var activeBookingArray = [Active_booking_source]()
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        
        MySingleton.shared.preTransfersearchVM = PreTransfersearchVM(self)
    }
    
    
    
    @objc func didTapOnModifySearchBtnAction(_ sender:UIButton) {
        gotoModifyTransferSearchVC()
    }
    
    
    func gotoModifyTransferSearchVC() {
        callapibool = false
        guard let vc = ModifyTransferSearchVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    
    
    @IBAction func didTapOnFilterBtnAction(_ sender: Any) {
        gotoFilterVC(strkey: "transferfilter")
    }
    
    func gotoFilterVC(strkey:String) {
        guard let vc = FilterVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.transferfilterDelegate = self
        vc.filterKey = strkey
        present(vc, animated: true)
    }
    
    @IBAction func didTapOnSortBtnAction(_ sender: Any) {
        print("didTapOnSortBtnAction")
    }
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        callapibool = false
        MySingleton.shared.callboolapi = false
        guard let vc = BookTransfersVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    override func didTapOnBookNowBtnAction(cell: TransfersInf0TVCell) {
        
        MySingleton.shared.transferpassengercount = cell.noofpassengers
        MySingleton.shared.transfer_token = cell.token
        didTapOnBookNowBtnAction()
    }
    
    
    
}



extension TransfersListVC {
    
    
    func setupUI(){
        
        setuplabels(lbl: fromcitylbl, text: "", textcolor: .BackBtnColor, font: .InterBold(size: 14), align: .center)
        setuplabels(lbl: tocitylbl, text: "", textcolor: .BackBtnColor, font: .InterBold(size: 14), align: .center)
        setuplabels(lbl: dateslbl, text: "", textcolor: .BackBtnColor, font: .InterRegular(size: 14), align: .center)
        
        modifybtn.addTarget(self, action: #selector(didTapOnModifySearchBtnAction(_:)), for: .touchUpInside)
        commonTableView.registerTVCells(["TransfersInf0TVCell",
                                         "EmptyTVCell"])
        
        
    }
    
    
    
    func didTapOnBookNowBtnAction() {
        gotoBDTransferVC()
    }
    
    
    func gotoBDTransferVC() {
        callapibool = true
        guard let vc = BDTransferVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
}







extension TransfersListVC {
    
    func callAPI() {
        
        
        DispatchQueue.main.async {[self] in
            holderView.isHidden = true
            MySingleton.shared.loderString = "fdetails"
            loderBool = true
            showLoadera()
            
            
            MySingleton.shared.preTransfersearchVM?.CALL_PRE_TRANSFER_SERACH_API(dictParam: MySingleton.shared.payload)
        }
        
        
        
    }
    
    
    func pretransfersearchDetails(response: PreTransfersearchModel) {
        DispatchQueue.main.async {
            MySingleton.shared.preTransfersearchVM?.CALL_TRANSFER_SERACH_API(dictParam: [:], url: response.hit_url ?? "")
        }
    }
    
    
    func transfersearchDetails(response: TransferSearchMode) {
        
        activeBookingArray = response.data?.active_booking_source ?? []
        bookingSourceDataArrayCount = activeBookingArray .count
        
        
        MySingleton.shared.transfer_searchid = "\(response.data?.sight_seen_search_params?.search_id ?? 0)"
        
        fromcitylbl.text = response.data?.sight_seen_search_params?.arrival
        tocitylbl.text = response.data?.sight_seen_search_params?.destination
        MySingleton.shared.transferlist.removeAll()
        
        
        
        dateslbl.text = response.data?.sight_seen_search_params?.trip_type == "oneway" ? "\(MySingleton.shared.convertDateFormat(inputDate: response.data?.sight_seen_search_params?.from_date ?? "", f1: "dd-MM-yyyy", f2: "MMM dd")) , Oneway" : "\(MySingleton.shared.convertDateFormat(inputDate: response.data?.sight_seen_search_params?.from_date ?? "", f1: "dd-MM-yyyy", f2: "MMM dd"))  to \(MySingleton.shared.convertDateFormat(inputDate: response.data?.sight_seen_search_params?.to_date ?? "", f1: "dd-MM-yyyy", f2: "MMM dd")) , Roundtrip"
        
        
        
        
        activeBookingArray.forEach { i in
            
            let seconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
                callGetTransferListAPI(searchid: "\(response.data?.sight_seen_search_params?.search_id ?? 0)", bookingsource: i.source_id ?? "")
            }
            
        }
        
        
        
    }
    
    
    func callGetTransferListAPI(searchid:String,bookingsource:String) {
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["booking_source"] = bookingsource
        MySingleton.shared.payload["search_id"] = searchid
        MySingleton.shared.payload["op"] = "load"
        
        DispatchQueue.main.async {
            MySingleton.shared.preTransfersearchVM?.CALL_TRANSFER_LIST_API(dictParam: MySingleton.shared.payload)
        }
    }
    
    
    
    func transferslistDetails(response: TransferListModel) {
        
        
        bookingSourceDataArrayCount -= 1
        
        
        if let newResults = response.data?.raw_transfer_list, !newResults.isEmpty {
            
            // Append the new data to the existing data
            MySingleton.shared.transferlist.append(contentsOf: newResults)
            
        } else {
            // No more items to load, update UI accordingly
            print("No more items to load.")
            // You can show a message or hide a loading indicator here
        }
        
        
        if bookingSourceDataArrayCount == 0 {
            if MySingleton.shared.transferlist.count <= 0 {
                
                
                gotoNoInternetScreen(keystr: "noresult")
            }else {
                appendPriceAndDate(list: MySingleton.shared.transferlist)
            }
        }
        
        
    }
    
    
    
    
    func appendPriceAndDate(list:[Raw_transfer_list]) {
        
        holderView.isHidden = false
        hideLoadera()
        loderBool = false
        
        
        
        prices.removeAll()
        cartype.removeAll()
        list.forEach { i in
            prices.append("\(i.price ?? 0)")
            cartype.append(i.car_detail?.title ?? "")
        }
        prices = prices.unique()
        cartype = cartype.unique()
        
        
        
        
        DispatchQueue.main.async {
            self.setupTVCells(list: list)
        }
        
    }
    
    
    
    func setupTVCells(list:[Raw_transfer_list]) {
        MySingleton.shared.tablerow.removeAll()
        
        
        
        
        
        list.forEach { i in
            MySingleton.shared.tablerow.append(TableRow(moreData: i,cellType:.TransfersInf0TVCell))
        }
        
        
        
        
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
}



extension TransfersListVC {
    
    
    func sportFilterByApplied(minpricerange: Double, maxpricerange: Double, cartypeArray: [String]) {
        
        print("minpricerange : \(minpricerange)")
        print("maxpricerange : \(maxpricerange)")
        print("cartypeArray : \(cartypeArray.joined(separator: ","))")
        
        
        // Filter the car rentals based on the specified criteria
        let filteredArray = MySingleton.shared.transferlist.filter { car in
            guard let totalString = car.price else { return false }
            
            let priceInRange = totalString >= minpricerange && totalString <= maxpricerange
            let cartypeArrayMatch = cartypeArray.isEmpty || cartypeArray.contains(car.car_detail?.title ?? "")
            
            return cartypeArrayMatch && priceInRange
            
            
        }
        
        setupTVCells(list: filteredArray)
        
        // Reload the table view with the filtered results
        commonTableView.reloadData()
        
    }
    
    
}


//MARK: - addObserver
extension TransfersListVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(nointrnetreload), name: Notification.Name("nointrnetreload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        
        
        if callapibool == true {
            callAPI()
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
