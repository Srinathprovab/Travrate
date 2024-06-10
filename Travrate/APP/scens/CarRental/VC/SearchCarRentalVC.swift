//
//  SearchCarRentalVC.swift
//  Travrate
//
//  Created by FCI on 10/06/24.
//

import UIKit

class SearchCarRentalVC: BaseTableVC {
    
    
    static var newInstance: SearchCarRentalVC? {
        let storyboard = UIStoryboard(name: Storyboard.CarRental.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SearchCarRentalVC
        return vc
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTV), name: Notification.Name("reloadTV"), object: nil)
    }
    
    @objc func reloadTV() {
        commonTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        
    }
    
    
    //MARK: - tfeditingChanged
    override func tfeditingChanged(tf: UITextField) {
        if tf.tag == 1 {
            print("tag 1")
        }else {
            print("tag 2")
        }
    }
    
    //MARK: - didTapOnBackBtnAction
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        MySingleton.shared.callboolapi = true
        guard let vc = DashBoardTBVC.newInstance.self else {return}
        vc.selectedIndex = 0
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    
    
    override func didTapOnSearchBtnAction(cell:SearchCarRentalTVCell) {
        gotoCarRentalResultsVC()
    }
    
    func gotoCarRentalResultsVC() {
        callapibool = true
        defaults.set(false, forKey: "carrentalfilteronce")
        guard let vc = CarRentalResultsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}



extension SearchCarRentalVC {
    
    
    func setupUI(){
        
        
        
        commonTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Top left corner, Top right corner respectively
        commonTableView.layer.cornerRadius = 12
        commonTableView.clipsToBounds = true
        commonTableView.registerTVCells(["SearchCarRentalTVCell",
                                         "EmptyTVCell"])
        
        
        setupTVCells()
        
    }
    
    
    
    
    func setupTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.SearchCarRentalTVCell))
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
}


