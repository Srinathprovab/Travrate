//
//  CarRentalChoosePackageVC.swift
//  Travrate
//
//  Created by FCI on 10/06/24.
//

import UIKit

class CarRentalChoosePackageVC: BaseTableVC {
    

    
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
        
    }
    
    
   
    
    //MARK: - didTapOnBackBtnAction
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        callapibool = false
        dismiss(animated: true)
    }
    
    
    //MARK: - didTapOnSelectPackageBtnAction  ChoosePackageTVCell
    override func didTapOnSelectPackageBtnAction(cell: ChoosePackageTVCell) {
        packageTitleStr = cell.titlelbl.text ?? ""
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
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [unowned self] in
            loderBool = false
            hideLoadera()
            
            setupTVCells()
        }
    }
    
    
    
    
    func setupTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
       
        MySingleton.shared.tablerow.append(TableRow(title:"Basic",
                                                    cellType:.ChoosePackageTVCell))
        
        MySingleton.shared.tablerow.append(TableRow(title:"Plus+",
                                                    cellType:.ChoosePackageTVCell))
        
        MySingleton.shared.tablerow.append(TableRow(title:"Premium plus+",
                                                    cellType:.ChoosePackageTVCell))

        
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
}


