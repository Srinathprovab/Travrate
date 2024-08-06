//
//  SportsBookingDetailsVC.swift
//  Travrate
//
//  Created by FCI on 27/05/24.
//

import UIKit

class SportsBookingDetailsVC: BaseTableVC, SportsBookingVMDelegate, LoginViewModelDelegate, RegisterViewModelDelegate {
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var gifimg: UIImageView!
    @IBOutlet weak var continuetoPaymentBtnView: UIView!
    @IBOutlet weak var continuetoPaymentBtnlbl: UILabel!
    @IBOutlet weak var continueBtn: UIButton!
    
    static var newInstance: SportsBookingDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Sports.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SportsBookingDetailsVC
        return vc
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        MySingleton.shared.sportsPersonCount = 0
        if callapibool == true {
            callAPI()
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        MySingleton.shared.registervm = RegisterViewModel(self)
        MySingleton.shared.loginvm = LoginViewModel(self)
        MySingleton.shared.sportsbookingvm = SportsBookingVM(self)
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
        travelerArray.removeAll()
        MySingleton.shared.positionsCount = 0
        
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
    
    
    
    //MARK: - AddDeatilsOfPersonTVCell Delegate Methods
    override func didTapOnExpandAdultViewbtnAction(cell: AddDeatilsOfPersonTVCell) {
        if cell.expandViewBool == true {
            
            cell.expandView()
            cell.expandViewBool = false
        }else {
            
            cell.collapsView()
            cell.expandViewBool = true
        }
        
        commonTableView.beginUpdates()
        commonTableView.endUpdates()
    }
    override func didTapOnTitleBtnAction(cell: AddDeatilsOfPersonTVCell) {
        print(cell.titleTF.text)
    }
    override func donedatePicker(cell:AddDeatilsOfTravellerTVCell){
        self.view.endEditing(true)
    }
    
    override func cancelDatePicker(cell:AddDeatilsOfTravellerTVCell){
        self.view.endEditing(true)
    }
    
    
    
    //MARK: - PersonInformationTVCell Delegate Methods
    override func didTapOnSelectPersonsBtnAction(cell: PersonInformationTVCell) {
        MySingleton.shared.sportsPersonCount = Int(cell.personslbl.text ?? "0") ?? 0
        setupTVCell()
    }
    
    override func didTapOnSelectTicketTypeBtnAction(cell: PersonInformationTVCell) {
        print(cell.tickettypelbl.text)
    }
    
    
    //MARK: - ContactInformationTVCell Delegate Methods
    
    override func editingTextField(tf:UITextField){
        
        switch tf.tag {
        case 1:
            MySingleton.shared.payemail = tf.text ?? ""
            break
            
        case 2:
            MySingleton.shared.paymobile = tf.text ?? ""
            break
            
        case 111:
            MySingleton.shared.payusername = tf.text ?? ""
            break
            
            
        case 5:
            MySingleton.shared.regpassword = tf.text ?? ""
            break
            
            
            
        default:
            break
        }
    }
    
    
    //MARK: - didTapOnCheckBoxBtnAction TermsAgreeTVCell
    override func didTapOnCheckBoxBtnAction(cell:TermsAgreeTVCell) {
        if cell.checkBool {
            continuetoPaymentBtnView.backgroundColor = .BooknowBtnColor
            gifimg.isHidden = false
        }else {
            continuetoPaymentBtnView.backgroundColor = .Buttoncolor
            gifimg.isHidden = true
        }
    }
    
    override func didTapOnTermsBtnAction(cell:TermsAgreeTVCell) {
        
        if cell.checkBool {
            continuetoPaymentBtnView.backgroundColor = .BooknowBtnColor
            gifimg.isHidden = false
        }else {
            continuetoPaymentBtnView.backgroundColor = .Buttoncolor
            gifimg.isHidden = true
        }
        
        gotoMoreDetailsVC(str: "Terms & Conditions")
    }
    
    override func didTapOnPrivacyPolicyBtnAction(cell:TermsAgreeTVCell) {
        
        if cell.checkBool {
            continuetoPaymentBtnView.backgroundColor = .BooknowBtnColor
            gifimg.isHidden = false
        }else {
            continuetoPaymentBtnView.backgroundColor = .Buttoncolor
            gifimg.isHidden = true
        }
        
        gotoMoreDetailsVC(str: "Privacy Policy")
    }
    
    
    func gotoMoreDetailsVC(str:String){
        guard let vc = MoreDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.titleString = str
        present(vc, animated: true)
    }
    
    
    
    
    override func didTapOnCountryCodeBtn(cell: ContactInformationTVCell) {
        MySingleton.shared.paymobilecountrycode = cell.countrycodeTF.text ?? ""
    }
    
    
    //MARK: - UsePromoCodesTVCell Delegate Methods
    override func didTapOnApplyPromosCodesBtn(cell:UsePromoCodesTVCell) {
        callApplyPromocodeAPI(promoStr: cell.codesTF.text ?? "")
    }
    
    
    override func didTapOnRemovePromoCodeBtnAction(cell:PriceSummaryTVCell) {
        
        MySingleton.shared.promocodebool.toggle()
        
        var amount = Double(Double(promocodeValue) - Double(totlConvertedGrand))
        totlConvertedGrand = Double(Double(totlConvertedGrand) + Double(amount))
        
        
        DispatchQueue.main.async {
            self.setupTVCell()
        }
        
    }
    
    
    
    func callApplyPromocodeAPI(promoStr:String) {
        
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["promocode"] = promoStr
        MySingleton.shared.payload["moduletype"] = "e325b16aa10bc2b065742595902073cb"
        MySingleton.shared.payload["total_amount_val"] = totlConvertedGrand
        MySingleton.shared.payload["convenience_fee"] = "0"
        MySingleton.shared.payload["booking_source"] = MySingleton.shared.bookingsourceforpromocode
        MySingleton.shared.payload["search_id"] = MySingleton.shared.searchid
        MySingleton.shared.payload["access_key_tp"] = MySingleton.shared.accesskeytp
        
        MySingleton.shared.mpbvm?.CALL_PROMOCODE_APPLY_API(dictParam: MySingleton.shared.payload)
        
    }
    
    func promocodeDetails(response : PromocodeModel) {
        
        if response.status == 0 {
            NotificationCenter.default.post(name: NSNotification.Name("invalidPromocode"), object: nil)
            
        }else {
            
            NotificationCenter.default.post(name: NSNotification.Name("validPromocode"), object: nil)
            
            MySingleton.shared.promocodebool.toggle()
            
            promocodeValue = totlConvertedGrand
            totlConvertedGrand = Double(String(format: "%.2f", response.total_amount_val_KWD ?? 0.0)) ?? 0.0
            
            DispatchQueue.main.async {
                self.setupTVCell()
            }
        }
        
    }
    
    
    
    override func didTapClosepromoViewBtnAction(cell:UsePromoCodesTVCell) {
        commonTableView.reloadData()
    }
    
    
    
    //MARK: - didTapOnContinueBtnAction
    @objc func didTapOnContinueBtnAction(_ sender :UIButton) {
        ContinueToPaymentBtnTap()
    }
}

extension SportsBookingDetailsVC {
    
    
    func setupUI(){
        
        setuplabels(lbl: titlelbl, text: "Booking Details", textcolor: .BackBtnColor, font: .InterBold(size: 14), align: .center)
        
        continuetoPaymentBtnView.backgroundColor = .Buttoncolor
        continuetoPaymentBtnView.isUserInteractionEnabled = true
        continuetoPaymentBtnlbl.text = "Continue To Next"
        
        guard let gifURL = Bundle.main.url(forResource: "pay", withExtension: "gif") else { return }
        guard let imageData = try? Data(contentsOf: gifURL) else { return }
        guard let image = UIImage.gifImageWithData(imageData) else { return }
        gifimg.image = image
        gifimg.isHidden = true
        
        continueBtn.addTarget(self, action: #selector(didTapOnContinueBtnAction(_:)), for: .touchUpInside)
        commonTableView.registerTVCells(["SportInfoTVCell",
                                         "RegisterSelectionLoginTableViewCell",
                                         "PrimaryContactInfoTVCell",
                                         "SportsFareSummeryTVCell",
                                         "TermsAgreeTVCell",
                                         "PersonInformationTVCell",
                                         "ContactInformationTVCell",
                                         "AddDeatilsOfPersonTVCell",
                                         "UsePromoCodesTVCell",
                                         "EmptyTVCell"])
        
        
        
        
    }
    
    
    func callAPI() {
        
        MySingleton.shared.loderString = "fdetails"
        MySingleton.shared.afterResultsBool = true
        loderBool = true
        showLoadera()
        
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["search_id"] = MySingleton.shared.sports_searchid
        MySingleton.shared.payload["token"] = MySingleton.shared.sports_token
        MySingleton.shared.payload["ticket_value"] = MySingleton.shared.sport_ticket_value
        MySingleton.shared.sportsbookingvm?.CALL_SPORTS_PRE_BOOKING_API(dictParam: MySingleton.shared.payload)
    }
    
    
    func sportBookingDetails(response: SportsBookingModel) {
        
        MySingleton.shared.sportsBookingData = response.data
        MySingleton.shared.sportEventList = response.data?.event_list
        MySingleton.shared.sportTicketValue = response.data?.ticket_value
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [unowned self] in
            loderBool = false
            hideLoadera()
            
            DispatchQueue.main.async {
                self.setupTVCell()
            }
        }
        
    }
    
    
    func setupTVCell() {
        
        MySingleton.shared.tablerow.removeAll()
        MySingleton.shared.positionsCount = 0
        
        
        MySingleton.shared.tablerow.append(TableRow(key:"bookingdetails",
                                                    cellType:.SportInfoTVCell))
        
        let userloggedBool = defaults.bool(forKey: UserDefaultsKeys.loggedInStatus)
        if userloggedBool == false {
            
            if MySingleton.shared.guestbool == false {
                
                MySingleton.shared.tablerow.append(TableRow(cellType:.RegisterSelectionLoginTableViewCell))
                MySingleton.shared.tablerow.append(TableRow(cellType:.PrimaryContactInfoTVCell))
                
            }
            
        }
        
        
        
        MySingleton.shared.tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.PersonInformationTVCell))
        
        let personCount = Int(MySingleton.shared.sportsPersonCount)
        if personCount > 0 {
            
            for i in 1...Int(MySingleton.shared.sportsPersonCount) {
                MySingleton.shared.positionsCount += 1
                MySingleton.shared.passengertypeArray.append("Adult")
                let travellerCell = TableRow(title: "Person \(i)",
                                             key: "person1",
                                             characterLimit: MySingleton.shared.positionsCount,
                                             cellType: .AddDeatilsOfPersonTVCell)
                MySingleton.shared.searchTextArray.append("Person \(i)")
                MySingleton.shared.tablerow.append(travellerCell)
                
            }
            
        }
        
        
        // Truncate or pad travelerArray to match personCount
        if travelerArray.count > personCount {
            travelerArray = Array(travelerArray.prefix(personCount))
        } else {
            for _ in travelerArray.count..<personCount {
                travelerArray.append(Traveler())
            }
        }
        
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.ContactInformationTVCell))
        MySingleton.shared.tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.UsePromoCodesTVCell))
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


extension SportsBookingDetailsVC {
    
    
    
    func ContinueToPaymentBtnTap() {
        loderBool = true
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload1.removeAll()
        
        
        
        var callpaymentbool = true
        var fnameCharBool = true
        var lnameCharBool = true
        
        
        
        
        // Check if there are any rows in section 0
        if commonTableView.numberOfRows(inSection: 0) == 0 {
            callpaymentbool = false
        } else {
            // Iterate over the cells if there are rows in section 0
            
            let positionsCount = commonTableView.numberOfRows(inSection: 0)
            for position in 0..<positionsCount {
                // Fetch the cell for the given position
                if let cell = commonTableView.cellForRow(at: IndexPath(row: position, section: 0)) as? AddDeatilsOfPersonTVCell {
                    
                    if cell.titleTF.text?.isEmpty == true {
                        // Textfield is empty
                        cell.titleView.layer.borderColor = UIColor.red.cgColor
                        callpaymentbool = false
                        
                    } else {
                        // Textfield is not empty
                    }
                    
                    if cell.fnameTF.text?.isEmpty == true {
                        // Textfield is empty
                        cell.fnameView.layer.borderColor = UIColor.red.cgColor
                        callpaymentbool = false
                    }else if (cell.fnameTF.text?.count ?? 0) <= 3{
                        cell.fnameView.layer.borderColor = UIColor.red.cgColor
                        fnameCharBool = false
                    }else {
                        fnameCharBool = true
                    }
                    
                    if cell.lnameTF.text?.isEmpty == true {
                        // Textfield is empty
                        cell.lnameView.layer.borderColor = UIColor.red.cgColor
                        callpaymentbool = false
                    }else if (cell.lnameTF.text?.count ?? 0) <= 3{
                        cell.lnameView.layer.borderColor = UIColor.red.cgColor
                        lnameCharBool = false
                    } else {
                        // Textfield is not empty
                        lnameCharBool = true
                    }
                    
                    
                    if cell.dobTF.text?.isEmpty == true {
                        // Textfield is empty
                        cell.dobView.layer.borderColor = UIColor.red.cgColor
                        callpaymentbool = false
                    } else {
                        // Textfield is not empty
                    }
                    
                    
                    if cell.passportnoTF.text?.isEmpty == true {
                        // Textfield is empty
                        cell.passportnoView.layer.borderColor = UIColor.red.cgColor
                        callpaymentbool = false
                    } else {
                        // Textfield is not empty
                    }
                    
                    
                    if cell.selectCountryTF.text?.isEmpty == true {
                        // Textfield is empty
                        cell.selectCountryView.layer.borderColor = UIColor.red.cgColor
                        callpaymentbool = false
                    } else {
                        // Textfield is not empty
                    }
                    
                }
            }
            
            // Check if there are any rows in section 0
            if positionsCount == 0 {
                callpaymentbool = false
            }
        }
        
        
        // Iterate over travelerArray to check if any required field is empty
        for traveler in travelerArray {
            if traveler.firstName == nil || traveler.firstName?.isEmpty == true ||
                traveler.lastName == nil || traveler.lastName?.isEmpty == true ||
                traveler.dob == nil || traveler.dob?.isEmpty == true ||
                traveler.passportno == nil || traveler.passportno?.isEmpty == true ||
                traveler.passportIssuingCountry == nil || traveler.passportIssuingCountry?.isEmpty == true || traveler.cityofbirth == nil || traveler.cityofbirth?.isEmpty == true{
                callpaymentbool = false
                break // Exit loop if any field is empty
            }else if (traveler.firstName?.count ?? 0) <= 3 {
                fnameCharBool = false
            }else if (traveler.lastName?.count ?? 0) <= 3 {
                lnameCharBool = false
            }
        }
        
        
        let firstnameArray = travelerArray.compactMap({$0.firstName})
        let lastNameArray = travelerArray.compactMap({$0.lastName})
        let dayArray = travelerArray.compactMap({$0.day})
        let monthArray = travelerArray.compactMap({$0.month})
        let yearArray = travelerArray.compactMap({$0.year})
        let passportnoArray = travelerArray.compactMap({$0.passportno})
        let passportIssuingCountryArray = travelerArray.compactMap({$0.passportIssuingCountry})
        let cityofbirthArray = travelerArray.compactMap({$0.cityofbirth})
        
        
        // Convert arrays to string representations
        let firstnameString = "[\"" + firstnameArray.joined(separator: "\",\"") + "\"]"
        let lastNameString = "[\"" + lastNameArray.joined(separator: "\",\"") + "\"]"
        let dayString = "[\"" + dayArray.joined(separator: "\",\"") + "\"]"
        let monthString = "[\"" + monthArray.joined(separator: "\",\"") + "\"]"
        let yearString = "[\"" + yearArray.joined(separator: "\",\"") + "\"]"
        let passportnoString = "[\"" + passportnoArray.joined(separator: "\",\"") + "\"]"
        let passportIssuingCountryString = "[\"" + passportIssuingCountryArray.joined(separator: "\",\"") + "\"]"
        let cityofbirthArrayString = "[\"" + cityofbirthArray.joined(separator: "\",\"") + "\"]"
        
        
        
        MySingleton.shared.payload["First_name"] = firstnameString
        MySingleton.shared.payload["last_name"] = lastNameString
        MySingleton.shared.payload["dateof_day"] = dayString
        MySingleton.shared.payload["dateof_month"] = monthString
        MySingleton.shared.payload["dateof_year"] = yearString
        MySingleton.shared.payload["passportNumber"] = passportnoString
        MySingleton.shared.payload["Country"] = passportIssuingCountryString
        MySingleton.shared.payload["city_of_birth"] = cityofbirthArrayString
        MySingleton.shared.payload["c_name"] = MySingleton.shared.payusername
        MySingleton.shared.payload["c_email"] = MySingleton.shared.payemail
        MySingleton.shared.payload["c_country"] = MySingleton.shared.paymobilecountrycode
        MySingleton.shared.payload["contact_number"] = MySingleton.shared.paymobile
        MySingleton.shared.payload["pax_count"] = MySingleton.shared.sportsPersonCount
        MySingleton.shared.payload["shipping_code_cost"] = "0"
        MySingleton.shared.payload["cost_code_cost"] = "100"
        MySingleton.shared.payload["totel_amount"] = "100"
        MySingleton.shared.payload["search_id"] = MySingleton.shared.sports_searchid
        MySingleton.shared.payload["totel_delivery"] = totlConvertedGrand
        MySingleton.shared.payload["event_list"] = MySingleton.shared.sports_token
        MySingleton.shared.payload["ticket_value"] = MySingleton.shared.sport_ticket_value
        
        
        
        
        // Check additional conditions
        if MySingleton.shared.sportsPersonCount == 0 {
            showToast(message: "Please select no of persons")
            return
        }else if !callpaymentbool {
            showToast(message: "Add Details")
            return
        }else if !fnameCharBool {
            showToast(message: "First name should have more than 3 characters")
            return
        }else if !lnameCharBool {
            showToast(message: "Last name should have more than 3 characters")
            return
        }else if MySingleton.shared.payusername == "" {
            showToast(message: "Enter Contact Name")
            return
        }else if MySingleton.shared.payemail == "" {
            showToast(message: "Enter Email Address")
            return
        }else if MySingleton.shared.payemail.isValidEmail() == false {
            showToast(message: "Enter Valid Email Addreess")
            return
        }else if MySingleton.shared.paymobile == "" {
            showToast(message: "Enter Mobile No")
            return
        }else if MySingleton.shared.paymobilecountrycode == "" {
            showToast(message: "Enter Country Code")
            return
        }else if mobilenoMaxLengthBool == false {
            showToast(message: "Enter Valid Mobile No")
            return
        }else if MySingleton.shared.checkTermsAndCondationStatus == false {
            showToast(message: "Please Allow Terms and Condition.")
            return
        }else {
            gotoSelectPaymentMethodsVC()
            
        }
    }
    
    
    
    func gotoSelectPaymentMethodsVC() {
        MySingleton.shared.callboolapi = true
        guard let vc = SelectPaymentMethodsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
}



