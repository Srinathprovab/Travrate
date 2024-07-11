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
        if callapibool == true {
            callAPI()
        }
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        
        MySingleton.shared.carPreBookingVM = CarPreBookingVM(self)
    }
    
    
   
    
    //MARK: - didTapOnBackBtnAction
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        callapibool = false
        dismiss(animated: true)
    }
    

    
    
    //MARK: - didTapOnBackBtnAction
    @IBAction func didTapOnProceedToBookBtnAction(_ sender: Any) {
        gotoCRBookingDetailsVC()
    }
    
    func gotoCRBookingDetailsVC() {
        callapibool = true
        guard let vc = CRBookingDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.cardetails = self.cardetails
        self.present(vc, animated: true)
    }
    
    
    //MARK: - didTapOnUpgradeServiceBtnAction
    override func didTapOnUpgradeServiceBtnAction(cell: UpgradeServiceTVCell) {
        commonTableView.reloadData()
    }
    
}



extension CRProceedToBookVC {
    
    
    func setupUI(){
        
        
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
        
        MySingleton.shared.addonServices = response.addon_services ?? []
        
        MySingleton.shared.carproductarray = response.result_token?.product ?? []
        MySingleton.shared.extraOption = response.result_token?.extra_option ?? []
        
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
        
     //   MySingleton.shared.tablerow.append(TableRow(cellType:.UpgradeServiceTVCell))
        MySingleton.shared.tablerow.append(TableRow(moreData:res.result_token?.extra_option,
                                                    cellType:.ChooseAdditionalOptionsTVCell))
        
        
        
        MySingleton.shared.carproductarray.forEach { i in
            MySingleton.shared.tablerow.append(TableRow(moreData: i,cellType:.CRFareSummaryTVCell))
        }
        
        
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
}


