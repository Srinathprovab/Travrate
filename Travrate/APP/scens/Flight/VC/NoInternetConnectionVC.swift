//
//  noInternetConnectionVC.swift
//  BabSafar
//
//  Created by MA673 on 08/08/22.
//

import UIKit

class NoInternetConnectionVC: UIViewController {
    
    
    @IBOutlet weak var wifiImg: UIImageView!
    @IBOutlet weak var closeImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subTitlelbl: UILabel!
    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var btnlbl: UILabel!
    @IBOutlet weak var tryAgainBtn: UIButton!
    
    
    var key = String()
    static var newInstance: NoInternetConnectionVC? {
        let storyboard = UIStoryboard(name: Storyboard.Flight.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? NoInternetConnectionVC
        return vc
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if key == "noresult" {
            noresultSetup()
        }
        
        if key == "noseat" {
            noSeatAvaliableSetup()
        }
    }
    
    func noresultSetup(){
        wifiImg.image = UIImage(named: "oops")
        setupLabels(lbl: titlelbl, text: "It looks like no results were found for your search criteria.", textcolor: .TitleColor, font: .OpenSansMedium(size: 16))
        setupLabels(lbl: subTitlelbl, text: "Please change your search details and try again. \nThank you", textcolor: .TitleColor, font: .OpenSansLight(size: 14))
        setupLabels(lbl: btnlbl, text: " Search Again", textcolor: .WhiteColor, font: .OpenSansBold(size: 16))
    }
    
    func noSeatAvaliableSetup(){
        wifiImg.image = UIImage(named: "oops")
        setupLabels(lbl: titlelbl, text: "Seat is not available!", textcolor: .TitleColor, font: .OpenSansMedium(size: 16))
        setupLabels(lbl: subTitlelbl, text: "Please Search Again", textcolor: .TitleColor, font: .OpenSansLight(size: 14))
        setupLabels(lbl: btnlbl, text: "Search Again", textcolor: .WhiteColor, font: .OpenSansBold(size: 16))
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI() {
        wifiImg.image = UIImage(named: "wifi")
        closeImg.image = UIImage(named: "close1")
        
        setupLabels(lbl: titlelbl, text: "No internet connection", textcolor: .AppLabelColor, font: .OpenSansMedium(size: 16))
        setupLabels(lbl: subTitlelbl, text: "Please Check your internet connection", textcolor: .AppLabelColor, font: .LatoLight(size: 14))
        setupLabels(lbl: btnlbl, text: "Try Again", textcolor: .WhiteColor, font: .OpenSansBold(size: 18))
        tryAgainBtn.setTitle("", for: .normal)
        setupViews(v: btnView, radius: 4, color: .Buttoncolor)
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
        lbl.numberOfLines = 0
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.clear.cgColor
    }
    
    @IBAction func didTapOnTryAgainBtn(_ sender: Any) {
        MySingleton.shared.afterResultsBool = false
        BASE_URL = BASE_URL1
        
        if key == "noresult" || key == "noseat"{
            let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect)
            if tabselect == "Flight" {
                guard let vc = FlightSearchVC.newInstance.self else {return}
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }else if tabselect == "Holiday" {
                guard let vc = HolidaysVC.newInstance.self else {return}
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }else if tabselect == "Sports" {
                guard let vc = DashBoardTBVC.newInstance.self else {return}
                vc.modalPresentationStyle = .fullScreen
                vc.selectedIndex = 0
                self.present(vc, animated: true)
            }else if tabselect == "CarRental" {
                guard let vc = SearchCarRentalVC.newInstance.self else {return}
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }else if tabselect == "transfers" {
                guard let vc = BookTransfersVC.newInstance.self else {return}
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }else if tabselect == "Activities" {
                guard let vc = ActivitiesSearchVC.newInstance.self else {return}
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }else{
                guard let vc = SearchHotelVC.newInstance.self else {return}
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }
            
            
        }else {
            NotificationCenter.default.post(name: NSNotification.Name("reloadTV"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name("nointrnetreload"), object: nil)
            dismiss(animated: false)
        }
    }
    
}
