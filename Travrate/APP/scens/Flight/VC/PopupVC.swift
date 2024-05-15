//
//  PopupVC.swift
//  BabSafar
//
//  Created by FCI on 06/03/23.
//

import UIKit

class PopupVC: UIViewController {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var searchBtnView: UIView!
    @IBOutlet weak var searchlbl: UILabel!
    @IBOutlet weak var searchBtn: UIButton!
    
    static var newInstance: PopupVC? {
        let storyboard = UIStoryboard(name: Storyboard.Flight.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? PopupVC
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    func setupUI() {
        self.view.backgroundColor = .black.withAlphaComponent(0.4)
        holderView.backgroundColor = .WhiteColor
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 5)
        setuplabels(lbl: titlelbl, text: "Your session expired. Your booking wont be completed.Please search again.", textcolor: .AppLabelColor, font: .LatoRegular(size: 16), align: .center)
        searchBtnView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 5)
        searchBtnView.backgroundColor = .Buttoncolor
        setuplabels(lbl: searchlbl, text: "Search Again", textcolor: .WhiteColor, font: .LatoBold(size: 15), align: .center)
        searchBtn.setTitle("", for: .normal)
        searchBtn.addTarget(self, action: #selector(didTapOnSearchFlightAgainBtn(_:)), for: .touchUpInside)
        
    }
    
    
    @objc func didTapOnSearchFlightAgainBtn(_ sender:UIButton) {
        if let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect){
            if tabselect == "Flight" {
                gotoSearchFlightsVC()
            }else {
                gotoSearchHotelsVC()
            }
        }
    }
    
    
    func gotoSearchFlightsVC() {
        guard let vc = FlightSearchVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    func gotoSearchHotelsVC() {
        guard let vc = SearchHotelVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    
}
