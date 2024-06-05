//
//  SelectSportsListVC.swift
//  Travgate
//
//  Created by FCI on 10/05/24.
//

import UIKit

class SelectSportsListVC: BaseTableVC, SportListVMDelegate, AppliedSportsFilters {
    
    
    
    @IBOutlet weak var teamlbl: UILabel!
    @IBOutlet weak var venulbl: UILabel!
    @IBOutlet weak var dateslbl: UILabel!
    
    
    static var newInstance: SelectSportsListVC? {
        let storyboard = UIStoryboard(name: Storyboard.Sports.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SelectSportsListVC
        return vc
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        if callapibool == true {
            callAPI()
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        MySingleton.shared.sportListVM = SportListVM(self)
    }
    
    
    @IBAction func didTapOnFilterBtnAction(_ sender: Any) {
        gotoFilterVC(strkey: "sportfilter")
    }
    
    @IBAction func didTapOnSortBtnAction(_ sender: Any) {
       // gotoFilterVC(strkey: "sportfilter")
    }
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        callapibool = false
        dismiss(animated: true)
    }
    
    
    
    override func didTapOnViewTicketBtnAction(cell: SportInfoTVCell) {
        
        MySingleton.shared.sports_searchid = cell.searchid
        MySingleton.shared.sports_token = cell.token
        
        didTapOnViewTicketBtnAction()
        
        
    }
    
    
    
    @IBAction func didTapOnModifySearchBtnAction(_ sender: Any) {
        gotoModifySportSearchVC()
    }
    
    func gotoModifySportSearchVC() {
        callapibool = true
        guard let vc = ModifySportSearchVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    
    
    
    //MARK: - gotoFilterVC
    func gotoFilterVC(strkey:String) {
        guard let vc = FilterVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.sportsdelegate = self
        vc.filterKey = strkey
        present(vc, animated: true)
    }
}



extension SelectSportsListVC {
    
    
    func setupUI(){
        
        commonTableView.registerTVCells(["SportInfoTVCell",
                                         "EmptyTVCell"])
        
        
    }
    
    
    func callAPI() {
        
        MySingleton.shared.loderString = "fdetails"
        MySingleton.shared.afterResultsBool = true
        loderBool = true
        showLoadera()
        
        
        MySingleton.shared.sportListVM?.CALL_GET_PRE_SPORTS_SEARCH_API(dictParam: MySingleton.shared.payload)
    }
    
    func sportPreSearchResponse(response: LoginModel) {
        
        
        DispatchQueue.main.async {
            MySingleton.shared.payload.removeAll()
            MySingleton.shared.sportListVM?.CALL_GET_SPORTS_SEARCH_API(dictParam: [:], searchid: "\(response.search_id ?? 0)")
        }
    }
    
    func sportListResponse(response: SportListModel) {
        
        teamlbl.text = MySingleton.shared.sportscityName
        venulbl.text = MySingleton.shared.sportsVenuName
        dateslbl.text = "\(MySingleton.shared.convertDateFormat(inputDate: MySingleton.shared.sportFromDate, f1: "dd-MM-yyyy", f2: "MMM dd")) - \(MySingleton.shared.convertDateFormat(inputDate: MySingleton.shared.sportToDate, f1: "dd-MM-yyyy", f2: "MMM dd"))"
        
        MySingleton.shared.sportslistArray = response.data ?? []
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [unowned self] in
            loderBool = false
            hideLoadera()
        }
        
        
        
        
        DispatchQueue.main.async {
            self.appendValues(list: MySingleton.shared.sportslistArray)
        }
        
        DispatchQueue.main.async {
            self.setupTVCells(list: MySingleton.shared.sportslistArray)
        }
        
        
    }
    
    
    func setupTVCells(list:[SportListData]) {
        
        MySingleton.shared.tablerow.removeAll()
        
        if list.isEmpty == false {
            
            list.forEach { i in
                MySingleton.shared.tablerow.append(TableRow(title:i.eventType?.name,
                                                            subTitle: i.name,
                                                            
                                                            price: "\(i.minTicketPrice?.price ?? 0)",
                                                            currency: "\(i.minTicketPrice?.currency ?? "")",
                                                            
                                                            searchid: i.search_id,
                                                            tokenid: i.token, 
                                                            key: "list",
                                                            headerText: i.venue?.name,
                                                            moreData: i.participants,
                                                            tempText: "\(i.dateOfEvent ?? "")-\(i.timeOfEvent ?? "")",
                                                            cellType:.SportInfoTVCell))
                
                
                
                
            }
            
            MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
            
            
        }else {
            TableViewHelper.EmptyMessage(message: "No Data Found", tableview: self.commonTableView, vc: self)
        }
        
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
    func didTapOnViewTicketBtnAction() {
        gotoViewTicketInfoVC()
        
        
    }
    
    
    
    func gotoViewTicketInfoVC() {
        callapibool = true
        guard let vc = ViewTicketInfoVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
}


extension SelectSportsListVC {
    
    
    func appendValues(list:[SportListData]) {
        
        tournamentArray.removeAll()
        eventsArray.removeAll()
        sportsCityArray.removeAll()
        sportsCountryArray.removeAll()
        
        list.forEach { i in
            
            tournamentArray.append(i.tournament?.name ?? "")
            eventsArray.append(i.eventType?.name ?? "")
            sportsCityArray.append(i.city?.name ?? "")
            sportsCountryArray.append(i.country?.name ?? "")
            
        }
        
        tournamentArray = tournamentArray.unique()
        eventsArray = eventsArray.unique()
        sportsCityArray = sportsCityArray.unique()
        sportsCountryArray = sportsCountryArray.unique()
        
    }
    
    func sportFilterByApplied(tournamentA: [String], eventsA: [String], sportsCityA: [String], sportsCountryA: [String]) {
        // Print the input arrays
        print(" ===== tournamentA ====== \n\(tournamentA.joined(separator: ","))")
        print(" ===== eventsA ====== \n\(eventsA.joined(separator: ","))")
        print(" ===== sportsCityA ====== \n\(sportsCityA.joined(separator: ","))")
        print(" ===== sportsCountryA ====== \n\(sportsCountryA.joined(separator: ","))")

        // Filter the sports list array based on the input arrays
        let filteredSportsList = MySingleton.shared.sportslistArray.filter { event in
            let isTournamentMatch = tournamentA.isEmpty || (event.tournament?.name != nil && tournamentA.contains(event.tournament!.name!))
            let isEventMatch = eventsA.isEmpty || (event.eventType?.name != nil && eventsA.contains(event.eventType!.name!))
            
            let isCityMatch = sportsCityA.isEmpty || (event.city?.name != nil && sportsCityA.contains(event.city?.name ?? ""))
            let isCountryMatch = sportsCountryA.isEmpty || (event.country?.name != nil && sportsCountryA.contains(event.country?.name! ?? ""))
            
            return isTournamentMatch && isEventMatch && isCityMatch && isCountryMatch
        }

        setupTVCells(list: filteredSportsList)
        
    }

    
    
    
}
