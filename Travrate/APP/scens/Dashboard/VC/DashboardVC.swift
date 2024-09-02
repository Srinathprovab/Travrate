//
//  DashboardVC.swift
//  TravgateApp
//
//  Created by FCI on 02/01/24.
//

import UIKit

class DashboardVC: BaseTableVC, AllCountryCodeListViewModelDelegate, SearchDataViewModelDelegate {
    
    
    //MARK: - side menu initial setup
    private var sideMenuViewController: SideMenuViewController!
    private var sideMenuShadowView: UIView!
    private var sideMenuRevealWidth: CGFloat = 260
    private let paddingForRotation: CGFloat = 150
    private var isExpanded: Bool = false
    private var draggingIsEnabled: Bool = false
    private var panBaseLocation: CGFloat = 0.0
    
    //MARK: - Expand/Collapse the side menu by changing trailing's constant
    private var sideMenuTrailingConstraint: NSLayoutConstraint!
    private var revealSideMenuOnTop: Bool = true
    var gestureEnabled: Bool = true
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
        
        if !UserDefaults.standard.bool(forKey: "cookiesExecuteOnce") {
            
            // self.gotoAcceptCookiesVC()
            UserDefaults.standard.set(true, forKey: "cookiesExecuteOnce")
        }
    }
    
    
    
    
    func gotoAcceptCookiesVC() {
        guard let vc = AcceptCookiesVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupUI()
        MySingleton.shared.indexpagevm = IndexPageViewModel(self)
        MySingleton.shared.countrylistvm = AllCountryCodeListViewModel(self)
        MySingleton.shared.recentsearchvm = SearchDataViewModel(self)
    }
    
    
    func setupUI() {
        
        setupMenu()
        commonTableView.registerTVCells(["TabSelectTVCell",
                                         "PopularDestinationsTVCell",
                                         "TopcityGuidesTVCell",
                                         "SpecialOffersTVCell",
                                         "PopularHotelDestinationsTVCell",
                                         "EmptyTVCell"])
        
        
    }
    
    
    func setupTableViewCells() {
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.TabSelectTVCell))
        
        if MySingleton.shared.topFlightDetails.count > 0 {
            MySingleton.shared.tablerow.append(TableRow(cellType:.PopularDestinationsTVCell))
        }
        
        if MySingleton.shared.topHotelDetails.count > 0 {
            MySingleton.shared.tablerow.append(TableRow(cellType:.PopularHotelDestinationsTVCell))
        }
        
        
//        if MySingleton.shared.topCityGuides.count > 0 {
//            MySingleton.shared.tablerow.append(TableRow(cellType:.TopcityGuidesTVCell))
//        }
        
        if MySingleton.shared.deail_code_list.count > 0 {
            MySingleton.shared.tablerow.append(TableRow(cellType:.SpecialOffersTVCell))
        }
        
        
        MySingleton.shared.tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    override func didTapOnMenuBtnAction(cell: TabSelectTVCell) {
        self.tabBarController?.tabBar.isHidden = true
        self.sideMenuState(expanded: self.isExpanded ? false : true)
    }
    
    override func didTapOnSelectCurrencyBtnAction(cell: TabSelectTVCell) {
        gotoSelectLanguageVC()
    }
    
    override func didTapOnFlightTabSelectBtnAction(cell: TabSelectTVCell) {
        
        defaults.set("Flight", forKey: UserDefaultsKeys.tabselect)
        //        defaults.set("Origin", forKey: UserDefaultsKeys.fromcityname)
        //        defaults.set("Destination", forKey: UserDefaultsKeys.tocityname)
        //        defaults.set("Economy", forKey: UserDefaultsKeys.selectClass)
        //        defaults.set("Economy", forKey: UserDefaultsKeys.rselectClass)
        //        defaults.set("Add Date", forKey: UserDefaultsKeys.calDepDate)
        //        defaults.set("Add Date", forKey: UserDefaultsKeys.calRetDate)
        //        defaults.set("1", forKey: UserDefaultsKeys.adultCount)
        //        defaults.set("0", forKey: UserDefaultsKeys.childCount)
        //        defaults.set("0", forKey: UserDefaultsKeys.infantsCount)
        //        defaults.set("ALL", forKey: UserDefaultsKeys.fcariercode)
        //        defaults.set("ALL AIRLINES", forKey: UserDefaultsKeys.fcariername)
        //        defaults.set("1", forKey: UserDefaultsKeys.totalTravellerCount)
        
        
        
        
        gotoFlightSearchVC()
    }
    
    
    override func didTapOnHotelTabSelect(cell: TabSelectTVCell) {
        defaults.set("Hotel", forKey: UserDefaultsKeys.tabselect)
        //        defaults.set("City/Location", forKey: UserDefaultsKeys.locationcity)
        //        defaults.set("Add Date", forKey: UserDefaultsKeys.checkin)
        //        defaults.set("Add Date", forKey: UserDefaultsKeys.checkout)
        //        defaults.set("Select Nationality", forKey: UserDefaultsKeys.hnationality)
        
        gotoSearchHotelVC()
    }
    
    
    override func didTapOnMoreServiceBtnAction(cell: TabSelectTVCell) {
        commonTableView.reloadData()
    }
    
    override func didTapOnClosebtnAction(cell: TabSelectTVCell) {
        commonTableView.reloadData()
    }
    
    override func didTapOnVisabtnAction(cell: TabSelectTVCell) {
        defaults.set("Visa", forKey: UserDefaultsKeys.tabselect)
        // gotoVisaVC()
    }
    
    override func didTapOnHolidaysbtnAction(cell: TabSelectTVCell) {
        defaults.set("Holiday", forKey: UserDefaultsKeys.tabselect)
        gotoHolidaysVC()
    }
    
    override func didTapOnTransfersbtnAction(cell: TabSelectTVCell) {
        defaults.set("transfers", forKey: UserDefaultsKeys.tabselect)
        //        defaults.set("From Airport", forKey: UserDefaultsKeys.transferfromcityname)
        //        defaults.set("", forKey: UserDefaultsKeys.transferfromcityid)
        //        defaults.set("To Airport", forKey: UserDefaultsKeys.transfertocityname)
        //        defaults.set("", forKey: UserDefaultsKeys.transfertocityid)
        //        defaults.set("Select Date", forKey: UserDefaultsKeys.transfercalDepDate)
        //        defaults.set("Select Time", forKey: UserDefaultsKeys.transfercalDepTime)
        //        defaults.set("Select Date", forKey: UserDefaultsKeys.transfercalRetDate)
        //        defaults.set("Select Time", forKey: UserDefaultsKeys.transfercalRetTime)
        //        defaults.set("", forKey: UserDefaultsKeys.transferfromlat)
        //        defaults.set("", forKey: UserDefaultsKeys.transferfromlang)
        //        defaults.set("", forKey: UserDefaultsKeys.transfertolat)
        //        defaults.set("", forKey: UserDefaultsKeys.transfertolang)
        
        
        
        
        gotoBookTransfersVC()
        //showToast(message: "Still Under Development")
    }
    
    override func didTapOnSportsbtnAction(cell: TabSelectTVCell) {
        defaults.set("Sports", forKey: UserDefaultsKeys.tabselect)
        gotoSportsSearchVC()
    }
    
    override func didTapOnCruisebtnAction(cell: TabSelectTVCell) {
        defaults.set("Cruise", forKey: UserDefaultsKeys.tabselect)
        gotoCruiseVC()
    }
    
    override func didTapOnActivitiesbtnAction(cell: TabSelectTVCell) {
        defaults.set("Activities", forKey: UserDefaultsKeys.tabselect)
        //        defaults.set("Select Destination City", forKey: UserDefaultsKeys.activitescityname)
        //        defaults.set("Select Date", forKey: UserDefaultsKeys.calActivitesDepDate)
        //        defaults.set("Select Date", forKey: UserDefaultsKeys.calActivitesRetDate)
        //        defaults.set("1", forKey: UserDefaultsKeys.activitesadultCount)
        //        defaults.set("0", forKey: UserDefaultsKeys.activiteschildCount)
        //        defaults.set("0", forKey: UserDefaultsKeys.activitesinfantsCount)
        //        totalPax = "1"
        gotoActivitiesSearchVC()
        
    }
    
    override func didTapOnInsurencebtnAction(cell:TabSelectTVCell) {
        defaults.set("Insurence", forKey: UserDefaultsKeys.tabselect)
        //  gotoInsuranceVC()
        showToast(message: "Still Under Development")
    }
    
    
    override func didTapOnCarRentalBtnAction(cell:TabSelectTVCell) {
        defaults.set("CarRental", forKey: UserDefaultsKeys.tabselect)
        gotoSearchCarRentalVC()
    }
    
    
    //MARK: - Go To Flight Search
    override func didTapOnPopulardestination(cell: PopularDestinationsTVCell) {
        gotoFlightSearchVC()
    }
    
    
    
    //MARK: - Go To Flight Search
    override func didTapOnPopulardestination(cell: PopularHotelDestinationsTVCell) {
        gotoSearchHotelVC()
    }
    
}


extension DashboardVC:IndexPageViewModelDelegate {
    
    func callIndexPageAPI() {
        MySingleton.shared.indexpagevm?.CALL_INDEX_PAGE_API(dictParam: [:])
    }
    
    
    func indexPageDetails(response: IndexPagemodel) {
        
        MySingleton.shared.topFlightDetails = response.topFlightDetails ?? []
        MySingleton.shared.topHotelDetails = response.topHotelDetails ?? []
        MySingleton.shared.topCityGuides = response.city_guides ?? []
        MySingleton.shared.deail_code_list = response.deail_code_list ?? []
        
        DispatchQueue.main.async {[self] in
            callCountryListAPI()
        }
        
        DispatchQueue.main.async {[self] in
            setupTableViewCells()
        }
        
    }
    
}

extension DashboardVC {
    
    func gotoSelectLanguageVC() {
        guard let vc = SelectLanguageVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    func gotoFlightSearchVC() {
        callapibool = true
        guard let vc = FlightSearchVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.isfromVC = "dashbord"
        present(vc, animated: true)
    }
    
    func gotoSearchHotelVC() {
        callapibool = true
        guard let vc = SearchHotelVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func gotoVisaVC() {
        callapibool = true
        guard let vc = VisaVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    func gotoHolidaysVC() {
        callapibool = true
        guard let vc = HolidaysVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func gotoCruiseVC() {
        callapibool = true
        guard let vc = CruiseVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    
    func gotoActivitiesSearchVC() {
        callapibool = true
        guard let vc = ActivitiesSearchVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func gotoBookTransfersVC() {
        callapibool = true
        guard let vc = BookTransfersVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func gotoSportsSearchVC() {
        
        defaults.set("Select Date", forKey: UserDefaultsKeys.sportcalDepDate)
        defaults.set("Select Date", forKey: UserDefaultsKeys.sportcalRetDate)
        
        callapibool = true
        guard let vc = SportsSearchVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func gotoInsuranceVC() {
        callapibool = true
        guard let vc = InsuranceVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func gotoSearchCarRentalVC() {
        callapibool = true
        
        //        defaults.set("Select Location", forKey: UserDefaultsKeys.pickuplocationname)
        //        defaults.set("", forKey: UserDefaultsKeys.pickuplocationcode)
        //        defaults.set("Select Location", forKey: UserDefaultsKeys.dropuplocationname)
        //        defaults.set("", forKey: UserDefaultsKeys.dropuplocationcode)
        //        defaults.set("Select Date", forKey: UserDefaultsKeys.pickuplocDate)
        //        defaults.set("Select Date", forKey: UserDefaultsKeys.dropuplocDate)
        //        defaults.set("Select Time", forKey: UserDefaultsKeys.pickuplocTime)
        //        defaults.set("Select Time", forKey: UserDefaultsKeys.dropuplocTime)
        //        defaults.set("Select Driver's Age", forKey: UserDefaultsKeys.driverage)
        
        guard let vc = SearchCarRentalVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    
    func setupMenu(){
        
        //MARK: Shadow Background View
        self.sideMenuShadowView = UIView(frame: self.view.bounds)
        self.sideMenuShadowView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.sideMenuShadowView.backgroundColor = .black
        self.sideMenuShadowView.alpha = 0.0
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TapGestureRecognizer))
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.delegate = self
        self.sideMenuShadowView.addGestureRecognizer(tapGestureRecognizer)
        if self.revealSideMenuOnTop {
            view.insertSubview(self.sideMenuShadowView, at: 1)
        }
        
        //MARK: Side Menu
        let storyboard = UIStoryboard(name: "Login", bundle: Bundle.main)
        self.sideMenuViewController = storyboard.instantiateViewController(withIdentifier: "SideMenuViewController") as? SideMenuViewController
        view.insertSubview(self.sideMenuViewController!.view, at: self.revealSideMenuOnTop ? 2 : 0)
        addChild(self.sideMenuViewController!)
        self.sideMenuViewController!.didMove(toParent: self)
        
        //MARK: Side Menu AutoLayout
        self.sideMenuViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        if self.revealSideMenuOnTop {
            self.sideMenuTrailingConstraint = self.sideMenuViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -self.sideMenuRevealWidth - self.paddingForRotation)
            self.sideMenuTrailingConstraint.isActive = true
        }
        NSLayoutConstraint.activate([
            self.sideMenuViewController.view.widthAnchor.constraint(equalToConstant: self.sideMenuRevealWidth + 50),
            self.sideMenuViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.sideMenuViewController.view.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        //MARK: Side Menu Gestures
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        panGestureRecognizer.delegate = self
        view.addGestureRecognizer(panGestureRecognizer)
    }
    
    //MARK: Keep the state of the side menu (expanded or collapse) in rotation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate { _ in
            if self.revealSideMenuOnTop {
                self.sideMenuTrailingConstraint.constant = self.isExpanded ? 0 : (-self.sideMenuRevealWidth - self.paddingForRotation)
            }
        }
    }
    
    func animateShadow(targetPosition: CGFloat) {
        UIView.animate(withDuration: 0.5) {
            //MARK: When targetPosition is 0, which means side menu is expanded, the shadow opacity is 0.6
            self.sideMenuShadowView.alpha = (targetPosition == 0) ? 0.6 : 0.0
        }
    }
    
    
    func sideMenuState(expanded: Bool) {
        if expanded {
            NotificationCenter.default.post(name: NSNotification.Name("callprofileapi"), object: nil)
            self.tabBarController?.tabBar.isHidden = true
            self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? 0 : self.sideMenuRevealWidth) { _ in
                self.isExpanded = true
            }
            // Animate Shadow (Fade In)
            UIView.animate(withDuration: 0.5) { self.sideMenuShadowView.alpha = 0.6 }
            
        }
        else {
            self.tabBarController?.tabBar.isHidden = false
            self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? (-self.sideMenuRevealWidth - self.paddingForRotation) : 0) { _ in
                self.isExpanded = false
            }
            // Animate Shadow (Fade Out)
            UIView.animate(withDuration: 0.5) { self.sideMenuShadowView.alpha = 0.0 }
            
        }
    }
    
    func animateSideMenu(targetPosition: CGFloat, completion: @escaping (Bool) -> ()) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .layoutSubviews, animations: {
            if self.revealSideMenuOnTop {
                self.sideMenuTrailingConstraint.constant = targetPosition
                self.view.layoutIfNeeded()
            }
            else {
                self.view.subviews[1].frame.origin.x = targetPosition
            }
        }, completion: completion)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
}

extension DashboardVC: UIGestureRecognizerDelegate {
    
    @objc func TapGestureRecognizer(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            if self.isExpanded {
                self.sideMenuState(expanded: false)
            }
        }
    }
    
    // Close side menu when you tap on the shadow background view
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: self.sideMenuViewController.view))! {
            return false
        }
        return true
    }
    
    // Dragging Side Menu
    @objc private func handlePanGesture(sender: UIPanGestureRecognizer) {
        
        guard gestureEnabled == true else { return }
        
        let position: CGFloat = sender.translation(in: self.view).x
        let velocity: CGFloat = sender.velocity(in: self.view).x
        
        switch sender.state {
        case .began:
            
            // If the user tries to expand the menu more than the reveal width, then cancel the pan gesture
            if velocity > 0, self.isExpanded {
                sender.state = .cancelled
            }
            
            // If the user swipes right but the side menu hasn't expanded yet, enable dragging
            if velocity > 0, !self.isExpanded {
                self.draggingIsEnabled = true
            }
            // If user swipes left and the side menu is already expanded, enable dragging
            else if velocity < 0, self.isExpanded {
                self.draggingIsEnabled = true
            }
            
            if self.draggingIsEnabled {
                // If swipe is fast, Expand/Collapse the side menu with animation instead of dragging
                let velocityThreshold: CGFloat = 550
                if abs(velocity) > velocityThreshold {
                    self.sideMenuState(expanded: self.isExpanded ? false : true)
                    self.draggingIsEnabled = false
                    return
                }
                
                if self.revealSideMenuOnTop {
                    self.panBaseLocation = 0.0
                    if self.isExpanded {
                        self.panBaseLocation = self.sideMenuRevealWidth
                    }
                }
            }
            
        case .changed:
            
            // Expand/Collapse side menu while dragging
            if self.draggingIsEnabled {
                if self.revealSideMenuOnTop {
                    // Show/Hide shadow background view while dragging
                    let xLocation: CGFloat = self.panBaseLocation + position
                    let percentage = (xLocation * 150 / self.sideMenuRevealWidth) / self.sideMenuRevealWidth
                    
                    let alpha = percentage >= 0.6 ? 0.6 : percentage
                    self.sideMenuShadowView.alpha = alpha
                    
                    // Move side menu while dragging
                    if xLocation <= self.sideMenuRevealWidth {
                        self.sideMenuTrailingConstraint.constant = xLocation - self.sideMenuRevealWidth
                    }
                }
                else {
                    if let recogView = sender.view?.subviews[1] {
                        // Show/Hide shadow background view while dragging
                        let percentage = (recogView.frame.origin.x * 150 / self.sideMenuRevealWidth) / self.sideMenuRevealWidth
                        
                        let alpha = percentage >= 0.6 ? 0.6 : percentage
                        self.sideMenuShadowView.alpha = alpha
                        
                        // Move side menu while dragging
                        if recogView.frame.origin.x <= self.sideMenuRevealWidth, recogView.frame.origin.x >= 0 {
                            recogView.frame.origin.x = recogView.frame.origin.x + position
                            sender.setTranslation(CGPoint.zero, in: view)
                        }
                    }
                }
            }
        case .ended:
            self.draggingIsEnabled = false
            // If the side menu is half Open/Close, then Expand/Collapse with animation
            if self.revealSideMenuOnTop {
                let movedMoreThanHalf = self.sideMenuTrailingConstraint.constant > -(self.sideMenuRevealWidth * 0.5)
                self.sideMenuState(expanded: movedMoreThanHalf)
            }
            else {
                if let recogView = sender.view?.subviews[1] {
                    let movedMoreThanHalf = recogView.frame.origin.x > self.sideMenuRevealWidth * 0.5
                    self.sideMenuState(expanded: movedMoreThanHalf)
                }
            }
        default:
            break
        }
    }
}



//MARK: - addObserver
extension DashboardVC {
    
    func addObserver() {
        
        
        MySingleton.shared.removeallstoredValues()
        
        MySingleton.shared.returnDateTapbool = false
        filterresettapbool = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(nointrnetreload), name: Notification.Name("nointrnetreload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(selectedCurrency), name: Notification.Name("selectedCurrency"), object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("logindone"), object: nil)
        
        
        //        // Iterate over each key and remove it
        //        let dictionary = defaults.dictionaryRepresentation()
        //        for key in dictionary.keys {
        //            defaults.removeObject(forKey: key)
        //        }
        //        NotificationCenter.default.removeObserver(self)
        
        
        if MySingleton.shared.callboolapi == true {
            callIndexPageAPI()
        }
        
    }
    
    
   
    
    
    @objc func selectedCurrency() {
        commonTableView.reloadRows(at: [IndexPath(item: 0, section: 0)], with: .automatic)
    }
    
    
    @objc func reload() {
        DispatchQueue.main.async {[self] in
            commonTableView.reloadData()
        }
    }
    
    @objc func nointrnetreload() {
        DispatchQueue.main.async {[self] in
            callIndexPageAPI()
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


extension DashboardVC {
    
    
    //MARK: - callCountryListAPI
    func callCountryListAPI() {
        MySingleton.shared.countrylistvm?.CALLGETCOUNTRYLIST_API(dictParam: [:])
    }
    
    func getCountryList(response: AllCountryCodeListModel) {
        MySingleton.shared.clist = response.all_country_code_list ?? []
        
        
        DispatchQueue.main.async {[self] in
            callGetRecentSearchAPI()
        }
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



