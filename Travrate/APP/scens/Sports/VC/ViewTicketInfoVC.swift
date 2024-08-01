//
//  ViewTicketInfoVC.swift
//  Travgate
//
//  Created by FCI on 10/05/24.
//

import UIKit

class ViewTicketInfoVC: BaseTableVC, SportDetailsVMDelegate {
    
    @IBOutlet weak var titlelbl: UILabel!
    
    static var newInstance: ViewTicketInfoVC? {
        let storyboard = UIStoryboard(name: Storyboard.Sports.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ViewTicketInfoVC
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
        
        MySingleton.shared.sportsdetailsvm = SportDetailsVM(self)
    }
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        callapibool = false
        dismiss(animated: true)
    }
    
    //MARK: - ViewStadiumBtnsTVCell Delegate Methods
    override func didTapOnViewStadiumBtnAction(cell: ViewStadiumBtnsTVCell) {
        gotoViewStadiumVC(keystr: "stadium")
    }
    
    override func didTapOnSeatingArrangementsBtnAction(cell: ViewStadiumBtnsTVCell) {
        gotoViewStadiumVC(keystr: "seat")
    }
    
    func gotoViewStadiumVC(keystr:String) {
        guard let vc = ViewStadiumVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.keystr = keystr
        self.present(vc, animated: false)
    }
    
    override func didTapOnConfBtnAction(cell: SportsBookNowTVCell) {
        print("didTapOnConfBtnAction")
    }
    
    
    override func didTapOnBookNowBtnAction(cell: SportsBookNowTVCell) {
        MySingleton.shared.sportsTotalPersonCount = cell.sportsTotalPersonCount
        MySingleton.shared.sport_ticket_value = cell.ticketValue
        gotoSportsBookingDetailsVC()
        
    }
    
    func gotoSportsBookingDetailsVC() {
        callapibool = true
        guard let vc = SportsBookingDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    //MARK: - didTapOnTicketsBtnAction SportsStadiumTVCell
    override func didTapOnTicketsBtnAction(cell: SportsStadiumTVCell) {
        setupTVCells()
    }
    
    
    
}



extension ViewTicketInfoVC {
    
    
    func setupUI(){
        setuplabels(lbl: titlelbl, text: "View Ticket Info", textcolor: .BackBtnColor, font: .InterBold(size: 14), align: .center)

        
        commonTableView.registerTVCells(["SelectedSportInfoTVCell",
                                         "SportsStadiumTVCell",
                                         "ViewStadiumBtnsTVCell",
                                         "SportsBookNowTVCell",
                                         "EmptyTVCell"])
        
        
    }

    
    func callAPI() {
        
        MySingleton.shared.loderString = "fdetails"
        MySingleton.shared.afterResultsBool = true
        loderBool = true
        showLoadera()
        
        
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["search_id"] = MySingleton.shared.sports_searchid
        MySingleton.shared.payload["dl_token"] = MySingleton.shared.sports_token
        MySingleton.shared.sportsdetailsvm?.CALL_SPORTS_DETAILS_API(dictParam: MySingleton.shared.payload)
    }
    
    func sportDetails(response: SportsDetailsModel) {
        
        filteredSportsTickekData = response.data ?? []
        MySingleton.shared.sports_searchid = response.search_id ?? ""
        MySingleton.shared.sportsDetailsData = response.data ?? []
        MySingleton.shared.sportListData = response.event_list
        MySingleton.shared.seatingArrangementList = response.seating_arrangement ?? []
        MySingleton.shared.sport_mapUrl = response.event_list?.venue?.mapUrl ?? ""
        
        MySingleton.shared.participantsArray = response.event_list?.participants ?? []
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [unowned self] in
            loderBool = false
            hideLoadera()
            
            setupTVCells()
        }
    }
    
    func setupTVCells() {
        
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(key:"details",cellType:.SelectedSportInfoTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.SportsStadiumTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.ViewStadiumBtnsTVCell))
        
        
        filteredSportsTickekData.forEach({ i in
            MySingleton.shared.tablerow.append(TableRow(title:i.categoryName,
                                                        subTitle: i.ticket_value,
                                                        price: "\(i.price ?? 0)",
                                                        currency: i.currency,
                                                        text: "\(i.availableSellingQuantities?.count ?? 0)",
                                                        headerText: "Service fee- \(i.serviceFee ?? 0) \(i.currency ?? "")",
                                                        cellType:.SportsBookNowTVCell))
        })
        
        
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
    
}
