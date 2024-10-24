//
//  CRBookingDetailsVC.swift
//  Travrate
//
//  Created by FCI on 14/06/24.
//

import UIKit

class CRBookingDetailsVC: BaseTableVC {
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var gifimg: UIImageView!
    @IBOutlet weak var continuetoPaymentBtnView: UIView!
    @IBOutlet weak var continuetoPaymentBtnlbl: UILabel!
    @IBOutlet weak var continuebtn: UIButton!
    @IBOutlet weak var holderview: UIView!
    
    static var newInstance: CRBookingDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.CarRental.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? CRBookingDetailsVC
        return vc
    }
    
    
    var countrycode = String()
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
        addObserver()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        
    }
    
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
        callSameInputsearch()
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
        
        if mrtitlecode.isEmpty == true {
            showToast(message: "Select Title")
            return
        }else if fname.isEmpty == true {
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
                
                gotoSelectPaymentMethodsVC()
                
            
        }
        
    }
    
    
    
    
    func gotoSelectPaymentMethodsVC() {
        
        
        
        MySingleton.shared.callboolapi = true
        callapibool = true
        guard let vc = SelectPaymentMethodsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.cardetails = self.cardetails
        self.present(vc, animated: false)
        
    }
    
    
    
    //MARK: - TermsAgreeTVCell
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
    
    
    
}



extension CRBookingDetailsVC {
    
    
    func callAPI() {
        holderview.isHidden = true
        MySingleton.shared.loderString = "fdetails"
        MySingleton.shared.afterResultsBool = true
        loderBool = true
        showLoadera()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [unowned self] in
            holderview.isHidden = false
            loderBool = false
            hideLoadera()
            
            setupTVCells()
        }
    }
    
    
    
    func setupTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        
        MySingleton.shared.tablerow.append(TableRow(title:"",moreData: cardetails,cellType:.SelectedCarRentalTVCell))
        
        
        MySingleton.shared.selectedcarproductarray.forEach { i in
            MySingleton.shared.tablerow.append(TableRow(key:"bookingdetails",
                                                        moreData: i,
                                                        cellType:.SelectedCRPackageTVCell))
        }
        
        
        MySingleton.shared.tablerow.append(TableRow(moreData:MySingleton.shared.extraOption,
                                                    cellType:.ChooseAdditionalOptionsTVCell))
        
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.DriverDetailsTVCell))
        
        MySingleton.shared.tablerow.append(TableRow(key: "car", moreData: services, cellType:.AddonTableViewCell))
        
        MySingleton.shared.tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        
        MySingleton.shared.selectedcarproductarray.forEach { i in
            MySingleton.shared.tablerow.append(TableRow(key:"bookingdetails",moreData: i,cellType:.CRFareSummaryTVCell))
            
        }
        
        
        
        
        MySingleton.shared.tablerow.append(TableRow(title:"* By booking this item, you agree to pay the total amount shown, which includes Service Fees. You also agree to the Terms and Conditions and privacy policy",
                                                    cellType:.TermsAgreeTVCell))
        
        
        MySingleton.shared.tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
        
    }
    
    
}




extension CRBookingDetailsVC {
     func callSameInputsearch() {
        
        guard let pickuplocationname =  defaults.string(forKey: UserDefaultsKeys.pickuplocationname) else {return}
        guard let pickuplocationcode =  defaults.string(forKey: UserDefaultsKeys.pickuplocationcode) else {return}
        guard let pickuplocDate =  defaults.string(forKey: UserDefaultsKeys.pickuplocDate) else {return}
        guard let dropuplocDate =  defaults.string(forKey: UserDefaultsKeys.dropuplocDate) else {return}
        guard let pickuplocTime =  defaults.string(forKey: UserDefaultsKeys.pickuplocTime) else {return}
        guard let dropuplocTime =  defaults.string(forKey: UserDefaultsKeys.dropuplocTime) else {return}
        guard let driverage =  defaults.string(forKey: UserDefaultsKeys.driverage) else {return}
        
        if pickuplocationname == "Select Location" {
            showToast(message: "Select Location")
        }else if pickuplocDate == "Select Date" {
            showToast(message: "Select Pick Up Date")
        }else if dropuplocDate == "Select Date" {
            showToast(message: "Select Date")
        }else if pickuplocTime == "Select Time" {
            showToast(message: "Select Pick Up Time")
        }else if dropuplocTime == "Select Time" {
            showToast(message: "Select Time")
        }else if driverage == "Select Driver's Age" {
            showToast(message: "Select Driver Age")
        }else {
            
            MySingleton.shared.payload.removeAll()
            MySingleton.shared.payload["car_from"] = pickuplocationname
            MySingleton.shared.payload["from_loc_id"] = pickuplocationcode
            MySingleton.shared.payload["car_to"] = ""
            MySingleton.shared.payload["to_loc_id"] = ""
            MySingleton.shared.payload["departure_date"] = pickuplocDate
            MySingleton.shared.payload["depart_time"] = pickuplocTime
            MySingleton.shared.payload["drop_date"] = dropuplocDate
            MySingleton.shared.payload["drop_time"] = dropuplocTime
            MySingleton.shared.payload["age_1"] = driverage
            
            gotoCarRentalResultsVC()
        }
        
    }
    
    func gotoCarRentalResultsVC() {
        MySingleton.shared.afterResultsBool = false
        MySingleton.shared.callboolapi = true
        defaults.set(false, forKey: "carfilteronce")
        guard let vc = CarRentalResultsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}



//MARK: - addObserver
extension CRBookingDetailsVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(nointrnetreload), name: Notification.Name("nointrnetreload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        
        
        if MySingleton.shared.callboolapi == true {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [unowned self] in
                callAPI()
            }
            
            
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
    
    
    func gotoNoInternetScreen(keystr:String) {
        callapibool = true
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.key = keystr
        self.present(vc, animated: false)
    }
    
    //MARK: - nointernet
    @objc func nointernet() {
        
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = "nointernet"
        self.present(vc, animated: true)
    }
    
    
}
