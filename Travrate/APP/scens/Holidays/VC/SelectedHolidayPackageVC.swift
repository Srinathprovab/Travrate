//
//  SelectedHolidayPackageVC.swift
//  Travgate
//
//  Created by FCI on 26/02/24.
//

import UIKit

class SelectedHolidayPackageVC: BaseTableVC, HolidaySelectedVMDelegate {
  
    
    static var newInstance: SelectedHolidayPackageVC? {
        let storyboard = UIStoryboard(name: Storyboard.Holidays.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SelectedHolidayPackageVC
        return vc
    }
    
    var holidaykey = String()
    var fname = String()
    var emailid = String()
    var mobile = String()
    var selectedHolidayOrigen = String()
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        
        MySingleton.shared.holidaySelectedVM = HolidaySelectedVM(self)
    }
    
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        MySingleton.shared.callboolapi = false
        dismiss(animated: true)
    }
    
    
    //MARK: -  editingTextField
    override func editingTextField(tf:UITextField){
        switch tf.tag {
        case 1:
            fname = tf.text ?? ""
            break
            
        case 2:
            emailid = tf.text ?? ""
            break
            
        case 3:
            mobile = tf.text ?? ""
            break
            
            
        default:
            break
        }
    }
    
    
    //MARK: -  didTapOnAddPeopleBtnAction
    override func didTapOnAddPeopleBtnAction(cell:HolidayContactdetailsTVCell){
        guard let vc = CruisePassengerSelectVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    
    
    //MARK: -  donedatePicker  cancelDatePicker
    override func donedatePicker(cell:HolidayContactdetailsTVCell){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        defaults.set(formatter.string(from: cell.travelFromDatePicker.date), forKey: UserDefaultsKeys.holidayfromtravelDate)
        
        defaults.set(formatter.string(from: cell.travelToDatePicker.date), forKey: UserDefaultsKeys.holidaytotravelDate)
        
        
        commonTableView.reloadData()
        self.view.endEditing(false)
    }
    
    
    override func cancelDatePicker(cell:HolidayContactdetailsTVCell){
        view.endEditing(true)
    }
    
    //MARK: -  didTapOnSubmitEnquiryBtnAction
    override func didTapOnSubmitEnquiryBtnAction(cell:HolidayContactdetailsTVCell){
        
        
        if MySingleton.shared.mrtitle.isEmpty == true {
            showToast(message: "Select Title For Your Name")
        }else if fname.isEmpty == true {
            showToast(message: "Enter First Name")
        }else if emailid.isEmpty == true {
            showToast(message: "Enter Email Address")
        }else if emailid.isValidEmail() == false {
            showToast(message: "Enter Valid Email Address")
        }else if MySingleton.shared.holidayCountryCode.isEmpty == true {
            showToast(message: "Select Country Code")
        }else if mobile.isEmpty == true {
            showToast(message: "Enter Mobile Number")
        }else if MySingleton.shared.travelfrom.isEmpty == true {
            showToast(message: "Enter travel Date")
        }else {
            callHolidayEnquireyAPI()
        }
        
        
    }
    
    //MARK: -  didTapOnRequestCallBackubmitEnquiryBtnAction
    override func didTapOnRequestCallBackBtnAction(cell:HolidayContactdetailsTVCell){
        
    }
    
    
}


extension SelectedHolidayPackageVC {
    
    
    func setupUI(){
        
        
        commonTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Top left corner, Top right corner respectively
        commonTableView.layer.cornerRadius = 12
        commonTableView.clipsToBounds = true
        commonTableView.registerTVCells(["HolidayItineraryTVCell",
                                         "HolidayContactdetailsTVCell",
                                         "EmptyTVCell"])
        
        
        
    }
    
    
    func callAPI() {
        
        MySingleton.shared.loderString = "fdetails"
        MySingleton.shared.afterResultsBool = true
        loderBool = true
        showLoadera()
        
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.holidaySelectedVM?.CALL_GET_SELECTED_HOLIDAY_LIST_API(dictParam: [:], key: self.holidaykey)
    }
    
    
    func holidaySelectedResponse(response: HolidaySelectedModel) {
        loderBool = false
        hideLoadera()
        
        
        if response.status == true {
            MySingleton.shared.holidaySelectedData = response.data
            selectedHolidayOrigen = response.data?.tour__2_data?[0].origin ?? ""
            MySingleton.shared.holidayItinerary = response.data?.tour__2_data?[0].itinerary ?? []
            
            DispatchQueue.main.async {
                self.setupTVCells()
            }
            
        }
    }
    
    
    
    
    func setupTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.HolidayItineraryTVCell))
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.HolidayContactdetailsTVCell))
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
}


//origin:17
//title:Mr
//fullname:Shivam
//mailto:email:shivamrajpoot18897@gmail.com
//country_code:104
//p_number:7785070089
//adult:2
//child:1
//infant:0
//travel_date:31-07-2024



extension SelectedHolidayPackageVC {
    
    func callHolidayEnquireyAPI() {
        
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["origin"] = selectedHolidayOrigen
        MySingleton.shared.payload["title"] = MySingleton.shared.mrtitle
        MySingleton.shared.payload["fullname"] = fname
        MySingleton.shared.payload["email"] = emailid
        MySingleton.shared.payload["country_code"] = MySingleton.shared.cruiseCountryCode
        MySingleton.shared.payload["p_number"] = mobile
        MySingleton.shared.payload["adult"] = defaults.string(forKey: UserDefaultsKeys.holidaydultCount) ?? "1"
        MySingleton.shared.payload["child"] = defaults.string(forKey: UserDefaultsKeys.holidaychildCount) ?? "0"
        MySingleton.shared.payload["infant"] = defaults.string(forKey: UserDefaultsKeys.holidayinfantsCount) ?? "0"
        MySingleton.shared.payload["travel_date"] = MySingleton.shared.convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.holidayfromtravelDate) ?? "", f1: "dd/MM/yyyy", f2: "dd-MM-yyyy")
        
        MySingleton.shared.holidaySelectedVM?.CALL_SEND_OTP_REQUEST_API(dictParam: MySingleton.shared.payload)
    }
    
    
    
    func otpRequestResponse(response: OTPSucessModel) {
        MySingleton.shared.un_id = response.data?.un_id ?? ""
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.gotoSubmitOTPVC()
        }
    }
    
    func holidayEnquireySucesse(response: HolidayEnquireyModel) {
        
    }
    
    
    func gotoSubmitOTPVC() {
        guard let vc = SubmitOTPVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: false)
    }
    
}


extension SelectedHolidayPackageVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        
        
        callAPI()
    }
    
    
    @objc func reload() {
        commonTableView.reloadData()
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


