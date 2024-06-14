//
//  CRBookingDetailsVC.swift
//  Travrate
//
//  Created by FCI on 14/06/24.
//

import UIKit

class CRBookingDetailsVC: BaseTableVC {
    
    @IBOutlet weak var continuebtn: UIButton!
    
    static var newInstance: CRBookingDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.CarRental.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? CRBookingDetailsVC
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
    
    
    //MARK: - didTapOnSelectPackageBtnAction  ChoosePackageTVCell
    override func didTapOnSelectPackageBtnAction(cell: ChoosePackageTVCell) {
        print("didTapOnSelectPackageBtnAction")
    }
    
    
    
}



extension CRBookingDetailsVC {
    
    
    func setupUI(){
        
        
        continuebtn.layer.cornerRadius = 4
        commonTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Top left corner, Top right corner respectively
        commonTableView.layer.cornerRadius = 12
        commonTableView.clipsToBounds = true
        commonTableView.registerTVCells(["SelectedCarRentalTVCell",
                                         "CRFareSummaryTVCell",
                                         "DriverDetailsTVCell",
                                         "TermsAgreeTVCell",
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
        MySingleton.shared.tablerow.append(TableRow(cellType:.DriverDetailsTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.CRFareSummaryTVCell))
        MySingleton.shared.tablerow.append(TableRow(title:"* By booking this item, you agree to pay the total amount shown, which includes Service Fees. You also agree to the Terms and Conditions and privacy policy",
                                                    cellType:.TermsAgreeTVCell))

        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
}


