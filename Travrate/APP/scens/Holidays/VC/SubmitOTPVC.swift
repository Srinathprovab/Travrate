//
//  SubmitOTPVC.swift
//  Travrate
//
//  Created by FCI on 17/05/24.
//

import UIKit

class SubmitOTPVC: UIViewController, HolidaySelectedVMDelegate, CruiseDetailsViewModelDelegate {
    
    
    @IBOutlet weak var otpTF: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var errorlbl: UILabel!
    
    
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
        MySingleton.shared.cruisedetailsvm = CruiseDetailsViewModel(self)
        
    }
    
    
    
    func setupUI() {
        otpTF.becomeFirstResponder()
        otpTF.addTarget(self, action: #selector(editingChangedTextField(_textfield:)), for: .editingChanged)
        submitBtn.layer.cornerRadius = 4
    }
    
    
    @objc func editingChangedTextField( _textfield:UITextField) {
        errorlbl.isHidden = true
    }
    
    
    @IBAction func didTapOnSubMitBtnAction(_ sender: Any) {
        otpTF.resignFirstResponder()
        
        guard let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect) else {return}
        if tabselect == "Cruise" {
            callCruiseEnquireyAPI()
        }else {
            callHolidayEnquireyAPI()
        }
    }
    
}



extension SubmitOTPVC {
    
    func callHolidayEnquireyAPI() {
        if otpTF.text?.isEmpty == true {
            errorlbl.isHidden = false
            errorlbl.text = "Please Enter Otp"
            showToast(message: "Please Enter Otp")
        }else {
            errorlbl.text = ""
            MySingleton.shared.payload["un_id"] = MySingleton.shared.un_id
            MySingleton.shared.payload["otp"] = otpTF.text
            
            MySingleton.shared.holidaySelectedVM?.CALL_HOLIDAY_ENQUIREY_API(dictParam: MySingleton.shared.payload)
        }
        
        
    }
    
    
    
    func holidayEnquireySucesse(response: HolidayEnquireyModel) {
        
        
        if response.status == true {
            errorlbl.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.gotoCruiseEnquireySucessVC()
            }
        }else {
            errorlbl.isHidden = false
            errorlbl.text = "Invalid O?TP"
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


extension SubmitOTPVC {
    func callCruiseEnquireyAPI() {
        if otpTF.text == "1234" {
            MySingleton.shared.cruisedetailsvm?.CALL_CRUISE_ENQUIREY_API(dictParam: MySingleton.shared.payload)
        }else {
            errorlbl.isHidden = false
            errorlbl.text = "Invalid OTP"
            showToast(message: "Invalid OTP")
        }
    }
    
    
    func cruiseEnquireyDetails(response: LoginModel) {
        
        if response.status == false {
            showToast(message: response.message ?? "")
        }else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.gotoCruiseEnquireySucessVC()
            }
        }
        
    }
    func cruiseDetails(response: CruiseDetailsModel) {
        
    }
    
    
    
}
