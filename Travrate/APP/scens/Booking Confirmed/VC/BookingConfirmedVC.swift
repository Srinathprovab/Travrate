//
//  BookingConfirmedVC.swift
//  BabSafar
//
//  Created by MA673 on 26/07/22.
//

import UIKit
//import FreshchatSDK

class BookingConfirmedVC: BaseTableVC, VocherDetailsViewModelDelegate {
    
    
    static var newInstance: BookingConfirmedVC? {
        let storyboard = UIStoryboard(name: Storyboard.Calender.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? BookingConfirmedVC
        return vc
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
    }
    
    
    func callAPI() {
        BASE_URL = ""
        MySingleton.shared.afterResultsBool = true
        MySingleton.shared.loderString = "payment"
        
        loderBool = true
        showLoadera()
        
        let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect)
        if tabselect == "Flight" {
            callGetFlightVoucherAPI()
        }else if tabselect == "Hotel" {
            callGetHotelVoucherAPI()
        }else if tabselect == "transfers" {
            callGetTransfersVoucherAPI()
        }else if tabselect == "Sports" {
            callGetSportsVoucherAPI()
        }else if tabselect == "CarRental" {
            callGetCarRentalVoucherAPI()
        }else if tabselect == "Activities" {
            callGetActivitesVoucherAPI()
        }else {
            
        }
        
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        viewModel = VocherDetailsViewModel(self)
        
    }
    
    func setupUI() {
        
        
        commonTableView.registerTVCells(["ImportentInfoTableViewCell",
                                         "NewBookingConfirmedTVCell",
                                         "HeaderTableViewCell",
                                         "EmptyTVCell",
                                         "LabelTVCell",
                                         "ButtonTVCell",
                                         "SportInfoTVCell",
                                         "BCFlightDetailsTVCell",
                                         "CarRentalResultTVCell",
                                         "PickupTVCell",
                                         "TitleLblTVCell",
                                         "BookingHotelDetailsTVCell",
                                         "BDTransfersInf0TVCell",
                                         "ActivityInformationTVCell",
                                         "FlightBookingConfirmedTVCell",
                                         "ActivitiesBookingDetailsTVCell",
                                         "BookedTravelDetailsTVCell"])
        
    }
    
    
    //MARK: - didTapOnViewVoucherBtnAction
    override func didTapOnViewVoucherBtnAction(cell:BCFlightDetailsTVCell){
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.gotoLoadWebViewVC(str: vocherpdf, keystr: "voucher")
        }
    }
    
    
    //MARK: - didTapOnBackBtnAction
    override func didTapOnBackBtnAction(cell: NewBookingConfirmedTVCell) {
        BASE_URL = BASE_URL1
        callapibool = true
        MySingleton.shared.callboolapi = true
        guard let vc = DashBoardTBVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.selectedIndex = 0
        present(vc, animated: true)
    }
    
    
    
    func gotoLoadWebViewVC(str:String,keystr:String) {
        guard let vc = LoadWebViewVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.urlString = str
        vc.keystr = keystr
        present(vc, animated: true)
    }
    
    
    //MARK: - HeaderTableViewCell Delegate Methodes
    override func didTapOnFacebookLinkBtnAction(cell: HeaderTableViewCell) {
        gotoLoadWebViewVC(str: social_linksArray[0].url_link ?? "", keystr: "link")
    }
    
    override func didTapOnTwitterLinkBtnAction(cell: HeaderTableViewCell) {
        gotoLoadWebViewVC(str: social_linksArray[1].url_link ?? "", keystr: "link")
    }
    
    override func didTapOnLinkedlnLinkBtnAction(cell: HeaderTableViewCell) {
        gotoLoadWebViewVC(str: social_linksArray[2].url_link ?? "", keystr: "link")
    }
    
    override func didTapOnInstagramLinkBtnAction(cell: HeaderTableViewCell) {
        gotoLoadWebViewVC(str: social_linksArray[4].url_link ?? "", keystr: "link")
    }
    
    
    override func didTapOnYoutubeBtnAction(cell:HeaderTableViewCell){
        gotoLoadWebViewVC(str: social_linksArray[3].url_link ?? "", keystr: "link")
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
    
    
    //MARK: -didTapOnBackBtnAction FlightBookingConfirmedTVCell
    override func didTapOnBackBtnAction(cell: FlightBookingConfirmedTVCell) {
        BASE_URL = BASE_URL1
        callapibool = true
        MySingleton.shared.callboolapi = true
        guard let vc = DashBoardTBVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.selectedIndex = 0
        present(vc, animated: true)
    }
}


//MARK: - Flight Voucher Deatails
extension BookingConfirmedVC {
    func callGetFlightVoucherAPI() {
        viewModel?.Call_Get_voucher_Details_API(dictParam: [:], url: MySingleton.shared.voucherurlsting)
    }
    
    
    
    func vocherdetails(response: VocherModel) {
        BASE_URL = BASE_URL1
        loderBool = false
        self.hideLoadera()
        
        
        MySingleton.shared.bookedbaggageDetails = response.data?.flight_details?.summary ?? []
        social_linksArray = response.data?.social_links ?? []
        bottom_text_info = response.data?.bottom_text_info ?? []
        vocherpdf = response.data?.voucher_pdf ?? ""
        bookedjurnycitys = "\(response.data?.booking_details?[0].journey_from ?? "")-\(response.data?.booking_details?[0].journey_to ?? "")"
        
        response.data?.booking_details?.forEach({ i in
            bookedDate = i.booked_date ?? ""
            bookingsource = i.booking_source ?? ""
            bookingId = i.booked_by_id ?? ""
            pnrNo = i.pnr ?? ""
            
        })
        
        response.data?.booking_details?.forEach({ j in
            bookingitinerarydetails = j.booking_itinerary_summary ?? []
            Customerdetails = j.customer_details ?? []
            
            
            j.booking_transaction_details?.forEach({ i in
                
                bookingRefrence = i.app_reference ?? ""
                bookingStatus = i.status ?? ""
                
                DispatchQueue.main.async {
                    self.setupTV(bd: response.data?.booking_details ?? [], info: response.cancelltion_policy ?? "")
                }
                
            })
        })
        
    }
    
    
    func setupTV(bd:[Booking_details],info:String) {
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:bookingId,
                                 subTitle: bookingRefrence,
                                 key: "flight",
                                 buttonTitle: bookedDate,
                                 moreData: bd,
                                 tempText: pnrNo,
                                 cellType:.FlightBookingConfirmedTVCell))
        
        
        
        tablerow.append(TableRow(title:"\(bookedjurnycitys)",key: "bc",cellType:.LabelTVCell))
        tablerow.append(TableRow(moreData: bookingitinerarydetails,cellType:.BCFlightDetailsTVCell))
        tablerow.append(TableRow(title:"Passenger Details",key: "bc",cellType:.LabelTVCell))
        tablerow.append(TableRow(title:"Lead",key:"BC",moreData:Customerdetails,cellType:.BookedTravelDetailsTVCell))
        tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Important Information",key: "bc",cellType:.LabelTVCell))
        tablerow.append(TableRow(cellType:.ImportentInfoTableViewCell))
        tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:info,cellType:.HeaderTableViewCell))
        tablerow.append(TableRow(height:60,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
}


//MARK: - Hotel Voucher Details
extension BookingConfirmedVC {
    
    
    func callGetHotelVoucherAPI() {
        viewModel?.CALL_HOTEL_VOUCHER_DETAILS_api(dictParam: [:], url: MySingleton.shared.voucherurlsting)
    }
    
    
    func hotelVoucherDetails(response: HotelVoucherModel) {
        
        BASE_URL = BASE_URL1
        loderBool = false
        self.hideLoadera()
        
        
        
        response.data?.booking_details?.forEach({ i in
            bookedDate = i.voucher_date ?? ""
            bookingsource = i.booking_source ?? ""
            bookingId = i.booking_id ?? ""
            pnrNo = "pnr"
            
        })
        
        response.data?.booking_details?.forEach({ j in
            
            hotelbookingdetails = j
            hotelCustomerdetails = j.customer_details ?? []
            
            
            j.itinerary_details?.forEach({ i in
                
                
                bookingRefrence = i.app_reference ?? ""
                bookingStatus = i.status ?? ""
                
            })
        })
        
        
        
        DispatchQueue.main.async {
            self.setupHotelTVCells()
        }
        
    }
    
    
    
    func setupHotelTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        MySingleton.shared.tablerow.append(TableRow(title:bookingId,
                                                    subTitle: bookingRefrence,
                                                    key: "sports",
                                                    buttonTitle: bookedDate,
                                                    tempText: pnrNo,
                                                    cellType:.NewBookingConfirmedTVCell))
        
        MySingleton.shared.tablerow.append(TableRow(key:"bc",cellType:.BookingHotelDetailsTVCell))
        MySingleton.shared.tablerow.append(TableRow(title:"Lead",
                                                    key:"hotel",
                                                    cellType:.BookedTravelDetailsTVCell))
        
        
        
        
        MySingleton.shared.tablerow.append(TableRow(height: 30, cellType:.EmptyTVCell))
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
}






//MARK: - Sports Voucher Details
extension BookingConfirmedVC {
    
    func callGetSportsVoucherAPI() {
        viewModel?.CALL_GET_SPORTS_VOUCHER_DETAILS_API(dictParam: [:], url: MySingleton.shared.voucherurlsting)
    }
    
    func sportsvoucherDetails(response: SportsVoucherModel) {
        
        hideLoadera()
        loderBool = false
        
        MySingleton.shared.sportvoucherEventList = response.data?.event_list_data
        MySingleton.shared.sports_passengers = response.sports_passengers ?? []
        bookingId = response.data?.app_reference ?? ""
        bookingRefrence =  response.data?.book_id ?? ""
        bookedDate = response.data?.dateOfEvent ?? ""
        MySingleton.shared.sport_mapUrl = response.data?.event_list_data?.venue?.mapUrl ?? ""
        
        
        pnrNo = ""
        
        //        MySingleton.shared.sportsBookingData = response.data
        //        MySingleton.shared.sportEventList = response.data?.event_list_data
        //        MySingleton.shared.sportTicketValue = response.data?.ticket_value
        
        DispatchQueue.main.async {
            self.setupSportsTVCells()
        }
    }
    
    
    func setupSportsTVCells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:bookingId,
                                 subTitle: bookingRefrence,
                                 key: "sports",
                                 buttonTitle: bookedDate,
                                 tempText: pnrNo,
                                 cellType:.NewBookingConfirmedTVCell))
        
        tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        
        tablerow.append(TableRow(key:"bc",
                                 cellType:.SportInfoTVCell))
        
        tablerow.append(TableRow(title:"",key:"sports",cellType:.BookedTravelDetailsTVCell))
        
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
        
    }
    
    
    
}




//MARK: - Transfers Voucher Details
extension BookingConfirmedVC {
    
    
    func callGetTransfersVoucherAPI() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            loderBool = false
            self.hideLoadera()
            self.setupTransferTVCells()
        }
        
    }
    
    
    
    
    func setupTransferTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        MySingleton.shared.tablerow.append(TableRow(title:bookingId,
                                                    subTitle: bookingRefrence,
                                                    key: "transfer",
                                                    buttonTitle: bookedDate,
                                                    tempText: pnrNo,
                                                    cellType:.NewBookingConfirmedTVCell))
        
        MySingleton.shared.tablerow.append(TableRow(moreData:transfer_data,cellType:.BDTransfersInf0TVCell))
        
        
        
        MySingleton.shared.tablerow.append(TableRow(title:"Lead",
                                                    key:"transfer",
                                                    cellType:.BookedTravelDetailsTVCell))
        
        MySingleton.shared.tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        
        
        MySingleton.shared.tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
        
    }
}


//MARK: - addObserver
extension BookingConfirmedVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        
        
        
        if callapibool == true {
            callAPI()
        }
        
        
    }
    
    @objc func reload() {
        DispatchQueue.main.async {[self] in
            callAPI()
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


//MARK: - Function to download and save the PDF
extension BookingConfirmedVC {
    
    
    func downloadAndSavePDF(showpdfurl:String) {
        let urlString = showpdfurl
        
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Download Error: \(error.localizedDescription)")
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    print("Invalid Response: \(response.debugDescription)")
                    return
                }
                
                if let pdfData = data {
                    self.savePdfToDocumentDirectory(pdfData: pdfData, fileName: "\(Date())")
                }
            }
            task.resume()
        } else {
            print("Invalid URL: \(urlString)")
        }
    }
    
    // Function to save PDF data to the app's document directory
    func savePdfToDocumentDirectory(pdfData: Data, fileName: String) {
        do {
            let resourceDocPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
            let pdfName = "Babsafar-\(fileName).pdf"
            let destinationURL = resourceDocPath.appendingPathComponent(pdfName)
            try pdfData.write(to: destinationURL)
            
            
        } catch {
            print("Error saving PDF to Document Directory: \(error)")
        }
    }
    
    
    
}



//MARK: - Car rental Voucher
extension BookingConfirmedVC {
    
    func callGetCarRentalVoucherAPI() {
        viewModel?.CALL_CAR_RENTAL_VOUCHER_API(dictParam: [:], url: MySingleton.shared.voucherurlsting)
    }
    
    func carrentalVoucherDetails(response: CarVoucherModel) {
        
        hideLoadera()
        loderBool = false
        
        
        bookingId = response.data?.car_id ?? ""
        bookingRefrence = response.app_reference ?? ""
        
        
        MySingleton.shared.carVoucherData =  response.data
        MySingleton.shared.carvoucherdetail =  response.data?.api_token_data
        MySingleton.shared.carpassengerDetails = response.car_passengers ?? []
        
        let originalDateString = response.data?.creation_date ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from: originalDateString) {
            dateFormatter.dateFormat = "MMMM dd yyyy"
            let desiredDateString = dateFormatter.string(from: date)
            bookedDate = desiredDateString
        }
        
        DispatchQueue.main.async {
            self.setupCarRentalVoucherTVCells()
        }
        
        
    }
    
    
    func setupCarRentalVoucherTVCells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:bookingId,
                                 subTitle: bookingRefrence,
                                 key: "sports",
                                 buttonTitle: bookedDate,
                                 tempText: pnrNo,
                                 cellType:.NewBookingConfirmedTVCell))
        
        tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        tablerow.append(TableRow( key:"bc",cellType:.CarRentalResultTVCell))
        
        tablerow.append(TableRow(title:MySingleton.shared.convertDateFormat(inputDate: MySingleton.shared.carVoucherData?.pickup_date ?? "", f1: "yyyy-MM-dd", f2: "dd MMM, yyyy"),
                                 subTitle: MySingleton.shared.carVoucherData?.from_loc ?? "",
                                 text: "\(MySingleton.shared.carVoucherData?.api_response_data?.location_info?.address_1 ?? ""), \(MySingleton.shared.carVoucherData?.api_response_data?.location_info?.address_2 ?? ""), \(MySingleton.shared.carVoucherData?.api_response_data?.location_info?.address_3 ?? ""), \(MySingleton.shared.carVoucherData?.api_response_data?.location_info?.address_city ?? "") , \(MySingleton.shared.carVoucherData?.api_response_data?.location_info?.address_county ?? ""), \(MySingleton.shared.carVoucherData?.api_response_data?.location_info?.address_postcode ?? "")",
                                 buttonTitle: "Pick Up",
                                 cellType:.PickupTVCell))
        
        
        
        
        tablerow.append(TableRow(title:"Driver Details",key: "carbc",cellType:.TitleLblTVCell))
        tablerow.append(TableRow(key:"car",cellType:.BookedTravelDetailsTVCell))
        
        
        
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
        
    }
    
}




//MARK: - ACTIVITIES
extension BookingConfirmedVC {
    
    
    func callGetActivitesVoucherAPI() {
        viewModel?.CALL_ACTIVITIES_VOUCHER_API(dictParam: [:], url: MySingleton.shared.voucherurlsting)
    }
    
    
    func activitiesVoucherDetails(response: ActivitiesVoucherModel) {
        
        hideLoadera()
        loderBool = false
        
        
        
        DispatchQueue.main.async {
            self.setupActivitiesVoucherTVCells(res: response)
        }
    }
    
    
    
    func setupActivitiesVoucherTVCells(res:ActivitiesVoucherModel) {
        tablerow.removeAll()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        let currentDate = Date()
        let formattedDate = dateFormatter.string(from: currentDate)
        
        tablerow.append(TableRow(title:res.data?.booking_itinerary_details?[0].booking_reference,
                                 subTitle: res.data?.booking_itinerary_details?[0].app_reference,
                                 key: "sports",
                                 buttonTitle: formattedDate,
                                 tempText: res.data?.booking_itinerary_details?[0].app_reference,
                                 cellType:.NewBookingConfirmedTVCell))
        
        tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType:.ActivitiesBookingDetailsTVCell))
        
        tablerow.append(TableRow(title:"Lead",
                                 key:"activites",
                                 cellType:.BookedTravelDetailsTVCell))
        
        tablerow.append(TableRow(moreData:res,cellType:.ActivityInformationTVCell))
        
        
        
        
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
        
    }
    
}
