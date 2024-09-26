//
//  SideMenuViewController.swift
//  Travrun
//
//  Created by MA1882 on 15/11/23.
//

import UIKit

class SideMenuViewController: BaseTableVC, ProfileViewModelDelegate, LogoutViewModelDelegate {
    
    
    @IBOutlet weak var logoutView: UIView!
    @IBOutlet weak var copyRightlbl: UILabel!
    @IBOutlet weak var logoutlbl: UILabel!
    @IBOutlet weak var deletelbl: UILabel!
    
    static var newInstance: SideMenuViewController? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SideMenuViewController
        return vc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        MySingleton.shared.profilevm = ProfileViewModel(self)
        MySingleton.shared.logoutvm = LogoutViewModel(self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(logindone), name: Notification.Name("logindone"), object: nil)
        
        let userloggedBool = defaults.bool(forKey: UserDefaultsKeys.loggedInStatus)
        if userloggedBool == true {
            
            logoutView.isHidden = false
            callShowProfileAPI()
        }
        
    }
    
    
    @objc func logindone() {
        
        DispatchQueue.main.async {
            self.callShowProfileAPI()
        }
        
    }
    
    
    func setupUI() {
        
        let currentYear = Calendar.current.component(.year, from: Date())
        
       
        
        if LanguageManager.shared.currentLanguage() == "ar" {
            deletelbl.text = "حذف الحساب"
            logoutlbl.text = "تسجيل الخروج"
            copyRightlbl.text = "حقوق النشر (C)\(currentYear)."
        } else {
            deletelbl.text = "Delete Account"
            logoutlbl.text = "Logout"
            copyRightlbl.text = "Copyright (C)\(currentYear)."
        }
        
        setupMenuTVCells()
        commonTableView.isScrollEnabled = true
        commonTableView.registerTVCells(["MenuBGTVCell",
                                         "QuickLinkTableViewCell",
                                         "SideMenuTitleTVCell",
                                         "EmptyTVCell"])
    }
    
    func setupMenuTVCells() {
        
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(cellType: .MenuBGTVCell))
        MySingleton.shared.tablerow.append(TableRow(height: 20,cellType: .EmptyTVCell))
        MySingleton.shared.tablerow.append(TableRow(title:"Services",key: "links", cellType: .QuickLinkTableViewCell))
        MySingleton.shared.tablerow.append(TableRow(height: 40, cellType: .EmptyTVCell))
        
        
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    override func didTapOnLoginBtn(cell: MenuBGTVCell) {
        guard let vc = LoginVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    
    override func didTaponCell(cell: SideMenuTitleTVCell) {
        if LanguageManager.shared.currentLanguage() == "ar" {
            switch cell.menuTitlelbl.text {
            
            case "الرحلات الجوية":  // "Flight" in Arabic
                defaults.set("Flight", forKey: UserDefaultsKeys.tabselect)
                showFlightSearchVC()
                break
                
            case "الفنادق":  // "Hotel" in Arabic
                defaults.set("Hotel", forKey: UserDefaultsKeys.tabselect)
                gotoSearchHotelVC()
                break
                
            case "النقل":  // "Transfers" in Arabic
                defaults.set("transfers", forKey: UserDefaultsKeys.tabselect)
                // gotoBookTransfersVC()
                break
                
            case "الرياضة":  // "Sports" in Arabic
                // gotoSportsSearchVC()
                break
                
            case "إدارة الحجوزات":  // "Manage Bookings" in Arabic
                gotoMyTrips()
                break
                
            default:
                break
            }
        } else {
            switch cell.menuTitlelbl.text {
            
            case "Flight":
                defaults.set("Flight", forKey: UserDefaultsKeys.tabselect)
                showFlightSearchVC()
                break
                
            case "Hotel":
                defaults.set("Hotel", forKey: UserDefaultsKeys.tabselect)
                gotoSearchHotelVC()
                break
                
            case "Transfers":
                defaults.set("transfers", forKey: UserDefaultsKeys.tabselect)
                // gotoBookTransfersVC()
                break
                
            case "Sports":
                // gotoSportsSearchVC()
                break
                
            case "Manage Bookings":
                gotoMyTrips()
                break
                
            default:
                break
            }
        }
    }

    
    
    
    func gotoMyTrips() {
        callapibool = true
        guard let vc = DashBoardTBVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.selectedIndex = 1
        present(vc, animated: true)
    }
    
    func gotoSportsSearchVC() {
        callapibool = true
        guard let vc = SportsSearchVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func gotoBookTransfersVC() {
        callapibool = true
        guard let vc = BookTransfersVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    
    func showFlightSearchVC() {
        guard let vc = FlightSearchVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func gotoSearchHotelVC() {
        guard let vc = SearchHotelVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    override func didTapOnEditProfileBtn(cell: MenuBGTVCell) {
        guard let vc = EditProfileVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    @IBAction func didTapOnDelegateBtnAction(_ sender: UIButton) {
        sender.tag == 1 ? deleteUserAccountAPI() : callLogoutAPI()
    }
    
    
    
    
    
}



extension SideMenuViewController {
    
    
    func callShowProfileAPI() {
        basicloderBool = true
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        MySingleton.shared.profilevm?.CALL_SHOW_PROFILE_DETAILS_API(dictParam:  MySingleton.shared.payload)
    }
    
    
    func profileDetails(response: ProfileModel) {
        
        basicloderBool = false
        logoutView.isHidden = false
        
        MySingleton.shared.profiledata = response.data
        MySingleton.shared.username = "\(response.data?.first_name ?? "") \(response.data?.last_name ?? "")"
        
        DispatchQueue.main.async {
            self.setupMenuTVCells()
        }
    }
    
    func profileUpdateSucess(response: ProfileModel) {
        
    }
    
    
    func callLogoutAPI() {
        basicloderBool = true
        MySingleton.shared.logoutvm?.CALL_USER_LOGOUT_API(dictParam: [:])
    }
    
    
    func logoutSucess(response: LoginModel) {
        basicloderBool = false
        logoutView.isHidden = true
        defaults.set(false, forKey: UserDefaultsKeys.loggedInStatus)
        defaults.set("0", forKey: UserDefaultsKeys.userid)
        showToast(message: response.data ?? "")
        let seconds = 2.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.setupMenuTVCells()
        }
        
    }
    
}


extension SideMenuViewController {
    
    
    func deleteUserAccountAPI() {
        basicloderBool = true
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? ""
        MySingleton.shared.logoutvm?.CALL__DELETE_USER_API(dictParam:  MySingleton.shared.payload)
    }
    
    
    func userDeleteSucess(response: LoginModel) {
        basicloderBool = false
        logoutView.isHidden = true
        
        defaults.set(false, forKey: UserDefaultsKeys.loggedInStatus)
        defaults.set("0", forKey: UserDefaultsKeys.userid)
        MySingleton.shared.guestbool = false
        
        
        showToast(message: response.msg ?? "")
        let seconds = 2.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.setupMenuTVCells()
        }
    }
    
}
