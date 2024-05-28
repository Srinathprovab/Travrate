//
//  SportsBookingDetailsVC.swift
//  Travrate
//
//  Created by FCI on 27/05/24.
//

import UIKit

class SportsBookingDetailsVC: BaseTableVC {
    
    
    @IBOutlet weak var continueBtn: UIButton!
    
    static var newInstance: SportsBookingDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Sports.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SportsBookingDetailsVC
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    
    //MARK: - didTapOnRegisterNowOrLoginButtonAction
    override func didTapOnRegisterNowOrLoginButtonAction(cell: RegisterSelectionLoginTableViewCell) {
        commonTableView.reloadData()
    }
    
    //MARK: - PrimaryContactInfoTVCell Delegate Methods
    override func didTapOnCountryCodeBtn(cell: PrimaryContactInfoTVCell) {
        MySingleton.shared.nationalityCode = cell.isoCountryCode
        //  MySingleton.shared.paymobilecountrycode = cell.countrycodeTF.text ?? ""
    }
    
    
    override func didTapOnGuestBtnAction(cell:PrimaryContactInfoTVCell) {
        MySingleton.shared.guestbool = true
        showToast(message: "Successfully Registered!..")
        
        setupTVCell()
    }
    
    
    override func didTapOnLoginBtnAction(cell:PrimaryContactInfoTVCell) {
        
        if MySingleton.shared.payemail.isEmpty == true {
            showToast(message: "Enter Email Address")
        }else if MySingleton.shared.payemail.isValidEmail() == false {
            showToast(message: "Enter Valid Email Address")
        }else if MySingleton.shared.regpassword.isEmpty == true {
            showToast(message: "Enter Password")
        }else {
            callLoginAPI()
        }
        
    }
    
    
    override func didTapOnRegisterBtnAction(cell:PrimaryContactInfoTVCell) {
        
        if MySingleton.shared.payemail.isEmpty == true {
            showToast(message: "Enter Email Address")
        }else if MySingleton.shared.payemail.isValidEmail() == false {
            showToast(message: "Enter Valid Email Address")
        }else if MySingleton.shared.paymobile.isEmpty == true {
            showToast(message: "Enter Mobile Number")
        }else if MySingleton.shared.paymobilecountrycode.isEmpty == true {
            showToast(message: "Please Select Country Code")
        }else if MySingleton.shared.regpassword.isEmpty == true {
            showToast(message: "Enter Password")
        }else {
            callRegisterAPI()
        }
        
    }
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        callapibool = false
        dismiss(animated: true)
    }
    
    
    
    
    
    //MARK: -didTapOnViewStadiumBtnAction
    override func didTapOnViewStadiumBtnAction(cell:SportInfoTVCell) {
        gotoViewStadiumVC(keystr: "stadium")
    }
    
    func gotoViewStadiumVC(keystr:String) {
        guard let vc = ViewStadiumVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.keystr = keystr
        self.present(vc, animated: false)
    }
    
    
    //MARK: - didTapOnContinueBtnAction
    @objc func didTapOnContinueBtnAction(_ sender :UIButton) {
        gotoSelectPaymentMethodsVC()
    }
    
    
    func gotoSelectPaymentMethodsVC() {
        guard let vc = SelectPaymentMethodsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
}

extension SportsBookingDetailsVC {
    
    
    func setupUI(){
        
        continueBtn.addTarget(self, action: #selector(didTapOnContinueBtnAction(_:)), for: .touchUpInside)
        commonTableView.registerTVCells(["SportInfoTVCell",
                                         "RegisterSelectionLoginTableViewCell",
                                         "PrimaryContactInfoTVCell",
                                         "SportsFareSummeryTVCell",
                                         "TermsAgreeTVCell",
                                         "ContactInformationTVCell",
                                         "EmptyTVCell"])
        
        
        setupTVCell()
        
    }
    
    
    func setupTVCell() {
        
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(key:"bookingdetails",
                                                    cellType:.SportInfoTVCell))
        
        let userloggedBool = defaults.bool(forKey: UserDefaultsKeys.loggedInStatus)
        if userloggedBool == false {
            
            if MySingleton.shared.guestbool == false {
                
                MySingleton.shared.tablerow.append(TableRow(cellType:.RegisterSelectionLoginTableViewCell))
                MySingleton.shared.tablerow.append(TableRow(cellType:.PrimaryContactInfoTVCell))
                
            }
            
        }
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.ContactInformationTVCell))
        MySingleton.shared.tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.SportsFareSummeryTVCell))
        MySingleton.shared.tablerow.append(TableRow(title:"By Booking This item, You agree to pay the total amount shown, with includes service fees. you also agree to the terms ans conditions and privacy policy .",cellType:.TermsAgreeTVCell))
        MySingleton.shared.tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
}


extension SportsBookingDetailsVC {
    
    //MARK: - callRegisterAPI registerSucess
    
    func callRegisterAPI() {
        
        basicloderBool = true
        
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["first_name"] = "firstname"
        MySingleton.shared.payload["last_name"] = "lastname"
        MySingleton.shared.payload["email"] = MySingleton.shared.payemail
        MySingleton.shared.payload["password"] = MySingleton.shared.regpassword
        MySingleton.shared.payload["phone"] = MySingleton.shared.paymobile
        MySingleton.shared.payload["country_code"] = MySingleton.shared.paymobilecountrycode
        
        MySingleton.shared.registervm?.CALL_USER_REGISTER_API(dictParam:  MySingleton.shared.payload)
        
    }
    
    
    func registerSucess(response: RegisterModel) {
        
        basicloderBool = false
        
        
        if response.status == false {
            showToast(message: response.msg ?? "")
        } else {
            
            MySingleton.shared.guestbool = true
            showToast(message: "Register Sucess")
            let seconds = 2.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
                setupTVCell()
            }
        }
    }
    
    
    
    //MARK: - callLoginAPI loginSucess
    
    func callLoginAPI() {
        
        basicloderBool = true
        
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["username"] = MySingleton.shared.payemail
        MySingleton.shared.payload["password"] = MySingleton.shared.regpassword
        MySingleton.shared.loginvm?.CALL_USER_LOGIN_API(dictParam:  MySingleton.shared.payload)
        
    }
    
    func loginSucess(response: LoginModel) {
        
        
        basicloderBool = false
        
        if response.status == false {
            showToast(message: response.data ?? "")
        }else {
            defaults.set(true, forKey: UserDefaultsKeys.loggedInStatus)
            defaults.set(response.logindetails?.user_id, forKey: UserDefaultsKeys.userid)
            
            
            defaults.set(response.logindetails?.email, forKey: UserDefaultsKeys.useremail)
            defaults.set(response.logindetails?.phone, forKey: UserDefaultsKeys.usermobile)
            defaults.set(response.logindetails?.country_code, forKey: UserDefaultsKeys.usermobilecode)
            
            MySingleton.shared.payemail = response.logindetails?.email ?? ""
            MySingleton.shared.paymobile = response.logindetails?.phone ?? ""
            MySingleton.shared.paymobilecountrycode = response.logindetails?.country_code ?? ""
            
            showToast(message: response.data ?? "")
            let seconds = 2.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
                setupTVCell()
                
            }
        }
        
    }
    
    
}


