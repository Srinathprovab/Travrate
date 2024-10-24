//
//  TripsVC.swift
//  TravgateApp
//
//  Created by FCI on 02/01/24.
//

import UIKit

class TripsVC: BaseTableVC {
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var loginlbl: UILabel!
    
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    func setupUI() {
        
        if LanguageManager.shared.currentLanguage() == "ar" {
            titlelbl.text = "رحلاتي"
            setAttributedString(str1: "تسجيل الدخول لعرض رحلاتك")
        } else {
            titlelbl.text = "My Trips"
            setAttributedString(str1: "Login To View Your Trips")
        }
        
       
        commonTableView.registerTVCells(["TripsTVCell",
                                         "EmptyTVCell"])
        
        
    }
    
    
    func setupTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(title:"Flight",image: "flighttrip",cellType:.TripsTVCell))
        MySingleton.shared.tablerow.append(TableRow(title:"Hotel",image: "hoteltrip",cellType:.TripsTVCell))
       // MySingleton.shared.tablerow.append(TableRow(title:"Transfers",image: "transfer",cellType:.TripsTVCell))
        MySingleton.shared.tablerow.append(TableRow(title:"Sports",image: "sports",cellType:.TripsTVCell))
        MySingleton.shared.tablerow.append(TableRow(title:"Car Rentals",image: "s3",cellType:.TripsTVCell))
        MySingleton.shared.tablerow.append(TableRow(title:"Activities",image: "activitiestrip",cellType:.TripsTVCell))
        //        MySingleton.shared.tablerow.append(TableRow(title:"Holidays",image: "cruisetrip",cellType:.TripsTVCell))
        //        MySingleton.shared.tablerow.append(TableRow(title:"Cruise",image: "cruisetrip",cellType:.TripsTVCell))
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    override func didTapOnTripsBtnAction(cell: TripsTVCell) {
        defaults.setValue(cell.titlelbl.text, forKey: UserDefaultsKeys.tripsselect)
        gotoBookingsVC()
        
    }
    
    func gotoBookingsVC() {
        callapibool = true
        guard let vc = BookingsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}



//MARK: - setAttributedString

extension TripsVC {
    
    
    func checkLoginStatus() {
        let userloginsataus = defaults.bool(forKey: UserDefaultsKeys.loggedInStatus)
        if userloginsataus == true {
            loginlbl.isHidden = true
            commonTableView.isHidden = false
            setupTVCells()
        }else {
            
            //                        loginlbl.isHidden = true
            //                        commonTableView.isHidden = false
            //                        setupTVCells()
            
            loginlbl.isHidden = false
            commonTableView.isHidden = true
        }
    }
    
    
    func setAttributedString(str1:String) {
        
        
        let atter1 : [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor:UIColor.TitleColor,
                                                      NSAttributedString.Key.font:UIFont.OpenSansRegular(size: 12),
                                                      .underlineStyle: NSUnderlineStyle.single.rawValue]
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        loginlbl.attributedText = combination
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        loginlbl.addGestureRecognizer(tapGesture)
        loginlbl.isUserInteractionEnabled = true
    }
    
    @objc func labelTapped(gesture: UITapGestureRecognizer) {
        
        didTapOnLoginBtnAction()
        // Check if the current language is Arabic
//        if LanguageManager.shared.currentLanguage() == "ar" {
//            // Ensure the label is aligned to the right for Arabic
//            loginlbl.textAlignment = .center
//            
//            // Check if the gesture tapped the Arabic attributed string
//            if gesture.didTapAttributedString("تسجيل الدخول لعرض رحلاتك", in: loginlbl) {
//                didTapOnLoginBtnAction()
//            }
//        } else {
//            // Ensure the label is aligned to the left for non-Arabic text
//            loginlbl.textAlignment = .center
//            
//            // Check if the gesture tapped the English attributed string
//            if gesture.didTapAttributedString("Login To View Your Trips", in: loginlbl) {
//                didTapOnLoginBtnAction()
//            }
//        }
    }

    
    
    
    func didTapOnLoginBtnAction() {
        guard let vc = LoginVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
}



//MARK: - addObserver
extension TripsVC {
    
    func addObserver() {
        
        MySingleton.shared.returnDateTapbool = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(nointrnetreload), name: Notification.Name("nointrnetreload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("logindone"), object: nil)
        
        
        checkLoginStatus()
        
    }
    
    
    @objc func reload() {
        DispatchQueue.main.async {[self] in
            checkLoginStatus()
        }
    }
    
    @objc func nointrnetreload() {
        DispatchQueue.main.async {[self] in
            checkLoginStatus()
        }
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
