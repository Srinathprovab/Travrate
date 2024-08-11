//
//  ViewController.swift
//  TravgateApp
//
//  Created by FCI on 02/01/24.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if !UserDefaults.standard.bool(forKey: "ExecuteOnce") {
            
            defaults.set("KWD", forKey: UserDefaultsKeys.selectedCurrency)
            defaults.set("ALL", forKey: UserDefaultsKeys.fcariername)
            defaults.set("ALL", forKey: UserDefaultsKeys.fcariercode)
            
            defaults.set("1", forKey: UserDefaultsKeys.adultCount)
            defaults.set("0", forKey: UserDefaultsKeys.childCount)
            defaults.set("0", forKey: UserDefaultsKeys.infantsCount)
            defaults.set("1", forKey: UserDefaultsKeys.totalTravellerCount)
            defaults.set("Economy", forKey: UserDefaultsKeys.selectClass)
            
            defaults.set("1", forKey: UserDefaultsKeys.visaadultCount)
            defaults.set("0", forKey: UserDefaultsKeys.visachildCount)
            defaults.set("0", forKey: UserDefaultsKeys.visainfantsCount)
            
            defaults.set("1 Passenger", forKey: UserDefaultsKeys.visatotalpassengercount)
            defaults.set("1", forKey: UserDefaultsKeys.activitesadultCount)
            defaults.set("2", forKey: UserDefaultsKeys.guestcount)
            
            UserDefaults.standard.set(true, forKey: "ExecuteOnce")
        }
        
        
        
        MySingleton.shared.callonce()
        MySingleton.shared.getCountryList()
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            self.gotodashBoardScreen()
           // self.gotoBookingConfirmedVC()
            
        })
    }
    
    
    
    
    
    func gotodashBoardScreen() {
        MySingleton.shared.callboolapi = true
        guard let vc = DashBoardTBVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.selectedIndex = 0
        callapibool = true
        present(vc, animated: true)
    }
    
    
    func gotoBookingConfirmedVC() {
        
        
        defaults.setValue("Flight", forKey: UserDefaultsKeys.tabselect)
        
        guard let vc = BookingConfirmedVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        //   MySingleton.shared.voucherurlsting = "https://provab.net/travrate/android_ios_webservices/mobile/index.php/sport/voucher/TR-SE-20240710040022/voucher_view"
        
       // MySingleton.shared.voucherurlsting = "https://provab.net/travrate/android_ios_webservices/mobile/index.php/voucher/flight/TRG-F-TP-0809-1723180338/13886"
        //  MySingleton.shared.voucherurlsting = "https://provab.net/travrate/android_ios_webservices/mobile/index.php/voucher/sightseeing/TR-A-HB-0722-110653715/PTBSID0000000010/BOOKING_CONFIRMED/email_voucher/srinath@gmail.com"
        
        
        MySingleton.shared.voucherurlsting = "https://provab.net/travrate/android_ios_webservices/mobile/index.php/voucher/flight/TRG-F-TP-0809-1723197451/13932"
        
        //  MySingleton.shared.voucherurlsting = "https://provab.net/travrate/android_ios_webservices/mobile/index.php/car/voucher/TR-CAR-20240712103921/PTBSID0000007785/BOOKING_CONFIRMED/show_voucher"
        
      //  MySingleton.shared.voucherurlsting = "https://provab.net/travrate/index.php/voucher/flight/TRG-F-TP-0312-1710223991/PTBSID0000000016/BOOKING_INPROGRESS/show_voucher"
        
        // urlString = "https://provab.net/travrate/android_ios_webservices/mobile/index.php/sport/voucher/TR-SE-20240710125733/voucher_view"
        
        // MySingleton.shared.voucherurlsting = "https://provab.net/travrate/android_ios_webservices/mobile/index.php/voucher/hotel/TRG-H-DW-13807/PTBSID0000000094/BOOKING_CONFIRMED/show_voucher"
        //   MySingleton.shared.voucherurlsting = "https://provab.net/travrate/android_ios_webservices/mobile/index.php/voucher/hotel/TRG-H-DW-13815/PTBSID0000000094/BOOKING_CONFIRMED/show_voucher"
        // MySingleton.shared.voucherurlsting = "https://provab.net/travrate/android_ios_webservices/mobile/index.php/voucher/hotel/TRG-H-DW-13781/PTBSID0000000094/BOOKING_CONFIRMED/show_voucher"
        
        
        //https://provab.net/travrate/android_ios_webservices/mobile/index.php/voucher/flight/TRG-F-TP-0809-1723181061/13889
        
        callapibool = true
        present(vc, animated: true)
    }
    
    
    func gotoOttuPaymentGatewayVC() {
        
        guard let vc = OttuPaymentGatewayVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    func setAttributedTextnew(str1:String,str2:String,lbl:UILabel,str1font:UIFont,str2font:UIFont,str1Color:UIColor,str2Color:UIColor)  {
        
        let atter1 = [NSAttributedString.Key.foregroundColor:str1Color,
                      NSAttributedString.Key.font:str1font] as [NSAttributedString.Key : Any]
        let atter2 = [NSAttributedString.Key.foregroundColor:str2Color,
                      NSAttributedString.Key.font:str2font] as [NSAttributedString.Key : Any]
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        let atterStr2 = NSMutableAttributedString(string: str2, attributes: atter2)
        
        
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        combination.append(atterStr2)
        
        lbl.attributedText = combination
        
    }
}


