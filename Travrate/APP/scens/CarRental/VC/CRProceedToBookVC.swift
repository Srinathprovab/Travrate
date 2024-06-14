//
//  CRProceedToBookVC.swift
//  Travrate
//
//  Created by FCI on 14/06/24.
//

import UIKit

class CRProceedToBookVC: BaseTableVC {
    
    @IBOutlet weak var proceedBtn: UIButton!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var dateslbl: UILabel!
    
    static var newInstance: CRProceedToBookVC? {
        let storyboard = UIStoryboard(name: Storyboard.CarRental.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? CRProceedToBookVC
        return vc
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if callapibool == true {
            callAPI()
        }
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        
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
        self.present(vc, animated: true)
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
                                         "EmptyTVCell"])
        
        
      
        
    }
    
    func callAPI() {
        MySingleton.shared.loderString = "fdetails"
        MySingleton.shared.afterResultsBool = true
        loderBool = true
        showLoadera()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [unowned self] in
            loderBool = false
            hideLoadera()
            
            setupTVCells()
        }
    }
    
    
    
    
    func setupTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
       
        MySingleton.shared.tablerow.append(TableRow(cellType:.SelectedCarRentalTVCell))
        MySingleton.shared.tablerow.append(TableRow(title:"Basic",cellType:.SelectedCRPackageTVCell))

        MySingleton.shared.tablerow.append(TableRow(cellType:.ChooseAdditionalOptionsTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.CRFareSummaryTVCell))
        
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
}


