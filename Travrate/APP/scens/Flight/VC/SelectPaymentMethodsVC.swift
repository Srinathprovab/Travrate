//
//  SelectPaymentMethodsVC.swift
//  Travgate
//
//  Created by FCI on 27/04/24.
//

import UIKit

class SelectPaymentMethodsVC: BaseTableVC, MobileProcessPassengerDetailVMDelegate, MobilePaymentVMDelegate {
    
    
    
    static var newInstance:  SelectPaymentMethodsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Flight.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SelectPaymentMethodsVC
        return vc
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        MySingleton.shared.passengerDetailsVM = MobileProcessPassengerDetailVM(self)
        MySingleton.shared.mobilepaymentvm = MobilePaymentVM(self)
        
    }
    
    
    func setupUI() {
        commonTableView.registerTVCells(["BookingDetailsFlightDataTVCell",
                                         "PaymentTypeTVCell",
                                         "BookedTravelDetailsTVCell",
                                         "BDTransfersInf0TVCell",
                                         "PriceSummaryTVCell",
                                         "SportInfoTVCell",
                                         "NewHotelPriceSummeryTVCell",
                                         "BookingHotelDetailsTVCell",
                                         "SportsFareSummeryTVCell",
                                         "EmptyTVCell"])
        
        
        MySingleton.shared.loderString = "fdetails"
        MySingleton.shared.afterResultsBool = true
        loderBool = true
        showLoadera()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [unowned self] in
            loderBool = false
            hideLoadera()
            
            
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
        }else{
            
        }
    }
    
    //MARK: - PaymentTypeTVCell
    override func didTapOnPayNowBtnAction(cell: PaymentTypeTVCell) {
        
        let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect)
        if tabselect == "Flight" {
            showToast(message: "Still Under Development")
        }else if tabselect == "Hotel" {
            showToast(message: "Still Under Development")
        }else if tabselect == "Sports" {
            print(MySingleton.shared.payload)
            showToast(message: "Still Under Development")
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
        
        MySingleton.shared.loderString = "payment"
        MySingleton.shared.afterResultsBool = true
        loderBool = true
        showLoadera()
        
        
        showToast(message: "Still Under Development")
        
        //  MySingleton.shared.passengerDetailsVM?.CALL_MOBILE_PROCESS_PASSENGER_DETAIL_API(dictParam:MySingleton.shared.payload)
    }
    
    //MARK: mobile process passenger Details
    func mobileprocesspassengerDetails(response: MobilePassengerdetailsModel) {
        
        DispatchQueue.main.async {
            BASE_URL = ""
            //   MySingleton.shared.mobilepaymentvm?.CALL_MOBILE_PAYMENT_API(dictParam: [:], url: response.url ?? "")
            
        }
        
    }
    
    
    
    func mobolePaymentDetails(response: PaymentModel) {
        self.gotoLoadWebViewVC(urlStr1: response.data ?? "")
    }
    
    
    func gotoLoadWebViewVC(urlStr1:String) {
        
        //        holderView.isHidden = false
        loderBool = false
        hideLoadera()
        
        
        
        guard let vc = LoadWebViewVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.urlString = urlStr1
        present(vc, animated: true)
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
        MySingleton.shared.payload["form_date"] = MySingleton.shared.convertDateFormat(inputDate: MySingleton.shared.sportFromDate, f1: "dd-MM-yyyy", f2: "dd/MM/yyy")
        MySingleton.shared.payload["to_date"] = MySingleton.shared.convertDateFormat(inputDate: MySingleton.shared.sportToDate, f1: "dd-MM-yyyy", f2: "dd/MM/yyy")
        MySingleton.shared.payload["special_events_id"] = MySingleton.shared.sportscityId
        
        gotoSelectSportsListVC()
    }
    
    
    func gotoSelectSportsListVC() {
        callapibool = true
        guard let vc = SelectSportsListVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
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
    
    
    func setupHotelTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        
        
        
        MySingleton.shared.tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.PaymentTypeTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.BookingHotelDetailsTVCell))
        MySingleton.shared.tablerow.append(TableRow(title:"Lead Passenger",
                                                    key:"hotel",
                                                    cellType:.BookedTravelDetailsTVCell))
        
        
        
        tablerow.append(TableRow(title:hbookingDetails?.name,
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
    
    
    func setupSportsTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        
        
        
        MySingleton.shared.tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.PaymentTypeTVCell))
        MySingleton.shared.tablerow.append(TableRow(key:"bookingdetails",
                                                    cellType:.SportInfoTVCell))
        MySingleton.shared.tablerow.append(TableRow(title:"Lead",
                                                    key:"sports",
                                                    cellType:.BookedTravelDetailsTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.SportsFareSummeryTVCell))
        MySingleton.shared.tablerow.append(TableRow(height: 30, cellType:.EmptyTVCell))
        
        
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
}



