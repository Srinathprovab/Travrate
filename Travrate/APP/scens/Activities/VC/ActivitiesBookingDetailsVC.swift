//
//  ActivitiesBookingDetailsVC.swift
//  Travrate
//
//  Created by Admin on 18/07/24.
//

import UIKit

class ActivitiesBookingDetailsVC: BaseTableVC, ActivitiesPreProcessBookingVMDelegate {
    
    
    @IBOutlet weak var bookingTitlelbl: UILabel!
    @IBOutlet weak var gifimg: UIImageView!
    @IBOutlet weak var continuetoPaymentBtnView: UIView!
    @IBOutlet weak var continuetoPaymentBtnlbl: UILabel!
    @IBOutlet weak var continuebtn: UIButton!
    @IBOutlet weak var backbtn: UIButton!
    
    static var newInstance: ActivitiesBookingDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Activities.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ActivitiesBookingDetailsVC
        return vc
    }
    
    var contract_remark = String()
    var response: ActivitiesBookingModel?
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        
        MySingleton.shared.activitiesPreProcessBookingVM = ActivitiesPreProcessBookingVM(self)
    }
    
    
    func setupUI() {
        
        setuplabels(lbl: bookingTitlelbl, text: "Booking Details", textcolor: .BackBtnColor, font: .InterBold(size: 14), align: .center)

        MySingleton.shared.addonServicesOrigenArray.removeAll()
        continuetoPaymentBtnView.backgroundColor = .Buttoncolor
        continuetoPaymentBtnView.isUserInteractionEnabled = true
        continuetoPaymentBtnlbl.text = "Continue To Next"
        
        guard let gifURL = Bundle.main.url(forResource: "pay", withExtension: "gif") else { return }
        guard let imageData = try? Data(contentsOf: gifURL) else { return }
        guard let image = UIImage.gifImageWithData(imageData) else { return }
        gifimg.image = image
        gifimg.isHidden = true
        
        backbtn.addTarget(self, action: #selector(didTapOnBackBtnAction(_:)), for: .touchUpInside)
        commonTableView.registerTVCells(["RegisterSelectionLoginTableViewCell",
                                         "PrimaryContactInfoTVCell",
                                         "TotalNoofTravellerTVCell",
                                         "AddDeatilsOfGuestTVCell",
                                         "TContactDetailsTVCell",
                                         "EmptyTVCell",
                                         "ActivitiesBookingDetailsTVCell",
                                         "ActivitiesFareSummeryTVCell",
                                         "AddonTableViewCell",
                                         "ContractRemarkTVCell",
                                         "BDPickupLocationTVCell",
                                         "TermsAgreeTVCell",])
        
        
    }
    
    
    
    @objc func didTapOnBackBtnAction(_ sender:UIButton) {
        MySingleton.shared.callboolapi = false
        dismiss(animated: true)
    }
    
    
    
    
    //MARK: - AddDeatilsOfGuestTVCell Delegate Methods
    override func didTapOnExpandAdultViewbtnAction(cell: AddDeatilsOfGuestTVCell) {
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
        setupTVCells()
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
    
    
    
    //MARK: - TContactDetailsTVCell Delegate Methods
    override func didTapOnCountryCodeBtn(cell: TContactDetailsTVCell) {
        MySingleton.shared.paymobilecountrycode = cell.countrycodeTF.text ?? ""
    }
    
    override func editingTextField(tf:UITextField){
        
        print(tf.tag)
        
        switch tf.tag {
        case 111:
            MySingleton.shared.paycontactname = tf.text ?? ""
            break
            
        case 1:
            MySingleton.shared.payemail = tf.text ?? ""
            break
            
        case 2:
            MySingleton.shared.paymobile = tf.text ?? ""
            break
            
            
        case 333:
            print(tf.text)
            break
            
            
        default:
            break
        }
    }
    
    
    
    //MARK: - Addon didSelectAddon  didDeselectAddon
    override func didDeselectAddon(index: Int, origen: String) {
        
        if index == 0 {
            hotelnotificationCheck = false
            updateTotalAndReload()
        } else  {
            hotelpriceCheck = false
            updateTotalAndReload()
        }
        
        
    }
    
    
    override  func didSelectAddon(index: Int, origen: String,price:String) {
        
        if index == 0 {
            
            hotelnotificationPrice = price
            hotelnotificationCheck = true
            
            updateTotalAndReload()
        } else  {
            hotelpriceChange = price
            hotelpriceCheck = true
            updateTotalAndReload()
            
        }
        
    }
    
    
    func updateTotalAndReload() {
        // Update total price or any related data
        // totlConvertedGrand = newTotal
        
        reloadPriceSummaryTVCell()
        
    }
    
    func reloadPriceSummaryTVCell() {
        if let indexPath = indexPathForPriceSummaryTVCell() {
            commonTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func indexPathForPriceSummaryTVCell() -> IndexPath? {
        if let row = MySingleton.shared.tablerow.firstIndex(where: { $0.cellType == .ActivitiesFareSummeryTVCell }) {
            return IndexPath(row: row, section: 0)
        }
        return nil
    }
    
    
    
    override func didTapOnDeleteAddonBtnAction(cell: ActivitiesFareSummeryTVCell) {
        reloadPriceSummaryTVCell()
    }
    
   
   
    
    //MARK: - didTapOnDropupBtnAction
    override func didTapOnDropupBtnAction(cell: ContractRemarkTVCell) {
        commonTableView.reloadData()
    }
    
    
    
    //MARK: - tapOnContinuetoPaymentBtnAction
    @IBAction func tapOnContinuetoPaymentBtnAction(_ sender: Any) {
        didTapOnContinuetoPaymentBtnAction()
    }
    
    
}


extension ActivitiesBookingDetailsVC {
    
    
    func callAPI() {
        MySingleton.shared.activitiesPreProcessBookingVM?.CALL_PRE_PROCESS_BOOKING_API(dictParam: MySingleton.shared.payload)
    }
    
    
    
    func preBookingResponse(response: ActivitiesPreProcessBookingModel) {
        
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["token"] = response.form_params?.token ?? ""
        MySingleton.shared.payload["booking_source"] = MySingleton.shared.activites_booking_source
        MySingleton.shared.payload["app_reference"] = response.form_params?.app_reference ?? ""
        MySingleton.shared.payload["resultToken"] = MySingleton.shared.resultToken
        MySingleton.shared.payload["rateKey"] = MySingleton.shared.rateKeySring
        MySingleton.shared.payload["activity_selecteddate"] = MySingleton.shared.activity_selecteddate
        
        MySingleton.shared.activitiesPreProcessBookingVM?.CALL_BOOKING_API(dictParam: MySingleton.shared.payload, urlstr: response.hit_url ?? "")
    }
    
    
    
    func bookingResponse(response: ActivitiesBookingModel) {
        loderBool = false
        hideLoadera()
        
        MySingleton.shared.activitiesAddonServices = response.addon_services ?? []
        MySingleton.shared.bookingactivitydetails = response.data?.activity_details
        MySingleton.shared.activitiesPostData =  response.post
        self.response = response
        contract_remark =  response.data?.activity_details?.token_mob?.content?.description ?? ""
        
        print(contract_remark)
        
        
        DispatchQueue.main.async {
            self.setupTVCells()
        }
        
    }
    
    
    
    
    
    //MARK: - setuptv
    func setupTVCells() {
        
        MySingleton.shared.tablerow.removeAll()
        MySingleton.shared.positionsCount = 0
        
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.ActivitiesBookingDetailsTVCell))
        
        
        let userloggedBool = defaults.bool(forKey: UserDefaultsKeys.loggedInStatus)
        if userloggedBool == false {
            
            if MySingleton.shared.guestbool == false {
                
                MySingleton.shared.tablerow.append(TableRow(cellType:.RegisterSelectionLoginTableViewCell))
                MySingleton.shared.tablerow.append(TableRow(cellType:.PrimaryContactInfoTVCell))
                
            }
            
        }
        
        
        let adultcount = defaults.integer(forKey: UserDefaultsKeys.activitesadultCount)
        let childcount = defaults.integer(forKey: UserDefaultsKeys.activiteschildCount)
        let infantcount = defaults.integer(forKey: UserDefaultsKeys.activitesinfantsCount)
        MySingleton.shared.tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        MySingleton.shared.tablerow.append(TableRow(title:"Enter Passenger Information",
                                                    cellType:.TotalNoofTravellerTVCell))
        
        for i in 1...adultcount {
            MySingleton.shared.positionsCount += 1
            let travellerCell = TableRow(title: "Adult \(i)",
                                         key: "adult",
                                         characterLimit:MySingleton.shared.positionsCount,
                                         cellType: .AddDeatilsOfGuestTVCell)
            
            MySingleton.shared.tablerow.append(travellerCell)
            
        }
        
        
        if childcount != 0 {
            for i in 1...childcount {
                MySingleton.shared.positionsCount += 1
                MySingleton.shared.tablerow.append(TableRow(title:"Child \(i)"
                                                            ,key:"child",
                                                            characterLimit:MySingleton.shared.positionsCount,
                                                            cellType:.AddDeatilsOfGuestTVCell))
                
            }
        }
        
        
        //        if infantcount != 0 {
        //            for i in 1...infantcount {
        //                MySingleton.shared.positionsCount += 1
        //                MySingleton.shared.tablerow.append(TableRow(title:"Infant \(i)"
        //                                                            ,key:"infant",
        //                                                            characterLimit:MySingleton.shared.positionsCount,
        //                                                            cellType:.AddDeatilsOfGuestTVCell))
        //
        //            }
        //        }
        
        
        
        
        
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.BDPickupLocationTVCell))
        MySingleton.shared.tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        MySingleton.shared.tablerow.append(TableRow(key: "activities",cellType:.TContactDetailsTVCell))
        MySingleton.shared.tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        MySingleton.shared.tablerow.append(TableRow(key: "activities", moreData: services, cellType:.AddonTableViewCell))
        MySingleton.shared.tablerow.append(TableRow(title:contract_remark,cellType:.ContractRemarkTVCell))
        MySingleton.shared.tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.ActivitiesFareSummeryTVCell))
        MySingleton.shared.tablerow.append(TableRow(title:"By Booking This item, You agree to pay the total amount shown, with includes service fees. you also agree to the terms ans conditions and privacy policy .",cellType:.TermsAgreeTVCell))
        
        MySingleton.shared.tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
    
}




extension ActivitiesBookingDetailsVC {
    
    
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
                setupTVCells()
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
            MySingleton.shared.guestbool = true
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
                setupTVCells()
            }
        }
        
    }
}







//MARK: - didTapOnContinuetoPaymentBtnAction
extension ActivitiesBookingDetailsVC {
    
    
    func didTapOnContinuetoPaymentBtnAction() {
        activitiesTapPayNow()
    }
    
    func activitiesTapPayNow() {
        
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload1.removeAll()
        
        
        var callpaymenthotelbool = true
        var fnameCharBool = true
        var lnameCharBool = true
        
        
        for traveler in travelerArray {
            
            if traveler.firstName == nil  || traveler.firstName?.isEmpty == true{
                callpaymenthotelbool = false
                
            }
            
            if (traveler.firstName?.count ?? 0) <= 3 {
                fnameCharBool = false
            }
            
            if traveler.lastName == nil || traveler.firstName?.isEmpty == true{
                callpaymenthotelbool = false
            }
            
            if (traveler.lastName?.count ?? 0) <= 3 {
                lnameCharBool = false
            }
            
            
            // Continue checking other fields
        }
        
        
        
        let positionsCount1 = commonTableView.numberOfRows(inSection: 0)
        for position in 0..<positionsCount1 {
            // Fetch the cell for the given position
            if let cell = commonTableView.cellForRow(at: IndexPath(row: position, section: 0)) as? AddDeatilsOfGuestTVCell {
                
                if cell.titleTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.titleView.layer.borderColor = UIColor.red.cgColor
                    callpaymenthotelbool = false
                    
                }
                
                if cell.fnameTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.fnameView.layer.borderColor = UIColor.red.cgColor
                    callpaymenthotelbool = false
                }else if (cell.fnameTF.text?.count ?? 0) <= 3{
                    cell.fnameView.layer.borderColor = UIColor.red.cgColor
                    fnameCharBool = false
                }else {
                    fnameCharBool = true
                }
                
                if cell.lnameTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.lnameView.layer.borderColor = UIColor.red.cgColor
                    callpaymenthotelbool = false
                }else if (cell.lnameTF.text?.count ?? 0) <= 3{
                    cell.lnameView.layer.borderColor = UIColor.red.cgColor
                    lnameCharBool = false
                } else {
                    // Textfield is not empty
                    lnameCharBool = true
                }
                
                
            }
        }
        
        
        let mrtitleArray = travelerArray.compactMap({$0.mrtitle})
        let passengertypeArray = travelerArray.compactMap({$0.passengertype})
        let firstnameArray = travelerArray.compactMap({$0.firstName})
        let lastNameArray = travelerArray.compactMap({$0.lastName})
        let laedpassengerArray = travelerArray.compactMap({$0.laedpassenger})
        let mrtitleString = "[\"" + mrtitleArray.joined(separator: "\",\"") + "\"]"
        let firstnameString = "[\"" + firstnameArray.joined(separator: "\",\"") + "\"]"
        let lastNameString = "[\"" + lastNameArray.joined(separator: "\",\"") + "\"]"
        let passengertypeString = "[\"" + passengertypeArray.joined(separator: "\",\"") + "\"]"
        let laedpassengerArrayString = "[\"" + laedpassengerArray.joined(separator: "\",\"") + "\"]"
        let addonArrayString = "[\"" + MySingleton.shared.addonServicesOrigenArray.joined(separator: "\",\"") + "\"]"
        
        
        
       
        
        let alocation = MySingleton.shared.activity_loc
        let agent_payable = MySingleton.shared.agentpayable
        let total_markupamt = MySingleton.shared.agentpayable
        let acity = response?.data?.activity_search_params?.city_name
        let acountry = response?.data?.activity_search_params?.country_name
        let selectedData = response?.post?.activity_selecteddate   //01-08-2024
        let booking_source = response?.post?.booking_source
        let payment_method = "PNHB1"
        let rateKey = response?.post?.rateKey
        let noOfDays = "1"
        let search_id = MySingleton.shared.activites_searchid
        let activity_from = response?.data?.activity_search_params?.from_date
        let pn_country_code = MySingleton.shared.paymobilecountrycode
        let passenger_contact = MySingleton.shared.paymobile
        let billing_email = MySingleton.shared.payemail
        let confirm = "0"
        let continuee = "Continue"
        let passenger_type = passengertypeString
        let lead_passenger = laedpassengerArrayString
        let name_title = mrtitleString
        let first_name = firstnameString
        let last_name = lastNameString
        
        
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["contract_remark"] = contract_remark
        MySingleton.shared.payload["alocation"] = alocation
        MySingleton.shared.payload["agent_payable"] = agent_payable
        MySingleton.shared.payload["total_markupamt"] = total_markupamt
        MySingleton.shared.payload["acity"] = acity
        MySingleton.shared.payload["acountry"] = acountry
        MySingleton.shared.payload["selectedData"] = MySingleton.shared.convertDateFormat(inputDate: selectedData ?? "", f1: "yyyy-MM-dd", f2: "dd-MM-yyyy")
        MySingleton.shared.payload["booking_source"] = booking_source
        MySingleton.shared.payload["payment_method"] = payment_method
        MySingleton.shared.payload["rateKey"] = rateKey
        MySingleton.shared.payload["noOfDays"] = noOfDays
        MySingleton.shared.payload["search_id"] = search_id
        MySingleton.shared.payload["activity_from"] = activity_from
        MySingleton.shared.payload["pn_country_code"] = pn_country_code
        MySingleton.shared.payload["passenger_contact"] = passenger_contact
        MySingleton.shared.payload["billing_email"] = billing_email
        MySingleton.shared.payload["confirm"] = confirm
        MySingleton.shared.payload["continue"] = continuee
        MySingleton.shared.payload["passenger_type"] = passenger_type
        MySingleton.shared.payload["lead_passenger"] = lead_passenger
        MySingleton.shared.payload["name_title"] = name_title
        MySingleton.shared.payload["first_name"] = first_name
        MySingleton.shared.payload["last_name"] = last_name
        
        
        // Check additional conditions
        if callpaymenthotelbool == false{
            showToast(message: "Add Details")
        }else if MySingleton.shared.payemail == "" {
            showToast(message: "Enter Email Address")
        }else if MySingleton.shared.payemail.isValidEmail() == false {
            showToast(message: "Enter Valid Email Addreess")
        }else if MySingleton.shared.paymobile == "" {
            showToast(message: "Enter Mobile No")
        }else if MySingleton.shared.paymobilecountrycode == "" {
            showToast(message: "Enter Country Code")
        }else if mobilenoMaxLengthBool == false {
            showToast(message: "Enter Valid Mobile No")
        }else if fnameCharBool == false{
            showToast(message: "More Than 3 Char")
        }else if lnameCharBool == false{
            showToast(message: "More Than 3 Char")
        }else if MySingleton.shared.checkTermsAndCondationStatus == false {
            showToast(message: "Please Accept T&C and Privacy Policy")
        }else {
            gotoSelectPaymentMethodsVC()
        }
        
    }
    
    
    
    func gotoSelectPaymentMethodsVC() {
        MySingleton.shared.callboolapi = true
        guard let vc = SelectPaymentMethodsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.activitiesProcessPangerUrl = response?.hit_url ?? ""
        self.present(vc, animated: false)
    }
    
    
}






//MARK: - addObserver
extension ActivitiesBookingDetailsVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(nointrnetreload), name: Notification.Name("nointrnetreload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        
        
        if MySingleton.shared.callboolapi == true {
            
            MySingleton.shared.loderString = "fdetails"
            MySingleton.shared.afterResultsBool = true
            loderBool = true
            showLoadera()
            
            callAPI()
        }
    }
    
    
    @objc func reload() {
        DispatchQueue.main.async {[self] in
            commonTableView.reloadData()
        }
    }
    
    @objc func nointrnetreload() {
        
        DispatchQueue.main.async {[self] in
            commonTableView.reloadData()
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

