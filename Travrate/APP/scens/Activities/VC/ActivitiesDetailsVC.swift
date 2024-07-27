//
//  ActivitiesDetailsVC.swift
//  Travrate
//
//  Created by Admin on 17/07/24.
//

import UIKit

class ActivitiesDetailsVC: BaseTableVC, ActivityDetailsVMDelagate {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var destinationcitylbl: UILabel!
    @IBOutlet weak var dateslbl: UILabel!
    @IBOutlet weak var paxlbl: UILabel!
    @IBOutlet weak var backbtn: UIButton!
    
    static var newInstance: ActivitiesDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Activities.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ActivitiesDetailsVC
        return vc
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        
        MySingleton.shared.activityDetailsVM = ActivityDetailsVM(self)
    }
    
    
    func setupUI() {
        setuplabels(lbl: destinationcitylbl, text: "", textcolor: .BackBtnColor, font: .InterBold(size: 14), align: .center)
        setuplabels(lbl: dateslbl, text: "", textcolor: .BackBtnColor, font: .InterRegular(size: 14), align: .center)
        setuplabels(lbl: paxlbl, text: "", textcolor: .BackBtnColor, font: .InterRegular(size: 14), align: .center)
        
        backbtn.addTarget(self, action: #selector(didTapOnBackBtnAction(_:)), for: .touchUpInside)
        commonTableView.registerTVCells(["ActivitiesImagesTVCell",
                                         "EmptyTVCell",
                                        "ActivitiesDetailsTVCell"])
        setupTVCells()
        
    }
    
    
    
    @objc func didTapOnBackBtnAction(_ sender:UIButton) {
        MySingleton.shared.callboolapi = false
        dismiss(animated: true)
    }
    
    
    //MARK: - didTapOnMoreBtnAction
    override func didTapOnMoreBtnAction(cell: ActivitiesImagesTVCell) {
        if  MySingleton.shared.activitiesImagesArray.count > 0 {
            guard let vc = HotelImagesVC.newInstance.self else {return}
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }
    
    
    //MARK: - didTapOnActivitiesBtnsAction  ActivitiesDetailsTVCell
    override func didTapOnActivitiesBtnsAction(cell: ActivitiesDetailsTVCell) {
        //commonTableView.reloadData()
    }
    
    
    //MARK: - didTapOnBookNowBtnAction ActivitiesTypeInfoTVCell
    override func didTapOnBookNowBtnAction(cell: ActivitiesTypeInfoTVCell) {
        
        MySingleton.shared.rateKeySring = cell.rateKeySring
        MySingleton.shared.agentpayable = cell.agentpayable
        
        
        MySingleton.shared.payload.removeAll()
       
        MySingleton.shared.payload["booking_source"] =  MySingleton.shared.activites_booking_source
        MySingleton.shared.payload["rateKey"] = MySingleton.shared.rateKeySring
        MySingleton.shared.payload["mark_amt"] = "0"
        MySingleton.shared.payload["agent_markup"] = "0"
        MySingleton.shared.payload["agent_payable"] = MySingleton.shared.agentpayable
        MySingleton.shared.payload["AgentServiceTax"] = "0"
        MySingleton.shared.payload["actual_netrate"] = MySingleton.shared.agentpayable
        MySingleton.shared.payload["admin_paymarkup"] = "0"
        MySingleton.shared.payload["stax"] = "0"
        MySingleton.shared.payload["search_id"] = MySingleton.shared.activites_searchid
        MySingleton.shared.payload["total_amt"] = MySingleton.shared.agentpayable
        MySingleton.shared.payload["currency"] = MySingleton.shared.activites_currency
        MySingleton.shared.payload["activity_type"] = MySingleton.shared.activity_type
        MySingleton.shared.payload["resultToken"] = MySingleton.shared.resultToken
        MySingleton.shared.payload["activity_selecteddate"] = MySingleton.shared.activity_selecteddate
        
        
        if  cell.datelbl.text == "Choose Date" {
            cell.errorlbl.isHidden = false
            cell.chooselbl.isHidden = true
        }else {
            cell.errorlbl.isHidden = true
            cell.chooselbl.isHidden = true
            totlConvertedGrand = Double(cell.agentpayable) ?? 0.0
            gotoActivitiesBookingDetailsVC()
        }
        
    }
    
    
    func gotoActivitiesBookingDetailsVC() {
        MySingleton.shared.callboolapi = true
        guard let vc = ActivitiesBookingDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
}


extension ActivitiesDetailsVC {
    
    
    func callAPI() {
        
        holderView.isHidden = true
        MySingleton.shared.loderString = "fdetails"
        MySingleton.shared.afterResultsBool = true
        
        loderBool = true
        showLoadera()
        
        
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["booking_source"] = MySingleton.shared.activites_booking_source
        MySingleton.shared.payload["activity_code"] = MySingleton.shared.activity_code
        MySingleton.shared.activityDetailsVM?.CALL_GET_ACTIVITES_DETAILS_API(dictParam: MySingleton.shared.payload)
    }
    
    
    func activitesDetailsResponse(response: ActivityDetailsModel) {
        
        loderBool = false
        hideLoadera()
        holderView.isHidden = false
        
        if response.status == false {
            resultnil()
        }else {
            
            
            
            MySingleton.shared.activity_details = response.data?.activity_details
            MySingleton.shared.activity_type = response.data?.activity_details?.type ?? ""
            MySingleton.shared.activitiesImagesArray = response.data?.activity_details?.images ?? []
         //   MySingleton.shared.modalitiesdetails = response.data?.activity_details?.modalities ?? []
            destinationcitylbl.text = response.data?.activity_search_params?.activity_destination
            
            let fromdate = defaults.string(forKey: UserDefaultsKeys.calActivitesDepDate)
            let todate = defaults.string(forKey: UserDefaultsKeys.calActivitesRetDate)
            dateslbl.text = "\(MySingleton.shared.convertDateFormat(inputDate: fromdate ?? "", f1: "dd-MM-yyyy", f2: "dd MMM yy")) To \(MySingleton.shared.convertDateFormat(inputDate: todate ?? "", f1: "dd-MM-yyyy", f2: "dd MMM yy"))"
            
            defaults.set(response.data?.activity_details?.activity_name ?? "", forKey: UserDefaultsKeys.activitesname)
            let adultcount = Int(response.data?.activity_search_params?.adult ?? "") ?? 0
            let childcount = Int(response.data?.activity_search_params?.child ?? "") ?? 0
            let infantcount = Int(response.data?.activity_search_params?.infant ?? "") ?? 0
            var labelText = adultcount > 1 ? "Adults \(adultcount)" : "Adult \(adultcount)"
            if childcount > 0 {
                labelText += ", Child \(childcount)"
            }
            if infantcount > 0 {
                labelText += ", Infant \(infantcount)"
            }
            paxlbl.text = labelText
            
           
            
            DispatchQueue.main.async {
                self.setupTVCells()
            }
        }
        
       
    }
    
    
    func setupTVCells() {
        
        MySingleton.shared.tablerow.removeAll()
        
        
        
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.ActivitiesImagesTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.ActivitiesDetailsTVCell))
        MySingleton.shared.tablerow.append(TableRow(height:100,cellType:.EmptyTVCell))
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
        
    }
    
}





//MARK: - addObserver
extension ActivitiesDetailsVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(nointrnetreload), name: Notification.Name("nointrnetreload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        
        
        if MySingleton.shared.callboolapi == true {
            callAPI()
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
    
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = "nointernet"
        self.present(vc, animated: true)
    }
    
    
}
