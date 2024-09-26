//
//  MoreDetailsVC.swift
//  Travgate
//
//  Created by FCI on 07/03/24.
//

import UIKit

class MoreDetailsVC: BaseTableVC, MoreDetailsViewModelDelegate {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    
    var titleString = String()
    static var newInstance: MoreDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? MoreDetailsVC
        return vc
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        holderView.isHidden = true
        callAPI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        MySingleton.shared.moredetailsvm = MoreDetailsViewModel(self)
    }
    
    
    
    func setupUI() {
        commonTableView.registerTVCells(["MoreDetailsTVCell"])
    }
    
    
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        callapibool = false
        MySingleton.shared.callboolapi = false
        dismiss(animated: true)
    }
    
    
    
}


extension MoreDetailsVC {
    
    func callAPI() {
        
        MySingleton.shared.afterResultsBool = true
        loderBool = true
        showLoadera()
        //BASE_URL = ""
        
        
        
        if LanguageManager.shared.currentLanguage() == "ar" {
            switch titleString {
                
            case "من نحن":  // "About Us" in Arabic
                MySingleton.shared.moredetailsvm?.CALL_GET_MORE_DETAILS_API(dictParam: [:],
                                                                            urlStr: "\(BASE_URL)general/cms?id=1")
                break
                
            case "الشروط والأحكام":  // "Terms & Conditions" in Arabic
                MySingleton.shared.moredetailsvm?.CALL_GET_MORE_DETAILS_API(dictParam: [:],
                                                                            urlStr: "\(BASE_URL)general/cms?id=3")
                break
                
            case "سياسة الخصوصية":  // "Privacy Policy" in Arabic
                MySingleton.shared.moredetailsvm?.CALL_GET_MORE_DETAILS_API(dictParam: [:],
                                                                            urlStr: "\(BASE_URL)general/cms?id=4")
                break
                
                
                
            default:
                break
            }
        } else {
            switch titleString {
            case "About Us":
                MySingleton.shared.moredetailsvm?.CALL_GET_MORE_DETAILS_API(dictParam: [:],
                                                                            urlStr: "\(BASE_URL)general/cms?id=1")
                break
                
            case "Terms & Conditions":
                MySingleton.shared.moredetailsvm?.CALL_GET_MORE_DETAILS_API(dictParam: [:],
                                                                            urlStr: "\(BASE_URL)general/cms?id=3")
                break
                
                
            case "Privacy Policy":
                MySingleton.shared.moredetailsvm?.CALL_GET_MORE_DETAILS_API(dictParam: [:],
                                                                            urlStr: "\(BASE_URL)general/cms?id=4")
                break
                
                
                
            default:
                break
            }
        }
    }
    
    
    
    
    
    
    
    func moreDetails(response: MoreDetailsModel) {
        BASE_URL = BASE_URL1
        MySingleton.shared.moreDetailsData = response.data
        holderView.isHidden = false
        hideLoadera()
        
        
        DispatchQueue.main.async {
            self.setupTVCells()
        }
    }
    
    func setupTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        
        
        if LanguageManager.shared.currentLanguage() == "ar" {
            titlelbl.text = MySingleton.shared.moreDetailsData?.page_title_ar ?? ""
        } else {
            titlelbl.text = MySingleton.shared.moreDetailsData?.page_title ?? ""
        }
        MySingleton.shared.tablerow.append(TableRow(cellType:.MoreDetailsTVCell))
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
}


