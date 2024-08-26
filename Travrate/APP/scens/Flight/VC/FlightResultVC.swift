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
    
    var arrayIndex = 0
    var filterdFlightList :[[FlightList]]?
    var bsDataArray = [ABSData]()
    var bookingSourceDataArrayCount = Int()
    var flights = [[FlightList]]()
    
    override func viewWillDisappear(_ animated: Bool) {
        flights.removeAll()
    }
    
    
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
        
        
        setuplabels(lbl: cityslbl, text: "", textcolor: .BackBtnColor, font: .InterBold(size: 14), align: .center)
        setuplabels(lbl: datelbl, text: "", textcolor: .BackBtnColor, font: .InterRegular(size: 14), align: .center)
        setuplabels(lbl: paxlbl, text: "", textcolor: .BackBtnColor, font: .InterRegular(size: 14), align: .center)
        
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
        
        if cell.bookNowlbl.text != "Select Fare" {
            gotoFlightDeatilsVC()
        }else {
            showToast(message: "Still Under Development")
        }
        
        
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
            
            if cell.bookNowlbl.text != "Select Fare" {
                guard let vc = SimilarFlightsVC.newInstance.self else {return}
                vc.modalPresentationStyle = .overCurrentContext
                callapibool = true
                MySingleton.shared.similarflightList = cell.newsimilarList
                present(vc, animated: true)
            }else {
                showToast(message: "Still Under Development")
            }
            
            
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
        vc.isfromVC = "back"
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
        NotificationCenter.default.post(name: NSNotification.Name("durationreset"), object: nil)
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
        vc.isfromVC = "resultsReturn"
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
    
    
    
    //MARK: - didTapOnShareBtnAction  FlightResultTVCell
    override func didTapOnShareBtnAction(cell:FlightResultTVCell) {
        MySingleton.shared.shareresultrandomid = cell.shareresultrandomid
        MySingleton.shared.shareresultaccesskey = cell.shareresultaccesskey
        MySingleton.shared.shareresultbookingsource = cell.shareresultbookingsource
        
        
        if cell.bookNowlbl.text != "Select Fare" {
            gotoShareResultVC()
        }else {
            showToast(message: "Still Under Development")
        }
    }
    
    
    func gotoShareResultVC() {
        guard let vc = ShareResultVC.newInstance.self else {return}
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
        flights.forEach { flightArray in
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
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm" // Adjusted for "HH:mm" format
        
        guard let timeDate = timeFormatter.date(from: time) else {
            print("Failed to parse time:", time)
            return false
        }
        
        let calendar = Calendar.current
        let timeInMinutes = calendar.component(.hour, from: timeDate) * 60 + calendar.component(.minute, from: timeDate)
        
        let rangeComponents = range.components(separatedBy: " - ")
        guard rangeComponents.count == 2 else {
            print("Invalid range format:", range)
            return false
        }
        
        guard let startTime = parseTime(from: rangeComponents[0]),
              let endTime = parseTime(from: rangeComponents[1]) else {
            print("Failed to parse start or end time from range:", range)
            return false
        }
        
        let startMinutes = startTime.hours * 60 + startTime.minutes
        let endMinutes = endTime.hours * 60 + endTime.minutes
        
        if endMinutes < startMinutes {
            // Overnight range
            return timeInMinutes >= startMinutes || timeInMinutes < endMinutes
        } else {
            // Regular range
            return timeInMinutes >= startMinutes && timeInMinutes <= endMinutes
        }
    }
    
    func parseTime(from string: String) -> (hours: Int, minutes: Int)? {
        let trimmedString = string.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh a" // Adjusted for "hh a" format
        
        guard let date = timeFormatter.date(from: trimmedString) else {
            print("Failed to parse time from string:", string)
            return nil
        }
        
        let calendar = Calendar.current
        let hours = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        return (hours, minutes)
    }
    
    
    func filtersByApplied(minpricerange: Double, maxpricerange: Double, noofStopsArray: [String], refundableTypeArray: [String], departureTime: [String], arrivalTime: [String], noOvernightFlight: [String], airlinesFilterArray: [String], luggageFilterArray: [String], connectingFlightsFilterArray: [String], ConnectingAirportsFilterArray: [String], mindurationrange: Double, maxdurationrange: Double, minTransitTimerange: Double, maxransitTimerange: Double) {
        
        
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
        
        
        print(" ===== mindurationrange ====== \n\(mindurationrange)")
        print(" ===== maxdurationrange ====== \n\(maxdurationrange)")
        
        print(" ===== minTransitTimerange ====== \n\(minTransitTimerange)")
        print(" ===== maxransitTimerange ====== \n\(maxransitTimerange)")
        
        
        
        let sortedArray = flnew.map { flight in
            flight.filter { j in
                
                guard let summary = j.first?.flight_details?.summary else { return false }
                guard let price = j.first?.price?.api_total_display_fare else { return false }
                guard let details = j.first?.flight_details?.details else { return false }
                
                
                //  let priceRangeMatch = (Double(price) ?? 0) >= minpricerange && (Double(price) ?? 0) <= maxpricerange
                
                let priceRangeMatch = ((Double(price) ) >= minpricerange && (Double(price) ) <= maxpricerange)
                //                let noOfStopsMatch = noofStopsArray.isEmpty || summary.contains(where: { noofStopsArray.contains("\($0.no_of_stops ?? 0)") }) == true
                
                
                guard let firstFlightDetail = summary.first else {
                    print("No flight details found in the first element")
                    // Handle case where there are no flight details
                    return false // or handle accordingly
                }
                // Now you can apply your no_of_stops matching logic on the `firstFlightDetail`
                let noOfStopsMatch = noofStopsArray.isEmpty || noofStopsArray.contains("\(firstFlightDetail.no_of_stops ?? 0)")
                
                
                
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
                
                
                
                //                let luggageMatch = luggageFilterArray.isEmpty || summary.contains(where: {
                //                    let formattedWeight = MySingleton.shared.convertToPC(input: $0.weight_Allowance ?? "")
                //                    return luggageFilterArray.contains(formattedWeight ?? "")
                //                }) == true
                
                guard let firstFlightDetail = details.first?.first else {
                    print("No flight details found in the first element")
                    // Handle case where there are no flight details
                    return false // or handle accordingly
                }
                
                // Now you can apply your luggage matching logic on the `firstFlightDetail`
                let formattedWeight = MySingleton.shared.convertToPC(input: firstFlightDetail.weight_Allowance ?? "")
                let luggageMatch = luggageFilterArray.isEmpty || formattedWeight.map { luggageFilterArray.contains($0) } ?? false
                
                
                // Duration filtering
                let durationMatch = summary.allSatisfy { flightDetail in
                    if let durationString = flightDetail.duration, let durationInHours = parseDuration(durationString) {
                        return durationInHours >= mindurationrange && durationInHours <= maxdurationrange
                    }
                    return false
                }
                
                
                
                // Transit time matching
                let transitTimeMatch: Bool
                if let layoverDetails = details.first {
                    transitTimeMatch = details.flatMap { $0 }.contains { flightDetail in
                        if let layoverDurationStr = flightDetail.layover_duration, let layoverDuration = parseDuration(layoverDurationStr) {
                            return (layoverDuration >= minTransitTimerange) && (layoverDuration <= maxransitTimerange)
                        }
                        return false
                    }
                } else {
                    transitTimeMatch = false
                }
                
                
                return priceRangeMatch  && noOfStopsMatch && refundableMatch && airlinesMatch && connectingFlightsMatch && luggageMatch && depMatch && arrMatch && ConnectingAirportsMatch && durationMatch
                
                //transitTimeMatch
            }
        }
        
        
        setupTVCell(list: sortedArray ?? [[]])
        
    }
    
    
    // Helper function to parse duration strings into a numerical value representing hours
    func parseDuration(_ duration: String) -> Double? {
        var totalHours: Double = 0.0
        
        // Regular expressions to match hours, minutes, and days
        let hourRegex = try! NSRegularExpression(pattern: "(\\d+)h")
        let minuteRegex = try! NSRegularExpression(pattern: "(\\d+)m")
        let dayRegex = try! NSRegularExpression(pattern: "(\\d+)D")
        
        // Find hours
        if let hourMatch = hourRegex.firstMatch(in: duration, options: [], range: NSRange(location: 0, length: duration.utf16.count)) {
            if let hourRange = Range(hourMatch.range(at: 1), in: duration) {
                let hours = Double(duration[hourRange]) ?? 0.0
                totalHours += hours
            }
        }
        
        // Find minutes
        if let minuteMatch = minuteRegex.firstMatch(in: duration, options: [], range: NSRange(location: 0, length: duration.utf16.count)) {
            if let minuteRange = Range(minuteMatch.range(at: 1), in: duration) {
                let minutes = Double(duration[minuteRange]) ?? 0.0
                totalHours += minutes / 60.0
            }
        }
        
        // Find days
        if let dayMatch = dayRegex.firstMatch(in: duration, options: [], range: NSRange(location: 0, length: duration.utf16.count)) {
            if let dayRange = Range(dayMatch.range(at: 1), in: duration) {
                let days = Double(duration[dayRange]) ?? 0.0
                totalHours += days * 24.0
            }
        }
        
        return totalHours
    }
    
    //MARK: - SORT BY FILTER
    func filtersSortByApplied(sortBy: SortParameter) {
        
        filterdFlightList?.removeAll()
        
        
        if sortBy == .PriceLow{
            
            let sortedArrays = flights.sorted { (item1, item2) in
                let price1 = item1.first?.price?.api_total_display_fare ?? 0.0
                let price2 = item2.first?.price?.api_total_display_fare ?? 0.0
                return price1 < price2
            }
            
            setupTVCell(list: sortedArrays)
            
            
        }else if sortBy == .PriceHigh{
            
            let sortedArrays = flights.sorted { (item1, item2) in
                let price1 = item1.first?.price?.api_total_display_fare ?? 0.0
                let price2 = item2.first?.price?.api_total_display_fare ?? 0.0
                return price1 > price2
            }
            
            
            setupTVCell(list: sortedArrays)
            
            
        }else if sortBy == .DepartureLow {
            
            let sortedArray = flights.flatMap { $0 }.sorted { a, b in
                let operator_name1 = a.flight_details?.summary?.first?.origin?.time ?? ""
                let operator_name2 = b.flight_details?.summary?.first?.origin?.time ?? ""
                return operator_name1 < operator_name2 // Sort in descending order
            }
            
            setupSortTVCell(list: sortedArray)
            
            
        }else if sortBy == .DepartureHigh {
            
            
            let sortedArray = flights.flatMap { $0 }.sorted { a, b in
                let operator_name1 = a.flight_details?.summary?.first?.origin?.time ?? ""
                let operator_name2 = b.flight_details?.summary?.first?.origin?.time ?? ""
                return operator_name1 > operator_name2 // Sort in descending order
            }
            
            setupSortTVCell(list: sortedArray)
            
            
        }else if sortBy == .ArrivalLow{
            
            let sortedArray = flights.flatMap { $0 }.sorted { a, b in
                let operator_name1 = a.flight_details?.summary?.first?.destination?.time ?? ""
                let operator_name2 = b.flight_details?.summary?.first?.destination?.time ?? ""
                return operator_name1 < operator_name2 // Sort in descending order
            }
            
            setupSortTVCell(list: sortedArray)
            
        }else if sortBy == .ArrivalHigh{
            
            let sortedArray = flights.flatMap { $0 }.sorted { a, b in
                let operator_name1 = a.flight_details?.summary?.first?.destination?.time ?? ""
                let operator_name2 = b.flight_details?.summary?.first?.destination?.time ?? ""
                return operator_name1 > operator_name2 // Sort in descending order
            }
            
            setupSortTVCell(list: sortedArray)
            
            
        }else if sortBy == .DurationLow{
            
            let sortedArray = flights.flatMap { $0 }.sorted { a, b in
                let operator_name1 = a.flight_details?.summary?.first?.duration_seconds ?? 0
                let operator_name2 = b.flight_details?.summary?.first?.duration_seconds ?? 0
                return operator_name1 < operator_name2 // Sort in descending order
            }
            
            setupSortTVCell(list: sortedArray)
            
            
        }else if sortBy == .DurationHigh{
            
            let sortedArray = flights.flatMap { $0 }.sorted { a, b in
                let operator_name1 = a.flight_details?.summary?.first?.duration_seconds ?? 0
                let operator_name2 = b.flight_details?.summary?.first?.duration_seconds ?? 0
                return operator_name1 > operator_name2 // Sort in descending order
            }
            
            setupSortTVCell(list: sortedArray)
            
        }else if sortBy == .airlinessortatoz {
            let sortedArray = flights.flatMap { $0 }.sorted { a, b in
                let operator_name1 = a.flight_details?.summary?.first?.operator_name ?? ""
                let operator_name2 = b.flight_details?.summary?.first?.operator_name ?? ""
                return operator_name1 < operator_name2 // Sort in ascending order
            }
            setupSortTVCell(list: sortedArray)
        } else if sortBy == .airlinessortztoa {
            
            
            let sortedArray = flights.flatMap { $0 }.sorted { a, b in
                let operator_name1 = a.flight_details?.summary?.first?.operator_name ?? ""
                let operator_name2 = b.flight_details?.summary?.first?.operator_name ?? ""
                return operator_name1 > operator_name2 // Sort in ascending order
            }
            setupSortTVCell(list: sortedArray)
            
        } else if sortBy == .nothing{
            setupTVCell(list: flights)
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
            flights.removeAll()
            
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
        self.holderView.isHidden = true
        defaults.set(false, forKey: "flightfilteronce")
        MySingleton.shared.loderString = "loder"
        loderBool = true
        showLoadera()
        
        
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
        
        
        
        MySingleton.shared.payemail = ""
        MySingleton.shared.paymobile = ""
        MySingleton.shared.paymobilecountrycode = ""
        MySingleton.shared.enablePaymentButtonBool1 = false
        MySingleton.shared.enablePaymentButtonBool2 = false
        
        cityslbl.text = "\(defaults.string(forKey: UserDefaultsKeys.fcity) ?? "") - \(defaults.string(forKey: UserDefaultsKeys.tcity) ?? "")"
        
        let adultcount = defaults.integer(forKey: UserDefaultsKeys.adultCount)
        let childcount = defaults.integer(forKey: UserDefaultsKeys.childCount)
        let infantcount = defaults.integer(forKey: UserDefaultsKeys.infantsCount)
        let classname = defaults.string(forKey: UserDefaultsKeys.selectClass)
        var labelText = adultcount > 1 ? "Adults \(adultcount)" : "Adult \(adultcount)"
        if childcount > 0 {
            labelText += ", Child \(childcount)"
        }
        if infantcount > 0 {
            labelText += ", Infant \(infantcount)"
        }
        paxlbl.text = "\(labelText) | \(classname ?? "")"
        
        
        if let newResults = response.data?.j_flight_list, !newResults.isEmpty {
            // Append the new data to the existing data
            flights.append(contentsOf: newResults)
            
            
            
            if flights.count > 0 {
                DispatchQueue.main.async {
                    
                    MySingleton.shared.returnDateTapbool = false
                    MySingleton.shared.searchid = "\(response.data?.search_id ?? "0")"
                    MySingleton.shared.traceid = response.data?.traceId ?? ""
                    
                    self.depDatelbl.text = response.data?.search_params?.depature ?? ""
                    self.retDatelbl.text = response.data?.search_params?.searchreturn ?? ""
                    self.citycodeslbl.text = "(\(response.data?.search_params?.from_loc ?? "") - \(response.data?.search_params?.to_loc ?? ""))"
                    let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType)
                    if journyType == "oneway" {
                        self.datelbl.text = MySingleton.shared.convertDateFormat(inputDate: response.data?.search_params?.depature ?? "", f1: "dd-MM-yyyy", f2: "MMM dd")
                    }else {
                        self.datelbl.text = "\(MySingleton.shared.convertDateFormat(inputDate: response.data?.search_params?.depature ?? "", f1: "dd-MM-yyyy", f2: "MMM dd")) - \(MySingleton.shared.convertDateFormat(inputDate: response.data?.search_params?.searchreturn ?? "", f1: "dd-MM-yyyy", f2: "MMM dd"))"
                    }
                    
                    self.appendPriceAndDate(list: self.flights)
                }
            }
            
            
        } else {
            // No more items to load, update UI accordingly
            print("No more items to load.")
            // You can show a message or hide a loading indicator here
        }
        
        
        if bookingSourceDataArrayCount == 0 {
            
            
            if flights.count <= 0 {
                gotoNoInternetScreen(keystr: "noresult")
                
            }else {
                
                hideLoadera()
                loderBool = false
                self.holderView.isHidden = false
                
                // appendPriceAndDate(list: flights)
            }
        }
        
        
        
    }
    
    
    
    
    func appendPriceAndDate(list:[[FlightList]]) {
        
        // Call this when you want to remove the child view controller
        //        hideLoadera()
        //        loderBool = false
        //        self.holderView.isHidden = false
        
        flnew = list
        
        list.forEach { i in
            i.map { k in
                
                k.flight_details?.summary.map({ l in
                    
                    l.map { m in
                        
                        durationArray.append(m.duration ?? "")
                        
                        // durationArray.append("\(k.price?.api_total_display_fare ?? 0.0)")
                        
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
                        
                        noofstopsArray.append("\(m.no_of_stops ?? 0)")
                        
                        if let convertedString = MySingleton.shared.convertToPC(input: m.weight_Allowance ?? "") {
                            luggageArray.append(convertedString)
                        } else {
                            print("Invalid input format")
                        }
                        
                        
                    }
                })
                
                k.flight_details?.details?.forEach({ a in
                    
                    a.forEach { b in
                        
                        if let layoverDuration = b.layover_duration, !layoverDuration.isEmpty {
                            layoverdurationArray.append(layoverDuration)
                        }
                        
                        if b.operator_code != "J9" {
                            ConnectingFlightsArray.append(b.operator_name ?? "")
                        }
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
        durationArray = durationArray.unique()
        noofstopsArray = noofstopsArray.unique()
        layoverdurationArray = layoverdurationArray.unique()
        
        DispatchQueue.main.async {
            self.setupTVCell(list: self.flights)
        }
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
            callGetRecentSearchAPI()
        }
        
        
    }
    
    
    
    
    func setupTVCell(list:[[FlightList]]) {
        MySingleton.shared.tablerow.removeAll()
        
        
        var updatedUniqueList: [[FlightList]] = []
        updatedUniqueList = getUniqueElements_oneway(inputArray: list)
        
        
        
        updatedUniqueList.forEach { array in
            array.enumerated().forEach { (itemIndex, j) in
                
                let uniqueID = generateUniqueID(for: arrayIndex, bookingSource: j.booking_source!, itemIndex: itemIndex)
                
                let similarFlights1 = similar(fare: Double(String(format: "%.2f", j.price?.api_total_display_fare ?? "")) ?? 0.0)
                
                MySingleton.shared.tablerow.append(TableRow(title: j.selectedResult,
                                                            subTitle: j.booking_source,
                                                            refundable:j.fareType,
                                                            key: "fl",
                                                            text: j.booking_source_key,
                                                            headerText: j.serialized_journeyKey,
                                                            data: similarFlights1,
                                                            key1: uniqueID,
                                                            moreData: j,
                                                            tempText: j.access_key,
                                                            tempInfo: j.farerulesref_Key,
                                                            cellType:.FlightResultTVCell,
                                                            userCatdetails:j.journeyKey,
                                                            data1: j.flight_details?.summary,
                                                            data2: j.farerulesref_content))
                
                
                
            }
            arrayIndex += 1
            
        }
        
        
        if updatedUniqueList.count <= 0 {
            MySingleton.shared.tablerow.removeAll()
            TableViewHelper.EmptyMessage(message: "No Data Found", tableview: commonTableView, vc: self)
        }else {
            TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
        }
        
        
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
        
    }
    
    
    func generateUniqueID(for arrayIndex: Int, bookingSource: String, itemIndex: Int) -> String {
        // Prefix for ID: Array index starting from 1
        let prefix = "\(arrayIndex + 1)"
        
        // Booking source part
        let bookingSourcePart = bookingSource
        
        // Suffix for ID: Zero-padded item index starting from 1 within the array
        _ = String(format: "%08d", itemIndex + 1)
        
        // Combine all parts to form the unique ID
        return "\(prefix)\(bookingSourcePart)\((Int(prefix) ?? 0) - 1)"
    }
    
    
    
    
    func setupSortTVCell(list:[FlightList]) {
        MySingleton.shared.tablerow.removeAll()
        
        
        
        var updatedUniqueList: [FlightList] = []
        updatedUniqueList = getUniqueElements(inputArray: list)
        
        // updatedUniqueList.forEach { j in
        updatedUniqueList.enumerated().forEach { (itemIndex, j) in
            
            
            let uniqueID = generateUniqueID(for: arrayIndex, bookingSource: j.booking_source!, itemIndex: itemIndex)
            let similarFlights1 = similar(fare: Double(String(format: "%.2f", j.price?.api_total_display_fare ?? "")) ?? 0.0)
            
            
            MySingleton.shared.tablerow.append(TableRow(title: j.selectedResult,
                                                        subTitle: j.booking_source,
                                                        refundable:j.fareType,
                                                        key: "fl",
                                                        text: j.booking_source_key,
                                                        headerText: j.serialized_journeyKey,
                                                        data: similarFlights1,
                                                        key1: uniqueID,
                                                        moreData: j,
                                                        tempText: j.access_key,
                                                        tempInfo: j.farerulesref_Key,
                                                        cellType:.FlightResultTVCell,
                                                        userCatdetails:j.journeyKey,
                                                        data1: j.flight_details?.summary,
                                                        data2: j.farerulesref_content))
            
            
            
        }
        
        arrayIndex += 1
        
        
        if updatedUniqueList.count <= 0 {
            MySingleton.shared.tablerow.removeAll()
            TableViewHelper.EmptyMessage(message: "No Data Found", tableview: commonTableView, vc: self)
        }else {
            TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
        }
        
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
        
    }
    
}
