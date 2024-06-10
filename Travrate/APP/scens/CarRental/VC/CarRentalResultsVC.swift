//
//  CarRentalResultsVC.swift
//  Travrate
//
//  Created by FCI on 10/06/24.
//

import UIKit

class CarRentalResultsVC: BaseTableVC {
    
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var dateslbl: UILabel!
    
    static var newInstance: CarRentalResultsVC? {
        let storyboard = UIStoryboard(name: Storyboard.CarRental.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? CarRentalResultsVC
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
        MySingleton.shared.callboolapi = true
        guard let vc = DashBoardTBVC.newInstance.self else {return}
        vc.selectedIndex = 0
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    
    
    //MARK: - didTapOnBackBtnAction
    @IBAction func didTapOnModifySearchBtnAction(_ sender: Any) {
        print("didTapOnModifySearchBtnAction")
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
        
       
        for _ in 0...100 {
            MySingleton.shared.tablerow.append(TableRow(cellType:.CarRentalResultTVCell))
        }
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
}


