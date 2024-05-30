//
//  HolidaysVC.swift
//  Travgate
//
//  Created by FCI on 26/02/24.
//

import UIKit

class HolidaysVC: BaseTableVC, HolidayListVMDelegate {
    
    
    
    
    static var newInstance: HolidaysVC? {
        let storyboard = UIStoryboard(name: Storyboard.Holidays.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? HolidaysVC
        return vc
    }
    
    
    var imageurl = String()
    var desc = String()
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        
        MySingleton.shared.holidayListVM = HolidayListVM(self)
    }
    
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        callapibool = false
        dismiss(animated: true)
    }
    
    
    
    //MARK: - didTapOnHolidayPackage   gotoSelectedHolidayPackageVC
    override func didTapOnHolidayPackage(cell:HolidayPackagesTVCell){
        gotoSelectedHolidayPackageVC(key: cell.holidayKey)
    }
    
    
    func gotoSelectedHolidayPackageVC(key:String){
        callapibool = true
        guard let vc = SelectedHolidayPackageVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.holidaykey = key
        present(vc, animated: true)
    }
    
}




extension HolidaysVC {
    
    func setupUI(){
        
        
        commonTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Top left corner, Top right corner respectively
        commonTableView.layer.cornerRadius = 12
        commonTableView.clipsToBounds = true
        commonTableView.registerTVCells(["HolidayPackagesTVCell",
                                         "EmptyTVCell"])
        
       
    }
    
    
    
    
    func callAPI() {
        
        
        MySingleton.shared.loderString = "fdetails"
        MySingleton.shared.afterResultsBool = true
        loderBool = true
        showLoadera()
        
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.holidayListVM?.CALL_GET_HOLIDAY_LIST_API(dictParam: [:])
    }
    
    func holidayListResponse(response: HolidayListModel) {
        
        loderBool = false
        hideLoadera()
        
        if response.status == true {
            MySingleton.shared.holidaylist = response.data ?? []
            
            desc = response.home_sliders?.text ?? ""
            imageurl = response.home_sliders?.image ?? ""
            
            DispatchQueue.main.async {
                self.setupTVCells()
            }
        }
    }
    
    
    
    func setupTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        
        
        
        MySingleton.shared.tablerow.append(TableRow(title:desc,
                                                    image:imageurl,
                                                    cellType:.HolidayPackagesTVCell))
        
        
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
}

extension HolidaysVC {
    
    func addObserver() {
        
       
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        
        if callapibool == true {
            callAPI()
        }
    }
    
    
    @objc func reload() {
        commonTableView.reloadData()
    }
    
    //MARK: - resultnil
    @objc func resultnil() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = "noresult"
        self.present(vc, animated: true)
    }
    
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = "nointernet"
        self.present(vc, animated: true)
    }
    
    
}
