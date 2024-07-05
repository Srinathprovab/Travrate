//
//  FilterVC.swift
//  BabSafar
//
//  Created by MA673 on 26/07/22.
//

import UIKit



struct FlightFilterModel {
    var minPriceRange: Double?
    var maxPriceRange: Double?
    var noOfStops: [String] = []
    var refundableTypes: [String] = []
    var airlines: [String] = []
    var departureTime: [String] = []
    var arrivalTime: [String] = []
    var noOvernightFlight: [String] = []
    var connectingFlights: [String] = []
    var connectingAirports: [String] = []
    var luggage: [String] = []
    var minDuration: Double?
    var maxDuration: Double?
    var minTransitTimeDuration: Double?
    var maxTransitTimeDuration: Double?
}


struct HotelFilterModel {
    var minPriceRange: Double?
    var maxPriceRange: Double?
    var starRating = String()
    var starRatingNew : [String] = []
    var refundableTypes: [String] = []
    var nearByLocA: [String] = []
    var niberhoodA: [String] = []
    var aminitiesA: [String] = []
}


struct SportsFilterModel {
    
    var TournamentA: [String] = []
    var EventsA: [String] = []
    var SportsCityA: [String] = []
    var SportsCountryA: [String] = []
    
}



enum SortParameter {
    case PriceHigh
    case PriceLow
    case DurationHigh
    case DurationLow
    case DepartureHigh
    case DepartureLow
    case ArrivalHigh
    case ArrivalLow
    case starLow
    case starHeigh
    case nothing
    case airlinessortatoz
    case airlinessortztoa
}


protocol AppliedSportsFilters {
    
    func sportFilterByApplied(tournamentA:[String],
                              eventsA:[String],
                              sportsCityA:[String],
                              sportsCountryA:[String])
    
}

protocol AppliedFilters:AnyObject {
    func filtersSortByApplied(sortBy: SortParameter)
    func filtersByApplied(minpricerange:Double,
                          maxpricerange:Double,
                          noofStopsArray:[String],
                          refundableTypeArray:[String],
                          departureTime:[String],
                          arrivalTime:[String],
                          noOvernightFlight:[String],
                          airlinesFilterArray:[String],
                          luggageFilterArray:[String],
                          connectingFlightsFilterArray:[String],
                          ConnectingAirportsFilterArray:[String],
                          mindurationrange:Double,
                          maxdurationrange:Double,
                          minTransitTimerange:Double,
                          maxransitTimerange:Double)
    
    
    
    func hotelFilterByApplied(minpricerange:Double,
                              maxpricerange:Double,
                              starRating: String,
                              starRatingNew: [String],
                              refundableTypeArray:[String],
                              nearByLocA:[String],
                              niberhoodA:[String],
                              aminitiesA:[String])
    
    
    
    
    
}


class FilterVC: BaseTableVC{
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var filterButtonsView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var sortbyBtnView: UIView!
    @IBOutlet weak var sortbyUL: UIView!
    @IBOutlet weak var filterUL: UIView!
    @IBOutlet weak var sortBylbl: UILabel!
    @IBOutlet weak var sortbyBtn: UIButton!
    @IBOutlet weak var filtersBtnView: UIView!
    @IBOutlet weak var filterslbl: UILabel!
    @IBOutlet weak var filtersBtn: UIButton!
    @IBOutlet weak var resetBtn: UIButton!
    
    //MARK: - Flights
    weak var delegate: AppliedFilters?
    var sportsdelegate: AppliedSportsFilters?
    var minpricerangefilter = Double()
    var maxpricerangefilter = Double()
    var mindurationrangefilter = Double()
    var maxdurationrangefilter = Double()
    var minTransitrangefilter = Double()
    var maxTransitrangefilter = Double()
    var starRatingFilter = String()
    var stopsArray = [String]()
    var resetHotelBool = false
    
    var departurnTimeArray = ["12 am - 6 am","06 am - 12 pm","12 pm - 06 pm","06 pm - 12 am"]
    var tablerow = [TableRow]()
    var filterKey = String()
    var noOverNightFlightArray = ["No"]
    var paymentTypeArray = ["Refundable","Non Refundable"]
    var selectedDepartureTime = [String]()
    var selectedArrivalTimeFilter = [String]()
    
    
    
    var selectedTournamentArray = [String]()
    var selectedEventsArray = [String]()
    var selectedSportsCityArray = [String]()
    var selectedSportsCountryArray = [String]()
    
    
    var noOvernightFlightFilterStr = [String]()
    var noOfStopsFilterArray = [String]()
    var refundablerTypeFilteArray = [String]()
    var departureTimeFilter = [String]()
    var arrivalTimeFilter = [String]()
    var airlinesFilterArray = [String]()
    var connectingFlightsFilterArray = [String]()
    var ConnectingAirportsFilterArray = [String]()
    var flightRefundablerTypeFilteArray = [String]()
    
    //MARK: - Hotels
    var selectedNeighbourwoodArray = [String]()
    var selectednearBylocationsArray = [String]()
    var selectedamenitiesArray = [String]()
    var selectedLuggageArray = [String]()
    var hotelRefundablerTypeFilteArray = [String]()
    
    static var newInstance: FilterVC? {
        let storyboard = UIStoryboard(name: Storyboard.Flight.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? FilterVC
        return vc
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        callapibool = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        for noOfStops in noofstopsArray {
            if let stopsInt = Int(noOfStops) {
                if stopsInt == 0 {
                    stopsArray.append("\(stopsInt) Stop")
                } else if stopsInt == 1 {
                    stopsArray.append("\(stopsInt) Stop")
                } else {
                    stopsArray.append("\(stopsInt) Stops")
                }
            }
        }
        
        
       // stopsArray = ["0 Stop","1 Stop","2 Stop"]
        
        
        print("====== print(stopsArray) =======")
        print(stopsArray.joined(separator: ","))
        print(noofstopsArray.joined(separator: ","))
        
        setupUI()
        addObserver()
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("nointernet"), object: nil)
        
    }
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //        setupUI()
    }
    
    
    func setupUI() {
        
        self.view.backgroundColor = .black.withAlphaComponent(0.3)
        setupViews(v: holderView, radius: 10, color: .WhiteColor)
        holderView.layer.borderColor = UIColor.WhiteColor.cgColor
        setupViews(v: filterButtonsView, radius: 0, color: .WhiteColor)
        filterButtonsView.addBottomBorderWithColor(color: .BorderColor, width: 1)
        setupViews(v: sortbyBtnView, radius: 0, color: .WhiteColor)
        setupViews(v: filtersBtnView, radius: 0, color: .WhiteColor)
        setupViews(v: sortbyUL, radius: 0, color: .Buttoncolor)
        setupViews(v: filterUL, radius: 0, color: .WhiteColor)
        setuplabels(lbl: sortBylbl, text: "Sort By", textcolor: .TitleColor, font: .OpenSansBold(size: 18), align: .center)
        setuplabels(lbl: filterslbl, text: "Filters", textcolor: .SubtitleColor, font: .OpenSansBold(size: 18), align: .center)
        closeBtn.setTitle("", for: .normal)
        sortbyBtn.setTitle("", for: .normal)
        filtersBtn.setTitle("", for: .normal)
        //  filterKey = "sort"
        
        filtersBtnView.isHidden = true
        filtersBtn.isUserInteractionEnabled = false
        sortbyBtn.isUserInteractionEnabled = false
        
        switch filterKey {
        case "filter":
            sortBylbl.text = "Filter"
            setupFilterTVCells()
            break
            
        case "sort":
            sortBylbl.text = "Sort"
            setupSortByTVCells()
            break
            
        case "hotelfilter":
            sortBylbl.text = "Filter"
            setupHotelsFilterTVCells()
            break
            
            
        case "sportfilter":
            sortBylbl.text = "Filter"
            setupSportsFilterTVCells()
            break
            
        case "hotelsort":
            sortBylbl.text = "Sort"
            setupHotelsSortByTVCells()
            break
            
            
        default:
            break
        }
        
        
        resetBtn.setTitle("Reset", for: .normal)
        resetBtn.titleLabel?.textColor = .Buttoncolor
        resetBtn.titleLabel?.font = UIFont.LatoRegular(size: 16)
        commonTableView.registerTVCells(["CheckBoxTVCell",
                                         "EmptyTVCell",
                                         "SortbyTVCell",
                                         "ButtonTVCell",
                                         "PopularFiltersTVCell",
                                         "LabelTVCell",
                                         "SliderTVCell",
                                         "DurationSliderTVCell",
                                         "NewDepartureTimeTVCell",
                                         "DepartureTimeTVCell",
                                         "TransitTimeSliderTVCell",
                                         "FilterDepartureTVCell"])
        
        
        
    }
    
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.4
        v.layer.borderColor = UIColor.WhiteColor.cgColor
    }
    
    
    
    //MARK: - setupFilterTVCells setupSortByTVCells
    func setupFilterTVCells() {
        commonTableView.isScrollEnabled = true
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:"Price",cellType:.SliderTVCell))
        tablerow.append(TableRow(title:"No. Of Stops",data: stopsArray,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(title:"Refundable Type",data: faretypeArray,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(title:"Luggage",data: luggageArray,cellType:.CheckBoxTVCell))
       
        //        tablerow.append(TableRow(title:"Departure Time",cellType:.FilterDepartureTVCell))
        //        tablerow.append(TableRow(title:"Arrival Time",cellType:.FilterDepartureTVCell))
        
        
        //                tablerow.append(TableRow(title:"Departure Time",cellType:.DepartureTimeTVCell))
        //                tablerow.append(TableRow(title:"Arrival Time",cellType:.DepartureTimeTVCell))
        
        
        tablerow.append(TableRow(title:"Departurn Time",key:"time", data: departurnTimeArray,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(title:"Arrival Time",key:"time", data: departurnTimeArray,cellType:.CheckBoxTVCell))
        
        
        //        tablerow.append(TableRow(title:"Departure Time",cellType:.NewDepartureTimeTVCell))
        //        tablerow.append(TableRow(title:"Arrival Time",cellType:.NewDepartureTimeTVCell))
        
        
        tablerow.append(TableRow(title:"No Overnight Flight",data: noOverNightFlightArray,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(title:"Airlines",data: AirlinesArray,cellType:.CheckBoxTVCell))
        
        tablerow.append(TableRow(cellType:.DurationSliderTVCell))
        tablerow.append(TableRow(cellType:.TransitTimeSliderTVCell))
        
        tablerow.append(TableRow(title:"Connecting Flights",data: ConnectingFlightsArray,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(title:"Connecting Airports",data: ConnectingAirportsArray,cellType:.CheckBoxTVCell))
        
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Apply",key: "filterbtn",bgColor: .Buttoncolor,cellType:.ButtonTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    func setupSortByTVCells() {
        
        if screenHeight > 835{
            commonTableView.isScrollEnabled = false
        }
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:"Price",key: "no",cellType:.SortbyTVCell))
        tablerow.append(TableRow(title:"Departure",key: "no",cellType:.SortbyTVCell))
        tablerow.append(TableRow(title:"Arrival Time",key: "no",cellType:.SortbyTVCell))
        tablerow.append(TableRow(title:"Duration",key: "no",cellType:.SortbyTVCell))
        tablerow.append(TableRow(title:"Airlines",key: "airline",cellType:.SortbyTVCell))
        
        
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Done",key: "filterbtn",bgColor: .AppBtnColor,cellType:.ButtonTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    //MARK: - setupHotelsFilterTVCells setupHotelsSortByTVCells
    func setupHotelsFilterTVCells() {
        
        commonTableView.isScrollEnabled = true
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:"Price",cellType:.SliderTVCell))
        tablerow.append(TableRow(title:"Star Ratings",cellType:.PopularFiltersTVCell))
        //   tablerow.append(TableRow(title:"Booking Type",data: paymentTypeArray,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(title:"Neighbourhood",data: neighbourwoodArray,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(title:"Near By Location's",data: nearBylocationsArray,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(title:"Amenities",data: amenitiesArray,cellType:.CheckBoxTVCell))
        
        
        
        tablerow.append(TableRow(height:100,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Apply",key: "btn",cellType:.ButtonTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    func setupHotelsSortByTVCells() {
        commonTableView.isScrollEnabled = false
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:"Price",key: "",cellType:.SortbyTVCell))
        tablerow.append(TableRow(title:"Star",key: "no",cellType:.SortbyTVCell))
        
        tablerow.append(TableRow(height:200,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Done",key: "btn",cellType:.ButtonTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    //MARK: - setupSportsFilterTVCells
    func setupSportsFilterTVCells() {
        
        commonTableView.isScrollEnabled = true
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:"Tournament",data: tournamentArray,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(title:"Events",data: eventsArray,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(title:"City",data: sportsCityArray,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(title:"Country",data: sportsCountryArray,cellType:.CheckBoxTVCell))
        
        
        tablerow.append(TableRow(height:100,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Apply",key: "btn",cellType:.ButtonTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    
    
    override func didTapOnShowMoreBtn(cell:CheckBoxTVCell){
        
        
        switch cell.titlelbl.text {
        case "Airlines":
            cell.nameArray = AirlinesArray
            break
            
        default:
            break
        }
        cell.btnView.isHidden = true
        cell.btnViewHeight.constant = 0
        cell.checkOptionsTV.reloadData()
        
        commonTableView.beginUpdates()
        commonTableView.endUpdates()
        
    }
    
    
    
    override func didTapOnLowtoHighBtn(cell: SortbyTVCell) {
        cell.lowtoHighlbl.textColor = .WhiteColor
        cell.lowtoHighView.backgroundColor = .Buttoncolor
        cell.hightoLowhlbl.textColor = .AppLabelColor
        cell.hightoLowView.backgroundColor = .WhiteColor
        
        
        
        if cell.titlelbl.text == "Price" {
            sortBy = .PriceLow
            
            
            if let cell2 = commonTableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell2)
            }
            
            if let cell3 = commonTableView.cellForRow(at: IndexPath(item: 2, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell3)
            }
            if let cell4 = commonTableView.cellForRow(at: IndexPath(item: 3, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell4)
            }
            
            if let cell5 = commonTableView.cellForRow(at: IndexPath(item: 4, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell5)
            }
        }else if cell.titlelbl.text == "Departure" {
            sortBy = .DepartureLow
            
            if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell1)
            }
            if let cell3 = commonTableView.cellForRow(at: IndexPath(item: 2, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell3)
            }
            if let cell4 = commonTableView.cellForRow(at: IndexPath(item: 3, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell4)
            }
            
            if let cell5 = commonTableView.cellForRow(at: IndexPath(item: 4, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell5)
            }
        }else if cell.titlelbl.text == "Arrival Time" {
            sortBy = .ArrivalLow
            
            if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell1)
            }
            if let cell2 = commonTableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell2)
            }
            if let cell4 = commonTableView.cellForRow(at: IndexPath(item: 3, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell4)
            }
            if let cell5 = commonTableView.cellForRow(at: IndexPath(item: 4, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell5)
            }
        }else if cell.titlelbl.text == "Star" {
            sortBy = .starLow
            if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell1)
            }
            
        }else if cell.titlelbl.text == "Duration"{
            sortBy = .DurationLow
            
            if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell1)
            }
            if let cell2 = commonTableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell2)
            }
            
            if let cell3 = commonTableView.cellForRow(at: IndexPath(item: 2, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell3)
            }
            
            if let cell5 = commonTableView.cellForRow(at: IndexPath(item: 4, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell5)
            }
        }else {
            sortBy = .airlinessortatoz
            
            if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell1)
            }
            if let cell2 = commonTableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell2)
            }
            
            if let cell3 = commonTableView.cellForRow(at: IndexPath(item: 2, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell3)
            }
            
            if let cell4 = commonTableView.cellForRow(at: IndexPath(item: 3, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell4)
            }
        }
        
        
    }
    
    override func didTapOnHightoLowBtn(cell: SortbyTVCell) {
        cell.lowtoHighlbl.textColor = .AppLabelColor
        cell.lowtoHighView.backgroundColor = .WhiteColor
        cell.hightoLowhlbl.textColor = .WhiteColor
        cell.hightoLowView.backgroundColor = .AppCalenderDateSelectColor
        
        if cell.titlelbl.text == "Price" {
            sortBy = .PriceHigh
            
            if let cell2 = commonTableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell2)
            }
            
            if let cell3 = commonTableView.cellForRow(at: IndexPath(item: 2, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell3)
            }
            if let cell4 = commonTableView.cellForRow(at: IndexPath(item: 3, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell4)
            }
            
            if let cell5 = commonTableView.cellForRow(at: IndexPath(item: 4, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell5)
            }
        }else if cell.titlelbl.text == "Departure" {
            sortBy = .DepartureHigh
            
            if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell1)
            }
            if let cell3 = commonTableView.cellForRow(at: IndexPath(item: 2, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell3)
            }
            if let cell4 = commonTableView.cellForRow(at: IndexPath(item: 3, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell4)
            }
            
            if let cell5 = commonTableView.cellForRow(at: IndexPath(item: 4, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell5)
            }
        }else if cell.titlelbl.text == "Arrival Time" {
            sortBy = .ArrivalHigh
            
            if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell1)
            }
            if let cell2 = commonTableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell2)
            }
            if let cell4 = commonTableView.cellForRow(at: IndexPath(item: 3, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell4)
            }
            if let cell5 = commonTableView.cellForRow(at: IndexPath(item: 4, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell5)
            }
        }else if cell.titlelbl.text == "Star" {
            sortBy = .starHeigh
            
            if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell1)
            }
            
        }else if cell.titlelbl.text == "Duration"{
            sortBy = .DurationHigh
            
            if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell1)
            }
            if let cell2 = commonTableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell2)
            }
            
            if let cell3 = commonTableView.cellForRow(at: IndexPath(item: 2, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell3)
            }
            
            if let cell5 = commonTableView.cellForRow(at: IndexPath(item: 4, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell5)
            }
        }else {
            sortBy = .airlinessortztoa
            
            if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell1)
            }
            if let cell2 = commonTableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell2)
            }
            
            if let cell3 = commonTableView.cellForRow(at: IndexPath(item: 2, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell3)
            }
            
            if let cell4 = commonTableView.cellForRow(at: IndexPath(item: 3, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell4)
            }
        }
        
        
    }
    
    
    func resetSortBy(cell:SortbyTVCell) {
        
        cell.lowtoHighlbl.textColor = .AppLabelColor
        cell.lowtoHighView.backgroundColor = .WhiteColor
        cell.hightoLowhlbl.textColor = .AppLabelColor
        cell.hightoLowView.backgroundColor = .WhiteColor
    }
    
    //    func resetFilterValues() {
    //        DispatchQueue.main.async {
    //            self.setupFilterTVCells()
    //        }
    //    }
    
    
    @IBAction func didTapOnResetBtn(_ sender: Any) {
        sortBy = .nothing
        
        
        resetHotelBool = true
        
        if let tabselect = defaults.object(forKey: UserDefaultsKeys.tabselect) as? String  {
            if tabselect == "Flight" {
                if filterKey == "filter" {
                    DispatchQueue.main.async {[self] in
                        resetFilter()
                    }
                }else {
                    DispatchQueue.main.async {[self] in
                        resetFlightSortFilter()
                    }
                }
            }else if tabselect == "Sports" {
                if filterKey == "sportfilter" {
                    DispatchQueue.main.async {[self] in
                        sportsResetFilter()
                    }
                }
            }else {
                
                resetHotelFilter()
            }
        }
        
        
        
    }
    
    
    
    @IBAction func didTapOnCloseBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func didTapOnSortByBtn(_ sender: Any) {
        commonTableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        sortbyTap()
    }
    
    func sortbyTap() {
        filterKey = "sortby"
        sortBylbl.textColor = .Buttoncolor
        sortbyUL.backgroundColor = .Buttoncolor
        filterslbl.textColor = .SubtitleColor
        filterUL.backgroundColor = .WhiteColor
        
        
        if let tabSelected = defaults.string(forKey: UserDefaultsKeys.tabselect) {
            if tabSelected == "Flight" {
                setupSortByTVCells()
            }else if tabSelected == "Sports" {
                
                
            }else {
                setupHotelsSortByTVCells()
            }
        }
    }
    
    
    
    override func didTapOnCheckBox(cell:checkOptionsTVCell){
        
        if let tabselect = defaults.object(forKey: UserDefaultsKeys.tabselect) as? String{
            
            if tabselect == "Flight"  {
                
                
                switch cell.filtertitle {
                    
                    
                case "Departurn Time":
                    selectedDepartureTime.append(cell.titlelbl.text ?? "")
                    break
                    
                case "Arrival Time":
                    selectedArrivalTimeFilter.append(cell.titlelbl.text ?? "")
                    break
                    
                    
                case "No. Of Stops":
                    if cell.titlelbl.text == "0 Stop" {
                        noOfStopsFilterArray.append("0")
                    }else if cell.titlelbl.text == "1 Stop" {
                        noOfStopsFilterArray.append("1")
                    }else {
                        noOfStopsFilterArray.append("2")
                    }
                    
                    break
                    
                case "Refundable Type":
                    
                    
                    flightRefundablerTypeFilteArray.append(cell.titlelbl.text ?? "")
                    
                    break
                    
                case "Airlines":
                    airlinesFilterArray.append(cell.titlelbl.text ?? "")
                    break
                    
                    
                case "Luggage":
                    selectedLuggageArray.append(cell.titlelbl.text ?? "")
                    break
                    
                    
                case "No Overnight Flight":
                    noOvernightFlightFilterStr.append(cell.titlelbl.text ?? "")
                    break
                    
                    
                case "Connecting Flights":
                    connectingFlightsFilterArray.append(cell.titlelbl.text ?? "")
                    break
                    
                    
                case "Connecting Airports":
                    ConnectingAirportsFilterArray.append(cell.titlelbl.text ?? "")
                    break
                    
                    
                    
                default:
                    break
                }
            }else  if tabselect == "Sports"  {
                
                switch cell.filtertitle {
                    
                case "Tournament":
                    selectedTournamentArray.append(cell.titlelbl.text ?? "")
                    break
                    
                case "Events":
                    selectedEventsArray.append(cell.titlelbl.text ?? "")
                    break
                    
                case "City":
                    selectedSportsCityArray.append(cell.titlelbl.text ?? "")
                    break
                    
                case "Country":
                    selectedSportsCountryArray.append(cell.titlelbl.text ?? "")
                    break
                    
                    
                default:
                    break
                }
                
                
            }else {
                
                switch cell.filtertitle {
                    
                    
                case "Booking Type":
                    
                    hotelRefundablerTypeFilteArray.append(cell.titlelbl.text ?? "")
                    
                    break
                    
                    
                    
                case "Neighbourhood":
                    selectedNeighbourwoodArray.append(cell.titlelbl.text ?? "")
                    break
                    
                    
                case "Near By Location's":
                    selectednearBylocationsArray.append(cell.titlelbl.text ?? "")
                    break
                    
                    
                case "Amenities":
                    selectedamenitiesArray.append(cell.titlelbl.text ?? "")
                    break
                    
                    
                    
                    
                default:
                    break
                }
            }
            
            
        }
        
    }
    
    
    override func didTapOnDeselectCheckBox(cell: checkOptionsTVCell) {
        
        if let tabselect = defaults.object(forKey: UserDefaultsKeys.tabselect) as? String{
            
            
            if tabselect == "Flight"  {
                
                switch cell.filtertitle {
                    
                    
                case "Departurn Time":
                    if let index = selectedDepartureTime.firstIndex(of: cell.titlelbl.text ?? "") {
                        selectedDepartureTime.remove(at: index)
                    }
                    break
                    
                case "Arrival Time":
                    if let index = selectedArrivalTimeFilter.firstIndex(of: cell.titlelbl.text ?? "") {
                        selectedArrivalTimeFilter.remove(at: index)
                    }
                    break
                    
                    
                case "No. Of Stops":
                    
                    if cell.titlelbl.text == "0 Stop" {
                        
                        if let index = noOfStopsFilterArray.firstIndex(of: "0") {
                            noOfStopsFilterArray.remove(at: index)
                        }
                    }else if cell.titlelbl.text == "1 Stop" {
                        if let index = noOfStopsFilterArray.firstIndex(of: "1") {
                            noOfStopsFilterArray.remove(at: index)
                        }
                    }else {
                        if let index = noOfStopsFilterArray.firstIndex(of: "2") {
                            noOfStopsFilterArray.remove(at: index)
                        }
                    }
                    
                    
                    
                    break
                    
                case "Refundable Type":
                    
                    if let index = flightRefundablerTypeFilteArray.firstIndex(of: cell.titlelbl.text ?? "") {
                        flightRefundablerTypeFilteArray.remove(at: index)
                    }
                    
                    
                    break
                    
                    
                case "Airlines":
                    if let index = airlinesFilterArray.firstIndex(of: cell.titlelbl.text ?? "") {
                        airlinesFilterArray.remove(at: index)
                    }
                    break
                    
                    
                case "Luggage":
                    
                    if let index = selectedLuggageArray.firstIndex(of: cell.titlelbl.text ?? "") {
                        selectedLuggageArray.remove(at: index)
                    }
                    
                    //                    if selectedLuggageArray.isEmpty == true {
                    //                        filterModel.luggage.removeAll()
                    //                    }
                    
                    print(selectedLuggageArray.joined(separator: "---"))
                    break
                    
                case "No Overnight Flight":
                    
                    if let index = noOvernightFlightFilterStr.firstIndex(of: cell.titlelbl.text ?? "") {
                        noOvernightFlightFilterStr.remove(at: index)
                    }
                    break
                    
                case "Connecting Flights":
                    if let index = connectingFlightsFilterArray.firstIndex(of: cell.titlelbl.text ?? "") {
                        connectingFlightsFilterArray.remove(at: index)
                    }
                    
                    break
                    
                    
                case "Connecting Airports":
                    if let index = ConnectingAirportsFilterArray.firstIndex(of: cell.titlelbl.text ?? "") {
                        ConnectingAirportsFilterArray.remove(at: index)
                    }
                    break
                    
                    
                    
                default:
                    break
                }
            }else if tabselect == "Sports"  {
                
                switch cell.filtertitle {
                    
                    
                case "Tournament":
                    if let index = selectedTournamentArray.firstIndex(of: cell.titlelbl.text ?? "") {
                        selectedTournamentArray.remove(at: index)
                    }
                    break
                    
                case "Events":
                    if let index = selectedEventsArray.firstIndex(of: cell.titlelbl.text ?? "") {
                        selectedEventsArray.remove(at: index)
                    }
                    break
                    
                case "City":
                    if let index = selectedSportsCityArray.firstIndex(of: cell.titlelbl.text ?? "") {
                        selectedSportsCityArray.remove(at: index)
                    }
                    break
                    
                case "Country":
                    if let index = selectedSportsCountryArray.firstIndex(of: cell.titlelbl.text ?? "") {
                        selectedSportsCountryArray.remove(at: index)
                    }
                    break
                    
                    
                default:
                    break
                }
                
                
            }else {
                
                
                switch cell.filtertitle {
                    
                    
                case "Booking Type":
                    
                    if let index = hotelRefundablerTypeFilteArray.firstIndex(of: cell.titlelbl.text ?? "") {
                        hotelRefundablerTypeFilteArray.remove(at: index)
                    }
                    break
                    
                    
                case "Neighbourhood":
                    
                    if let index = selectedNeighbourwoodArray.firstIndex(of: cell.titlelbl.text ?? "") {
                        selectedNeighbourwoodArray.remove(at: index)
                    }
                    break
                    
                    
                case "Near By Location's":
                    
                    if let index = selectednearBylocationsArray.firstIndex(of: cell.titlelbl.text ?? "") {
                        selectednearBylocationsArray.remove(at: index)
                    }
                    break
                    
                    
                case "Amenities":
                    
                    if let index = selectedamenitiesArray.firstIndex(of: cell.titlelbl.text ?? "") {
                        selectedamenitiesArray.remove(at: index)
                    }
                    break
                    
                    
                default:
                    break
                }
            }
            
            
        }
    }
    
    
    //    override func didTapOnTimeBtn(cell:FilterDepartureTVCell){
    //
    //
    //        switch cell.titlelbl.text {
    //        case "Departure Time":
    //
    //
    //            switch cell.timeString {
    //
    //            case "12AM - 6AM":
    //                departureTimeFilter.append("12 am - 6 am")
    //                break
    //
    //            case "6AM - 12PM":
    //                departureTimeFilter.append("06 am - 12 pm")
    //                break
    //
    //            case "12PM - 6PM":
    //                departureTimeFilter.append("12 pm - 06 pm")
    //                break
    //
    //
    //            case "6PM - 12AM":
    //                departureTimeFilter.append("06 pm - 12 am")
    //                break
    //
    //            default:
    //                break
    //            }
    //
    //
    //        case "Arrival Time":
    //
    //            switch cell.timeString {
    //
    //            case "12AM - 6AM":
    //                arrivalTimeFilter.append("12 am - 6 am")
    //                break
    //
    //            case "6AM - 12PM":
    //                arrivalTimeFilter.append("06 am - 12 pm")
    //                break
    //
    //            case "12PM - 6PM":
    //                arrivalTimeFilter.append("12 pm - 06 pm")
    //                break
    //
    //
    //            case "6PM - 12AM":
    //                arrivalTimeFilter.append("06 pm - 12 am")
    //                break
    //
    //            default:
    //                break
    //            }
    //
    //        default:
    //            break
    //        }
    //    }
    
    
    //MARK: - didSelectDepartureTime
//    override func didSelectDepartureTime(cell: DepartureTimeCVCell) {
//        if cell.filterTitle == "Departure Time" {
//            
//            
//            switch cell.titlelbl.text {
//                
//            case "from 12AM":
//                departureTimeFilter.append("12 am - 6 am")
//                break
//                
//            case "from 6AM":
//                departureTimeFilter.append("06 am - 12 pm")
//                break
//                
//            case "from 12PM":
//                departureTimeFilter.append("12 pm - 06 pm")
//                break
//                
//                
//            case "from 6PM":
//                departureTimeFilter.append("06 pm - 12 am")
//                break
//                
//            default:
//                break
//            }
//            
//            
//        }else {
//            arrivalTimeFilter.append(cell.titlelbl.text ?? "")
//            
//            
//            switch cell.titlelbl.text {
//                
//            case "from 12AM":
//                arrivalTimeFilter.append("12 am - 6 am")
//                break
//                
//            case "from 6AM":
//                arrivalTimeFilter.append("06 am - 12 pm")
//                break
//                
//            case "from 12PM":
//                arrivalTimeFilter.append("12 pm - 06 pm")
//                break
//                
//                
//            case "from 6PM":
//                arrivalTimeFilter.append("06 pm - 12 am")
//                break
//                
//            default:
//                break
//            }
//        }
//    }
    
    
    //MARK: - didSelectDepartureTime
//    override func didDeSelectDepartureTime(cell: DepartureTimeCVCell) {
//        
//        if cell.filterTitle == "Departure Time" {
//            if let index = departureTimeFilter.firstIndex(of: cell.titlelbl.text ?? "") {
//                departureTimeFilter.remove(at: index)
//            }
//        }else {
//            if let index = arrivalTimeFilter.firstIndex(of: cell.titlelbl.text ?? "") {
//                arrivalTimeFilter.remove(at: index)
//            }
//        }
//        
//    }
    
    
    
    //MARK: - didTapOnDropDownBtnAction
    override func didTapOnDropDownBtnAction(cell:NewDepartureTimeTVCell) {
        commonTableView.reloadRows(at: [IndexPath(item: cell.indexPath?.row ?? 0, section: 0)], with: .automatic)
        
        print(cell.indexPath?.row ?? 0)
    }
    
    
    
    //MARK: - didTapOnFiltersBtn
    @IBAction func didTapOnFiltersBtn(_ sender: Any) {
        filtertap()
    }
    
    
    func filtertap() {
        filterKey = "filter"
        sortBylbl.textColor = .SubtitleColor
        sortbyUL.backgroundColor = .WhiteColor
        filterslbl.textColor = .Buttoncolor
        filterUL.backgroundColor = .Buttoncolor
        
        if let tabSelected = defaults.string(forKey: UserDefaultsKeys.tabselect) {
            if tabSelected == "Flight" {
                setupFilterTVCells()
            }else if tabSelected == "Sports" {
                setupSportsFilterTVCells()
            }else {
                setupHotelsFilterTVCells()
            }
        }
    }
    
    //MARK: - Apply Filter
    override func btnAction(cell: ButtonTVCell) {
        
        
        
        if let tabselect = defaults.object(forKey: UserDefaultsKeys.tabselect) as? String {
            let pricesFloat = prices.compactMap { Float($0) }
            let durationFloat = durationArray.compactMap { Float($0) }
            let transitTimeFloat = layoverdurationArray.compactMap { Float($0) }
            
            if tabselect == "Flight" {
                
                if filterKey == "filter" {
                    
                    
                    //MARK: - Price
                    if minpricerangefilter != 0.0 {
                        filterModel.minPriceRange = minpricerangefilter
                    }else {
                        filterModel.minPriceRange = Double(pricesFloat.min() ?? 0.0)
                    }
                    
                    if maxpricerangefilter != 0.0 {
                        filterModel.maxPriceRange = maxpricerangefilter
                    }else {
                        filterModel.maxPriceRange = Double(pricesFloat.max() ?? 0.0)
                    }
                    
                    
                    //MARK: - Duration
                    
                    
                    if mindurationrangefilter != 0.0 {
                        filterModel.minDuration = mindurationrangefilter
                    }else {
                        filterModel.minDuration = Double(durationFloat.min() ?? 0.0)
                    }
                    
                    if maxdurationrangefilter != 0.0 {
                        filterModel.maxDuration = maxdurationrangefilter
                    }else {
                        filterModel.maxDuration = Double(durationFloat.max() ?? 0.0)
                    }
                    
                    
                    //MARK: - Transit Time Duration
                    if minTransitrangefilter != 0.0 {
                        filterModel.minTransitTimeDuration = minTransitrangefilter
                    }else {
                        filterModel.minTransitTimeDuration = Double(transitTimeFloat.min() ?? 0.0)
                    }
                    
                    if maxTransitrangefilter != 0.0 {
                        filterModel.maxTransitTimeDuration = maxTransitrangefilter
                    }else {
                        filterModel.maxTransitTimeDuration = Double(transitTimeFloat.max() ?? 0.0)
                    }
                    
                    //MARK: - noOvernightFlightFilterStr
                    
                    if noOvernightFlightFilterStr.isEmpty == false {
                        filterModel.noOvernightFlight = noOvernightFlightFilterStr
                    }else {
                        filterModel.noOvernightFlight.removeAll()
                    }
                    
                    if selectedDepartureTime.isEmpty == false {
                        filterModel.departureTime = selectedDepartureTime
                    }else {
                        filterModel.departureTime.removeAll()
                    }
                    
                    
                    //MARK: - arrivalTimeFilter
                    
                    if selectedArrivalTimeFilter.isEmpty == false {
                        filterModel.arrivalTime = selectedArrivalTimeFilter
                    }else {
                        filterModel.arrivalTime.removeAll()
                    }
                    
                    
                    if !noOfStopsFilterArray.isEmpty {
                        filterModel.noOfStops = noOfStopsFilterArray
                    }else {
                        filterModel.noOfStops.removeAll()
                    }
                    
                    if !flightRefundablerTypeFilteArray.isEmpty {
                        filterModel.refundableTypes = flightRefundablerTypeFilteArray
                    }else {
                        filterModel.refundableTypes.removeAll()
                    }
                    
                    if !airlinesFilterArray.isEmpty {
                        filterModel.airlines = airlinesFilterArray
                    }else {
                        filterModel.airlines.removeAll()
                    }
                    
                    if !connectingFlightsFilterArray.isEmpty {
                        filterModel.connectingFlights = connectingFlightsFilterArray
                    }else {
                        filterModel.connectingFlights.removeAll()
                    }
                    
                    
                    if !ConnectingAirportsFilterArray.isEmpty {
                        filterModel.connectingAirports = ConnectingAirportsFilterArray
                    }else {
                        filterModel.connectingAirports.removeAll()
                    }
                    
                    
                    if !selectedLuggageArray.isEmpty {
                        filterModel.luggage = selectedLuggageArray
                    }else {
                        filterModel.luggage.removeAll()
                    }
                    
                    
                    
                    delegate?.filtersByApplied(minpricerange:filterModel.minPriceRange ?? 0.0,
                                               maxpricerange: filterModel.maxPriceRange ?? 0.0,
                                               noofStopsArray:  filterModel.noOfStops,
                                               refundableTypeArray: filterModel.refundableTypes,
                                               departureTime:  filterModel.departureTime ,
                                               arrivalTime: filterModel.arrivalTime ,
                                               noOvernightFlight: filterModel.noOvernightFlight,
                                               airlinesFilterArray: filterModel.airlines,
                                               luggageFilterArray: filterModel.luggage,
                                               connectingFlightsFilterArray: filterModel.connectingFlights,
                                               ConnectingAirportsFilterArray: filterModel.connectingAirports,
                                               mindurationrange: filterModel.minDuration ?? 0.0,
                                               maxdurationrange: filterModel.maxDuration ?? 0.0,
                                               minTransitTimerange: filterModel.minTransitTimeDuration ?? 0.0,
                                               maxransitTimerange: filterModel.maxTransitTimeDuration ?? 0.0)
                    
                    
                }else {
                    delegate?.filtersSortByApplied(sortBy: sortBy)
                }
            }else if tabselect == "Sports" {
                
                if filterKey == "sportfilter" {
                    
                    if selectedTournamentArray.isEmpty == false {
                        sportsfilterModel.TournamentA = selectedTournamentArray
                    }else {
                        sportsfilterModel.TournamentA.removeAll()
                    }
                    
                    if selectedEventsArray.isEmpty == false {
                        sportsfilterModel.EventsA = selectedEventsArray
                    }else {
                        sportsfilterModel.EventsA.removeAll()
                    }
                    
                    if selectedSportsCityArray.isEmpty == false {
                        sportsfilterModel.SportsCityA = selectedSportsCityArray
                    }else {
                        sportsfilterModel.SportsCityA.removeAll()
                    }
                    
                    
                    if selectedSportsCountryArray.isEmpty == false {
                        sportsfilterModel.SportsCountryA = selectedSportsCountryArray
                    }else {
                        sportsfilterModel.SportsCountryA.removeAll()
                    }
                    
                    
                    sportsdelegate?.sportFilterByApplied(tournamentA: selectedTournamentArray,
                                                         eventsA: selectedEventsArray,
                                                         sportsCityA: selectedSportsCityArray,
                                                         sportsCountryA: selectedSportsCountryArray)
                }
            }else {
                
                if resetHotelBool == true {
                    MySingleton.shared.filterApplyedBool = false
                }else {
                    MySingleton.shared.filterApplyedBool = true
                }
                
                
                
                if minpricerangefilter != 0.0 {
                    hotelfiltermodel.minPriceRange = minpricerangefilter
                }else {
                    hotelfiltermodel.minPriceRange = Double(pricesFloat.min() ?? 0.0)
                }
                
                if maxpricerangefilter != 0.0 {
                    hotelfiltermodel.maxPriceRange = maxpricerangefilter
                }else {
                    hotelfiltermodel.maxPriceRange = Double(pricesFloat.max() ?? 0.0)
                }
                
                
                if !starRatingFilter.isEmpty {
                    hotelfiltermodel.starRating = starRatingFilter
                }else {
                    hotelfiltermodel.starRating = ""
                }
                
                
                if !startRatingArray.isEmpty {
                    hotelfiltermodel.starRatingNew = startRatingArray
                }else {
                    hotelfiltermodel.starRatingNew.removeAll()
                }
                
                
                
                if !hotelRefundablerTypeFilteArray.isEmpty {
                    hotelfiltermodel.refundableTypes = hotelRefundablerTypeFilteArray
                }else {
                    hotelfiltermodel.refundableTypes.removeAll()
                }
                
                if !selectednearBylocationsArray.isEmpty {
                    hotelfiltermodel.nearByLocA = selectednearBylocationsArray
                }else {
                    hotelfiltermodel.nearByLocA.removeAll()
                }
                
                
                if !selectedNeighbourwoodArray.isEmpty {
                    hotelfiltermodel.niberhoodA = selectedNeighbourwoodArray
                }else {
                    hotelfiltermodel.niberhoodA.removeAll()
                }
                
                if !selectedamenitiesArray.isEmpty {
                    hotelfiltermodel.aminitiesA = selectedamenitiesArray
                }else {
                    hotelfiltermodel.aminitiesA.removeAll()
                }
                
                
                
                delegate?.hotelFilterByApplied(minpricerange:  hotelfiltermodel.minPriceRange ?? 0.0,
                                               maxpricerange:  hotelfiltermodel.maxPriceRange ?? 0.0,
                                               starRating:  hotelfiltermodel.starRating,
                                               starRatingNew: startRatingArray,
                                               refundableTypeArray: hotelfiltermodel.refundableTypes,
                                               nearByLocA: hotelfiltermodel.nearByLocA,
                                               niberhoodA: hotelfiltermodel.niberhoodA,
                                               aminitiesA: hotelfiltermodel.aminitiesA)
                
            }
            
            
            
            
        }
        
        
        
        dismiss(animated: true)
    }
    
    
    
    //MARK: - INITIAL SETUP LABELS
    func setuplabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont,align:NSTextAlignment) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
        lbl.numberOfLines = 0
        lbl.textAlignment = align
    }
    
    
    //MARK: - didTapOnStarRatingCell
    override func didTapOnStarRatingCell(cell: StarRatingCVCell) {
        starRatingFilter = cell.titlelbl.text ?? ""
        print(startRatingArray.joined(separator: ","))
    }
    
    
    //MARK: - didTapOnShowSliderBtn  SliderTVCell
    override func didTapOnShowSliderBtn(cell: SliderTVCell) {
        
        
        print("Selected minimum value: \(cell.minValue1)")
        print("Selected maximum value: \(cell.maxValue1)")
        
        minpricerangefilter = cell.minValue1
        maxpricerangefilter = cell.maxValue1
        
        
    }
    
    //MARK: - didTapOnShowSliderBtn  DurationSliderTVCell
    override func didTapOnShowSliderBtn(cell: DurationSliderTVCell) {
        print("Selected minimum value: \(cell.minValue1)")
        print("Selected maximum value: \(cell.maxValue1)")
        
        mindurationrangefilter = cell.minValue1
        maxdurationrangefilter = cell.maxValue1
    }
    
    
    //MARK: - didTapOnShowSliderBtn
    override func didTapOnShowSliderBtn(cell: TransitTimeSliderTVCell) {
        print("Selected minimum value: \(cell.minValue1)")
        print("Selected maximum value: \(cell.maxValue1)")
        
        minTransitrangefilter = cell.minValue1
        maxTransitrangefilter = cell.maxValue1
        
    }
    
    
    
}




extension FilterVC {
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? CheckBoxTVCell {
            
            if cell.showbool == true {
                cell.expand()
                cell.showbool = false
            }else {
                cell.hide()
                cell.showbool = true
            }
            
        }else if let cell = tableView.cellForRow(at: indexPath) as? SliderTVCell {
            if cell.showbool == true {
                cell.expand()
                cell.showbool = false
            }else {
                cell.hide()
                cell.showbool = true
            }
        }else if let cell = tableView.cellForRow(at: indexPath) as? DurationSliderTVCell {
            cell.showbool.toggle()
            if cell.showbool{
                cell.expand()
            }else {
                cell.hide()
            }
        }else if let cell = tableView.cellForRow(at: indexPath) as? TransitTimeSliderTVCell {
            cell.showbool.toggle()
            if cell.showbool{
                cell.expand()
            }else {
                cell.hide()
            }
        }else if let cell = tableView.cellForRow(at: indexPath) as? FilterDepartureTVCell {
            if cell.showbool == true {
                cell.expand()
                cell.showbool = false
            }else {
                cell.hide()
                cell.showbool = true
            }
        }
        
        UIView.animate(withDuration: 0.3) {
            tableView.performBatchUpdates(nil)
        }
    }
    
}



extension FilterVC {
    
    
    //MARK: - ResetFilter For Floights
    func resetFilter() {
        // Reset all values in the FilterModel
        
        
        //MARK: - PRICE
        let pricesFloat = prices.compactMap { Float($0) }
        filterModel.minPriceRange = Double((pricesFloat.min() ?? prices.compactMap { Float($0) }.min()) ?? 0.0)
        filterModel.maxPriceRange = Double((pricesFloat.max() ?? prices.compactMap { Float($0) }.max()) ?? 0.0)
        if let cell = commonTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? SliderTVCell {
            cell.setupUI()
        }
        minpricerangefilter = filterModel.minPriceRange ?? 0.0
        maxpricerangefilter = filterModel.maxPriceRange ?? 0.0
        
        
        
        //MARK: - Duration
        // Parse the duration strings into an array of Double values representing hours
        let parsedDurations = durationArray.map { parseDuration($0) }
        // Determine the minimum and maximum values from the parsed durations
        let minDurationValue = parsedDurations.min() ?? 0.0
        let maxDurationValue = parsedDurations.max() ?? 0.0
        
        filterModel.minDuration = minDurationValue
        filterModel.maxDuration = maxDurationValue
        if let cell = commonTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? DurationSliderTVCell {
            cell.setupUI()
        }
        mindurationrangefilter = filterModel.minDuration ?? minDurationValue
        maxdurationrangefilter = filterModel.maxDuration ?? maxDurationValue
        
        
        
        //MARK: - Transit Time
        // Parse the duration strings into an array of Double values representing hours
        let parsedDurations1 = layoverdurationArray.map { parseDuration($0) }
        // Determine the minimum and maximum values from the parsed durations
        let minDurationValue1 = parsedDurations1.min() ?? 0.0
        let maxDurationValue1 = parsedDurations1.max() ?? 0.0
        
        filterModel.minTransitTimeDuration = minDurationValue1
        filterModel.maxTransitTimeDuration = maxDurationValue1
        if let cell = commonTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? TransitTimeSliderTVCell {
            cell.setupUI()
        }
        
        minTransitrangefilter = filterModel.minTransitTimeDuration ?? minDurationValue1
        maxTransitrangefilter = filterModel.maxTransitTimeDuration ?? maxDurationValue1
        
        NotificationCenter.default.post(name: NSNotification.Name("durationreset"), object: nil)
        
        
        
        filterModel.noOfStops = []
        filterModel.refundableTypes = []
        filterModel.airlines = []
        filterModel.connectingFlights = []
        filterModel.connectingAirports = []
        filterModel.luggage.removeAll()
        filterModel.noOvernightFlight = []
        filterModel.departureTime.removeAll()
        filterModel.arrivalTime.removeAll()
        
        noOfStopsFilterArray.removeAll()
        flightRefundablerTypeFilteArray.removeAll()
        airlinesFilterArray.removeAll()
        connectingFlightsFilterArray.removeAll()
        ConnectingAirportsFilterArray.removeAll()
        selectedLuggageArray.removeAll()
        departureTimeFilter.removeAll()
        arrivalTimeFilter.removeAll()
        selectedDepartureTime.removeAll()
        selectedArrivalTimeFilter.removeAll()
        
        // Deselect all cells in your checkOptionsTVCell table view
        deselectAllCheckOptionsCells()
        
        // Reload the table view to reflect the changes
        commonTableView.reloadData()
    }
    
    func deselectAllCheckOptionsCells() {
        // Iterate through the table view and deselect all cells
        for section in 0..<commonTableView.numberOfSections {
            for row in 0..<commonTableView.numberOfRows(inSection: section) {
                if let cell = commonTableView.cellForRow(at: IndexPath(row: row, section: section)) as? checkOptionsTVCell {
                    cell.unselected()
                }
            }
        }
    }
    
    
    func resetFlightSortFilter() {
        
        if let tabSelected = defaults.string(forKey: UserDefaultsKeys.tabselect) {
            if tabSelected == "Flight" {
                if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortbyTVCell {
                    resetSortBy(cell: cell1)
                }
                if let cell2 = commonTableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? SortbyTVCell {
                    resetSortBy(cell: cell2)
                }
                
                if let cell3 = commonTableView.cellForRow(at: IndexPath(item: 2, section: 0)) as? SortbyTVCell {
                    resetSortBy(cell: cell3)
                }
                if let cell4 = commonTableView.cellForRow(at: IndexPath(item: 3, section: 0)) as? SortbyTVCell {
                    resetSortBy(cell: cell4)
                }
                
                if let cell5 = commonTableView.cellForRow(at: IndexPath(item: 4, section: 0)) as? SortbyTVCell {
                    resetSortBy(cell: cell5)
                }
                
                
            }else {
                if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortbyTVCell {
                    resetSortBy(cell: cell1)
                }
                if let cell2 = commonTableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? SortbyTVCell {
                    resetSortBy(cell: cell2)
                }
            }
        }
    }
    
    
    
    //MARK: - For Sports
    func sportsResetFilter() {
        // Reset all values in the FilterModel
        
        sportsfilterModel.TournamentA = []
        sportsfilterModel.EventsA = []
        sportsfilterModel.SportsCityA = []
        sportsfilterModel.SportsCountryA = []
        
        selectedTournamentArray.removeAll()
        selectedEventsArray.removeAll()
        selectedSportsCityArray.removeAll()
        selectedSportsCountryArray.removeAll()
        
        // Deselect all cells in your checkOptionsTVCell table view
        deselectAllCheckOptionsCells()
        
        // Reload the table view to reflect the changes
        commonTableView.reloadData()
    }
    
    
    
    //MARK: - Reset Hotel Filter
    func resetHotelFilter() {
        // Reset all values in the FilterModel
        
        let pricesFloat = hotelprices.compactMap { Float($0) }
        hotelfiltermodel.minPriceRange = Double((pricesFloat.min() ?? hotelprices.compactMap { Float($0) }.min()) ?? 0.0)
        hotelfiltermodel.maxPriceRange = Double((pricesFloat.max() ?? hotelprices.compactMap { Float($0) }.max()) ?? 0.0)
        if let cell = commonTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? SliderTVCell {
            cell.setupUI()
        }
        minpricerangefilter = hotelfiltermodel.minPriceRange ?? 0.0
        maxpricerangefilter = hotelfiltermodel.maxPriceRange ?? 0.0
        
        
        
        hotelfiltermodel.refundableTypes.removeAll()
        hotelfiltermodel.aminitiesA.removeAll()
        hotelfiltermodel.nearByLocA.removeAll()
        hotelfiltermodel.niberhoodA.removeAll()
        hotelfiltermodel.starRating = ""
        
        starRatingFilter = ""
        hotelRefundablerTypeFilteArray.removeAll()
        selectednearBylocationsArray.removeAll()
        selectedNeighbourwoodArray.removeAll()
        selectedamenitiesArray.removeAll()
        hotelfiltermodel.starRatingNew.removeAll()
        startRatingArray.removeAll()
        
        
        // Deselect all cells in your checkOptionsTVCell table view
        deselectAllCheckOptionsCells()
        
        // Reload the table view to reflect the changes
        commonTableView.reloadData()
    }
    
}



extension FilterVC {
    func addObserver() {
        
        if let tabSelected = defaults.string(forKey: UserDefaultsKeys.tabselect) {
            if tabSelected == "Flight" {
                loadinitiallFlightFilterValues()
            }else if tabSelected == "Sports" {
                loadinitiallSportsFilterValues()
            }else {
                loadinitiallHotelFilterValues()
            }
        }
    }
    
    
    
    func loadinitiallFlightFilterValues(){
        
        if !UserDefaults.standard.bool(forKey: "flightfilteronce") {
            resetFilter()
            defaults.set(true, forKey: "flightfilteronce")
        }
        
        //MARK: - Price
        if filterModel.minPriceRange != 0.0 {
            minpricerangefilter = filterModel.minPriceRange ?? Double(prices.compactMap { Float($0) }.min()!)
        }
        
        if filterModel.maxPriceRange != 0.0 {
            maxpricerangefilter = filterModel.maxPriceRange ?? Double(prices.compactMap { Float($0) }.max()!)
        }
        
        
        // MARK: - Duration
        if filterModel.minDuration != 0.0 {
            let minDuration = durationArray.compactMap { Float($0) }.min() ?? 0.0 // Provide a default value
            mindurationrangefilter = filterModel.minDuration ?? Double(minDuration)
        }
        
        if filterModel.maxDuration != 0.0 {
            let maxDuration = durationArray.compactMap { Float($0) }.max() ?? 0.0 // Provide a default value
            maxdurationrangefilter = filterModel.maxDuration ?? Double(maxDuration)
        }
        
        // MARK: - TransitTime
        if filterModel.minTransitTimeDuration != 0.0 {
            let minDuration = layoverdurationArray.compactMap { Float($0) }.min() ?? 0.0 // Provide a default value
            minTransitrangefilter = filterModel.minTransitTimeDuration ?? Double(minDuration)
        }
        
        if filterModel.maxTransitTimeDuration != 0.0 {
            let maxDuration = layoverdurationArray.compactMap { Float($0) }.max() ?? 0.0 // Provide a default value
            maxTransitrangefilter = filterModel.maxTransitTimeDuration ?? Double(maxDuration)
        }
        
        
        
        //MARK: -
        
        if !filterModel.noOfStops.isEmpty {
            noOfStopsFilterArray = filterModel.noOfStops
        }
        
        if !filterModel.refundableTypes.isEmpty {
            flightRefundablerTypeFilteArray = filterModel.refundableTypes
        }
        
        if !filterModel.departureTime.isEmpty {
            selectedDepartureTime = filterModel.departureTime
        }
        
        if !filterModel.arrivalTime.isEmpty {
            selectedArrivalTimeFilter = filterModel.arrivalTime
        }
        
        if !filterModel.airlines.isEmpty {
            airlinesFilterArray = filterModel.airlines
        }
        
        
        if !filterModel.connectingFlights.isEmpty {
            connectingFlightsFilterArray = filterModel.connectingFlights
        }
        
        if !filterModel.connectingAirports.isEmpty {
            ConnectingAirportsFilterArray = filterModel.connectingAirports
        }
        
        if !filterModel.luggage.isEmpty {
            selectedLuggageArray = filterModel.luggage
        }
        
        
        if !filterModel.noOvernightFlight.isEmpty {
            noOverNightFlightArray = filterModel.noOvernightFlight
        }
        
    }
    
    
    func loadinitiallHotelFilterValues(){
        
        if !UserDefaults.standard.bool(forKey: "hoteltfilteronce") {
            resetHotelFilter()
            defaults.set(true, forKey: "hoteltfilteronce")
        }
        
        
        if hotelfiltermodel.minPriceRange != 0.0 {
            minpricerangefilter = hotelfiltermodel.minPriceRange ?? Double(hotelprices.compactMap { Float($0) }.min()!)
        }
        
        if hotelfiltermodel.maxPriceRange != 0.0 {
            maxpricerangefilter = hotelfiltermodel.maxPriceRange ?? Double(hotelprices.compactMap { Float($0) }.max()!)
        }
        
        
        
        
        if !hotelfiltermodel.refundableTypes.isEmpty {
            hotelRefundablerTypeFilteArray = hotelfiltermodel.refundableTypes
        }
        
        if !hotelfiltermodel.aminitiesA.isEmpty {
            selectedamenitiesArray = hotelfiltermodel.aminitiesA
        }
        
        if !hotelfiltermodel.nearByLocA.isEmpty {
            selectednearBylocationsArray = hotelfiltermodel.nearByLocA
        }
        
        if !hotelfiltermodel.niberhoodA.isEmpty {
            selectedNeighbourwoodArray = hotelfiltermodel.niberhoodA
        }
        
        if !hotelfiltermodel.starRatingNew.isEmpty {
            startRatingArray = hotelfiltermodel.starRatingNew
        }
    }
    
    
    
    
    
    func loadinitiallSportsFilterValues(){
        
        if !UserDefaults.standard.bool(forKey: "sportfilteronce") {
            sportsResetFilter()
            defaults.set(true, forKey: "sportfilteronce")
        }
        
        
        if !sportsfilterModel.TournamentA.isEmpty {
            selectedTournamentArray = sportsfilterModel.TournamentA
        }
        
        if !sportsfilterModel.EventsA.isEmpty {
            selectedEventsArray = sportsfilterModel.EventsA
        }
        
        if !sportsfilterModel.SportsCityA.isEmpty {
            selectedSportsCityArray = sportsfilterModel.SportsCityA
        }
        
        if !sportsfilterModel.SportsCountryA.isEmpty {
            selectedSportsCountryArray = sportsfilterModel.SportsCountryA
        }
        
        
        
    }
    
    
}


extension FilterVC {
    
    func parseDuration(_ duration: String) -> Double {
        var totalHours = 0.0
        
        // Extract days, hours, and minutes
        let dayMatches = duration.matchingStrings(regex: "(\\d+)D")
        let hourMatches = duration.matchingStrings(regex: "(\\d+)h")
        let minuteMatches = duration.matchingStrings(regex: "(\\d+)m")
        
        if let dayMatch = dayMatches.first, let days = Double(dayMatch[1]) {
            totalHours += days * 24.0
        }
        
        if let hourMatch = hourMatches.first, let hours = Double(hourMatch[1]) {
            totalHours += hours
        }
        
        if let minuteMatch = minuteMatches.first, let minutes = Double(minuteMatch[1]) {
            totalHours += minutes / 60.0
        }
        
        return totalHours
    }
    
    
    func formatDuration(hours: Double) -> String {
        if hours < 24 {
            return String(format: "%.1f Hours", hours)
        } else {
            let days = Int(hours / 24)
            let remainingHours = hours.truncatingRemainder(dividingBy: 24)
            return "\(days)D \(String(format: "%.1f Hours", remainingHours))"
        }
    }
    
}
