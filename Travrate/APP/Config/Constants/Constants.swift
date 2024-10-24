//
//  Constants.swift
//  DoorcastRebase
//
//  Created by U Dinesh Kumar Reddy on 04/05/22.
//

import Foundation
import UIKit
import CoreData


/*SETTING USER DEFAULTS*/
let defaults = UserDefaults.standard

let loginResponseDefaultKey = "LoginResponse"
let KPlatform = "Platform"
let KPlatformValue = "iOS"
let KContentType = "Content-Type"
let KContentTypeValue = "application/x-www-form-urlencoded"
let KAccept = "Accept"
let KAcceptValue = "application/json"
let KAuthorization = "Authorization"
//let KDEVICE_ID = "DEVICE_ID"
let KAccesstoken = "Accesstoken"
let KAccesstokenValue = ""
var key = ""
let screenHeight = UIScreen.main.bounds.size.height
let screenwidth = UIScreen.main.bounds.size.width
//var data : Data?
var loderBool = false
var basicloderBool = false


//var BASE_URL = "https://provab.net/travrate/android_ios_webservices/mobile/index.php/"
//var BASE_URL1 = "https://provab.net/travrate/android_ios_webservices/mobile/index.php/"


var BASE_URL = "https://travrate.com/android_ios_webservices/mobile/index.php/"
var BASE_URL1 = "https://travrate.com/android_ios_webservices/mobile/index.php/"

var accessToken = "e3VzZXJuYW1lOmFudWpob29kYSxwYXNzd29yZDp0cmF2Z2F0ZUBtb2JpbGVhcHAsYXV0aHR5cGU6dGVzdH0="
var authorizationkey = "Api-Key mXSkj6CS.hXxp9suftZUk7X8zagbA9GhQnhQL9KOh"
//var authorizationkey = "Api-Key 5d8f6bb5377bcf52b7da1d5cfbef843c94ee04ea"

var defaultCountryCode = "+91"
var mobilenoMaxLength = Int()
var mobilenoMaxLengthBool = false
var isLoadingData = false


var promocodeValue = Double()
var whatsAppCheck = false
var priceCheck = false
var flexibleCheck = false
var notificationCheck = true
var addonCheck = false
var totlConvertedGrand = Double()
var whatsAppAmount = Int()
var flexibleAmount = Int()
var addonAmount = Int()
var priceChangeAmount = Int()
var notificationAmount = Int()
var services = [Addon_services]()
var addon_services = [Addon_services]()
var whatsAppPrice = String()
var flexiblePrie = String()
var priceChange = String()
var notificationPrice = String()
var hotelselectedcountrycode = String()

var AdultsTotalPrice = String()
var ChildTotalPrice = String()
var InfantTotalPrice = String()
var sub_total_adult : String?
var sub_total_child : String?
var sub_total_infant : String?
var isChecked =  true
var totalRooms = 0
var totalAdults = 0
var totalChildren = 0

var Adults_Base_Price = String()
var Adults_Tax_Price = String()
var Childs_Base_Price = String()
var Childs_Tax_Price = String()
var Infants_Base_Price = String()
var Infants_Tax_Price = String()
var TotalPrice_API = String()
var grandTotal = String()
var subtotal = String()


//HOTEL
var adtArray = [String]()
var chArray = [String]()
var hotelDetailsTapBool = Bool()
var oldjournyType = ""
var selectedSpecificatonArray = [String]()
var startRatingArray = [String]()
var starRatingInputArray = [String]()
var hotelstarratingArray = [String]()
var filterresettapbool = true
var filteredSportsTickekData = [SportsDetailsData]()
var hotelroomtap = "room"
var activitiestap = "activities"

//DASHBOARD
var mrtitlecode = ""
var callapibool = Bool()
var travelerArray: [Traveler] = []

//MARK: - FILTER RELATED VARIABLES
var filterTap = String()
var filterPrice = String()
var prices = [String]()
var carprices = [String]()
var cartype = [String]()
var durationArray = [String]()
var hotelprices = [String]()

var filterModel = FlightFilterModel()
var sortBy: SortParameter = .nothing
var hotelfiltermodel = HotelFilterModel()
var sportsfilterModel = SportsFilterModel()
var carfilterModel = CarRentalFilterModel()
var transferfilterModel = TransferFilterModel()
var activitiesfiltermodel = ActivitiesFilterModel()
var tournamentArray = [String]()
var eventsArray = [String]()
var sportsCityArray = [String]()
var sportsCountryArray = [String]()
var transfer_data : Transfer_data?


var totalDurationArray = [String]()
var mapModelArray: [MapModel] = []
var faretypeArray = [String]()
var directFlightBool = true
var facilityArray = [String]()
var AirlinesArray = [String]()
var ConnectingFlightsArray = [String]()
var ConnectingAirportsArray = [String]()
var luggageArray = [String]()
var noofstopsArray = [String]()
var layoverdurationArray = [String]()
var neighbourwoodArray = [String]()
var amenitiesArray = [String]()
var nearBylocationsArray = [String]()
var kwdPriceArray = [String]()
var dateArray = [String]()
var flnew : [[FlightList]]?
var btnTapString = "departure"

var hbookingDetails:Hotel_details?
var hoteltotalprice = ""
var hotelwhatsAppCheck = false
var hotelpriceCheck = false
var hotelflexibleCheck = false
var hotelnotificationCheck = false
var hotelwhatsAppPrice = String()
var hotelflexiblePrie = String()
var hotelpriceChange = String()
var hotelnotificationPrice = String()
var hotelflexibleAmount = Int()
var hotelwhatsAppAmount = Int()
var hotelpriceChangeAmount = Int()
var hotelnotificationAmount = Int()
var HoteladdonAmount = Int()
var hotel_Addservices = [HotelAddonModel]()
var origin_array = [String]()

var totalWhatsAppPrice: Double = 0.0
var totalFlexiblePrice: Double = 0.0
var totalPriceChange: Double = 0.0
var totalNotificationPrice: Double = 0.0

var bookedjurnycitys = String()
var lastContentOffset: CGFloat = 0
var urlString = String()
var tablerow = [TableRow]()
var bookingsource = String()
var bookingStatus = String()
var bookingRefrence = String()
var bookedDate = String()
var pnrNo = String()
var bookingId = String()
var flightSelectedIndex = Int()
var userspecification = [String]()

var isfilterApplied = false
var hotelimg = ""
var hotel_check_in = ""
var hotel_check_out = ""
var hotel_name = ""
var hotel_address = ""
var total_rooms = ""
var adult_count = ""
var vocherpdf = ""

var bottom_text_info = [Bottom_text_info]()
var social_linksArray = [Social_links]()
var bookingitinerarydetails = [Booking_itinerary_summary]()
var Customerdetails = [Customer_details]()


var hotelbookingdetails : Hotel_Booking_details?
var hotelCustomerdetails = [Hotel_Customer_details]()


var currency = ""
var totalPrice = ""
var totalPax = ""
var viewModel:VocherDetailsViewModel?
var grand_total_Price = String()
var totalPrice1 = String()
var mbviewmodel:MPBViewModel?

//MARK: - Hotel
var hotelSearchId = String()
var roomsDetails = [[Rooms]]()
var imagesArray = [Images]()
var formatAmeArray = [Format_ame]()
var formatDesc = [Format_desc]()
var hotel_filtersumry : Filter_sumry?
var hsearchid = String()
var hbookingsource = String()
var htoken = String()
var htokenkey = String()
var roomselected = String()
var selectedrRateKeyArray = String()
var hotelSearchResult = [HotelSearchResult]()

var selectedCellStates: [IndexPath: Bool] = [:]
var selectedCellIndices: [IndexPath] = [] // Keep track of selected cell indices

var withwhomtitleArray = [String]()
var withwhomcodeArray = [String]()
var multitripstittleArray = [String]()
var multitripscodeArray = [String]()

var isSearchBool = false
var hoterresetApplied = false
var zonetitleArray = [String]()
var zonecodeArray = [String]()
var optionsIndexpathArray: [IndexPath] = []
var selectedOptions: [AdditionalOption] = []

//CAR RENTAL
var fuleArray = [String]()
var carmanualArray = [String]()
var doorcountArray = [String]()
//Activities
var durationTypeArray = [String]()
var activitiesTypeArray = [String]()


/* URL endpoints */
struct ApiEndpoints {
    
    static let indexpage = "general/getTopFlightHotelDestination"
    static let get_airport_code_list = "ajax/get_airport_code_list"
    static let general_searchdata = "general/searchdata"
    static let general_removeRecentSearch = "general/removeRecentSearch"
    static let general_mobile_pre_flight_search = "general/mobile_pre_flight_search"
    static let general_get_active_booking_source = "general/get_active_booking_source"
    static let general_search_flight = "general/search_flight"
    
    static let flight_getFlightDetails = "flight/getFlightDetails"
    static let flight_mobile_pre_process_booking = "flight/mobile_pre_process_booking"
    static let flight_mobile_pre_booking = "flight/mobile_pre_booking"
    static let mobileprocesspassengerdetail = "mobile_process_passenger_detail"
    static let getCountryList = "getCountryList"
    static let general_mobile_pre_flight_search_loader = "general/mobile_pre_flight_search_loader"
    static let general_mobile_pre_hotel_search_loader = "general/mobile_pre_hotel_search_loader"
    static let general_get_airlines_list = "general/get_airlines_list"
    static let mobilepreprocessbooking = "mobile_pre_process_booking"
    static let general_getMobileCurrency = "general/getMobileCurrency"
    static let general_mobile_contact_us = "general/mobile_contact_us"
    static let ajax_mobile_get_fare_rules = "ajax/mobile_get_fare_rules"
    static let general_get_more_option_at_same_price = "general/get_more_option_at_same_price"
    static let management_promocode = "management/promocode"
    static let ajax_share_itinerary = "ajax/share_itinerary"
    static let ajax_share_itinerary_hotel = "ajax/share_itinerary_hotel"
    static let flight_mobile_pre_payment_confirmation = "flight/mobile_pre_payment_confirmation/"
    static let flight_mobile_send_to_payment = "flight/mobile_send_to_payment"
    static let report_flight = "report/flight"
    static let report_hotel = "report/hotel"
    static let report_activities = "report/activities"
    static let report_car = "report/car"
    
    
    
    //LOGIN
    static let auth_mobile_login = "auth/mobile_login"
    static let auth_mobile_logout = "auth/mobile_logout"
    static let auth_deleteuser = "auth/deleteuser"
    static let auth_mobile_forgot_password = "auth/mobile_forgot_password"
    static let auth_mobile_register_on_light_box = "auth/mobile_register_on_light_box"
    static let user_mobile_profile = "user/mobile_profile"
    static let gethotelcitylist = "get_hotel_city_list"
    static let getAirlineList = "general/getAirlineList"
    
    
    //Hotels
    static let general_getActiveBookingSource = "general/getActiveBookingSource"
    static let ajaxHotelSearch_pagination = "ajaxHotelSearch_pagination"
    static let mobileprehotelsearch = "mobile_pre_hotel_search"
    static let general_mobileHotelSearch = "general/mobileHotelSearch"
    static let hotelmobiledetails = "mobile_details"
    static let hotel_mobile_booking = "hotel/mobile_booking"
    static let hotel_mobile_hotel_pre_booking = "hotel/mobile_hotel_pre_booking"
    static let hotel_mobile_pre_payment_confirmation = "hotel/mobile_pre_payment_confirmation"
    static let hotel_mobile_send_to_payment = "hotel/mobile_send_to_payment"
    
    
    
    //VISA
    static let visa_enquiry_form = "visa/visa_enquiry_form"
    static let cruise_get_cruise_list = "cruise/get_cruise_list"
    static let cruise_get_more_info = "cruise/get_more_info/"
    static let cruise_cruise_enquiry_form = "cruise/cruise_enquiry_form"
    
    //INSURENCE
    static let insurance_get_insurance_items = "insurance/get_insurance_items"
    static let general_mobile_pre_insurance_search = "general/mobile_pre_insurance_search"
    static let holiday = "holiday"
    static let holiday_more_info = "holiday/more_info"
    static let holiday_holiday_requests = "holiday/holiday_requests"
    static let holiday_send_otp_for_special_offer = "holiday/send_otp_for_special_offer"
    static let general_get_sport_city_list = "general/get_sport_city_list"
    static let general_get_sport_event_list = "general/get_sport_event_list"
    static let general_get_sport_type = "general/get_sport_type"
    static let sport_api_sport_search = "sport/api_sport_search"
    static let general_pre_sports_search = "general/pre_sports_search"
    static let sport_pre_sport_tickets = "sport/pre_sport_tickets"
    static let sport_pre_booking = "sport/pre_booking"
    static let sport_sent_to_payment_pre = "sport/sent_to_payment_pre"
    static let sport_send_to_payment = "sport/send_to_payment"
    static let report_sports = "report/sports"
    
    
    //CAR RENTAL
    static let ajax_get_car_rental_city_list = "ajax/get_car_rental_city_list"
    static let general_pre_car_search = "general/pre_car_search"
    static let car_car_list = "car/car_list"
    static let car_detials = "car/detials"
    static let car_pre_booking = "car/pre_booking"
    static let car_booking = "car/booking"
    
    //TRANSFERS
    static let transfers_get_location_list = "transfers/get_location_list"
    static let general_pre_transfer_search = "general/pre_transfer_search"
    static let transfers_transfer_list = "transfers/transfer_list"
    static let transfers_pre_booking = "transfers/pre_booking"
    static let transfers_booking = "transfers/booking"
   
    
    //Activites
    static let ajax_get_activity_destination_list = "ajax/get_activity_destination_list"
    static let general_mobile_pre_activity_search = "general/mobile_pre_activity_search"
    static let activity_search = "activity/search"
    static let activity_activity_detail = "activity/activity_detail"
    static let activity_pre_process_booking = "activity/pre_process_booking"
    
}

/*App messages*/
struct Message {
    static let internetConnectionError = "Please check your connection and try reconnecting to internet"
    static let sessionExpired = "Your session has been expired, please login again"
}


/*USER ENTERED DETAILS DEFAULTS*/

struct UserDefaultsKeys {
    
    static var selectedLanguage = "Selected_Language"
    static var mobilecountrycode = "mobilecountrycode"
    static var mobilecountryname = "mobilecountryname"
    static var tabselect = "tabselect"
    static var tripsselect = "tripsselect"
    static var nationality = "nationality"
    static var airlinescode = "airlinescode"
    static var userLoggedIn = "userLoggedIn"
    static var loggedInStatus = "loggedInStatus"
    static var userid = "userid"
    static var username = "username"
    static var userimg = "userimg"
    static var useremail = "useremail"
    static var countryCode = "countryCode"
    static var regStatus = "regStatus"
    static var usermobile = "usermobile"
    static var usermobilecode = "usermobilecode"
    static var journeyType = "Journey_Type"
    static var previousjourneyType = "Previous_Journey_Type"
    static var itinerarySelectedIndex = "ItinerarySelectedIndex"
    static var selectedCurrency = "selectedCurrency"
    static var selectedCurrencyType = "selectedCurrencyType"
    static var totalTravellerCount = "totalTravellerCount"
    static var select_classIndex = "select_classIndex"
    static var rselect_classIndex = "rselect_classIndex"
    static var mselect_classIndex = "mselect_classIndex"
    static var journeyCitys = "journeyCitys"
    static var journeyDates = "journeyDates"
    static var cellTag = "cellTag"
    static var flightrefundtype = "flightrefundtype"
    static var mcountrycode = "mcountrycode"
    
    
    //ONE WAY
    static var fromcitynameshow = "fromcitynameshow"
    static var tocitynameshow = "tocitynameshow"
    static var fromCode = "fromCode"
    static var toCode = "toCode"
    static var fromCity = "fromCity"
    static var toCity = "toCity"
    static var calDepDate = "calDepDate"
    static var calRetDate = "calRetDate"
    static var hadultCount = "HAdult_Count"
    static var hchildCount = "HChild_Count"
    static var adultCount = "Adult_Count"
    static var childCount = "Child_Count"
    static var infantsCount = "Infants_Count"
    static var selectClass = "select_class"
    static var rselectClass = "rselect_class"
    
    static var selectClass_ar = "selectClass_ar"
    static var rselectClass_ar = "rselectClass_ar"
    
    static var fromlocid = "from_loc_id"
    static var tolocid = "to_loc_id"
    static var fromcityname = "fromcityname"
    static var tocityname = "tocityname"
    static var fcity = "fcity"
    static var tcity = "tcity"
    static var fcariername = "fcariername"
    static var fcariercode = "fcariercode"
    
    
    static var fromcityname_ar = "fromcityname_ar"
    static var tocityname_ar = "tocityname_ar"
   
    //MULTICITY TRIP
    static var mlocationcity = "mlocation_city"
    static var mfromCity = "mfromCity"
    static var mtoCity = "mtoCity"
    
  
    static var mfromlocid = "mfrom_loc_id"
    static var mtolocid = "mto_loc_id"
    static var mfromcityname = "mfromcityname"
    static var mtocityname = "mtocityname"
    
    
    //Hotel
    static var locationcity = "location_city"
    static var locationid = "location_id"
    static var hoteladultCount = "HotelAdult_Count"
    static var hotelchildCount = "HotelChild_Count"
    static var cityid = "cityid"
    static var htravellerDetails = "htraveller_Details"
    static var roomType = "Room_Type"
    static var refundtype = "refundtype"
    static var hnationality = "hnationality"
    static var hnationalitycode = "hnationalitycode"
    
    
    static var select = "select"
    static var checkin = "check_in"
    static var checkout = "check _out"
    static var addTarvellerDetails = "addTarvellerDetails"
    static var travellerDetails = "traveller_Details"
    // static var mtravellerDetails = "mtraveller_Details"
    
    static var roomcount = "room_count"
    static var hoteladultscount = "hotel_adults_count"
    static var hotelchildcount = "hotel_child_count"
    static var guestcount = "guestcount"
    static var selectPersons = "selectPersons"
    static var kwdprice = "kwdprice"
    
    
    //visa
    static var travelDate = "travelDate"
    static var visaadultCount = "visaadultCount"
    static var visachildCount = "visachildCount"
    static var visainfantsCount = "visainfantsCount"
    static var visatotalpassengercount = "visatotalpassengercount"
    
    
    //Cruise
    static var fromtravelDate = "fromtravelDate"
    static var totravelDate = "totravelDate"
    static var cruisadultCount = "cruisadultCount"
    static var cruischildCount = "cruischildCount"
    static var cruisinfantsCount = "cruisinfantsCount"
    static var cruistotalpassengercount = "cruistotalpassengercount"
    
    //Transfer
    static var transfercalDepDate = "transfercalDepDate"
    static var transfercalRetDate = "transfercalRetDate"
    static var transfercalDepTime = "transfercalDepTime"
    static var transfercalRetTime = "transfercalRetTime"
    static var transferfromcityname = "transferfromcityname"
    static var transferfromcityid = "transferfromcityid"
    static var transfertocityname = "transfertocityname"
    static var transfertocityid = "transfertocityid"
    static var transferjournytype = "transferjournytype"
    
    static var transferfromlat = "transferfromlat"
    static var transferfromlang = "transferfromlang"
    static var transfertolat = "transfertolat"
    static var transfertolang = "transfertolang"
    
    
    //sportds
    
    static var sportcalDepDate = "sportcalDepDate"
    static var sportcalRetDate = "sportcalRetDate"
    static var pickuplocDate = "pickuplocDate"
    static var dropuplocDate = "dropuplocDate"
    static var pickuplocTime = "pickuplocTime"
    static var dropuplocTime = "dropuplocTime"
    static var driverage = "driverage"
    
    
    //Holiday
    static var holidayfromtravelDate = "holidayfromtravelDate"
    static var holidaytotravelDate = "holidaytotravelDate"
    static var holidaydultCount = "holidaydultCount"
    static var holidaychildCount = "holidaychildCount"
    static var holidayinfantsCount = "holidayinfantsCount"
    static var holidaytotalpassengercount = "holidaytotalpassengercount"
    static var pickuplocationname = "pickuplocationname"
    static var pickuplocationcode = "pickuplocationcode"
    static var dropuplocationname = "dropuplocationname"
    static var dropuplocationcode = "dropuplocationcode"
    static var cardriverage = "cardriverage"
    
    
    
    //ACTIVITES
    static var activitesname = "activitesname"
    static var calActivitesDepDate = "calActivitesDepDate"
    static var calActivitesRetDate = "calActivitesRetDate"
    static var activitescityname = "activitescityname"
    static var activitescityid = "activitescityid"
    static var activitesadultCount = "ativitesadultCount"
    static var activiteschildCount = "activiteschildCount"
    static var activitesinfantsCount = "activitesinfantsCount"
    
    
}


struct sessionMgrDefaults {
    
    static var userLoggedIn = "username"
    static var loggedInStatus = "email"
    static var globalAT = "mobile_no"
    static var Base_url = "accesstoken"
   
    
}



/*LOCAL JSON FILES*/
struct LocalJsonFiles {
    
}
