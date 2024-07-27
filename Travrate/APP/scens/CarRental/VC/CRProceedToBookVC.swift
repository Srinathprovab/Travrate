//
//  CRProceedToBookVC.swift
//  Travrate
//
//  Created by FCI on 14/06/24.
//

import UIKit

class CRProceedToBookVC: BaseTableVC, CarPreBookingVMDelegate {
   
    
    @IBOutlet weak var proceedBtn: UIButton!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var dateslbl: UILabel!
    
    static var newInstance: CRProceedToBookVC? {
        let storyboard = UIStoryboard(name: Storyboard.CarRental.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? CRProceedToBookVC
        return vc
    }
    
    
    var pkgtitleStr = String()
    var cardetails : Result_token?
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        
        MySingleton.shared.carPreBookingVM = CarPreBookingVM(self)
    }
    
    
   
    
    //MARK: - didTapOnBackBtnAction
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        callSameInputsearch()
    }
    

    
    
    //MARK: - didTapOnBackBtnAction
    @IBAction func didTapOnProceedToBookBtnAction(_ sender: Any) {
        gotoCRBookingDetailsVC()
    }
    
    func gotoCRBookingDetailsVC() {
        callapibool = true
        MySingleton.shared.callboolapi = true
        guard let vc = CRBookingDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.cardetails = self.cardetails
        self.present(vc, animated: true)
    }
    
    
    //MARK: - didTapOnUpgradeServiceBtnAction
    override func didTapOnUpgradeServiceBtnAction(cell: UpgradeServiceTVCell) {
        gotoUpgradeServiceVC()
    }
    
    func gotoUpgradeServiceVC() {
        callapibool = true
        guard let vc = UpgradeServiceVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    //MARK: - didTapOnAdditionalOptionasBtnAction
    override func didTapOnAdditionalOptionasBtnAction(cell: ChooseAdditionalOptionsTVCell) {
        reloadPriceSummaryTVCell()
    }
    
    func reloadPriceSummaryTVCell() {
        if let indexPath = indexPathForPriceSummaryTVCell() {
            commonTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func indexPathForPriceSummaryTVCell() -> IndexPath? {
        if let row = MySingleton.shared.tablerow.firstIndex(where: { $0.cellType == .CRFareSummaryTVCell }) {
            return IndexPath(row: row, section: 0)
        }
        return nil
    }
    
    
}



extension CRProceedToBookVC {
    
    
    func setupUI(){
        
        
        setuplabels(lbl: titlelbl, text: "", textcolor: .BackBtnColor, font: .InterBold(size: 14), align: .center)
        setuplabels(lbl: dateslbl, text: "", textcolor: .BackBtnColor, font: .InterRegular(size: 14), align: .center)
        
        proceedBtn.layer.cornerRadius = 4
        commonTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Top left corner, Top right corner respectively
        commonTableView.layer.cornerRadius = 12
        commonTableView.clipsToBounds = true
        commonTableView.registerTVCells(["SelectedCarRentalTVCell",
                                         "SelectedCRPackageTVCell",
                                         "ChooseAdditionalOptionsTVCell",
                                         "CRFareSummaryTVCell",
                                         "UpgradeServiceTVCell",
                                         "EmptyTVCell"])
        
        
      
        
    }
    
    func callAPI() {
        
        MySingleton.shared.loderString = "fdetails"
        MySingleton.shared.afterResultsBool = true
        loderBool = true
        showLoadera()
        
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["product_code"] = MySingleton.shared.carproductcode
        MySingleton.shared.payload["result_token"] = MySingleton.shared.carresulttoken
        MySingleton.shared.payload["result_index"] = MySingleton.shared.carresultindex
        MySingleton.shared.payload["extra_option_price"] = MySingleton.shared.carextraoptionPrice
        
        MySingleton.shared.carPreBookingVM?.CALL_CAR_PRE_BOOKING_API(dictParam: MySingleton.shared.payload)
       
    }
    
    
   
    func carPreBooking(response: CarPreBookingMode) {
        
        loderBool = false
        hideLoadera()
        cardetails = response.result_token
        
        titlelbl.text = response.car_search_params?.from_loc ?? ""
        dateslbl.text = "\(MySingleton.shared.convertDateFormat(inputDate: response.car_search_params?.pickup_date ?? "", f1: "yyyy-MM-dd", f2: "MMM dd")) - \(MySingleton.shared.convertDateFormat(inputDate: response.car_search_params?.drop_date ?? "", f1: "yyyy-MM-dd", f2: "MMM dd"))"
        
        MySingleton.shared.carAddonServices = response.addon_services ?? []
        
        MySingleton.shared.carproductarray = response.result_token?.product ?? []
        MySingleton.shared.extraOption = response.result_token?.extra_option ?? []
        MySingleton.shared.carsearchid = "\(response.result_token?.search_id ?? 0)"
        MySingleton.shared.carcurrency = response.result_token?.product?[0].currency ?? ""
        MySingleton.shared.carproductcode = response.product_code ?? ""
        MySingleton.shared.carresultindex = "\(response.post_data?.result_index ?? "")"
        MySingleton.shared.carresulttoken = "\(response.post_data?.result_token ?? "")"
        
        totlConvertedGrand = Double(response.result_token?.product?[0].total ?? "") ?? 0.0
        MySingleton.shared.car_extra_option_price = response.extra_option_price ?? ""
        MySingleton.shared.car_markup_value = "\(response.result_token?.markup?.value ?? 0)"
        MySingleton.shared.car_discount_value = "\(response.result_token?.discount?.value ?? 0)"
        
        
        
        
        
        DispatchQueue.main.async {
            self.setupTVCells(res: response)
        }
    }
    
    
    
    
    func setupTVCells(res:CarPreBookingMode) {
        MySingleton.shared.tablerow.removeAll()
        
       
        MySingleton.shared.tablerow.append(TableRow(title:"",moreData: cardetails,cellType:.SelectedCarRentalTVCell))
        
        
        
        MySingleton.shared.carproductarray.forEach { i in
            MySingleton.shared.tablerow.append(TableRow(title:pkgtitleStr,moreData: i,cellType:.SelectedCRPackageTVCell))
        }
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.UpgradeServiceTVCell))
        MySingleton.shared.tablerow.append(TableRow(moreData:res.result_token?.extra_option,
                                                    cellType:.ChooseAdditionalOptionsTVCell))
        
        
        
        MySingleton.shared.carproductarray.forEach { i in
            MySingleton.shared.tablerow.append(TableRow(key:"proceedbooking",moreData: i,cellType:.CRFareSummaryTVCell))
        }
        
        
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
}



extension CRProceedToBookVC {
     func callSameInputsearch() {
        
        guard let pickuplocationname =  defaults.string(forKey: UserDefaultsKeys.pickuplocationname) else {return}
        guard let pickuplocationcode =  defaults.string(forKey: UserDefaultsKeys.pickuplocationcode) else {return}
        guard let pickuplocDate =  defaults.string(forKey: UserDefaultsKeys.pickuplocDate) else {return}
        guard let dropuplocDate =  defaults.string(forKey: UserDefaultsKeys.dropuplocDate) else {return}
        guard let pickuplocTime =  defaults.string(forKey: UserDefaultsKeys.pickuplocTime) else {return}
        guard let dropuplocTime =  defaults.string(forKey: UserDefaultsKeys.dropuplocTime) else {return}
        guard let driverage =  defaults.string(forKey: UserDefaultsKeys.driverage) else {return}
        
        if pickuplocationname == "Select Location" {
            showToast(message: "Select Location")
        }else if pickuplocDate == "Select Date" {
            showToast(message: "Select Pick Up Date")
        }else if dropuplocDate == "Select Date" {
            showToast(message: "Select Date")
        }else if pickuplocTime == "Select Time" {
            showToast(message: "Select Pick Up Time")
        }else if dropuplocTime == "Select Time" {
            showToast(message: "Select Time")
        }else if MySingleton.shared.carRentalDriverAge == "" {
            showToast(message: "Select Driver Age")
        }else {
            
            MySingleton.shared.payload.removeAll()
            MySingleton.shared.payload["car_from"] = pickuplocationname
            MySingleton.shared.payload["from_loc_id"] = pickuplocationcode
            MySingleton.shared.payload["car_to"] = ""
            MySingleton.shared.payload["to_loc_id"] = ""
            MySingleton.shared.payload["departure_date"] = pickuplocDate
            MySingleton.shared.payload["depart_time"] = pickuplocTime
            MySingleton.shared.payload["drop_date"] = dropuplocDate
            MySingleton.shared.payload["drop_time"] = dropuplocTime
            MySingleton.shared.payload["age_1"] = driverage
            
            gotoCarRentalResultsVC()
        }
        
    }
    
    func gotoCarRentalResultsVC() {
        MySingleton.shared.afterResultsBool = false
        MySingleton.shared.callboolapi = true
        defaults.set(false, forKey: "carfilteronce")
        guard let vc = CarRentalResultsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}



//MARK: - addObserver
extension CRProceedToBookVC {
    
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
