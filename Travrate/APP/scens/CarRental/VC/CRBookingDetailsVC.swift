//
//  CRBookingDetailsVC.swift
//  Travrate
//
//  Created by FCI on 14/06/24.
//

import UIKit

class CRBookingDetailsVC: BaseTableVC, CarBookingVMDelegate {
    
    
    
    
    @IBOutlet weak var continuebtn: UIButton!
    
    static var newInstance: CRBookingDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.CarRental.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? CRBookingDetailsVC
        return vc
    }
    
    var countrycode = String()
    var mrtitlecode = String()
    var fname = String()
    var lname = String()
    var email = String()
    var mobile = String()
    var nationality = String()
    var city = String()
    var postal = String()
    var address = String()
    var cardetails : Result_token?
    var appref = String()
    
    override func viewWillAppear(_ animated: Bool) {
        if callapibool == true {
            callAPI()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        MySingleton.shared.carBookingVM = CarBookingVM(self)
        
    }
    
    
    func setupUI(){
        
        
        continuebtn.layer.cornerRadius = 4
        continuebtn.addTarget(self, action: #selector(didTapOnContinueBtnAction), for: .touchUpInside)
        commonTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Top left corner, Top right corner respectively
        commonTableView.layer.cornerRadius = 12
        commonTableView.clipsToBounds = true
        commonTableView.registerTVCells(["SelectedCarRentalTVCell",
                                         "CRFareSummaryTVCell",
                                         "DriverDetailsTVCell",
                                         "TermsAgreeTVCell",
                                         "SelectedServiceTVCell",
                                         "SelectedAdditionalOptionsTVCell",
                                         "ChooseAdditionalOptionsTVCell",
                                         "SelectedCRPackageTVCell",
                                         "AddonTableViewCell",
                                         "EmptyTVCell"])
        
        
    }
    
    
    //MARK: - didTapOnBackBtnAction
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        callapibool = false
        dismiss(animated: true)
    }
    
    
    //MARK: - didTapOnSelectPackageBtnAction  ChoosePackageTVCell
    override func didTapOnSelectPackageBtnAction(cell: ChoosePackageTVCell) {
        print("didTapOnSelectPackageBtnAction")
    }
    
    
    //MARK: - Address Text View
    override func textViewDidChange(textView:UITextView) {
        address = textView.text
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
        if let row = MySingleton.shared.tablerow.firstIndex(where: { $0.cellType == .CRFareSummaryTVCell }) {
            return IndexPath(row: row, section: 0)
        }
        return nil
    }
    
    
    //MARK: - editingTextFieldChanged DriverDetailsTVCell Delegate Methods
    override func editingTextFieldChanged(tf: UITextField) {
        
        print(tf.tag)
        switch tf.tag {
        case 1:
            fname = tf.text ?? ""
            break
            
        case 2:
            lname = tf.text ?? ""
            break
            
        case 3:
            email = tf.text ?? ""
            break
            
        case 4:
            mobile = tf.text ?? ""
            break
            
            
        default:
            break
        }
    }
    
    
    
    
    override func didTapOnTitleSelectBtnAction(cell:DriverDetailsTVCell) {
        mrtitlecode = cell.mrtitle
    }
    
    override func didTapOnCountryCodeBtn(cell:DriverDetailsTVCell) {
        countrycode = cell.isoCountryCode
    }
    
    
    //MARK: - didTapOnSelectServiceBtnAction
    override func didTapOnSelectServiceBtnAction(cell: SelectedServiceTVCell) {
        commonTableView.reloadData()
    }
    
    
    //MARK: - didTapOnSelectedAdditionalOptionsBtnAction  SelectedAdditionalOptionsTVCell
    override func didTapOnSelectedAdditionalOptionsBtnAction(cell: SelectedAdditionalOptionsTVCell) {
        commonTableView.reloadData()
    }
    
    
    @objc func didTapOnContinueBtnAction() {
        
        if fname.isEmpty == true {
            showToast(message: "Enter First Name")
            return
        }else if lname.isEmpty == true {
            showToast(message: "Enter Last Name")
            return
        }else if self.email.isEmpty == true {
            showToast(message: "Enter Email Address")
            return
        }else if email.isValidEmail() == false {
            showToast(message: "Enter Valid Email Address")
            return
        }else if countrycode.isEmpty == true {
            showToast(message: "Please Select Country Code")
            return
        }else if mobile.isEmpty == true {
            showToast(message: "Enter Mobile Number")
            return
        }else if MySingleton.shared.checkTermsAndCondationStatus == false {
            showToast(message: "Please select option to continue")
            return
        }else {
            callcarBookingAPI()
        }
        
    }
    
    
    
}



extension CRBookingDetailsVC {
    
    
    func callAPI() {
        MySingleton.shared.loderString = "fdetails"
        MySingleton.shared.afterResultsBool = true
        loderBool = true
        showLoadera()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [unowned self] in
            loderBool = false
            hideLoadera()
            
            setupTVCells()
        }
    }
    
    
    
    func setupTVCells() {
        MySingleton.shared.tablerow.removeAll()
     
        
        MySingleton.shared.tablerow.append(TableRow(title:"",moreData: cardetails,cellType:.SelectedCarRentalTVCell))
        
        
        MySingleton.shared.carproductarray.forEach { i in
            MySingleton.shared.tablerow.append(TableRow(key:"bookingdetails",
                                                        moreData: i,
                                                        cellType:.SelectedCRPackageTVCell))
        }
        
        
        MySingleton.shared.tablerow.append(TableRow(moreData:MySingleton.shared.extraOption,
                                                    cellType:.ChooseAdditionalOptionsTVCell))
        
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.DriverDetailsTVCell))
        
        MySingleton.shared.tablerow.append(TableRow(key: "car", moreData: services, cellType:.AddonTableViewCell))
        
        MySingleton.shared.tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        
        MySingleton.shared.carproductarray.forEach { i in
            MySingleton.shared.tablerow.append(TableRow(moreData: i,cellType:.CRFareSummaryTVCell))
            
        }
        
        
        
        
        MySingleton.shared.tablerow.append(TableRow(title:"* By booking this item, you agree to pay the total amount shown, which includes Service Fees. You also agree to the Terms and Conditions and privacy policy",
                                                    cellType:.TermsAgreeTVCell))
        
        
        MySingleton.shared.tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
        
    }
    
    
}




extension CRBookingDetailsVC {
    
    func callcarBookingAPI() {
        
        MySingleton.shared.loderString = "payment"
        MySingleton.shared.afterResultsBool = true
        loderBool = true
        showLoadera()
        
        MySingleton.shared.payload.removeAll()
        
        
        MySingleton.shared.payload["selected_option"] = "\(["2","3"])"
        MySingleton.shared.payload["first_name"] = fname
        MySingleton.shared.payload["last_name"] = lname
        MySingleton.shared.payload["email"] = email
        MySingleton.shared.payload["phone_code"] = mobile
        MySingleton.shared.payload["phone_number"] = countrycode
        MySingleton.shared.payload["tc"] = "no"
        MySingleton.shared.payload["product_code"] = MySingleton.shared.carproductcode
        MySingleton.shared.payload["result_token"] = MySingleton.shared.carresulttoken
        MySingleton.shared.payload["result_index"] = MySingleton.shared.carresultindex
        MySingleton.shared.payload["extra_option_price"] = MySingleton.shared.car_extra_option_price
        MySingleton.shared.payload["total_amount"] = MySingleton.shared.car_total_amount
        MySingleton.shared.payload["total_amount_origin"] = MySingleton.shared.car_total_amount_origin
        MySingleton.shared.payload["markup_value"] = MySingleton.shared.car_markup_value
        MySingleton.shared.payload["discount_value"] = MySingleton.shared.car_discount_value
        MySingleton.shared.payload["currency"] = MySingleton.shared.carcurrency
        MySingleton.shared.payload["search_id"] = MySingleton.shared.carsearchid
        
        
        MySingleton.shared.carBookingVM?.CALL_CAR_BOOKING_API(dictParam: MySingleton.shared.payload)
        
    }
    
    
    func carBookingdetails(response: CarSearchModel) {
        
        DispatchQueue.main.async {
            MySingleton.shared.carBookingVM?.CALL_CAR_PRE_PAYMENT_BOOKING_API(dictParam: [:], urlstr: response.hit_url ?? "")
        }
    }
    
    
    func carPrePaymentDetails(response: carPrePaymrntConfirmationModel) {
        
        appref = response.data?.app_reference ?? ""
        var hiturl = "\(BASE_URL)car/send_to_payment/\(response.data?.app_reference ?? "")/\(response.data?.search_id ?? "")"
        
        DispatchQueue.main.async {
            MySingleton.shared.carBookingVM?.CALL_CAR_SEND_TO_PAYMENT_API(dictParam: [:], urlstr: hiturl)
        }
        
        
    }
    
    
    func carSendtoPaymentDetails(response: CarSearchModel) {
        var hit_url = "https://provab.net/travrate/android_ios_webservices/mobile/index.php/car/secure_booking/\(appref)"
        DispatchQueue.main.async {
            MySingleton.shared.carBookingVM?.CALL_CAR_SECURE_BOOKING_API(dictParam: [:], urlstr: hit_url)
        }
    }
    
    
    func carSecureBookingDetails(response: CarSearchModel) {
        hideLoadera()
        loderBool = false
        print(response.hit_url)
        
        MySingleton.shared.voucherurlsting = response.hit_url ?? ""
        gotoBookingSucessVC()
    }
    
    
    
    func gotoBookingSucessVC() {
        guard let vc = BookingSucessVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    
}
