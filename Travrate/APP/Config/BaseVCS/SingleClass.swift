//
//  SingleClass.swift
//  TravgateApp
//
//  Created by FCI on 04/01/24. fcariername
//

import Foundation
import UIKit
import EasyTipView
import SDWebImage






func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
    lbl.text = text
    lbl.textColor = textcolor
    lbl.font = font
}

//MARK: - INITIAL SETUP LABELS
func setuplabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont,align:NSTextAlignment) {
    lbl.text = text
    lbl.textColor = textcolor
    lbl.font = font
    lbl.numberOfLines = 0
    lbl.textAlignment = align
}


class MySingleton {
    // Declare static constant instance
    static  let shared = MySingleton()
    
   
    // Declare your variables
    var loderString = "loder"
    var myVariable1: Int
    var myVariable2: String
    var tablerow = [TableRow]()
    var payload = [String:Any]()
    var payload1 = [String:Any]()
    var inputs = [String:Any]()
    
    
    //Home Page
    var username = String()
    var usermobile = String()
    var useremail = String()
    var userimage = String()
    var tabselect = "close"
    var indexpagevm:IndexPageViewModel?
    var topFlightDetails = [TopFlightDetails]()
    var topCityGuides = [City_guides]()
    var topHotelDetails = [TopHotelDetails]()
    var deail_code_list = [Deail_code_list]()
    var currencyListArray = [Currency_list]()
    var cruiseList = [CruiseData]()
    var cruise : CruiseModel?
    var cruiseDetails : CruiseDetailsModel?
    var bhotelDetials:Hotel_details?
    var user_specification = [String]()
    var hotel_user_specification = [User_specification]()
    var roompaxesdetails = [Room_paxes_details]()
    var hotelAddonServices = [HotelAddonModel]()
    var fareRulesData = [FareRulesData]()
    var selectedAddonServices: [SelectedAddonService] = []
    var mealListArray = [Meals_list]()
    var ssrListArray = [Ssr_list]()
    var journeyKeyArray = [String]()
    var farekey = String()
    var selectedFares = [SelectFare]()
    var indexpathA = [IndexPath]()
    var cancellationRoomStringArray = [Cancellation_string]()
    //Flight Search
    var loderimgurl = String()
    var afterResultsBool = false
    var directFlightBool = false
    var filterApplyedBool = false
    var adultsCount = 1
    var sportsPersonCount = 0
    var sportsShippingFees = 0
    var childCount = 0
    var infantsCount = 0
    var acount = 0
    var ccount = 0
    var icount = 0
    var infoArray = [String]()
    var countrylist = [Country_list]()
    var flights = [[FlightList]]()
    var carlist = [Raw_hotel_list]()
    var transferlist = [Raw_transfer_list]()
    var callboolapi = false
    var flighttoken = String()
    var shareresultrandomid = String()
    var shareresultaccesskey = String()
    var shareresultbookingsource = String()
    var bookingsource = String()
    var bookingsourcekey = String()
    var searchid = String()
    var traceid = String()
    var selectedResult = String()
    var bookingsourceforpromocode = String()
    var tmpFlightPreBookingId = String()
    var accesskeytp = String()
    var fd : [[ItinearyFlightDetails]]?
    let dateFormatter = DateFormatter()
    var similarflightList = [[FlightList]]()
    var flightPriceDetails: PriceDetails?
    var baggageDetails = [Baggage_details]()
    var mpbpriceDetails: PriceDetails?
    var mpbFlightData : MPBFlightDetails?
    var frequent_flyersArray = [Frequent_flyers]()
    var addonServices = [Addon_services]()
    var addonServicesOrigenArray = [String]()
    var carAddonServices = [Addon_services]()
    var activitiesAddonServices = [Addon_services]()
    var transferAddonServices = [Addon_services]()
    var firstHalf_addonServices: [Addon_services] = []
    var secondHalf_addonServices: [Addon_services] = []
    var ageCategory: AgeCategory = .adult
    var passportExpireDateBool = false
    var passengertypeArray = [String]()
    var positionsCount = 0
    var searchTextArray = [String]()
    var payemail = String()
    var paycontactname = String()
    var payusername = String()
    var regpassword = String()
    var paymobile = String()
    var paymobilecountrycode = String()
    var hotelcountrycode = String()
    var checkTermsAndCondationStatus = false
    var directflightString = String()
    var returnDateTapbool = false
    var totalselectedDepfareprice = Double()
    var totalselectedRetfareprice = Double()
    var totalselectedfareprice = Double()
    var voucherurlsting = String()
    
    var guestbool = false
    var nationalityCode = String()
    var email = String()
    var password = String()
    var mobile = String()
    var fname = String()
    var lname = String()
    var travelfrom = String()
    var travelto = String()
    var mrtitle = String()
    var totalnights = String()
    var promocodebool = false
    var un_id = String()
    var checkedbaggagevalue = String()
    
    var addBaggageBool = false
    var mealBool = false
    var addMealBool = false
    var addInsuranceBool = false
    var addSpecialAssistanceBool = false
    var addSeatBool = false
    var addAirportTransfersBool = false
    
    var enablePaymentButtonBool1 = false
    var enablePaymentButtonBool2 = false
    var paymenttype = String()
    var paymenttypeurl = String()
    
    var selected_meals_codeArray = [String]()
    var selected_special_assistance_codeArray = [String]()
    var addon_servicesArray = [String]()
    // var addOptions =  [AddOptions]()
    
    var visaNationalityCode = String()
    var visaResidencyCode = String()
    var visaDestinationCode = String()
    var visaCountryCode = String()
    var cruiseKeyStr = String()
    var cruiseCountryCode = String()
    var holidayCountryCode = String()
    var selectedResultStr = String()
    
    var insurencetravelcode = String()
    var insurencwhomcode = String()
    var insurenczonecode = String()
    var insurencmultitripscode = String()
    var insurencePaxCount = "1"
    var insurenceDepDate = String()
    var insurenceArrivalDate = String()
    
    var bookingsrc = String()
    var htoken = String()
    var htokenkey = String()
    var hoteladultscount = Int()
    var hotelchildcount = Int()
    
    var merchantid = String()
    var sessionid = String()
    var farerulesrefKey = [[String]]()
    var farerulesrefContent = [[String]]()
    var tapRegorLogonBool = false
    var sportsTeamName = String()
    var sportsTeamId = String()
    var sportsVenuName = String()
    var sportsVenuId = String()
    var sportFromDate = String()
    var sportToDate = String()
    var sportscityName = String()
    var sportscityId = String()
    var sports_searchid = String()
    var sports_token = String()
    var sport_mapUrl = String()
    var sport_ticket_value = String()
    var sport_eventlist = String()
    var carRentalDriverAge = String()
    var carproductcode = String()
    var carcurrency = String()
    var carextraoptionPrice = String()
    var carproductarray = [Product]()
    var carresulttoken = String()
    var carresultindex = String()
    
    var car_extra_option_price = String()
    var car_total_amount = String()
    var car_total_amount_origin = String()
    var car_markup_value = String()
    var car_discount_value = String()
    
    var carsearchid = String()
    var driverbool = false
    var childbool = false
    var carvoucherdetail : Api_token_data?
    var carpassengerDetails = [Car_passengers]()
    var carVoucherData : CarVoucherData?
    var transfer_token = String()
    var transfer_searchid = String()
    var transferpassengercount = 1
    
    
    var confpassword = String()
    var recentData:[Recent_searches]?
    var Recentsearches = [Recent_searches]()
    var clist = [All_country_code_list]()
    var airlinelist = [AirlineDate]()
    var addson:Addson = .nothing
    var addonSelectedArray = [String]()
    var selectedAddonTotalPrice = 0
    var afterAddonAmountAdded = 0
    var moreDetailsData : MoreDetailsData?
    var fareFlightlistArray = [Onward]()
    var fareReturnFlightlistArray = [FligtsFareReturn]()
    var selectedIndexPathsDeparture: Set<IndexPath> = []
    var selectedIndexPathsReturn: Set<IndexPath> = []
    var holidaylist = [HolidayListData]()
    var holidaySelectedData:HolidaySelectedData?
    var holidayItinerary = [Itinerary]()
    var cruiseItinerary = [Itinerary]()
    var penalityArray = [Penalty]()
    var hotelDetails:Hotel_details?
    var sportslistArray = [SportListData]()
    var sportsDetailsData : [SportsDetailsData]?
    var sportListData : Event_list?
    var seatingArrangementList = [Seating_arrangement]()
    var sportBookingData : SportsBookingData?
    var sportEventList : Event_list?
    var sportvoucherEventList : Event_list_data?
    var sportTicketValue : Ticket_value?
    var sportsBookingData:SportsBookingData?
    var participantsArray = [Participants]()
    var PaymentSelectionArray = [Payment_selection]()
    var SportsPaymentSelectionArray = [SportsPaymentSelection]()
    var sports_passengers = [Sports_passengers]()
    var extraOption = [Extra_option]()
    var extraOptionPrice = String()
    var carselectedoption = String()
    var activityList = [Activity]()
    var activites_booking_source = String()
    var activites_searchid = String()
    var activites_currency = String()
    var activity_code = String()
    var resultToken = String()
    var activity_type = String()
    var rateKeySring = String()
    var agentpayable = String()
    var activity_selecteddate = String()
    var activity_cancellation_string = String()
    var activitiesImagesArray = [Activity_images]()
    var activity_details :Activity_details?
    var bookingactivitydetails :Booking_Activity_details?
    var modalitiesdetails = [ActivityDetailsModalities]()
    var activitiesPostData : Post?
    var activity_name = String()
    var activity_loc = String()
    var activity_image = String()
    var activity_duration_type = String()
    var activity_name_type = String()
    
    
    //View Models
    var loginvm:LoginViewModel?
    var vm:FlightListViewModel?
    var fdvm:FlightDetailsViewModel?
    var resetpasswordvm:ResetPasswordViewModel?
    var registervm:RegisterViewModel?
    var profilevm:ProfileViewModel?
    var profiledata:ProfileData?
    var logoutvm:LogoutViewModel?
    var recentsearchvm:SearchDataViewModel?
    var countrylistvm:AllCountryCodeListViewModel?
    var lodervm:SearchLoaderViewModel?
    var hotellodervm:SearchHotelLoderViewModel?
    var airlinevm:GetAirlineViewModel?
    var viewmodel1:MobileSecureBookingViewModel?
    var visavm:VisaEnquireyViewModel?
    var cruisevm:CruiseViewModel?
    var cruisedetailsvm:CruiseDetailsViewModel?
    var moredetailsvm:MoreDetailsViewModel?
    var currencylistvm:CurrencyListViewModel?
    var contactusvm:mobilecontactusViewModel?
    var farelistvm:SelectFareViewModel?
    var mpbvm:MPBViewModel?
    var mobilepaymentvm:MobilePaymentVM?
    var passengerDetailsVM:MobileProcessPassengerDetailVM?
    var getInsuranceItemsVM:GetInsuranceItemsVM?
    var holidayListVM:HolidayListVM?
    var holidaySelectedVM:HolidaySelectedVM?
    var sportsCityvm:SportServiceVM?
    var sportsCityList = [SportsServiceData]()
    var sportsTeamtList = [SportsServiceData]()
    var sportsVenuList = [SportsServiceData]()
    var sportListVM:SportListVM?
    var sportlist = [SportListData]()
    var sportsdetailsvm: SportDetailsVM?
    var sportsbookingvm:SportsBookingVM?
    var shareresultvm:ShareResultViewModel?
    var SsportsPaymentvm:SportsPaymentViewModel?
    var carpresearchVM:CarrentalSearchVM?
    var sportsVoucherVM:SportsViewVoucherVM?
    var carDetailsVM:CarDetailsVM?
    var carPreBookingVM:CarPreBookingVM?
    var carBookingVM:CarBookingVM?
    var transferCityVM:GetTransferCityVM?
    var preTransfersearchVM:PreTransfersearchVM?
    var transferPreBookingVM:TransferPreBookingVM?
    var transferBookingVM:TransferBookingVM?
    var getActivitesDestinationListVM:GetActivitesDestinationListVM?
    var preactivitysearchVM:MobilepreactivitysearchVM?
    var activityDetailsVM:ActivityDetailsVM?
    var activitiesPreProcessBookingVM:ActivitiesPreProcessBookingVM?
    var activitiesProcessPassengerVM:ActivitiesProcessPassengerVM?
    
    
    //TIMER
    weak var delegate: TimerManagerDelegate?
    var timerDidFinish = false
    var timer: Timer?
    var totalTime = 1
    private var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    var preferences = EasyTipView.Preferences()
    
    
    func setupTipView(arrowPosition:EasyTipView.ArrowPosition){
        
        preferences.drawing.font = .OpenSansMedium(size: 13)
        preferences.drawing.foregroundColor = UIColor.white
        preferences.drawing.backgroundColor = .black
        preferences.drawing.arrowPosition = arrowPosition
        
        preferences.animating.dismissTransform = CGAffineTransform(translationX: 0, y: -15)
        preferences.animating.showInitialTransform = CGAffineTransform(translationX: 0, y: -15)
        preferences.animating.showInitialAlpha = 0
        preferences.animating.showDuration = 1.5
        preferences.animating.dismissDuration = 1.5
        
        EasyTipView.globalPreferences = preferences
    }
    
    
    // Private initializer to prevent multiple instances
    private init() {
        myVariable1 = 0
        myVariable2 = "Default value"
    }
    
    
    
    //MARK: - ExecuteOnce
    func callonce() {
        
        if !UserDefaults.standard.bool(forKey: "ExecuteOnce") {
            
            defaults.set("KWD", forKey: UserDefaultsKeys.selectedCurrency)
            defaults.set("KWD", forKey: UserDefaultsKeys.selectedCurrencyType)
            
            UserDefaults.standard.set(true, forKey: "ExecuteOnce")
        }
    }
    
    
    //MARK: - convert Date Format
    func convertDateFormat(inputDate: String,f1:String,f2:String) -> String {
        
        let olDateFormatter = DateFormatter()
        olDateFormatter.dateFormat = f1
        
        guard let oldDate = olDateFormatter.date(from: inputDate) else { return "" }
        
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = f2
        
        return convertDateFormatter.string(from: oldDate)
    }
    
    
    
    //MARK: - getCountryList
    func getCountryList() {
        
        
        
        // Get the path to the clist.json file in the Xcode project
        if let jsonFilePath = Bundle.main.path(forResource: "clist", ofType: "json") {
            do {
                // Read the data from the file
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: jsonFilePath))
                
                // Decode the JSON data into a dictionary
                let jsonDictionary = try JSONDecoder().decode([String: [Country_list]].self, from: jsonData)
                
                // Access the array of countries using the "country_list" key
                if let countries = jsonDictionary["country_list"] {
                    self.countrylist = countries
                    
                } else {
                    print("Unable to find 'country_list' key in the JSON dictionary.")
                }
                
                
            } catch let error {
                print("Error decoding JSON: \(error)")
            }
        } else {
            print("Unable to find clist.json in the Xcode project.")
        }
        
        
    }
    
    
    
    //MARK: - getPaymentList
    func getPaymentList() {
        
        
        // Get the path to the clist.json file in the Xcode project
        if let jsonFilePath = Bundle.main.path(forResource: "paymentes", ofType: "json") {
            do {
                // Read the data from the file
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: jsonFilePath))
                
                // Decode the JSON data into a dictionary
                let jsonDictionary = try JSONDecoder().decode([String: [Payment_selection]].self, from: jsonData)
                
                // Access the array of countries using the "country_list" key
                if let payments = jsonDictionary["data"] {
                    self.PaymentSelectionArray = payments
                    
                } else {
                    print("Unable to find 'data' key in the JSON dictionary.")
                }
                
                
            } catch let error {
                print("Error decoding JSON: \(error)")
            }
        } else {
            print("Unable to find clist.json in the Xcode project.")
        }
        
        
    }
    
    
    
    //MARK: - convertToDesiredFormat
    
    func convertToDesiredFormat(_ inputString: String) -> String {
        if let number = Int(inputString.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
            if inputString.contains("Kilogram") {
                return "\(number) kg"
            } else if inputString.contains("Kg") {
                return "\(number) Kilogram"
            } else if inputString.contains("NumberOfPieces") {
                return "\(number) Piece per person."
            }
        }
        return "Invalid input format."
    }
    
    
    
    
    
    //MARK: - Timer SETUP
    func startTimer(time:Int) {
        endBackgroundTask() // End any existing background task (if any)
        backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
            self?.endBackgroundTask()
        }
        
        // Reset the totalTime to its initial value (e.g., 60 seconds)
        totalTime = time
        
        // Schedule the timer in the common run loop mode
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    
    @objc func updateTimer() {
        if totalTime != 0 {
            totalTime -= 1
            delegate?.updateTimer()
        } else {
            sessionStop()
            delegate?.timerDidFinish()
            endBackgroundTask()
        }
    }
    
    @objc func sessionStop() {
        if let timer = timer {
            timer.invalidate()
            self.timer = nil
        }
    }
    
    func stopTimer() {
        if let timer = timer {
            timer.invalidate()
            self.timer = nil
        }
    }
    
    
    private func endBackgroundTask() {
        guard backgroundTask != .invalid else { return }
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = .invalid
    }
    
    
    func setAttributedTextnew(str1:String,str2:String,lbl:UILabel,str1font:UIFont,str2font:UIFont,str1Color:UIColor,str2Color:UIColor)  {
        
        let atter1 = [NSAttributedString.Key.foregroundColor:str1Color,
                      NSAttributedString.Key.font:str1font] as [NSAttributedString.Key : Any]
        let atter2 = [NSAttributedString.Key.foregroundColor:str2Color,
                      NSAttributedString.Key.font:str2font] as [NSAttributedString.Key : Any]
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        let atterStr2 = NSMutableAttributedString(string: str2, attributes: atter2)
        
        
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        combination.append(atterStr2)
        
        lbl.attributedText = combination
        
    }
    
    
    func convertToPC(input: String) -> String? {
        // Split the input string by space
        let components = input.components(separatedBy: " ")
        
        // Check if the input string follows the "NumberOfPieces X" format
        if components.count == 2, components[0] == "NumberOfPieces", let number = Int(components[1]) {
            return "\(number)pc"
        }
        
        // Check if the input string follows the "X Kilograms" format
        if components.count == 2, let number = Int(components[0]), components[1].lowercased() == "kilograms" {
            return "\(number)kg"
        }
        
        // Return nil if the input format is invalid
        return nil
    }
    
    
    func isValidPassportNumber(_ passportNumber: String) -> Bool {
        // Define the regular expression pattern
        let passportPattern = "^[A-Z0-9]{6,9}$"
        
        // Create a regular expression object
        let regex = try? NSRegularExpression(pattern: passportPattern, options: [])

        // Test the string against the pattern
        let range = NSRange(location: 0, length: passportNumber.utf16.count)
        let match = regex?.firstMatch(in: passportNumber, options: [], range: range)

        // Return true if there is a match, false otherwise
        return match != nil
    }
    
}


protocol TimerManagerDelegate: AnyObject {
    func timerDidFinish()
    func updateTimer()
}





extension MySingleton {
    
    func removeallstoredValues() {
        
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload1.removeAll()
        travelerArray.removeAll()
        MySingleton.shared.PaymentSelectionArray.removeAll()
        
        
        //FLIGHTS
        prices.removeAll()
        durationArray.removeAll()
        kwdPriceArray.removeAll()
        dateArray.removeAll()
        AirlinesArray.removeAll()
        ConnectingFlightsArray.removeAll()
        ConnectingAirportsArray.removeAll()
        luggageArray.removeAll()
        noofstopsArray.removeAll()
        layoverdurationArray.removeAll()
        MySingleton.shared.similarflightList.removeAll()
        MySingleton.shared.flightPriceDetails = nil
        MySingleton.shared.baggageDetails.removeAll()
        MySingleton.shared.fareRulesData.removeAll()
        MySingleton.shared.penalityArray.removeAll()
        MySingleton.shared.mpbpriceDetails = nil
        MySingleton.shared.mpbFlightData = nil
        MySingleton.shared.frequent_flyersArray.removeAll()
        MySingleton.shared.addonServices.removeAll()
        MySingleton.shared.mealListArray.removeAll()
        MySingleton.shared.ssrListArray.removeAll()
        services.removeAll()
        addon_services.removeAll()
        social_linksArray.removeAll()
        bottom_text_info.removeAll()
        
        
        
        
        //HOTEL
        mapModelArray.removeAll()
        neighbourwoodArray.removeAll()
        nearBylocationsArray.removeAll()
        faretypeArray .removeAll()
        amenitiesArray.removeAll()
        mapModelArray.removeAll()
        hotelstarratingArray.removeAll()
        hotelSearchResult.removeAll()
        MySingleton.shared.hotelDetails = nil
        roomsDetails.removeAll()
        imagesArray.removeAll()
        formatAmeArray.removeAll()
        formatDesc.removeAll()
        MySingleton.shared.hotel_user_specification.removeAll()
        hbookingDetails = nil
        MySingleton.shared.bhotelDetials = nil
        MySingleton.shared.hotel_user_specification.removeAll()
        MySingleton.shared.roompaxesdetails.removeAll()
        MySingleton.shared.hotelAddonServices.removeAll()
        hotel_Addservices.removeAll()
        
        
        //ACTIVITIES
        durationTypeArray.removeAll()
        activitiesTypeArray.removeAll()
        MySingleton.shared.activityList.removeAll()
        MySingleton.shared.activity_details = nil
        MySingleton.shared.activitiesImagesArray.removeAll()
        MySingleton.shared.activitiesAddonServices.removeAll()
        MySingleton.shared.bookingactivitydetails = nil
        MySingleton.shared.activitiesPostData =  nil
        
        
        //CARRENTAL
        fuleArray.removeAll()
        carmanualArray.removeAll()
        doorcountArray.removeAll()
        MySingleton.shared.carlist.removeAll()
        MySingleton.shared.extraOption.removeAll()
        MySingleton.shared.carproductarray.removeAll()
        MySingleton.shared.extraOption.removeAll()
        MySingleton.shared.carproductarray.removeAll()
        MySingleton.shared.carAddonServices.removeAll()
        MySingleton.shared.carproductarray.removeAll()
        MySingleton.shared.extraOption.removeAll()
        
        
        //SPORTS
        tournamentArray.removeAll()
        eventsArray.removeAll()
        sportsCityArray.removeAll()
        sportsCountryArray.removeAll()
        
        
        //TRANSFERS
        MySingleton.shared.transferlist.removeAll()
        cartype.removeAll()
        MySingleton.shared.transferAddonServices.removeAll()
        transfer_data = nil
        
        
        //HOLIDAYS cruise
        MySingleton.shared.holidaylist.removeAll()
        MySingleton.shared.holidaySelectedData = nil
        MySingleton.shared.holidayItinerary.removeAll()
        
        MySingleton.shared.cruiseList.removeAll()
        MySingleton.shared.cruise = nil
        MySingleton.shared.cruiseItinerary.removeAll()
        MySingleton.shared.cruiseItinerary.removeAll()
        
        
        // Clear memory cache
        SDImageCache.shared.clearMemory()
        
        // Optionally clear disk cache as well
        SDImageCache.shared.clearDisk {
            print("Disk cache cleared when view controller is dismissed")
        }
    }
}
