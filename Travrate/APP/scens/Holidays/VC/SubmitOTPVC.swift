//
//  SubmitOTPVC.swift
//  Travrate
//
//  Created by FCI on 17/05/24.
//

import UIKit

class SubmitOTPVC: UIViewController, HolidaySelectedVMDelegate {
  
   
    
    
    @IBOutlet weak var otpTF: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    
    
    static var newInstance: SubmitOTPVC? {
        let storyboard = UIStoryboard(name: Storyboard.Holidays.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SubmitOTPVC
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        
        MySingleton.shared.holidaySelectedVM = HolidaySelectedVM(self)
    }
    
    
    
    func setupUI() {
        submitBtn.layer.cornerRadius = 4
    }
    
    
    
    @IBAction func didTapOnSubMitBtnAction(_ sender: Any) {
        callHolidayEnquireyAPI()
    }
    
}



extension SubmitOTPVC {
    
    func callHolidayEnquireyAPI() {
        if otpTF.text?.isEmpty == true {
            showToast(message: "Please Enter Otp")
        }else {
            MySingleton.shared.payload["un_id"] = MySingleton.shared.un_id
            MySingleton.shared.payload["otp"] = otpTF.text
            
            print(MySingleton.shared.payload)
            
            MySingleton.shared.holidaySelectedVM?.CALL_HOLIDAY_ENQUIREY_API(dictParam: MySingleton.shared.payload)
        }
       
      
    }
    
    
    
    func holidayEnquireySucesse(response: HolidayEnquireyModel) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.gotoCruiseEnquireySucessVC()
         }
    }
    
    
    
    func gotoCruiseEnquireySucessVC() {
        guard let vc = CruiseEnquireySucessVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: false)
    }
    
    func holidaySelectedResponse(response: HolidaySelectedModel) {}
    func otpRequestResponse(response: OTPSucessModel) {}
    
   
}
