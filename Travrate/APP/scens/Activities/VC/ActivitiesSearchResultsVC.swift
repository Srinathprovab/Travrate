//
//  ActivitiesSearchResultsVC.swift
//  Travrate
//
//  Created by Admin on 17/07/24.
//

import UIKit

class ActivitiesSearchResultsVC: BaseTableVC, MobilepreactivitysearchVMDelegate {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var destinationcitylbl: UILabel!
    @IBOutlet weak var dateslbl: UILabel!
    @IBOutlet weak var totalcountlbl: UILabel!
    @IBOutlet weak var paxlbl: UILabel!
    @IBOutlet weak var modifyBtn: UIButton!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var backbtn: UIButton!
    
    
    static var newInstance: ActivitiesSearchResultsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Activities.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ActivitiesSearchResultsVC
        return vc
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        MySingleton.shared.preactivitysearchVM = MobilepreactivitysearchVM(self)
    }
    
    
    func setupUI() {
        modifyBtn.addTarget(self, action: #selector(didTapOnModifySearchBtnAction(_:)), for: .touchUpInside)
        backbtn.addTarget(self, action: #selector(didTapOnBackBtnAction(_:)), for: .touchUpInside)
        filterBtn.addTarget(self, action: #selector(didTapOnFilterBtnAction(_:)), for: .touchUpInside)
        commonTableView.registerTVCells(["EmptyTVCell",
                                         "ActivitiesResultTVCell"])
        
    }
    
    
    @objc func didTapOnBackBtnAction(_ sender:UIButton) {
        MySingleton.shared.callboolapi = false
        guard let vc = ActivitiesSearchVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    @objc func didTapOnModifySearchBtnAction(_ sender:UIButton) {
        guard let vc = ModifyActivitySearchVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    @objc func didTapOnFilterBtnAction(_ sender:UIButton) {
        print("didTapOnFilterBtnAction")
    }
    
    
    override func didTapOnActivitesDetailsBtnAction(cell: ActivitiesResultTVCell) {
        MySingleton.shared.activity_code = cell.activitycode
        gotoActivitiesDetailsVC()
    }
    
    
    func gotoActivitiesDetailsVC() {
        MySingleton.shared.callboolapi = true
        guard let vc = ActivitiesDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
}



extension ActivitiesSearchResultsVC {
    
    func callAPI(){
        
        MySingleton.shared.loderString = "fdetails"
        loderBool = true
        showLoadera()
        
        MySingleton.shared.preactivitysearchVM?.CALL_MOBILE_PRE_ACTIVITES_SEARCH_API(dictParam: MySingleton.shared.payload)
    }
    
    func preSearchResponse(response: MobilepreactivitysearchModel) {
        
        DispatchQueue.main.async {
            MySingleton.shared.preactivitysearchVM?.CALL_ACTIVITES_SERCH_API(dictParam: [:], urlstr: response.hit_url ?? "")
        }
    }
    
    
    func activitylistResponse(response: ActivitesListModel) {
        loderBool = false
        hideLoadera()
        holderView.isHidden = false
        
        
        MySingleton.shared.activityList = response.data?.raw_activity_list?.activitySearchResult?.activity ?? []
        MySingleton.shared.activites_booking_source = response.data?.booking_source ?? ""
        MySingleton.shared.activites_currency = response.data?.currency_obj?.to_currency ?? ""
        MySingleton.shared.activites_searchid = "\(response.data?.search_id ?? 0)"
        
        
        let cityname = defaults.string(forKey: UserDefaultsKeys.activitescityname)
        let fromdate = defaults.string(forKey: UserDefaultsKeys.calActivitesDepDate)
        let todate = defaults.string(forKey: UserDefaultsKeys.calActivitesRetDate)
        let adultcount = defaults.integer(forKey: UserDefaultsKeys.activitesadultCount)
        let childcount = defaults.integer(forKey: UserDefaultsKeys.activiteschildCount)
        let infantcount = defaults.integer(forKey: UserDefaultsKeys.activitesinfantsCount)
        
        
        destinationcitylbl.text = cityname
        dateslbl.text = "\(fromdate ?? "") To \(todate ?? "")"
        
        var labelText = adultcount > 1 ? "Adults: \(adultcount)" : "Adult: \(adultcount)"
        if childcount > 0 {
            labelText += ", Child: \(childcount)"
        }
        if infantcount > 0 {
            labelText += ", Infant: \(infantcount)"
        }
        paxlbl.text = labelText
        
        MySingleton.shared.setAttributedTextnew(str1: "\(MySingleton.shared.activityList.count)", str2: " Activities  Available", lbl: totalcountlbl, str1font: .InterBold(size: 16), str2font: .InterRegular(size: 14), str1Color: .TitleColor, str2Color: .TitleColor)
        
        DispatchQueue.main.async {
            self.setupTVCells()
        }
    }
    
    
    func setupTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        
        
        
        
        MySingleton.shared.activityList.forEach { i in
            MySingleton.shared.tablerow.append(TableRow(moreData: i,cellType:.ActivitiesResultTVCell))
        }
        
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType: .EmptyTVCell))
        
        
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
}



//MARK: - addObserver
extension ActivitiesSearchResultsVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(nointrnetreload), name: Notification.Name("nointrnetreload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        
        
        if MySingleton.shared.callboolapi == true {
            holderView.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [unowned self] in
                callAPI()
            }
        }
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
    
    
}
