//
//  CarRentalChoosePackageVC.swift
//  Travrate
//
//  Created by FCI on 10/06/24.
//

import UIKit

class CarRentalChoosePackageVC: BaseTableVC, CarDetailsVMDelegate {
   
    
    @IBOutlet weak var titlelbl: UILabel!
    
    static var newInstance: CarRentalChoosePackageVC? {
        let storyboard = UIStoryboard(name: Storyboard.CarRental.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? CarRentalChoosePackageVC
        return vc
    }
    
    
   
    var packageTitleStr = String()
    override func viewWillAppear(_ animated: Bool) {
        if callapibool == true {
            callAPI()
        }
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        
        MySingleton.shared.carDetailsVM = CarDetailsVM(self)
    }
    
    
   
    
    //MARK: - didTapOnBackBtnAction
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        MySingleton.shared.callboolapi = false
        dismiss(animated: true)
    }
    
    
    //MARK: - didTapOnSelectPackageBtnAction  ChoosePackageTVCell
    override func didTapOnSelectPackageBtnAction(cell: ChoosePackageTVCell) {
        
        
        MySingleton.shared.carproductcode = cell.carproductcode
        MySingleton.shared.carextraoptionPrice = cell.carproductcode
      
        gotoCRProceedToBookVC()
    }
    
    
    func gotoCRProceedToBookVC() {
        callapibool = true
        guard let vc = CRProceedToBookVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.pkgtitleStr = packageTitleStr
        self.present(vc, animated: true)
    }
    
    
}



extension CarRentalChoosePackageVC {
    
    
    func setupUI(){
        
        
        setuplabels(lbl: titlelbl, text: "Choose your Package", textcolor: .BackBtnColor, font: .InterBold(size: 14), align: .center)

        commonTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Top left corner, Top right corner respectively
        commonTableView.layer.cornerRadius = 12
        commonTableView.clipsToBounds = true
        commonTableView.registerTVCells(["ChoosePackageTVCell",
                                         "EmptyTVCell"])
        
    }
    
    func callAPI() {
        
        MySingleton.shared.loderString = "fdetails"
        MySingleton.shared.afterResultsBool = true
        loderBool = true
        showLoadera()
        
        
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["product_code"] = MySingleton.shared.carproductcode
        MySingleton.shared.payload["result_index"] = MySingleton.shared.carresultindex
        MySingleton.shared.payload["result_token"] = MySingleton.shared.carresulttoken
        
        MySingleton.shared.carDetailsVM?.CALL_SELECT_YOUR_PACKAGE_API(dictParam: MySingleton.shared.payload)
        
    }
    
    
    func cardeatils(response: CarDetailsModel) {
        loderBool = false
        hideLoadera()
        
       
        MySingleton.shared.extraOption = response.result_token?.extra_option ?? []
        MySingleton.shared.carproductarray = response.result_token?.product ?? []
        MySingleton.shared.car_total_amount = response.result_token?.product?[0].total ?? ""
        MySingleton.shared.car_total_amount_origin = response.result_token?.product?[0].org_total ?? ""
        
        
        totlConvertedGrand = Double(response.result_token?.product?[0].total ?? "") ?? 0.0
        
        DispatchQueue.main.async {
            self.setupTVCells()
        }
    }
    
    
    func setupTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.carproductarray.forEach { i in
            MySingleton.shared.tablerow.append(TableRow(moreData: i,cellType:.ChoosePackageTVCell))
        }
        
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
}


