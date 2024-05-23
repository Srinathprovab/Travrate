//
//  FlightResultVC.swift
//  TravgateApp
//
//  Created by FCI on 05/01/24.
//

import UIKit

class FlightResultVC: BaseTableVC, FlightListModelProtocal, SearchDataViewModelDelegate {
    
    
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var cityslbl: UILabel!
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var paxlbl: UILabel!
    @IBOutlet weak var depDatelbl: UILabel!
    @IBOutlet weak var retDatelbl: UILabel!
    @IBOutlet weak var citycodeslbl: UILabel!
    
    
    static var newInstance: FlightResultVC? {
        let storyboard = UIStoryboard(name: Storyboard.Flight.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? FlightResultVC
        return vc
    }
    
    
    var filterdFlightList :[[FlightList]]?
    var bsDataArray = [ABSData]()
    var bookingSourceDataArrayCount = Int()
    
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        MySingleton.shared.dateFormatter.dateFormat = "HH:mm"
        MySingleton.shared.vm = FlightListViewModel(self)
        MySingleton.shared.recentsearchvm = SearchDataViewModel(self)
        
        
    }
    
    
    
    
    func setupUI() {
        let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType)
        if journyType == "oneway" {
            retDatelbl.isHidden = true
            MySingleton.shared.acount = 1
        }else {
            MySingleton.shared.acount = 2
            retDatelbl.isHidden = false
        }
        
        commonTableView.registerTVCells(["EmptyTVCell",
                                         "FlightResultTVCell"])
    }
    
    
    
    //MARK: - didTapOnFlightDetails
    override func didTapOnFlightDetails(cell: FlightResultTVCell) {
        MySingleton.shared.callboolapi = true
        MySingleton.shared.selectedResult = cell.selectedResult
        MySingleton.shared.farerulesrefKey = cell.farerulesrefKey
        MySingleton.shared.farerulesrefContent = cell.farerulesrefContent
        MySingleton.shared.bookingsourceforpromocode = cell.bookingsource
        
        MySingleton.shared.bookingsource = cell.bookingsourcekey
        MySingleton.shared.bookingsourcekey = cell.bookingsourcekey
        
        
        gotoFlightDeatilsVC()
    }
    
    func gotoFlightDeatilsVC(){
        guard let vc = FlightDeatilsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    
    //MARK: -   didTapFlightDetailsPopupBrtnBtnAction
    override func didTapFlightDetailsPopupBrtnBtnAction(cell:FlightResultTVCell){
        MySingleton.shared.callboolapi = true
        MySingleton.shared.selectedResult = cell.selectedResult
        MySingleton.shared.farerulesrefKey = cell.farerulesrefKey
        MySingleton.shared.farerulesrefContent = cell.farerulesrefContent
        
        MySingleton.shared.bookingsource = cell.bookingsourcekey
        MySingleton.shared.bookingsourcekey = cell.bookingsourcekey
        
        gotoFlightItinarryPopupVC()
    }
    
    
    func gotoFlightItinarryPopupVC() {
        guard let vc = FlightItinarryPopupVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: false)
    }
    
    
    //MARK: - didTapOnBookNowBtnAction
    override func didTapOnBookNowBtnAction(cell: FlightResultTVCell) {
        MySingleton.shared.callboolapi = true
        MySingleton.shared.selectedResult = cell.selectedResult
        MySingleton.shared.bookingsourceforpromocode = cell.bookingsource
        
        MySingleton.shared.bookingsource = cell.bookingsourcekey
        MySingleton.shared.bookingsourcekey = cell.bookingsourcekey
        
        gotoBookingDetailsVC()
        //callFlightDeatilsAPI()
    }
    
    
    //MARK: - didTapOnMoreSimilarFlightBtnAction ======
    override func didTapOnMoreSimilarFlightBtnAction(cell:FlightResultTVCell){
        
        MySingleton.shared.bookingsource = cell.bookingsourcekey
        MySingleton.shared.bookingsourcekey = cell.bookingsourcekey
        
        
        if cell.newsimilarList.count != 0 {
            
            guard let vc = SimilarFlightsVC.newInstance.self else {return}
            vc.modalPresentationStyle = .overCurrentContext
            callapibool = true
            MySingleton.shared.similarflightList = cell.newsimilarList
            present(vc, animated: true)
        }else {
            showToast(message: "No Flights Found")
        }
        
       // commonTableView.reloadRows(at: [IndexPath(item: cell.indexPath?.row ?? 0, section: 0)], with: .automatic)
        
    }
    
    
    //MARK: - didTapOnBackBtnAction
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        MySingleton.shared.callboolapi = false
        guard let vc = FlightSearchVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    
    
    //MARK: - didTapOnModifySearchBtmAction
    @IBAction func didTapOnModifySearchBtmAction(_ sender: Any) {
        guard let vc = ModifySearchVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    
    
    //MARK: - didTapOnSortBtnAction  didTapOnFilterBtnAction
    @IBAction func didTapOnSortBtnAction(_ sender: Any) {
        gotoFilterVC(strkey: "sort")
    }
    
    
    @IBAction func didTapOnFilterBtnAction(_ sender: Any) {
        gotoFilterVC(strkey: "filter")
    }
    
    
    
    //MARK: - didTapOnnextDayFlightSearchBtnAction  didTapOnPrivousdayFlightSearchBtnAction
    @IBAction func didTapOnnextDayFlightSearchBtnAction(_ sender: Any) {
        didTapOnNextDateBtnTapAction()
    }
    
    
    @IBAction func didTapOnPrivousdayFlightSearchBtnAction(_ sender: Any) {
        didTapOnPreviousDateBtnAction()
    }
    
    
    
    //MARK: - gotoFilterVC
    func gotoFilterVC(strkey:String) {
        guard let vc = FilterVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self
        vc.filterKey = strkey
        present(vc, animated: true)
    }
    
    
    //MARK: - didTapOnReturnDateBtnAction
    override func didTapOnReturnDateBtnAction(cell:FlightResultTVCell) {
        defaults.setValue("circle", forKey: UserDefaultsKeys.journeyType)
        gotoFlightSearchVC()
    }
    
    func gotoFlightSearchVC() {
        guard let vc = FlightSearchVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    //MARK: - didTapOnSelectFareBtnAction
    override func didTapOnSelectFareBtnAction(cell:FlightResultTVCell) {
        MySingleton.shared.callboolapi = true
        MySingleton.shared.selectedResult = cell.selectedResult
        MySingleton.shared.bookingsourceforpromocode = cell.bookingsource
        
        MySingleton.shared.farekey = cell.journeyKeystr
        MySingleton.shared.bookingsource = cell.bookingsource
        MySingleton.shared.bookingsourcekey = cell.bookingsourcekey
        
       // gotoSelectFareVC()
        
        showToast(message: "Still Under Development")
    }
    
    func gotoSelectFareVC() {
        MySingleton.shared.selectedFares.removeAll()
        guard let vc = FareListVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
}



//MARK: - didTapOnPreviousDateBtnAction
extension FlightResultVC {
    
    func didTapOnPreviousDateBtnAction() {
        
        holderView.isHidden = true
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                // Convert the date string to a Date object
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                let dateString = defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? ""
                guard let date = dateFormatter.date(from: dateString) else { return }
                
                // Get the previous day's date
                let previousDay = Calendar.current.date(byAdding: .day, value: -1, to: date)
                
                // Convert the next and previous day's dates back to a string format
                let previousDayString = dateFormatter.string(from: previousDay!)
                print("previousDayString ==== > \(previousDayString)")
                defaults.set(previousDayString, forKey: UserDefaultsKeys.calDepDate)
                //  MySingleton.shared.payload["depature"] = defaults.string(forKey:UserDefaultsKeys.calDepDate)
                
                
                MySingleton.shared.payload["depature"] = MySingleton.shared.convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "", f1: "dd-MM-yyyy", f2: "dd/MM/yyyy")
                
                
                self.datelbl.text = previousDayString
                
                
                
                //     callAPI()
                callActiveBookingSourceAPI()
                
            }else {
                
                
                // Convert the date string to a Date object
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                let dateString = defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? ""
                guard let date = dateFormatter.date(from: dateString) else { return }
                
                // Get the next day's date
                let nextDay = Calendar.current.date(byAdding: .day, value: -1, to: date)
                
                // Convert the next and previous day's dates back to a string format
                let nextDayString = dateFormatter.string(from: nextDay!)
                
                if self.retDatelbl.text == nextDayString {
                    showToast(message: "Journey Dates Should Not Same")
                }else {
                    
                    
                    print("nextDayString ==== > \(nextDayString)")
                    defaults.set(nextDayString, forKey: UserDefaultsKeys.calDepDate)
                    //   MySingleton.shared.payload["depature"] = defaults.string(forKey:UserDefaultsKeys.calDepDate)
                    MySingleton.shared.payload["depature"] = MySingleton.shared.convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "", f1: "dd-MM-yyyy", f2: "dd/MM/yyyy")
                    self.datelbl.text = nextDayString
                    
                    
                    // callAPI()
                    
                    callActiveBookingSourceAPI()
                }
            }
            
        }
        
        
    }
    
    //MARK: - didTapOnNextDateBtnTapAction
    func didTapOnNextDateBtnTapAction() {
        
        holderView.isHidden = true
        
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            
            if journeyType == "oneway" {
                // Convert the date string to a Date object
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                let dateString = defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? ""
                guard let date = dateFormatter.date(from: dateString) else { return }
                
                // Get the next day's date
                let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: date)
                
                // Convert the next and previous day's dates back to a string format
                let nextDayString = dateFormatter.string(from: nextDay!)
                print("nextDayString ==== > \(nextDayString)")
                defaults.set(nextDayString, forKey: UserDefaultsKeys.calDepDate)
                //   MySingleton.shared.payload["depature"] = defaults.string(forKey:UserDefaultsKeys.calDepDate)
                MySingleton.shared.payload["depature"] = MySingleton.shared.convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "", f1: "dd-MM-yyyy", f2: "dd/MM/yyyy")
                self.datelbl.text = nextDayString
                
                
                
                
                //   callAPI()
                
                callActiveBookingSourceAPI()
                
            }else {
                
                
                // Convert the date string to a Date object
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                let dateString = defaults.string(forKey: UserDefaultsKeys.calRetDate) ?? ""
                guard let date = dateFormatter.date(from: dateString) else { return }
                
                // Get the next day's date
                let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: date)
                
                // Convert the next and previous day's dates back to a string format
                let nextDayString = dateFormatter.string(from: nextDay!)
                print("nextDayString ==== > \(nextDayString)")
                
                if self.retDatelbl.text == nextDayString {
                    showToast(message: "Journey Dates Should Not Same")
                }else {
                    
                    
                    defaults.set(nextDayString, forKey: UserDefaultsKeys.calRetDate)
                    //  MySingleton.shared.payload["depature"] = defaults.string(forKey:UserDefaultsKeys.calDepDate)
                    MySingleton.shared.payload["return"] = MySingleton.shared.convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.calRetDate) ?? "", f1: "dd-MM-yyyy", f2: "dd/MM/yyyy")
                    self.datelbl.text = nextDayString
                    
                    
                    
                    // callAPI()
                    
                    callActiveBookingSourceAPI()
                }
            }
            
        }
        
    }
}


//MARK: - Function to get unique elements based on totalPrice oneway
extension FlightResultVC {
    
    func getUniqueElements_oneway(inputArray: [[FlightList]]) -> [[FlightList]] {
        var uniqueElements: [[FlightList]] = []
        var uniquePrices: Set<String> = []
        
        for array in inputArray {
            var uniqueArray: [FlightList] = []
            for item in array {
                if !uniquePrices.contains("\(item.price?.api_total_display_fare ?? 0.0)") {
                    uniquePrices.insert("\(item.price?.api_total_display_fare ?? 0.0)")
                    uniqueArray.append(item)
                }
            }
            if !uniqueArray.isEmpty {
                uniqueElements.append(uniqueArray)
            }
        }
        
        return uniqueElements
    }
    
    
    func getUniqueElements(inputArray: [FlightList]) -> [FlightList] {
        var uniqueElements: [FlightList] = []
        var uniquePrices: Set<String> = []
        
        for item in inputArray {
            if !uniquePrices.contains("\(item.price?.api_total_display_fare ?? 0.0)") {
                uniquePrices.insert("\(item.price?.api_total_display_fare ?? 0.0)")
                uniqueElements.append(item)
            }
        }
        
        return uniqueElements
    }
    
    
    
    
    func similar(fare: Double) -> [[FlightList]] {
        // Create a dictionary to group flights with the same api_total_display_fare
        var similarFlightsDictionary: [Double: [[FlightList]]] = [:]
        
        // Iterate through the FlightList (ensure that FlightList contains the correct data)
        MySingleton.shared.flights.forEach { flightArray in
            flightArray.forEach { flight in
                if let flightFare = Double(String(format: "%.2f", flight.price?.api_total_display_fare ?? "")) {
                    // Check if the fare is already present in the dictionary
                    if let existingFlights = similarFlightsDictionary[flightFare] {
                        // If it exists, append the current flight to the existing array
                        var updatedFlights = existingFlights
                        updatedFlights.append([flight])
                        similarFlightsDictionary[flightFare] = updatedFlights
                    } else {
                        // If it doesn't exist, create a new array with the current flight
                        similarFlightsDictionary[flightFare] = [[flight]]
                    }
                }
            }
        }
        
        // To access the flights with a specific fare, you can do something like this:
        if let flightsWithFare = similarFlightsDictionary[fare] {
            // flightsWithFare will contain an array of flights with api_total_display_fare equal to the specified fare
            return flightsWithFare
        } else {
            // If no similar flights found for the specified fare, return an empty array
            return []
        }
    }
}




extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: [Iterator.Element: Bool] = [:]
        return self.filter { seen.updateValue(true, forKey: $0) == nil }
    }
}



//MARK: - AppliedFilters

extension FlightResultVC:AppliedFilters {
    func hotelFilterByApplied(minpricerange: Double, maxpricerange: Double, starRating: String, starRatingNew: [String], refundableTypeArray: [String], nearByLocA: [String], niberhoodA: [String], aminitiesA: [String]) {
        
    }
    
    
    
    
    func isTimeInRange(time: String, range: String) -> Bool {
        guard let departureDate = MySingleton.shared.dateFormatter.date(from: time) else {
            return false
        }
        
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: departureDate)
        
        // Convert the 12-hour format to 24-hour format
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh a"
        guard let startDate = dateFormatter.date(from: range.components(separatedBy: " - ")[0]),
              let endDate = dateFormatter.date(from: range.components(separatedBy: " - ")[1]) else {
            return false
        }
        
        let startHour = calendar.component(.hour, from: startDate)
        let endHour = calendar.component(.hour, from: endDate)
        
        // Check if the hour falls within the range
        return hour >= startHour && hour < endHour
    }
    
    
    func filtersByApplied(minpricerange: Double, maxpricerange: Double, noofStopsArray: [String], refundableTypeArray: [String], departureTime: [String], arrivalTime: [String], noOvernightFlight: [String], airlinesFilterArray: [String], luggageFilterArray: [String], connectingFlightsFilterArray: [String], ConnectingAirportsFilterArray: [String]) {
        
        print(" ===== minpricerange ====== \n\(minpricerange)")
        print(" ===== maxpricerange ====== \n\(maxpricerange)")
        print(" ===== noofStopsArray ====== \n\(noofStopsArray.joined(separator: ","))")
        print(" ===== refundableTypeArray ====== \n\(refundableTypeArray)")
        print(" ===== airlinesFilterArray ====== \n\(airlinesFilterArray.joined(separator: ","))")
        print(" ===== departureTime ====== \n\(departureTime)")
        print(" ===== arrivalTime ====== \n\(arrivalTime)")
        print(" ===== noOvernightFlight ====== \n\(noOvernightFlight)")
        print(" ===== connectingFlightsFilterArray ====== \n\(connectingFlightsFilterArray)")
        print(" ===== ConnectingAirportsFilterArray ====== \n\(ConnectingAirportsFilterArray)")
        print(" ===== luggageFilterArray ====== \n\(luggageFilterArray)")
        
        
        
        let sortedArray = flnew.map { flight in
            flight.filter { j in
                
                guard let summary = j.first?.flight_details?.summary else { return false }
                guard let price = j.first?.price?.api_total_display_fare else { return false }
                guard let details = j.first?.flight_details?.details else { return false }
                
                let priceRangeMatch = ((Double(price) ) >= minpricerange && (Double(price) ) <= maxpricerange)
                let noOfStopsMatch = noofStopsArray.isEmpty || summary.contains(where: { noofStopsArray.contains("\($0.no_of_stops ?? 0)") }) == true
                let refundableMatch = refundableTypeArray.isEmpty || refundableTypeArray.contains(j.first?.fareType ?? "")
                let airlinesMatch = airlinesFilterArray.isEmpty || summary.contains(where: { airlinesFilterArray.contains($0.operator_name ?? "") }) == true
                
                
                
                let connectingFlightsMatch = flight.contains { flight in
                    if connectingFlightsFilterArray.isEmpty {
                        return true // Return true for all flights if 'connectingAirportsFA' is empty
                    }
                    
                    
                    for summaryArray in details {
                        if summaryArray.contains(where: { flightDetail in
                            let operatorname = flightDetail.operator_name ?? ""
                            return connectingFlightsFilterArray.contains("\(operatorname)")
                        }) {
                            return true // Return true for this flight if it contains a matching airport
                        }
                    }
                    
                    
                    return false // Return false if no matching airport is found in this flight
                }
                
                
                
                let ConnectingAirportsMatch = flight.contains { flight in
                    if ConnectingAirportsFilterArray.isEmpty {
                        return true // Return true for all flights if 'connectingAirportsFA' is empty
                    }
                    
                    
                    for summaryArray in details {
                        if summaryArray.contains(where: { flightDetail in
                            let airportName = flightDetail.destination?.airport_name ?? ""
                            return ConnectingAirportsFilterArray.contains("\(airportName)")
                        }) {
                            return true // Return true for this flight if it contains a matching airport
                        }
                    }
                    
                    
                    return false // Return false if no matching airport is found in this flight
                }
                
                
                
                
                
                let depMatch = departureTime.isEmpty || summary.first?.origin?.time.flatMap { departureDateTime in
                    return departureTime.contains { departureTimeRange in
                        let timeIsInRange = isTimeInRange(time: departureDateTime, range: String(departureTimeRange))
                        return timeIsInRange
                    }
                } ?? false
                
                
                // Filter by arrival time
                let arrMatch = arrivalTime.isEmpty || summary.first?.destination?.time.flatMap { arrivalDateTime in
                    return arrivalTime.contains { arrivalTimeRange in
                        let timeIsInRange = isTimeInRange(time: arrivalDateTime, range: String(arrivalTimeRange)) // Convert Character to String
                        return timeIsInRange
                    }
                } ?? false
                
                
                
                let luggageMatch = luggageFilterArray.isEmpty || summary.contains(where: {
                    let formattedWeight = MySingleton.shared.convertToPC(input: $0.weight_Allowance ?? "")
                    return luggageFilterArray.contains(formattedWeight ?? "")
                }) == true
                
                
                
                return priceRangeMatch && noOfStopsMatch && refundableMatch && airlinesMatch && connectingFlightsMatch && luggageMatch && depMatch && arrMatch && ConnectingAirportsMatch
            }
        }
        
        
        setupTVCell(list: sortedArray ?? [[]])
        
    }
    
    
    //MARK: - SORT BY FILTER
    func filtersSortByApplied(sortBy: SortParameter) {
        
        filterdFlightList?.removeAll()
        
        
        if sortBy == .PriceLow{
            
            let sortedArrays = MySingleton.shared.flights.sorted { (item1, item2) in
                let price1 = item1.first?.price?.api_total_display_fare ?? 0.0
                let price2 = item2.first?.price?.api_total_display_fare ?? 0.0
                return price1 < price2
            }
            
            setupTVCell(list: sortedArrays)
            
            
        }else if sortBy == .PriceHigh{
            
            let sortedArrays = MySingleton.shared.flights.sorted { (item1, item2) in
                let price1 = item1.first?.price?.api_total_display_fare ?? 0.0
                let price2 = item2.first?.price?.api_total_display_fare ?? 0.0
                return price1 > price2
            }
            
            
            setupTVCell(list: sortedArrays)
            
            
        }else if sortBy == .DepartureLow {
            
            let sortedArray = MySingleton.shared.flights.flatMap { $0 }.sorted { a, b in
                let operator_name1 = a.flight_details?.summary?.first?.destination?.time ?? ""
                let operator_name2 = b.flight_details?.summary?.first?.destination?.time ?? ""
                return operator_name1 < operator_name2 // Sort in descending order
            }
            
            setupSortTVCell(list: sortedArray)
            
            
        }else if sortBy == .DepartureHigh {
            
            
            let sortedArray = MySingleton.shared.flights.flatMap { $0 }.sorted { a, b in
                let operator_name1 = a.flight_details?.summary?.first?.destination?.time ?? ""
                let operator_name2 = b.flight_details?.summary?.first?.destination?.time ?? ""
                return operator_name1 > operator_name2 // Sort in descending order
            }
            
            setupSortTVCell(list: sortedArray)
            
            
        }else if sortBy == .ArrivalLow{
            
            let sortedArray = MySingleton.shared.flights.flatMap { $0 }.sorted { a, b in
                let operator_name1 = a.flight_details?.summary?.first?.origin?.time ?? ""
                let operator_name2 = b.flight_details?.summary?.first?.origin?.time ?? ""
                return operator_name1 < operator_name2 // Sort in descending order
            }
            
            setupSortTVCell(list: sortedArray)
            
        }else if sortBy == .ArrivalHigh{
            
            let sortedArray = MySingleton.shared.flights.flatMap { $0 }.sorted { a, b in
                let operator_name1 = a.flight_details?.summary?.first?.origin?.time ?? ""
                let operator_name2 = b.flight_details?.summary?.first?.origin?.time ?? ""
                return operator_name1 > operator_name2 // Sort in descending order
            }
            
            setupSortTVCell(list: sortedArray)
            
            
        }else if sortBy == .DurationLow{
            
            let sortedArray = MySingleton.shared.flights.flatMap { $0 }.sorted { a, b in
                let operator_name1 = a.flight_details?.summary?.first?.duration_seconds ?? 0
                let operator_name2 = b.flight_details?.summary?.first?.duration_seconds ?? 0
                return operator_name1 < operator_name2 // Sort in descending order
            }
            
            setupSortTVCell(list: sortedArray)
            
            
        }else if sortBy == .DurationHigh{
            
            let sortedArray = MySingleton.shared.flights.flatMap { $0 }.sorted { a, b in
                let operator_name1 = a.flight_details?.summary?.first?.duration_seconds ?? 0
                let operator_name2 = b.flight_details?.summary?.first?.duration_seconds ?? 0
                return operator_name1 > operator_name2 // Sort in descending order
            }
            
            setupSortTVCell(list: sortedArray)
            
        }else if sortBy == .airlinessortatoz {
            let sortedArray = MySingleton.shared.flights.flatMap { $0 }.sorted { a, b in
                let operator_name1 = a.flight_details?.summary?.first?.operator_name ?? ""
                let operator_name2 = b.flight_details?.summary?.first?.operator_name ?? ""
                return operator_name1 < operator_name2 // Sort in ascending order
            }
            setupSortTVCell(list: sortedArray)
        } else if sortBy == .airlinessortztoa {
            
            
            let sortedArray = MySingleton.shared.flights.flatMap { $0 }.sorted { a, b in
                let operator_name1 = a.flight_details?.summary?.first?.operator_name ?? ""
                let operator_name2 = b.flight_details?.summary?.first?.operator_name ?? ""
                return operator_name1 > operator_name2 // Sort in ascending order
            }
            setupSortTVCell(list: sortedArray)
            
        } else if sortBy == .nothing{
            setupTVCell(list: MySingleton.shared.flights)
        }
        
    }
    
    
}



//MARK: - addObserver
extension FlightResultVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(modifyclose), name: Notification.Name("modifyclose"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(nointrnetreload), name: Notification.Name("nointrnetreload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        
        
        if MySingleton.shared.callboolapi == true {
            MySingleton.shared.flights.removeAll()
            
            holderView.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
                callActiveBookingSourceAPI()
            }
            
            
        }
    }
    
    @objc func modifyclose() {
        self.holderView.isHidden = false
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
    
    
    
    func callGetRecentSearchAPI() {
        MySingleton.shared.recentsearchvm?.CALL_GET_FLIGHT_SEARCH_RECENT_DATA_API(dictParam: [:])
    }
    
    func flightRecentSearchDate(response: SearchDataModel) {
        MySingleton.shared.recentData = response.recent_searches ?? []
    }
    
    func removeflightRecentSearchDate(response: LoginModel) {
        
    }
}



//MARK: - Call Flight Details when book now btn tap
extension FlightResultVC {
    
    
    func gotoBookingDetailsVC() {
        guard let vc = BookingDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    
}


extension FlightResultVC {
    
    func callActiveBookingSourceAPI() {
        
        MySingleton.shared.loderString = "loder"
        loderBool = true
        showLoadera()
        
        
        MySingleton.shared.vm?.CALL_GET_ACTIVE_BOOKING_SOURCE_API(dictParam: [:])
    }
    
    func activebookingSourceResult(response: ActiveBookingSourceModel) {
        
        bsDataArray = response.data ?? []
        bookingSourceDataArrayCount = response.data?.count ?? 0
        
        
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
            callGetFlightPreSearchAPI()
        }
    }
    
    func callGetFlightPreSearchAPI() {
        
        MySingleton.shared.vm?.CALL_GET_FLIGHTS_PRE_SEARCH_API(dictParam: MySingleton.shared.payload)
        
    }
    
    func flighPresearchResult(response:MobileFlightPreSearchModel) {
        
        MySingleton.shared.payload1.removeAll()
        
        
        bsDataArray.forEach { i in
            
            let seconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
                callFlightSearch(bookingsource: i.source_id ?? "",
                                 searchid: response.data?[0].search_id ?? 0)
            }
            
        }
        
        
        
    }
    
    func callFlightSearch(bookingsource:String,searchid:Int) {
        
        MySingleton.shared.payload1["search_id"] = "\(searchid)"
        MySingleton.shared.payload1["booking_source"] = bookingsource
        
        MySingleton.shared.vm?.CALL_GET_FLIGHTS_SEARCH_API(dictParam: MySingleton.shared.payload1)
        
    }
    
    
    
    func flightList(response: FlightModel) {
        
        bookingSourceDataArrayCount -= 1
        MySingleton.shared.returnDateTapbool = false
        MySingleton.shared.searchid = "\(response.data?.search_id ?? "0")"
        MySingleton.shared.traceid = response.data?.traceId ?? ""
        
        
        MySingleton.shared.payemail = ""
        MySingleton.shared.paymobile = ""
        MySingleton.shared.paymobilecountrycode = ""
        MySingleton.shared.enablePaymentButtonBool1 = false
        MySingleton.shared.enablePaymentButtonBool2 = false
        
        cityslbl.text = "\(defaults.string(forKey: UserDefaultsKeys.fcity) ?? "") - \(defaults.string(forKey: UserDefaultsKeys.tcity) ?? "")"
        paxlbl.text = "\(MySingleton.shared.adultsCount) Adults | \(MySingleton.shared.childCount) Child | \(MySingleton.shared.infantsCount) Infant | \(defaults.string(forKey: UserDefaultsKeys.selectClass) ?? "")"
        depDatelbl.text = response.data?.search_params?.depature ?? ""
        retDatelbl.text = response.data?.search_params?.searchreturn ?? ""
        citycodeslbl.text = "(\(response.data?.search_params?.from_loc ?? "") - \(response.data?.search_params?.to_loc ?? ""))"
        let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType)
        if journyType == "oneway" {
            datelbl.text = MySingleton.shared.convertDateFormat(inputDate: response.data?.search_params?.depature ?? "", f1: "dd-MM-yyyy", f2: "MMM dd")
            
        }else {
            datelbl.text = "\(MySingleton.shared.convertDateFormat(inputDate: response.data?.search_params?.depature ?? "", f1: "dd-MM-yyyy", f2: "MMM dd")) - \(MySingleton.shared.convertDateFormat(inputDate: response.data?.search_params?.searchreturn ?? "", f1: "dd-MM-yyyy", f2: "MMM dd"))"
            
        }
        
        
        
        if let newResults = response.data?.j_flight_list, !newResults.isEmpty {
            // Append the new data to the existing data
            MySingleton.shared.flights.append(contentsOf: newResults)
            
        } else {
            // No more items to load, update UI accordingly
            print("No more items to load.")
            // You can show a message or hide a loading indicator here
        }
        
        
        if bookingSourceDataArrayCount == 0 {
            
            
            if MySingleton.shared.flights.count <= 0 {
                gotoNoInternetScreen(keystr: "noresult")
                
            }else {
                
                appendPriceAndDate(list: MySingleton.shared.flights)
            }
        }
        
        
        
    }
    
    
    
    
    func appendPriceAndDate(list:[[FlightList]]) {
        
        // Call this when you want to remove the child view controller
        hideLoadera()
        loderBool = false
        self.holderView.isHidden = false
        
        flnew = list
        prices.removeAll()
        kwdPriceArray.removeAll()
        dateArray.removeAll()
        AirlinesArray.removeAll()
        ConnectingFlightsArray.removeAll()
        ConnectingAirportsArray.removeAll()
        luggageArray.removeAll()
        
        
        
        list.forEach { i in
            i.map { k in
                
                k.flight_details?.summary.map({ l in
                    
                    l.map { m in
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "dd MMM yyyy"
                        if let date = dateFormatter.date(from: "\(m.origin?.date ?? "")"){
                            dateFormatter.dateFormat = "dd MMM"
                            _ = dateFormatter.string(from: date)
                            dateArray.append(dateFormatter.string(from: date))
                        }
                        
                        faretypeArray.append(k.fareType ?? "")
                        prices.append("\(k.price?.api_total_display_fare ?? 0.0)")
                        AirlinesArray.append(m.operator_name ?? "")
                        
                        
                        
                        if let convertedString = MySingleton.shared.convertToPC(input: m.weight_Allowance ?? "") {
                            luggageArray.append(convertedString)
                        } else {
                            print("Invalid input format")
                        }
                        
                        
                    }
                })
                
                k.flight_details?.details?.forEach({ a in
                    a.forEach { b in
                        ConnectingFlightsArray.append(b.operator_name ?? "")
                        ConnectingAirportsArray.append(b.destination?.airport_name ?? "")
                    }
                })
                
            }
        }
        
        
        faretypeArray = faretypeArray.unique()
        dateArray = dateArray.unique()
        AirlinesArray = AirlinesArray.unique()
        ConnectingFlightsArray = ConnectingFlightsArray.unique()
        ConnectingAirportsArray = ConnectingAirportsArray.unique()
        prices = prices.unique()
        luggageArray = luggageArray.unique()
        
        
        DispatchQueue.main.async {
            self.setupTVCell(list: MySingleton.shared.flights)
        }
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
            callGetRecentSearchAPI()
        }
        
        
    }
    
    
    func setupTVCell(list:[[FlightList]]) {
        MySingleton.shared.tablerow.removeAll()
        
        
        var updatedUniqueList: [[FlightList]] = []
        updatedUniqueList = getUniqueElements_oneway(inputArray: list)
        
        
        updatedUniqueList.forEach { i in
            i.forEach { j in
                
                
                
                let similarFlights1 = similar(fare: Double(String(format: "%.2f", j.price?.api_total_display_fare ?? "")) ?? 0.0)
                
                
                MySingleton.shared.tablerow.append(TableRow(title: j.selectedResult,
                                                            subTitle: j.booking_source,
                                                            refundable:j.fareType,
                                                            key: "fl",
                                                            text: j.booking_source_key,
                                                            headerText: j.serialized_journeyKey,
                                                            data: similarFlights1,
                                                            moreData: j,
                                                            tempInfo: j.farerulesref_Key,
                                                            cellType:.FlightResultTVCell,
                                                            userCatdetails:j.journeyKey,
                                                            data1: j.flight_details?.summary,
                                                            data2: j.farerulesref_content))
            }
        }
        
        
        
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
        
    }
    
    
    
    
    func setupSortTVCell(list:[FlightList]) {
        MySingleton.shared.tablerow.removeAll()
        
        
        
        var updatedUniqueList: [FlightList] = []
        updatedUniqueList = getUniqueElements(inputArray: list)
        
        updatedUniqueList.forEach { j in
            
            
            
            let similarFlights1 = similar(fare: Double(String(format: "%.2f", j.price?.api_total_display_fare ?? "")) ?? 0.0)
            
            
            MySingleton.shared.tablerow.append(TableRow(title: j.selectedResult,
                                                        subTitle: j.booking_source,
                                                        refundable:j.fareType,
                                                        key: "fl",
                                                        text: j.booking_source_key,
                                                        headerText: j.serialized_journeyKey,
                                                        data: similarFlights1,
                                                        moreData: j,
                                                        tempInfo: j.farerulesref_Key,
                                                        cellType:.FlightResultTVCell,
                                                        userCatdetails:j.journeyKey,
                                                        data1: j.flight_details?.summary,
                                                        data2: j.farerulesref_content))
            
        }
        
        
        
        
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
        
    }
    
}
