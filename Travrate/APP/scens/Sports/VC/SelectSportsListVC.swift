//
//  SelectSportsListVC.swift
//  Travgate
//
//  Created by FCI on 10/05/24.
//

import UIKit

class SelectSportsListVC: BaseTableVC, SportListVMDelegate {
    
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
        print("didTapOnFilterBtnAction")
    }
    
    @IBAction func didTapOnSortBtnAction(_ sender: Any) {
        print("didTapOnSortBtnAction")
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [unowned self] in
            loderBool = false
            hideLoadera()
        }
        
        
        DispatchQueue.main.async {
            self.setupTVCells()
        }
        
        
    }
    
    
    func setupTVCells() {
        
        MySingleton.shared.tablerow.removeAll()
        
        
        
        MySingleton.shared.sportslistArray.forEach { i in
            MySingleton.shared.tablerow.append(TableRow(title:i.eventType?.name,
                                                        subTitle: i.name,
                                                        price: "\(i.minTicketPrice?.price ?? 0)",
                                                        currency: "\(i.minTicketPrice?.currency ?? "")",
                                                        searchid: i.search_id,
                                                        tokenid: i.token,
                                                        headerText: i.venue?.name,
                                                        cellType:.SportInfoTVCell))
        }
        
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
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
