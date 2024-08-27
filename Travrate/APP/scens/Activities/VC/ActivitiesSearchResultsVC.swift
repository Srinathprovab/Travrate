//
//  ActivitiesSearchResultsVC.swift
//  Travrate
//
//  Created by Admin on 17/07/24.
//

import UIKit

class ActivitiesSearchResultsVC: BaseTableVC, MobilepreactivitysearchVMDelegate, AppliedActivitiesFilters {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var destinationcitylbl: UILabel!
    @IBOutlet weak var dateslbl: UILabel!
    @IBOutlet weak var totalcountlbl: UILabel!
    @IBOutlet weak var paxlbl: UILabel!
    @IBOutlet weak var modifyBtn: UIButton!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var backbtn: UIButton!
    @IBOutlet weak var searchNameTF: UITextField!
    @IBOutlet weak var searchNameView: BorderedView!
    @IBOutlet weak var searchNameBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    
    
    static var newInstance: ActivitiesSearchResultsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Activities.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ActivitiesSearchResultsVC
        return vc
    }
    
    
    var searchText = String()
    var filtered1 = [Activity]()
    
    override func viewWillDisappear(_ animated: Bool) {
        closeSearchNameTextfield()
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
        
        
        setuplabels(lbl: destinationcitylbl, text: "", textcolor: .BackBtnColor, font: .InterBold(size: 14), align: .center)
        setuplabels(lbl: dateslbl, text: "", textcolor: .BackBtnColor, font: .InterRegular(size: 14), align: .center)
        setuplabels(lbl: paxlbl, text: "", textcolor: .BackBtnColor, font: .InterRegular(size: 14), align: .center)

        
        searchNameTF.setLeftPaddingPoints(15)
        searchNameTF.addTarget(self, action: #selector(searchTextChanged(_:)), for: .editingChanged)
        searchNameView.isHidden = true
        searchNameBtn.addTarget(self, action: #selector(didTapOnSearchNameBtnAction(_:)), for: .touchUpInside)
        closeBtn.addTarget(self, action: #selector(didTapOnCloseSearchNameTFBtnAction(_:)), for: .touchUpInside)
        
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
    
    
    @objc func didTapOnSearchNameBtnAction(_ sender:UIButton) {
        searchNameView.isHidden = false
        searchNameTF.becomeFirstResponder()
    }
    
    @objc func didTapOnCloseSearchNameTFBtnAction(_ sender:UIButton) {
        closeSearchNameTextfield()
    }
    
    func closeSearchNameTextfield() {
        searchNameView.isHidden = true
        searchNameTF.text = ""
        searchNameTF.resignFirstResponder()
        setupTVCells(list: MySingleton.shared.activityList)
    }
    
    
    //MARK: - gotoFilterVC
    @objc func didTapOnFilterBtnAction(_ sender:UIButton) {
        gotoFilterVC(strkey: "activitiesfilter")
    }
    
    
    func gotoFilterVC(strkey:String) {
        guard let vc = FilterVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.activitiesfilterDelegate = self
        vc.filterKey = strkey
        present(vc, animated: true)
    }
    
    
    override func didTapOnActivitesDetailsBtnAction(cell: ActivitiesResultTVCell) {
        
        MySingleton.shared.activity_code = cell.activitycode
        MySingleton.shared.resultToken = cell.resultToken
        MySingleton.shared.activity_image = cell.selectedImage
        MySingleton.shared.activity_duration_type = cell.selecteddurationType
        MySingleton.shared.activity_name_type = cell.selectedNameType
        
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
        
        MySingleton.shared.payemail = ""
        MySingleton.shared.paymobile = ""
        MySingleton.shared.paymobilecountrycode = ""
        
        MySingleton.shared.activityList = response.data?.raw_activity_list?.activitySearchResult?.activity ?? []
        
        MySingleton.shared.activites_booking_source = response.data?.booking_source ?? ""
        MySingleton.shared.activites_currency = response.data?.currency_obj?.to_currency ?? ""
        MySingleton.shared.activites_searchid = "\(response.data?.search_id ?? 0)"
        
        
        let cityname = defaults.string(forKey: UserDefaultsKeys.activitescityname)
        let fromdate = defaults.string(forKey: UserDefaultsKeys.calActivitesDepDate)
        let todate = defaults.string(forKey: UserDefaultsKeys.calActivitesRetDate)
        
        
        destinationcitylbl.text = cityname
        dateslbl.text = "\(MySingleton.shared.convertDateFormat(inputDate: fromdate ?? "", f1: "dd-MM-yyyy", f2: "dd MMM")) - \(MySingleton.shared.convertDateFormat(inputDate: todate ?? "", f1: "dd-MM-yyyy", f2: "dd MMM"))"
        
        
        let adultcount = defaults.integer(forKey: UserDefaultsKeys.activitesadultCount)
        let childcount = defaults.integer(forKey: UserDefaultsKeys.activiteschildCount)
        let infantcount = defaults.integer(forKey: UserDefaultsKeys.activitesinfantsCount)
        var labelText = adultcount > 1 ? "Adults \(adultcount)" : "Adult \(adultcount)"
        if childcount > 0 {
            labelText += ", Child \(childcount)"
        }
        if infantcount > 0 {
            labelText += ", Infant \(infantcount)"
        }
        paxlbl.text = labelText
        
        DispatchQueue.main.async {
            self.appendResults(list: response.data?.raw_activity_list?.activitySearchResult?.activity ?? [])
        }
    }
    
    
    func appendResults(list: [Activity]) {
        
        prices.removeAll()
        durationTypeArray.removeAll()
        activitiesTypeArray.removeAll()
        
        list.forEach { i in
            durationTypeArray.append(i.activityDuration ?? "")
            prices.append(i.amountStarts ?? "")
            
            i.modalities?.forEach({ j in
                activitiesTypeArray.append(j.name ?? "")
            })
        }
        
        // Remove empty elements
        durationTypeArray = durationTypeArray.filter { !$0.isEmpty }
        activitiesTypeArray = activitiesTypeArray.filter { !$0.isEmpty }
        prices = prices.filter { !$0.isEmpty }
        
        // Get unique elements
        durationTypeArray = Array(Set(durationTypeArray))
        activitiesTypeArray = Array(Set(activitiesTypeArray))
        prices = Array(Set(prices))
        
        DispatchQueue.main.async {
            self.setupTVCells(list: list)
        }
    }

    
    
    func setupTVCells(list:[Activity]) {
        MySingleton.shared.tablerow.removeAll()
        
        
        MySingleton.shared.setAttributedTextnew(str1: "\(list.count)", str2: " Activities available", lbl: totalcountlbl, str1font: .InterBold(size: 16), str2font: .InterRegular(size: 14), str1Color: .TitleColor, str2Color: .TitleColor)
        
        
        for  (index,value) in list.enumerated() {
            MySingleton.shared.tablerow.append(TableRow(title:"\(index + 1)",moreData: value,cellType:.ActivitiesResultTVCell))
        }
        
        
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType: .EmptyTVCell))
        
        
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
}



extension ActivitiesSearchResultsVC {
    
    
    func activitiesFilterByApplied(minpricerange: Double, maxpricerange: Double, durationTypeArray: [String], activitiesTypeArray: [String]) {
        
        print("minpricerange : \(minpricerange)")
        print("maxpricerange : \(maxpricerange)")
        print("durationTypeArray : \(durationTypeArray.joined(separator: ","))")
        print("activitiesTypeArray : \(activitiesTypeArray.joined(separator: ","))")
        
        // Normalize input arrays for case-insensitive comparison
        let normalizedDurationTypeArray = durationTypeArray.map { $0.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) }
        let normalizedActivitiesTypeArray = activitiesTypeArray.map { $0.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) }

        // Filter the car rentals based on the specified criteria
        let filteredArray = MySingleton.shared.activityList.filter { activity in
            guard let totalString = activity.amountStarts else { return false }
            
            let priceInRange = (Double(totalString) ?? 0.0) >= minpricerange && (Double(totalString) ?? 0.0) <= maxpricerange
            let durationTypeMatch = normalizedDurationTypeArray.isEmpty || normalizedDurationTypeArray.contains(activity.activityDuration?.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) ?? "")
            
            let activitiesTypeMatch = normalizedActivitiesTypeArray.isEmpty || (activity.modalities?.contains { modality in
                normalizedActivitiesTypeArray.contains(modality.name?.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) ?? "")
            } ?? false)

            return priceInRange && durationTypeMatch && activitiesTypeMatch
        }

        //setupTVCells(list: filteredArray)
        filterresettapbool == true ? setupTVCells(list: MySingleton.shared.activityList) : setupTVCells(list: filteredArray)
        
    }

    
}




extension ActivitiesSearchResultsVC {
    
    
    @objc func searchTextChanged(_ sender: UITextField) {
        searchText = sender.text ?? ""
        
        
        if searchText == "" {
            isSearchBool = false
            filterContentForSearchText(searchText)
        }else {
            isSearchBool = true
            filterContentForSearchText(searchText)
        }
    }
    
    func filterContentForSearchText(_ searchText: String) {
        print("Filterin with:", searchText)
        
        filtered1.removeAll()
        filtered1 =  MySingleton.shared.activityList.filter { thing in
            return "\(thing.name?.lowercased() ?? "")".contains(searchText.lowercased())
        }
        
        setupTVCells(list: filtered1)
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
