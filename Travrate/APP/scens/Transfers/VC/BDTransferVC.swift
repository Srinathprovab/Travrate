//
//  BDTransferVC.swift
//  Travgate
//
//  Created by FCI on 08/05/24.
//

import UIKit

class BDTransferVC: BaseTableVC, TransferPreBookingVMDelegate, TransferBookingVMDelegate {
    
    
    
    
    @IBOutlet weak var gifimg: UIImageView!
    @IBOutlet weak var continuetoPaymentBtnView: UIView!
    @IBOutlet weak var continuetoPaymentBtnlbl: UILabel!
    @IBOutlet weak var continuebtn: UIButton!
    
    
    static var newInstance: BDTransferVC? {
        let storyboard = UIStoryboard(name: Storyboard.Transfers.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? BDTransferVC
        return vc
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        
        MySingleton.shared.transferPreBookingVM = TransferPreBookingVM(self)
        MySingleton.shared.transferBookingVM = TransferBookingVM(self)
    }
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        callapibool = false
        dismiss(animated: true)
    }
    
    var arrivaldate = String()
    var arrivaltime = String()
    var depdate = String()
    var deptime = String()
    
    var arrivalflightno = String()
    var arrivalterminal = String()
    var depflightno = String()
    var depterminal = String()
    
    
    
    
    
    //MARK: - TContactDetailsTVCell Delegate Methods
    override func didTapOnCountryCodeBtn(cell: TContactDetailsTVCell) {
        MySingleton.shared.paymobilecountrycode = cell.countrycodeTF.text ?? ""
    }
    
    override func editingTextField(tf:UITextField) {
        switch tf.tag {
        case 1:
            MySingleton.shared.paycontactname = tf.text ?? ""
            break
            
        case 2:
            MySingleton.shared.payemail = tf.text ?? ""
            break
            
        case 3:
            MySingleton.shared.paymobile = tf.text ?? ""
            break
            
            
        case 20:
            arrivalflightno = tf.text ?? ""
            break
            
        case 21:
            arrivalterminal = tf.text ?? ""
            break
            
        case 22:
            depflightno = tf.text ?? ""
            break
            
        case 23:
            depterminal = tf.text ?? ""
            break
            
        default:
            break
        }
    }
    
    
    //MARK: - didTapOnContinueBtnAction
    @objc func didTapOnContinueBtnAction(_ sender: UIButton) {
        didTapOnContinueToNextBtnAction()
    }
    
    
    //MARK: - didTapOnCheckBoxBtnAction
    override func didTapOnCheckBoxBtnAction(cell:TermsAgreeTVCell) {
        if cell.checkBool {
            continuetoPaymentBtnView.backgroundColor = .BooknowBtnColor
            gifimg.isHidden = false
        }else {
            continuetoPaymentBtnView.backgroundColor = .Buttoncolor
            gifimg.isHidden = true
        }
    }
    
    
    //MARK: - Addon didSelectAddon  didDeselectAddon
    override func didDeselectAddon(index: Int, origen: String) {
        
        if index == 0 {
            hotelwhatsAppCheck = false
            updateTotalAndReload()
        } else  {
            hotelflexibleCheck = false
            updateTotalAndReload()
        }
        
        
    }
    
    
    override  func didSelectAddon(index: Int, origen: String,price:String) {
        
        if index == 0 {
            
            hotelwhatsAppPrice = price
            hotelwhatsAppCheck = true
            updateTotalAndReload()
            
        } else  {
            
            hotelflexiblePrie = price
            hotelflexibleCheck = true
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
        if let row = MySingleton.shared.tablerow.firstIndex(where: { $0.cellType == .TransferfareSummeryTVCell }) {
            return IndexPath(row: row, section: 0)
        }
        return nil
    }
    
    
    // MARK: - AddDeatilsOfPassengerTVCell Delegate Methods
    override func didTapOnExpandAdultViewbtnAction(cell: AddDeatilsOfPassengerTVCell) {
        
        // Decrease passenger count ensuring it doesn't go below 1
        if MySingleton.shared.transferpassengercount > 1 {
            MySingleton.shared.transferpassengercount -= 1
        }
        
        travelerArray.remove(at: cell.indexposition)
        setupTVCells()
    }
    
    // MARK: - didTapOnAddPassengerBtnAction Delegate Methods
    override func didTapOnAddPassengerBtnAction(cell: AddPassengerButtonTVCell) {
        // Increase passenger count ensuring it doesn't go above 3
        if MySingleton.shared.transferpassengercount < 3 {
            MySingleton.shared.transferpassengercount += 1
        }
        setupTVCells()
    }
    
    override func donedatePicker1(cell:TFlighDetailsTVCell) {
        arrivaldate = cell.arrivalDateTF.text ?? ""
        depdate = cell.departureDateTF.text ?? ""
        
    }
    
    
    override func doneTimePicker(cell: TFlighDetailsTVCell) {
        arrivaltime = cell.arrivalTimeTF.text ?? ""
        deptime = cell.departurelTimeTF.text ?? ""
        self.view.endEditing(true)
    }
    
    override func cancelTimePicker(cell: TFlighDetailsTVCell) {
        self.view.endEditing(true)
    }
    
    
    
}



extension BDTransferVC {
    
    
    func setupUI(){
        
        
        arrivaldate = defaults.string(forKey: UserDefaultsKeys.transfercalRetDate) ?? ""
        arrivaltime = defaults.string(forKey: UserDefaultsKeys.transfercalRetTime) ?? ""
        depdate = defaults.string(forKey: UserDefaultsKeys.transfercalDepDate) ?? ""
        deptime = defaults.string(forKey: UserDefaultsKeys.transfercalDepTime) ?? ""
        
        hotelwhatsAppCheck = true
        hotelflexibleCheck = true
        reloadPriceSummaryTVCell()
        
        MySingleton.shared.addonServicesOrigenArray.removeAll()
        continuetoPaymentBtnView.backgroundColor = .Buttoncolor
        continuetoPaymentBtnView.isUserInteractionEnabled = true
        continuetoPaymentBtnlbl.text = "Continue To Next"
        
        guard let gifURL = Bundle.main.url(forResource: "pay", withExtension: "gif") else { return }
        guard let imageData = try? Data(contentsOf: gifURL) else { return }
        guard let image = UIImage.gifImageWithData(imageData) else { return }
        gifimg.image = image
        gifimg.isHidden = true
        
        continuebtn.addTarget(self, action: #selector(didTapOnContinueBtnAction(_:)), for: .touchUpInside)
        
        commonTableView.registerTVCells(["BDTransfersInf0TVCell",
                                         "EmptyTVCell",
                                         "TContactDetailsTVCell",
                                         "TermsAgreeTVCell",
                                         "AddDeatilsOfPassengerTVCell",
                                         "AddPassengerButtonTVCell",
                                         "AddonTableViewCell",
                                         "TransferfareSummeryTVCell",
                                         "TFlighDetailsTVCell"])
        // setupVisaTVCells(keystr: "oneway")
        
    }
    
    
    
    func callAPI() {
        
        MySingleton.shared.loderString = "fdetails"
        MySingleton.shared.afterResultsBool = true
        loderBool = true
        showLoadera()
        
        
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["search_id"] = MySingleton.shared.transfer_searchid
        MySingleton.shared.payload["token"] = MySingleton.shared.transfer_token
        
        MySingleton.shared.transferPreBookingVM?.CALL_PRE_BOOKING_API(dictParam: MySingleton.shared.payload)
        
    }
    
    func preBookingResponse(response: TransferPreBookingModel) {
        loderBool = false
        hideLoadera()
        
        MySingleton.shared.transferAddonServices = response.addon_services ?? []
        transfer_data = response.transfer_data
        totlConvertedGrand = response.transfer_data?.price ?? 0.0
        hotelwhatsAppPrice = response.addon_services?[0].price ?? ""
        hotelflexiblePrie = response.addon_services?[1].price ?? ""
        totlConvertedGrand = totlConvertedGrand + (Double(hotelwhatsAppPrice) ?? 0.0) + (Double(hotelflexiblePrie) ?? 0.0)
        
        DispatchQueue.main.async {
            self.setupTVCells()
        }
    }
    
    
    
    
    func setupTVCells() {
        
        MySingleton.shared.tablerow.removeAll()
        MySingleton.shared.positionsCount = 0
        
        MySingleton.shared.tablerow.append(TableRow(moreData:transfer_data,cellType:.BDTransfersInf0TVCell))
        MySingleton.shared.tablerow.append(TableRow(moreData:transfer_data,cellType:.TFlighDetailsTVCell))
        
        // Add rows for each passenger
        for i in 1...MySingleton.shared.transferpassengercount {
            MySingleton.shared.positionsCount += 1
            let travellerCell = TableRow(title: "Passenger \(i)",
                                         key: "adult",
                                         characterLimit: MySingleton.shared.positionsCount,
                                         cellType: .AddDeatilsOfPassengerTVCell)
            MySingleton.shared.tablerow.append(travellerCell)
            MySingleton.shared.tablerow.append(TableRow(height: 10, cellType: .EmptyTVCell))
        }
        
        // Add button to add passenger if count is less than 3
        if MySingleton.shared.transferpassengercount < 3 {
            MySingleton.shared.tablerow.append(TableRow(cellType: .AddPassengerButtonTVCell))
        }
        
        MySingleton.shared.tablerow.append(TableRow(moreData:transfer_data,cellType:.TContactDetailsTVCell))
        MySingleton.shared.tablerow.append(TableRow(key: "transfer", moreData: services, cellType:.AddonTableViewCell))
        
        MySingleton.shared.tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.TransferfareSummeryTVCell))
        MySingleton.shared.tablerow.append(TableRow(height:5,cellType:.EmptyTVCell))
        
        MySingleton.shared.tablerow.append(TableRow(title:"By Booking This item, You agree to pay the total amount shown, with includes service fees. you also agree to the terms ans conditions and privacy policy .",cellType:.TermsAgreeTVCell))
        MySingleton.shared.tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
}





//MARK: - addObserver
extension BDTransferVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(nointrnetreload), name: Notification.Name("nointrnetreload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        
        
        if callapibool == true {
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


extension BDTransferVC {
    
    
    func didTapOnContinueToNextBtnAction() {
        
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
            
            if traveler.email == nil  || traveler.email?.isEmpty == true{
                callpaymenthotelbool = false
                
            }
            
            if traveler.mobile == nil  || traveler.mobile?.isEmpty == true{
                callpaymenthotelbool = false
            }
            
            if traveler.mobilecountrycode == nil  || traveler.mobilecountrycode?.isEmpty == true{
                callpaymenthotelbool = false
                
            }
            
            
            // Continue checking other fields
        }
        
        
        
        let positionsCount1 = commonTableView.numberOfRows(inSection: 0)
        for position in 0..<positionsCount1 {
            // Fetch the cell for the given position
            if let cell = commonTableView.cellForRow(at: IndexPath(row: position, section: 0)) as? AddDeatilsOfPassengerTVCell {
                
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
                
                
                if cell.emailTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.emailview.layer.borderColor = UIColor.red.cgColor
                    callpaymenthotelbool = false
                }
                
                
                if cell.mobileTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.mobileview.layer.borderColor = UIColor.red.cgColor
                    callpaymenthotelbool = false
                }
                
                if cell.countrycodeTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.mobileview.layer.borderColor = UIColor.red.cgColor
                    callpaymenthotelbool = false
                }
                
            }
        }
        
        
        let mrtitleArray = travelerArray.compactMap({$0.mrtitle})
        let firstnameArray = travelerArray.compactMap({$0.firstName})
        let lastNameArray = travelerArray.compactMap({$0.lastName})
        let laedpassengerArray = travelerArray.compactMap({$0.laedpassenger})
        let emailArray = travelerArray.compactMap({$0.email})
        let mobilenoArray = travelerArray.compactMap({$0.mobile})
        let mobilecountrycodeArray = travelerArray.compactMap({$0.mobilecountrycode})
        
        let mrtitleString = "[\"" + mrtitleArray.joined(separator: "\",\"") + "\"]"
        let firstnameString = "[\"" + firstnameArray.joined(separator: "\",\"") + "\"]"
        let lastNameString = "[\"" + lastNameArray.joined(separator: "\",\"") + "\"]"
        let laedpassengerArrayString = "[\"" + laedpassengerArray.joined(separator: "\",\"") + "\"]"
        let emailArrayString = "[\"" + emailArray.joined(separator: "\",\"") + "\"]"
        let mobilenoArrayString = "[\"" + mobilenoArray.joined(separator: "\",\"") + "\"]"
        let mobilecountrycodeArrayString = "[\"" + mobilecountrycodeArray.joined(separator: "\",\"") + "\"]"
        let addonArrayString = "[\"" + MySingleton.shared.addonServicesOrigenArray.joined(separator: "\",\"") + "\"]"
        
        //    search_id:9408
        //    token:
        //    depart_airport:Airport Al Maktoum International Airport
        //    arrival_airport:Airport Dubai International
        //    pnr_no:
        //    arrival_flight_no:866
        //    arrival_terminal:1
        //    arrival_date:19-08-2024
        //    arrival_time:12:05
        //    depart_flight_no:985
        //    depart_terminal:3
        //    depart_date:21-08-2024
        //    depart_time:12:45
        //    addon_services:["10","14"]
        //    title:["10","10"]
        //    first_name:["Poovarasan","test"]
        //    last_name:["Govidaraju","tester"]
        //    pemail:["supervision@provab.com","tesrter@gmail.com"]
        //    pn_code:["987456","98753"]
        //    phone_no:["98746321","9874563210"]
        //    c_name:poovarsan
        //    c_email:supervision@provab.com
        //    pn_country_code:+91
        //    contact_number:98746321
        //    tc:on
        
        
        MySingleton.shared.payload["search_id"] = MySingleton.shared.transfer_searchid
        MySingleton.shared.payload["token"] = MySingleton.shared.transfer_token
        MySingleton.shared.payload["depart_airport"] = defaults.string(forKey: UserDefaultsKeys.transferfromcityname)
        MySingleton.shared.payload["arrival_airport"] = defaults.string(forKey: UserDefaultsKeys.transfertocityname)
        MySingleton.shared.payload["pnr_no"] = ""
        MySingleton.shared.payload["arrival_flight_no"] = arrivalflightno
        MySingleton.shared.payload["arrival_terminal"] = arrivalterminal
        MySingleton.shared.payload["arrival_date"] = arrivaldate
        MySingleton.shared.payload["arrival_time"] = arrivaltime
        
        MySingleton.shared.payload["depart_flight_no"] = ""
        MySingleton.shared.payload["depart_terminal"] = ""
        MySingleton.shared.payload["depart_date"] = ""
        MySingleton.shared.payload["depart_time"] = ""
        
        MySingleton.shared.payload["addon_services"] = addonArrayString
        MySingleton.shared.payload["title"] = mrtitleString
        MySingleton.shared.payload["first_name"] = firstnameString
        MySingleton.shared.payload["last_name"] = lastNameString
        MySingleton.shared.payload["pemail"] = emailArrayString
        MySingleton.shared.payload["pn_code"] = "\(["987456","98753"])"
        MySingleton.shared.payload["phone_no"] = mobilenoArrayString
        MySingleton.shared.payload["c_name"] = MySingleton.shared.paycontactname
        MySingleton.shared.payload["c_email"] = MySingleton.shared.payemail
        MySingleton.shared.payload["pn_country_code"] = MySingleton.shared.paymobilecountrycode
        MySingleton.shared.payload["contact_number"] = MySingleton.shared.paymobile
        MySingleton.shared.payload["tc"] = "0n"
        
        if defaults.string(forKey: UserDefaultsKeys.transferjournytype) == "circle" {
            MySingleton.shared.payload["depart_flight_no"] = depflightno
            MySingleton.shared.payload["depart_terminal"] = depterminal
            MySingleton.shared.payload["depart_date"] = depdate
            MySingleton.shared.payload["depart_time"] = deptime
        }
        
        
        // Check additional conditions
        if callpaymenthotelbool == false{
            showToast(message: "Add Details")
        }else if MySingleton.shared.paycontactname == "" {
            showToast(message: "Enter Contact Name")
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
            // gotoSelectPaymentMethodsVC()
            
            
            MySingleton.shared.loderString = "fdetails"
            loderBool = true
            showLoadera()
            
            DispatchQueue.main.async {
                MySingleton.shared.transferBookingVM?.CALL_BOOKING_API(dictParam: MySingleton.shared.payload)
            }
        }
        
    }
    
    
    func bookingResponse(response: TransferBookingModel) {
        DispatchQueue.main.async {
            MySingleton.shared.transferBookingVM?.CALL_PRE_PAYMENT_CONFORMATION_API(dictParam: [:], urlstr: response.hit_url ?? "")
        }
    }
    
    func prePaymentConformationResponse(response: TransferPrePaymentConfModel) {
        hideLoadera()
        loderBool = false
        
        MySingleton.shared.PaymentSelectionArray = response.payment_selection ?? []
        
        
        
        DispatchQueue.main.async {
            self.gotoSelectPaymentMethodsVC(str: response.hit_url ?? "")
        }
    }
    
    
    
    
    func gotoSelectPaymentMethodsVC(str:String) {
        callapibool = true
        guard let vc = SelectPaymentMethodsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.transfersendtopaymenturl = str
        self.present(vc, animated: false)
    }
    
    
    func preSendtoPaymentResponse(response: TransferPrePaymentConfModel) {
        
    }
    
    
}
