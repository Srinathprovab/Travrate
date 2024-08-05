//
//  SelectPaymentMethodsVC.swift
//  Travgate
//
//  Created by FCI on 27/04/24.
//

import UIKit

class SelectPaymentMethodsVC: BaseTableVC, MobileProcessPassengerDetailVMDelegate, MobilePaymentVMDelegate, HotelBookingViewModelDelegate, SportsPaymentViewModelDelegate, TransferBookingVMDelegate, ActivitiesProcessPassengerVMDelegate, CarBookingVMDelegate {
    
    
    @IBOutlet weak var titlelbl: UILabel!
    
    static var newInstance:  SelectPaymentMethodsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Flight.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SelectPaymentMethodsVC
        return vc
    }
    
    
    var activitiesProcessPangerUrl = String()
    var carRentalsendToPaymenthiturl  = String()
    var transfersendtopaymenturl = String()
    var cardetails : Result_token?
    var appref = String()
    var responseConfirmationModel : SportsPrePaymentConfirmationModel?
    var responseHotelBookingDetials: HotelMBPModel?
    var hdvm:HotelBookingVM?
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        MySingleton.shared.passengerDetailsVM = MobileProcessPassengerDetailVM(self)
        MySingleton.shared.mobilepaymentvm = MobilePaymentVM(self)
        self.hdvm = HotelBookingVM(self)
        MySingleton.shared.SsportsPaymentvm = SportsPaymentViewModel(self)
        MySingleton.shared.transferBookingVM = TransferBookingVM(self)
        MySingleton.shared.activitiesProcessPassengerVM = ActivitiesProcessPassengerVM(self)
        MySingleton.shared.carBookingVM = CarBookingVM(self)
        
    }
    
    
    func setupUI() {
        setuplabels(lbl: titlelbl, text: "Select Payment Methods", textcolor: .BackBtnColor, font: .InterBold(size: 14), align: .center)
        
        commonTableView.registerTVCells(["BookingDetailsFlightDataTVCell",
                                         "PaymentTypeTVCell",
                                         "BookedTravelDetailsTVCell",
                                         "BDTransfersInf0TVCell",
                                         "PriceSummaryTVCell",
                                         "SportInfoTVCell",
                                         "NewHotelPriceSummeryTVCell",
                                         "BookingHotelDetailsTVCell",
                                         "SportsFareSummeryTVCell",
                                         "SelectedCarRentalTVCell",
                                         "SelectedCRPackageTVCell",
                                         "CRFareSummaryTVCell",
                                         "ActivitiesBookingDetailsTVCell",
                                         "TransferfareSummeryTVCell",
                                         "ActivitiesFareSummeryTVCell",
                                         "EmptyTVCell"])
        
        
        
        
    }
    
    
    @IBAction func didTapOnCloseBtnAction(_ sender: Any) {
        MySingleton.shared.callboolapi = true
        callapibool = true
        
        let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect)
        if tabselect == "Flight" {
            sameInputs_Again_CallSaerchAPI()
        }else if tabselect == "Hotel" {
            Same_Input_Hotel_Serach()
        }else if tabselect == "Sports" {
            Same_Saerch_InPut_Sports()
        }else if tabselect == "CarRental" {
            Same_Saerch_InPut_CarRental()
        }else if tabselect == "transfers" {
            Same_Saerch_InPut_Transfers()
        }else{
            Same_Saerch_InPut_Activities()
        }
    }
    
    
    func gotoActivitiesSearchVC() {
        guard let vc = ActivitiesSearchVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    //MARK: - PaymentTypeTVCell
    override func didTapOnPayNowBtnAction(cell: PaymentTypeTVCell) {
        
        
        let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect)
        if tabselect == "Flight" {
            callFlightSendToPaymentAPI()
        }else if tabselect == "Hotel" {
            hotelSendToPayment()
            // gotoBookingConfirmedVC()
        }else if tabselect == "Sports" {
            callSportsSendToPayment()
        }else if tabselect == "transfers" {
            callTransferSendToPaymentAPI()
            // gotoBookingConfirmedVC()
        }else if tabselect == "CarRental" {
            callCarrentalSendToPaymentAPI()
        }else if tabselect == "Activities" {
            callActivitiesSendToPayMentAPI()
        }else{
            
        }
    }
    
    
    
    
    //MARK: - MPBDetails MobilePreProcessBookingModel
    func MPBDetails(response: MobilePreProcessBookingModel) {
        
    }
    
    
    
    //MARK: - didTapOnFlightDetails BookingDetailsFlightDataTVCell
    override func didTapOnFlightDetails(cell: BookingDetailsFlightDataTVCell) {
        MySingleton.shared.callboolapi = true
        guard let vc = ViewFlightDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    
    
    //MARK: - ViewStadiumBtnsTVCell Delegate Methods
    override func didTapOnViewStadiumBtnAction(cell: SportInfoTVCell) {
        gotoViewStadiumVC(keystr: "stadium")
    }
    
    func gotoViewStadiumVC(keystr:String) {
        guard let vc = ViewStadiumVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.keystr = keystr
        self.present(vc, animated: false)
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
    
    
    
    //MARK: - didTapOnDeleteOptionsBtnAction  CRFareSummaryTVCell
    override func didTapOnDeleteOptionsBtnAction(cell: CRFareSummaryTVCell) {
        reloadPriceSummaryTVCell()
    }
    
}


//MARK: - CALL_MOBILE_PROCESS_PASSENGER_DETAIL_API
extension SelectPaymentMethodsVC {
    
    
    func setupTVCells() {
        
        MySingleton.shared.tablerow.removeAll()
        
        
        MySingleton.shared.tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.PaymentTypeTVCell))
        
        if (MySingleton.shared.mpbFlightData?.summary?.count ?? 0) > 0 {
            MySingleton.shared.tablerow.append(TableRow(cellType:.BookingDetailsFlightDataTVCell,
                                                        data1: MySingleton.shared.mpbFlightData?.summary))
            
        }
        
        
        MySingleton.shared.tablerow.append(TableRow(title:"Lead Passenger",
                                                    key:"payment",
                                                    cellType:.BookedTravelDetailsTVCell))
        
        
        MySingleton.shared.tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        MySingleton.shared.tablerow.append(TableRow(covetedAmnt: totlConvertedGrand, cellType:.PriceSummaryTVCell))
        
        
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
        
    }
    
    
    
    func CALL_MOBILE_PROCESS_PASSENGER_DETAIL_API() {
        MySingleton.shared.passengerDetailsVM?.CALL_MOBILE_PROCESS_PASSENGER_DETAIL_API(dictParam:MySingleton.shared.payload)
    }
    
    //MARK: mobile process passenger Details
    func mobileprocesspassengerDetails(response: MobilePreBookingModel) {
        
        
        DispatchQueue.main.async {
            
            MySingleton.shared.payload.removeAll()
            MySingleton.shared.payload["app_reference"] =  response.data?.app_reference ?? MySingleton.shared.tmpFlightPreBookingId
            MySingleton.shared.payload["search_id"] = response.data?.search_id ?? MySingleton.shared.searchid
            MySingleton.shared.payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
            
            MySingleton.shared.mobilepaymentvm?.CALL_MOBILE_PRE_PAYMENT_API(dictParam: MySingleton.shared.payload, url: response.data?.form_url ?? "")
            
        }
        
    }
    
    
    
    func mobolePrePaymentDetails(response: PaymentModel) {
        
        
        MySingleton.shared.PaymentSelectionArray = response.data?.payment_selection ?? []
        
        hideLoadera()
        loderBool = false
        
        DispatchQueue.main.async {[self] in
            let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect)
            if tabselect == "Flight" {
                setupTVCells()
            }else if tabselect == "Hotel" {
                setupHotelTVCells()
            }else if tabselect == "Sports" {
                setupSportsTVCells()
            }else{
                setupTransfersTVCells()
            }
        }
        
    }
    
}






extension SelectPaymentMethodsVC {
    
    func setupTransfersTVCells() {
        
        MySingleton.shared.tablerow.removeAll()
        
        
        MySingleton.shared.tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.PaymentTypeTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.BDTransfersInf0TVCell))
        
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
        
    }
    
    
    
    
    
    
    
}


extension SelectPaymentMethodsVC {
    
    //MARK: - FLIGHT
    func callFlightSendToPaymentAPI() {
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["app_reference"] =  MySingleton.shared.tmpFlightPreBookingId
        MySingleton.shared.payload["search_id"] = MySingleton.shared.searchid
        MySingleton.shared.payload["pg_type"] = MySingleton.shared.paymenttype
        
        MySingleton.shared.mobilepaymentvm?.CALL_SEND_TO_PAYMENT_API(dictParam: MySingleton.shared.payload)
    }
    
    
    func mibileSendToPaymentDetails(response: MobilePassengerdetailsModel) {
        DispatchQueue.main.async {
            MySingleton.shared.mobilepaymentvm?.CALL_FLIGHT_GET_PAYMENT_GATEWAY_URL_API(dictParam: [:], url: response.url ?? "")
        }
        
        //        DispatchQueue.main.async {
        //            MySingleton.shared.SsportsPaymentvm?.CALL_SECURE_BOOKING_API(dictParam: [:], url: response.data ?? "")
        //        }
    }
    
    
    func flightgetPaymentgatewayUrlDetails(response: getPaymentgatewayUrlModel) {
        print("====== response.data  ======")
        print(response.data)
        
        gotoLoadWebViewVC(urlStr1: response.data ?? "")
        //        DispatchQueue.main.async {
        //            MySingleton.shared.SsportsPaymentvm?.CALL_SECURE_BOOKING_API(dictParam: [:], url: response.data ?? "")
        //        }
    }
    
    
    
    func gotoLoadWebViewVC(urlStr1:String) {
        guard let vc = LoadWebViewVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.urlString = urlStr1
        present(vc, animated: true)
    }
    
    
    
    
    
}




extension SelectPaymentMethodsVC {
    
    //Hotel
    func CALL_HOTEL_MOBILE_PROCESS_PASSENGER_DETAIL_API() {
        self.hdvm?.CALL_HOTEL_PRE_MOBILE_BOOKING_API(dictParam:  MySingleton.shared.payload)
    }
    
    func hotelBookingDetails(response: HotelBookingModel) {
        
    }
    
    func hotelpreBookingDetails(response: HotelMBPModel) {
        
        responseHotelBookingDetials = response
        
        DispatchQueue.main.async {
            MySingleton.shared.payload.removeAll()
            MySingleton.shared.payload["search_id"] = response.data?.search_id
            MySingleton.shared.payload["app_reference"] = response.data?.app_reference
            MySingleton.shared.payload["booking_source"] = response.data?.booking_source
            MySingleton.shared.payload["booking_status"] = response.data?.booking_source
            
            self.hdvm?.CALL_HOTEL_PRE_PAYMENT_CONFIRMATION_API(dictParam:  MySingleton.shared.payload)
        }
    }
    
    func prePaymentConfirmationDetails(response: PaymentModel) {
        
        hideLoadera()
        loderBool = false
        
        MySingleton.shared.PaymentSelectionArray = response.data?.payment_selection ?? []
        DispatchQueue.main.async {
            self.setupHotelTVCells()
        }
    }
    
    
    
    func setupHotelTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.PaymentTypeTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.BookingHotelDetailsTVCell))
        MySingleton.shared.tablerow.append(TableRow(title:"Lead Passenger",
                                                    key:"hotel",
                                                    cellType:.BookedTravelDetailsTVCell))
        
        
        
        MySingleton.shared.tablerow.append(TableRow(title:hbookingDetails?.name,
                                                    subTitle: hbookingDetails?.address,
                                                    covetedAmnt: totlConvertedGrand, price: hoteltotalprice,
                                                    text: MySingleton.shared.convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.checkin) ?? "", f1: "yyyy-MM-dd", f2: "dd MMM yyyy"),
                                                    headerText: "\(MySingleton.shared.roompaxesdetails[0].no_of_rooms ?? 0) \(MySingleton.shared.roompaxesdetails[0].room_name ?? "")",
                                                    buttonTitle:MySingleton.shared.convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.checkout) ?? "", f1: "yyyy-MM-dd", f2: "dd MMM yyyy"),
                                                    tempText: "\(MySingleton.shared.totalnights )",
                                                    TotalQuestions: "\(MySingleton.shared.roompaxesdetails[0].no_of_adults ?? "0")",
                                                    cellType: .NewHotelPriceSummeryTVCell,
                                                    questionBase: "\(MySingleton.shared.roompaxesdetails[0].no_of_children ?? "0")"))
        
        
        MySingleton.shared.tablerow.append(TableRow(height: 30, cellType:.EmptyTVCell))
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    func hotelSendToPayment() {
        
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["search_id"] = responseHotelBookingDetials?.data?.search_id
        MySingleton.shared.payload["app_reference"] = responseHotelBookingDetials?.data?.app_reference
        MySingleton.shared.payload["booking_source"] = responseHotelBookingDetials?.data?.booking_source
        MySingleton.shared.payload["booking_status"] = responseHotelBookingDetials?.data?.booking_status
        MySingleton.shared.payload["post_token"] = htoken
        MySingleton.shared.payload["pg_type"] = MySingleton.shared.paymenttype
        
        self.hdvm?.CALL_HOTEL_SEND_TO_PAYMENNT_API(dictParam:  MySingleton.shared.payload)
        
    }
    
    
    func hotelSendToPayMentDetails(response: HotelPaymentModel) {
        DispatchQueue.main.async {
            self.hdvm?.CALL_GET_PAYMENT_GATEWAY_URL_API(dictParam: [:], url: response.data?.url ?? "")
        }
        
        //        DispatchQueue.main.async {
        //            MySingleton.shared.SsportsPaymentvm?.CALL_SECURE_BOOKING_API(dictParam: [:], url: response.data?.url ?? "")
        //        }
    }
    
    
    func getPaymentgatewayUrlDetails(response: getPaymentgatewayUrlModel) {
        print("====== response.data  ======")
        print(response.data)
        
        
        //        DispatchQueue.main.async {
        //            MySingleton.shared.SsportsPaymentvm?.CALL_SECURE_BOOKING_API(dictParam: [:], url: response.data ?? "")
        //        }
        
        gotoLoadWebViewVC(urlStr1: response.data ?? "")
    }
    
    
    
}




//MARK: - Sport CALL_SPORTS_MOBILE_PROCESS_PASSENGER_DETAIL_API
extension SelectPaymentMethodsVC {
    
    func CALL_SPORTS_MOBILE_PROCESS_PASSENGER_DETAIL_API() {
        MySingleton.shared.SsportsPaymentvm?.CALL_SPORTS_PRE_BOOKING_API(dictParam: MySingleton.shared.payload)
    }
    
    
    func sportsPreBookingDetails(response: SportsPreBookingModel) {
        
        DispatchQueue.main.async {
            MySingleton.shared.SsportsPaymentvm?.CALL_SPORTS_PAYMENT_CONFIRMATION_API(dictParam: [:], url: response.data ?? "")
        }
    }
    
    
    func sportsprepaymentDetails(response: SportsPrePaymentConfirmationModel) {
        
        hideLoadera()
        loderBool = false
        
        
        responseConfirmationModel = response
        MySingleton.shared.SportsPaymentSelectionArray = response.payment_selection ?? []
        
        DispatchQueue.main.async {
            self.setupSportsTVCells()
        }
    }
    
    
    func setupSportsTVCells() {
        
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.PaymentTypeTVCell))
        MySingleton.shared.tablerow.append(TableRow(key:"bookingdetails",
                                                    cellType:.SportInfoTVCell))
        MySingleton.shared.tablerow.append(TableRow(title:"Lead",
                                                    key:"sportspay",
                                                    cellType:.BookedTravelDetailsTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.SportsFareSummeryTVCell))
        MySingleton.shared.tablerow.append(TableRow(height: 30, cellType:.EmptyTVCell))
        
        
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    func callSportsSendToPayment() {
        
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["book_id"] = responseConfirmationModel?.book_id
        MySingleton.shared.payload["search_id"] = responseConfirmationModel?.search_id
        MySingleton.shared.payload["pg_type"] = MySingleton.shared.paymenttype
        
        
        MySingleton.shared.SsportsPaymentvm?.CALL_SEND_TO_PAYMENT_API(dictParam: MySingleton.shared.payload)
        
    }
    
    
    
    func sendtopaymentDetails(response: SportsSndtopaymentModel) {
        print("====== response.data  ======")
        print(response.data?.url)
        
        
        DispatchQueue.main.async {
            MySingleton.shared.SsportsPaymentvm?.CALL_SECURE_BOOKING_API(dictParam: [:], url: response.data?.url ?? "")
        }
    }
    
    
    func secureBookingDetails(response: sportssecureBooingModel) {
        MySingleton.shared.voucherurlsting = response.hit_url ?? ""
        
        DispatchQueue.main.async {
            self.gotoBookingSucessVC()
        }
    }
    
    
    
    
    
    
    
}




//MARK: - sameInputs_Again_CallSaerchAPI
extension SelectPaymentMethodsVC {
    
    //MARK: - Flights
    func sameInputs_Again_CallSaerchAPI() {
        
        MySingleton.shared.payload.removeAll()
        
        
        
        MySingleton.shared.payload["trip_type"] = defaults.string(forKey: UserDefaultsKeys.journeyType)
        MySingleton.shared.payload["adult"] = defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1"
        MySingleton.shared.payload["child"] = defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0"
        MySingleton.shared.payload["infant"] = defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0"
        MySingleton.shared.payload["from"] = defaults.string(forKey: UserDefaultsKeys.fromCity)
        MySingleton.shared.payload["from_loc_id"] = defaults.string(forKey: UserDefaultsKeys.fromlocid)
        MySingleton.shared.payload["to"] = defaults.string(forKey: UserDefaultsKeys.toCity)
        MySingleton.shared.payload["to_loc_id"] = defaults.string(forKey: UserDefaultsKeys.tolocid)
        MySingleton.shared.payload["depature"] = MySingleton.shared.convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "", f1: "dd-MM-yyyy", f2: "dd/MM/yyyy")
        MySingleton.shared.payload["out_jrn"] = "All Times"
        MySingleton.shared.payload["ret_jrn"] = "All Times"
        MySingleton.shared.payload["direct_flight"] = MySingleton.shared.directflightString
        MySingleton.shared.payload["carrier"] = ""
        MySingleton.shared.payload["psscarrier"] = defaults.string(forKey: UserDefaultsKeys.fcariercode) ?? "ALL"
        MySingleton.shared.payload["search_flight"] = "Search"
        MySingleton.shared.payload["search_source"] = "Mobile_IOS"
        MySingleton.shared.payload["currency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency)
        MySingleton.shared.payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        
        
        if defaults.string(forKey: UserDefaultsKeys.journeyType) == "oneway" {
            
            MySingleton.shared.payload["v_class"] = defaults.string(forKey: UserDefaultsKeys.selectClass)
            MySingleton.shared.payload["return"] = ""
            
            if defaults.string(forKey: UserDefaultsKeys.fromCity) == nil {
                showToast(message: "Enter From City")
            }else if defaults.string(forKey: UserDefaultsKeys.toCity) == nil {
                showToast(message: "Enter To City")
            }else if defaults.string(forKey: UserDefaultsKeys.calDepDate) == "Add Date" || defaults.string(forKey: UserDefaultsKeys.calDepDate) == nil {
                showToast(message: "Add Departure Date")
            }else {
                gotoFlightResultVC()
            }
            
        }else {
            MySingleton.shared.payload["v_class"] = defaults.string(forKey: UserDefaultsKeys.selectClass)
            // MySingleton.shared.payload["v_class"] = defaults.string(forKey: UserDefaultsKeys.selectClass)
            MySingleton.shared.payload["return"] = MySingleton.shared.convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.calRetDate) ?? "", f1: "dd-MM-yyyy", f2: "dd/MM/yyyy")
            
            if defaults.string(forKey: UserDefaultsKeys.fromCity) == nil {
                showToast(message: "Enter From City")
            }else if defaults.string(forKey: UserDefaultsKeys.toCity) == nil {
                showToast(message: "Enter To City")
            }else if defaults.string(forKey: UserDefaultsKeys.calDepDate) == "Add Date" || defaults.string(forKey: UserDefaultsKeys.calDepDate) == nil {
                showToast(message: "Add Departure Date")
            }else if defaults.string(forKey: UserDefaultsKeys.calRetDate) == "Add Date" || defaults.string(forKey: UserDefaultsKeys.calRetDate) == nil {
                showToast(message: "Add Return Date")
            }else {
                gotoFlightResultVC()
            }
            
            
        }
        
        
        func gotoFlightResultVC() {
            MySingleton.shared.callboolapi = true
            MySingleton.shared.afterResultsBool = false
            defaults.set(false, forKey: "flightfilteronce")
            guard let vc = FlightResultVC.newInstance.self else {return}
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
        
    }
    
    
    
    //MARK: - Same_Input_Hotel_Serach
    func Same_Input_Hotel_Serach() {
        
        NotificationCenter.default.post(name: NSNotification.Name("resetallFilters"), object: nil)
        MySingleton.shared.payload.removeAll()
        
        MySingleton.shared.payload["city"] = defaults.string(forKey: UserDefaultsKeys.locationcity)
        MySingleton.shared.payload["hotel_destination"] = defaults.string(forKey: UserDefaultsKeys.locationid)
        
        MySingleton.shared.payload["hotel_checkin"] = MySingleton.shared.convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.checkin) ?? "", f1: "dd-MM-yyyy", f2: "dd/MM/yyyy")
        MySingleton.shared.payload["hotel_checkout"] = MySingleton.shared.convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.checkout) ?? "", f1: "dd-MM-yyyy", f2: "dd/MM/yyyy")
        
        MySingleton.shared.payload["rooms"] = "\(defaults.string(forKey: UserDefaultsKeys.roomcount) ?? "1")"
        MySingleton.shared.payload["adult"] = adtArray
        MySingleton.shared.payload["child"] = chArray
        
        
        if starRatingInputArray.count > 0 {
            MySingleton.shared.payload["star_rating"] = starRatingInputArray
        }
        
        
        if defaults.string(forKey: UserDefaultsKeys.hotelchildcount) == "0" {
            
            MySingleton.shared.payload["childAge_1"] = [""]
            
        }else {
            
            for roomIndex in 0..<totalRooms {
                if let numChildren = Int(chArray[roomIndex]), numChildren > 0 {
                    var childAges: [String] = Array(repeating: "0", count: numChildren)
                    
                    if numChildren > 2 {
                        childAges.append("0")
                    }
                    
                    MySingleton.shared.payload["childAge_\(roomIndex + 1)"] = childAges
                }
            }
            
        }
        
        
        
        
        MySingleton.shared.payload["nationality"] = defaults.string(forKey: UserDefaultsKeys.hnationalitycode)
        
        if defaults.string(forKey: UserDefaultsKeys.locationcity) == "Add City" || defaults.string(forKey: UserDefaultsKeys.locationcity) == nil{
            showToast(message: "Enter Hotel or City ")
        }else if defaults.string(forKey: UserDefaultsKeys.checkin) == "Add Check In Date" || defaults.string(forKey: UserDefaultsKeys.checkin) == nil{
            showToast(message: "Enter Checkin Date")
        }else if defaults.string(forKey: UserDefaultsKeys.checkout) == "Add Check Out Date" || defaults.string(forKey: UserDefaultsKeys.checkout) == nil{
            showToast(message: "Enter Checkout Date")
        }
        else if defaults.string(forKey: UserDefaultsKeys.checkout) == defaults.string(forKey: UserDefaultsKeys.checkin) {
            showToast(message: "Enter Different Dates")
        }
        //        else if  let checkinDate = defaults.string(forKey: UserDefaultsKeys.checkin),
        //                  let checkoutDate = defaults.string(forKey: UserDefaultsKeys.checkout),
        //                  let checkin = formatter.date(from: checkinDate),
        //                  let checkout = formatter.date(from: checkoutDate),
        //                  checkin > checkout {
        //            showToast(message: "Invalid Date")
        //        }
        
        else if defaults.string(forKey: UserDefaultsKeys.roomcount) == "" {
            showToast(message: "Add Rooms For Booking")
        }else if defaults.string(forKey: UserDefaultsKeys.hnationalitycode) == nil {
            showToast(message: "Please Select Nationality.")
        }else {
            
            
            do{
                
                let jsonData = try JSONSerialization.data(withJSONObject: MySingleton.shared.payload, options: JSONSerialization.WritingOptions.prettyPrinted)
                let jsonStringData =  NSString(data: jsonData as Data, encoding: NSUTF8StringEncoding)! as String
                
                print(jsonStringData)
                
                
            }catch{
                print(error.localizedDescription)
            }
            
            gotoHotelResultVC()
            
        }
    }
    
    
    func gotoHotelResultVC() {
        
        MySingleton.shared.loderString = "loder"
        MySingleton.shared.afterResultsBool = false
        hotelSearchResult.removeAll()
        loderBool = true
        callapibool = true
        defaults.set(false, forKey: "hoteltfilteronce")
        guard let vc = SearchHotelsResultVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        //   vc.countrycode = self.countrycode
        vc.payload =  MySingleton.shared.payload
        present(vc, animated: true)
    }
    
    
    
    //MARK: - For Sports
    func Same_Saerch_InPut_Sports() {
        
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["from"] = ""
        MySingleton.shared.payload["destination_id"] = ""
        MySingleton.shared.payload["from_type"] = ""
        MySingleton.shared.payload["to"] = ""
        MySingleton.shared.payload["event_id"] = ""
        MySingleton.shared.payload["venue_type"] = ""
        MySingleton.shared.payload["form_date"] = MySingleton.shared.convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.sportcalDepDate) ?? "", f1: "dd-MM-yyyy", f2: "dd/MM/yyy")
        MySingleton.shared.payload["to_date"] = MySingleton.shared.convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.sportcalRetDate) ?? "", f1: "dd-MM-yyyy", f2: "dd/MM/yyy")
        MySingleton.shared.payload["special_events_id"] = MySingleton.shared.sportsservicId
        
        gotoSelectSportsListVC()
    }
    
    
    func gotoSelectSportsListVC() {
        callapibool = true
        guard let vc = SelectSportsListVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    
    //MARK: - For Sports
    func Same_Saerch_InPut_CarRental() {
        
        guard let pickuplocationname =  defaults.string(forKey: UserDefaultsKeys.pickuplocationname) else {return}
        guard let pickuplocationcode =  defaults.string(forKey: UserDefaultsKeys.pickuplocationcode) else {return}
        guard let pickuplocDate =  defaults.string(forKey: UserDefaultsKeys.pickuplocDate) else {return}
        guard let dropuplocDate =  defaults.string(forKey: UserDefaultsKeys.dropuplocDate) else {return}
        guard let pickuplocTime =  defaults.string(forKey: UserDefaultsKeys.pickuplocTime) else {return}
        guard let dropuplocTime =  defaults.string(forKey: UserDefaultsKeys.dropuplocTime) else {return}
        guard let driverage =  defaults.string(forKey: UserDefaultsKeys.driverage) else {return}
        
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
    
    
    func gotoCarRentalResultsVC() {
        MySingleton.shared.callboolapi = true
        defaults.set(false, forKey: "carfilteronce")
        guard let vc = CarRentalResultsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    
    //MARK: - Same_Saerch_InPut_Transfers
    func Same_Saerch_InPut_Transfers() {
        
        
        
        let journytype =  defaults.string(forKey: UserDefaultsKeys.transferjournytype)
        let fromcity =  defaults.string(forKey: UserDefaultsKeys.transferfromcityname)
        let fromcityid =  defaults.string(forKey: UserDefaultsKeys.transferfromcityid)
        let tocity =  defaults.string(forKey: UserDefaultsKeys.transfertocityname)
        let tocityid =  defaults.string(forKey: UserDefaultsKeys.transfertocityid)
        let fromdate =  defaults.string(forKey: UserDefaultsKeys.transfercalDepDate)
        let fromtime =  defaults.string(forKey: UserDefaultsKeys.transfercalDepTime)
        let todate =  defaults.string(forKey: UserDefaultsKeys.transfercalRetDate)
        let totime =  defaults.string(forKey: UserDefaultsKeys.transfercalRetTime)
        let fromlatitude =  defaults.string(forKey: UserDefaultsKeys.transferfromlat)
        let fromlongitude =  defaults.string(forKey: UserDefaultsKeys.transferfromlang)
        let tolatitude =  defaults.string(forKey: UserDefaultsKeys.transfertolat)
        let tolongitude =  defaults.string(forKey: UserDefaultsKeys.transfertolang)
        
        
        
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["transfer_type"] = journytype
        MySingleton.shared.payload["transfer_from"] = fromcity
        MySingleton.shared.payload["from_loc_id"] = fromcityid
        MySingleton.shared.payload["from_lat"] = fromlatitude
        MySingleton.shared.payload["from_lng"] = fromlongitude
        MySingleton.shared.payload["transfer_to"] = tocity
        MySingleton.shared.payload["to_loc_id"] = tocityid
        MySingleton.shared.payload["to_lat"] = tolatitude
        MySingleton.shared.payload["to_lng"] = tolongitude
        MySingleton.shared.payload["departure_date"] = fromdate
        MySingleton.shared.payload["depart_time"] = fromtime
        
        
        if journytype == "oneway" {
            
            MySingleton.shared.payload["return_date"] = ""
            MySingleton.shared.payload["return_time"] = ""
            
            if fromcity == "From Airport" {
                showToast(message: "Select From Airtport")
            }else if tocity == "To Airport" {
                showToast(message: "Select To Airtport")
            }else if fromdate == "Select Date" {
                showToast(message: "Select Date")
            }else if fromtime == "Select Time" {
                showToast(message: "Select Time")
            }else {
                gotoTransfersListVC()
            }
        }else {
            
            MySingleton.shared.payload["return_date"] = todate
            MySingleton.shared.payload["return_time"] = totime
            
            
            if fromcity == "From Airport" {
                showToast(message: "Select From Airtport")
            }else if tocity == "To Airport" {
                showToast(message: "Select To Airtport")
            }else if fromdate == "Select Date" {
                showToast(message: "Select Date")
            }else if fromtime == "Select Time" {
                showToast(message: "Select Time")
            }else if todate == "Select Date" {
                showToast(message: "Select Date")
            }else if totime == "Select Time" {
                showToast(message: "Select Time")
            }else {
                gotoTransfersListVC()
            }
            
            
        }
        
    }
    
    
    
    
    
    func gotoTransfersListVC() {
        defaults.set(false, forKey: "transferfilteronce")
        callapibool = true
        guard let vc = TransfersListVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    //MARK: - ACTIVITIES Same_Saerch_InPut_Activities
    
    func Same_Saerch_InPut_Activities() {
        
        
        let cityid = defaults.string(forKey: UserDefaultsKeys.activitescityid)
        let cityname = defaults.string(forKey: UserDefaultsKeys.activitescityname)
        let fromdate = defaults.string(forKey: UserDefaultsKeys.calActivitesDepDate)
        let todate = defaults.string(forKey: UserDefaultsKeys.calActivitesRetDate)
        let adultcount = defaults.string(forKey: UserDefaultsKeys.activitesadultCount) ?? "1"
        let childcount = defaults.string(forKey: UserDefaultsKeys.activiteschildCount) ?? "0"
        let infantcount = defaults.string(forKey: UserDefaultsKeys.activitesinfantsCount) ?? "0"
        
        
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["activity_destination"] = cityname
        MySingleton.shared.payload["activity_destination_id"] = cityid
        MySingleton.shared.payload["from_date"] = fromdate
        MySingleton.shared.payload["to_date"] = todate
        MySingleton.shared.payload["adult"] = adultcount
        MySingleton.shared.payload["child"] = childcount
        MySingleton.shared.payload["infant"] = infantcount
        
        gotoActivitiesSearchResultsVC()
        
        
    }
    
    func gotoActivitiesSearchResultsVC() {
        MySingleton.shared.afterResultsBool = false
        MySingleton.shared.callboolapi = true
        defaults.set(false, forKey: "activitesfilteronce")
        guard let vc = ActivitiesSearchResultsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
}


//MARK: -CAR RENTAL

extension SelectPaymentMethodsVC {
    
    
    func callcarBookingAPI() {
        MySingleton.shared.carBookingVM?.CALL_CAR_BOOKING_API(dictParam: MySingleton.shared.payload)
    }
    
    
    func carBookingdetails(response: CarSecureBookingMode) {
        DispatchQueue.main.async {
            MySingleton.shared.carBookingVM?.CALL_CAR_PRE_PAYMENT_BOOKING_API(dictParam: [:], urlstr: response.hit_url ?? "")
        }
    }
    
    
    func carPrePaymentDetails(response: carPrePaymrntConfirmationModel) {
        
        loderBool = false
        hideLoadera()
        
        MySingleton.shared.PaymentSelectionArray = response.payment_selection ?? []
        appref = response.data?.app_reference ?? ""
        carRentalsendToPaymenthiturl = "\(BASE_URL)car/send_to_payment/\(response.data?.app_reference ?? "")/\(response.data?.search_id ?? "")"
        totlConvertedGrand = Double(response.data?.total_amount ?? "") ?? 0.0
        
        DispatchQueue.main.async {
            self.setupCarRentalTVCells()
        }
        
    }
    
    
    func setupCarRentalTVCells() {
        
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.PaymentTypeTVCell))
        MySingleton.shared.tablerow.append(TableRow(title:"",moreData: cardetails,cellType:.SelectedCarRentalTVCell))
        
        MySingleton.shared.carproductarray.forEach { i in
            MySingleton.shared.tablerow.append(TableRow(key:"bookingdetails",
                                                        moreData: i,
                                                        cellType:.SelectedCRPackageTVCell))
        }
        
        MySingleton.shared.tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        
        MySingleton.shared.carproductarray.forEach { i in
            MySingleton.shared.tablerow.append(TableRow(key:"selectpayment",moreData: i,cellType:.CRFareSummaryTVCell))
        }
        
        
        MySingleton.shared.tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
        
    }
    
    
    
    
    func callCarrentalSendToPaymentAPI() {
        
        MySingleton.shared.loderString = "payment"
        loderBool = true
        showLoadera()
        
        
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["knet_pg"] = MySingleton.shared.paymenttype
        MySingleton.shared.payload["selected_option"] = MySingleton.shared.carselectedoption
        MySingleton.shared.payload["extra_option_price"] = MySingleton.shared.car_extra_option_price
        
        
        MySingleton.shared.carBookingVM?.CALL_CAR_SEND_TO_PAYMENT_API(dictParam: MySingleton.shared.payload, urlstr: self.carRentalsendToPaymenthiturl)
        
        
    }
    
    
    func carSendtoPaymentDetails(response: CarSecureBookingMode) {
        
        
        //  let hit_url = "https://provab.net/travrate/android_ios_webservices/mobile/index.php/car/secure_booking/\(appref)"
        
        DispatchQueue.main.async {
            MySingleton.shared.carBookingVM?.CALL_CAR_SECURE_BOOKING_API(dictParam: [:], urlstr: response.hit_url ?? "")
        }
        
        
    }
    
    
    func carSecureBookingDetails(response: CarSecureBookingMode) {
        print("=== response.hit_url  ====")
        print(response.hit_url ?? "")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {[self] in
            loderBool = false
            hideLoadera()
            
            MySingleton.shared.voucherurlsting = response.hit_url ?? ""
            response.status == true ?  gotoBookingConfirmedVC() : showToast(message: response.message ?? "")
        }
        
    }
    
    
    
    //MARK: - gotoBookingSucessVC
    func gotoBookingSucessVC() {
        
        hideLoadera()
        loderBool = false
        
        MySingleton.shared.callboolapi = true
        guard let vc = BookingSucessVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    func gotoBookingConfirmedVC() {
        callapibool = true
        guard let vc = BookingConfirmedVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
}




extension SelectPaymentMethodsVC {
    
    
    func setupTransferTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.PaymentTypeTVCell))
        
        
        MySingleton.shared.tablerow.append(TableRow(moreData:transfer_data,cellType:.BDTransfersInf0TVCell))
        
        
        
        MySingleton.shared.tablerow.append(TableRow(title:"Lead",
                                                    key:"transfer",
                                                    cellType:.BookedTravelDetailsTVCell))
        
        MySingleton.shared.tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.TransferfareSummeryTVCell))
        MySingleton.shared.tablerow.append(TableRow(height:5,cellType:.EmptyTVCell))
        
        
        MySingleton.shared.tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
        
    }
    
    
    
    
    func calltransferBookingAPI() {
        DispatchQueue.main.async {
            MySingleton.shared.transferBookingVM?.CALL_BOOKING_API(dictParam: MySingleton.shared.payload)
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
        transfersendtopaymenturl = response.hit_url ?? ""
        
        
        
        DispatchQueue.main.async {
            self.setupTransferTVCells()
        }
        
    }
    
    
    func callTransferSendToPaymentAPI() {
        
        MySingleton.shared.loderString = "payment"
        MySingleton.shared.afterResultsBool = true
        loderBool = true
        showLoadera()
        
        
        
        DispatchQueue.main.async {[self] in
            MySingleton.shared.transferBookingVM?.CALL_PRE_SENDTO_PAYMENT__API(dictParam: [:], urlstr: transfersendtopaymenturl)
        }
    }
    
    
    func preSendtoPaymentResponse(response: TransferPrePaymentConfModel) {
        MySingleton.shared.transferBookingVM?.CALL_TRANSFERS_SECURE_BOOKING_API(dictParam: [:], urlstr: response.hit_url ?? "")
    }
    
    func transfersSecurebookingDetails(response: SendToPaymentModel) {
        print("=== response.hit_url  ====")
        print(response.hit_url ?? "")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {[self] in
            loderBool = false
            hideLoadera()
            
            MySingleton.shared.voucherurlsting = response.hit_url ?? ""
            
            
            
            response.status == true ?  gotoBookingConfirmedVC() : showToast(message: response.msg ?? "")
        }
        
    }
    
    
}



//MARK: - ACTIVITIES
extension SelectPaymentMethodsVC {
    
    
    func CALL_ACTIVITIES_PROCESS_PASSENGER_DETAILS_API() {
        MySingleton.shared.activitiesProcessPassengerVM?.CALL_PROCESS_PASSENGER_DETAILS_BOOKING_API(dictParam: MySingleton.shared.payload, urlstr: self.activitiesProcessPangerUrl)
    }
    
    func processPassengerDetailsResponse(response: sportssecureBooingModel) {
        
        loderBool = false
        hideLoadera()
        
        
        activitiesProcessPangerUrl = response.hit_url ?? ""
        MySingleton.shared.getPaymentList()
        
        DispatchQueue.main.async {
            self.setupActivitiesTVCells()
        }
    }
    
    
    
    func setupActivitiesTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        
        
        MySingleton.shared.tablerow.append(TableRow(key:"activites",cellType:.PaymentTypeTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.ActivitiesBookingDetailsTVCell))
        MySingleton.shared.tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        
        
        
        
        MySingleton.shared.tablerow.append(TableRow(title:"Lead",
                                                    key:"activites",
                                                    cellType:.BookedTravelDetailsTVCell))
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.ActivitiesFareSummeryTVCell))
        MySingleton.shared.tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
        
    }
    
    
    func callActivitiesSendToPayMentAPI() {
        
        MySingleton.shared.loderString = "payment"
        MySingleton.shared.afterResultsBool = true
        loderBool = true
        showLoadera()
        
        
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["pg_type"] = MySingleton.shared.paymenttype
        MySingleton.shared.activitiesProcessPassengerVM?.CALL_SEND_TO_PAYMENT_API(dictParam: MySingleton.shared.payload, urlstr: self.activitiesProcessPangerUrl)
    }
    
    
    
    func activitieSendToPaymeentDetailsResponse(response: SendToPaymentModel) {
        DispatchQueue.main.async {
            MySingleton.shared.activitiesProcessPassengerVM?.CALL_ACTIVITIES_SECURE_BOOKING_API(dictParam: [:], urlstr: response.hit_url ?? "")
        }
    }
    
    func activitiesSecureBookingDetails(response: SendToPaymentModel) {
        
        loderBool = false
        hideLoadera()
        
        MySingleton.shared.voucherurlsting = response.hit_url ?? ""
        
        if response.status == true  {
            gotoBookingConfirmedVC()
        }else {
            showToast(message: response.msg ?? "")
        }
    }
    
    
}


//MARK: - addObserver
extension SelectPaymentMethodsVC {
    
    func addObserver() {
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(nointrnetreload), name: Notification.Name("nointrnetreload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        
        
        if callapibool == true || MySingleton.shared.callboolapi == true {
            callAPI()
        }
        
        
    }
    
    
    
    func callAPI() {
        
        
        MySingleton.shared.loderString = "fdetails"
        loderBool = true
        showLoadera()
        
        let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect)
        if tabselect == "Flight" {
            DispatchQueue.main.async {
                self.CALL_MOBILE_PROCESS_PASSENGER_DETAIL_API()
            }
            
        }else if tabselect == "Sports"{
            DispatchQueue.main.async {
                self.CALL_SPORTS_MOBILE_PROCESS_PASSENGER_DETAIL_API()
            }
        }else if tabselect == "CarRental"{
            
            
            DispatchQueue.main.async {[self] in
                // self.setupCarRentalTVCells()
                self.callcarBookingAPI()
            }
            
            
        }else if tabselect == "Activities"{
            
            DispatchQueue.main.async {[self] in
                self.CALL_ACTIVITIES_PROCESS_PASSENGER_DETAILS_API()
            }
            
            
        }else if tabselect == "transfers"{
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {[self] in
                self.calltransferBookingAPI()
            }
            
        }else {
            DispatchQueue.main.async {
                self.CALL_HOTEL_MOBILE_PROCESS_PASSENGER_DETAIL_API()
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
