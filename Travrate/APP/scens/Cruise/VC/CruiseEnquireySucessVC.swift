//
//  CruiseEnquireySucessVC.swift
//  Travgate
//
//  Created by FCI on 27/02/24.
//

import UIKit

class CruiseEnquireySucessVC: UIViewController {
    
    @IBOutlet weak var img: UIImageView!
    
    
    
    static var newInstance: CruiseEnquireySucessVC? {
        let storyboard = UIStoryboard(name: Storyboard.Cruise.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? CruiseEnquireySucessVC
        return vc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        img.layer.cornerRadius = 6
        
        callapibool = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            
            if let  tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect), tabselect == "Cruise" {
                //  self.presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)
                // self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)
                self.gotoCruiseVC()
            }else {
                // self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)
                self.gotoHolidaysVC()
            }
        }
    }
    
    
    
    func gotoCruiseVC() {
        callapibool = true
        MySingleton.shared.callboolapi = true
        guard let vc = CruiseVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    
    func gotoHolidaysVC() {
        callapibool = true
        MySingleton.shared.callboolapi = true
        guard let vc = HolidaysVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    
    
}


