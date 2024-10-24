//
//  MoreVC.swift
//  TravgateApp
//
//  Created by FCI on 02/01/24.
//

import UIKit

class MoreVC: BaseTableVC {
    
    
    @IBOutlet weak var titlelbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    
    func setupUI() {
        
        MySingleton.shared.loderString = "fdetails"
        commonTableView.registerTVCells(["TripsTVCell",
                                         "EmptyTVCell"])
        
        DispatchQueue.main.async {
            self.setupTVCells()
        }
    }
    
    
    func setupTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        
        if LanguageManager.shared.currentLanguage() == "ar" {
            titlelbl.text = "مزيد من التفاصيل"
            MySingleton.shared.tablerow.append(TableRow(title: "من نحن", key: "more", cellType: .TripsTVCell)) // About Us
            MySingleton.shared.tablerow.append(TableRow(title: "الشروط والأحكام", key: "more", cellType: .TripsTVCell)) // Terms & Conditions
            MySingleton.shared.tablerow.append(TableRow(title: "سياسة الخصوصية", key: "more", cellType: .TripsTVCell)) // Privacy Policy
            MySingleton.shared.tablerow.append(TableRow(title: "اتصل بنا", key: "more", cellType: .TripsTVCell)) // Contact Us
        } else {
            titlelbl.text = "More Details"
            MySingleton.shared.tablerow.append(TableRow(title:"About Us",key: "more",cellType:.TripsTVCell))
            MySingleton.shared.tablerow.append(TableRow(title:"Terms & Conditions",key: "more",cellType:.TripsTVCell))
            MySingleton.shared.tablerow.append(TableRow(title:"Privacy Policy",key: "more",cellType:.TripsTVCell))
            MySingleton.shared.tablerow.append(TableRow(title:"Contact Us",key: "more",cellType:.TripsTVCell))
        }
        
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    override func didTapOnTripsBtnAction(cell: TripsTVCell) {
        
        
        if LanguageManager.shared.currentLanguage() == "ar" {
            switch cell.titlelbl.text {
                
            case "من نحن":  // "About Us" in Arabic
                gotoMoreDetailsVC(str: "من نحن")
                break
                
            case "الشروط والأحكام":  // "Terms & Conditions" in Arabic
                gotoMoreDetailsVC(str: "الشروط والأحكام")
                break
                
            case "سياسة الخصوصية":  // "Privacy Policy" in Arabic
                gotoMoreDetailsVC(str: "سياسة الخصوصية")
                break
                
            case "اتصل بنا":  // "Contact Us" in Arabic
                gotoContactUsVC()
                break
                
            default:
                break
            }
        } else {
            switch cell.titlelbl.text {
                
            case "About Us":
                gotoMoreDetailsVC(str: "About Us")
                break
                
            case "Terms & Conditions":
                gotoMoreDetailsVC(str: "Terms & Conditions")
                break
                
            case "Privacy Policy":
                gotoMoreDetailsVC(str: "Privacy Policy")
                break
                
            case "Contact Us":
                gotoContactUsVC()
                break
                
            default:
                break
            }
        }

        
    }
    
    
    
    func gotoContactUsVC() {
        guard let vc = ContactUsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    func gotoMoreDetailsVC(str:String) {
        guard let vc = MoreDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.titleString = str
        present(vc, animated: true)
    }
    
    
    
}



