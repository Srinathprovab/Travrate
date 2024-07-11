//
//  CRBookingDetailsVC.swift
//  Travrate
//
//  Created by FCI on 14/06/24.
//

import UIKit

class CRBookingDetailsVC: BaseTableVC {
    
    @IBOutlet weak var continuebtn: UIButton!
    
    static var newInstance: CRBookingDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.CarRental.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? CRBookingDetailsVC
        return vc
    }
    
    var countryode = String()
    var mrtitlecode = String()
    var fname = String()
    var lname = String()
    var email = String()
    var mobile = String()
    var nationality = String()
    var city = String()
    var postal = String()
    var address = String()
    var cardetails : Result_token?
    
    
    override func viewWillAppear(_ animated: Bool) {
        if callapibool == true {
            callAPI()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        
    }
    
    
    func setupUI(){
        
        
        continuebtn.layer.cornerRadius = 4
        continuebtn.addTarget(self, action: #selector(didTapOnContinueBtnAction), for: .touchUpInside)
        commonTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Top left corner, Top right corner respectively
        commonTableView.layer.cornerRadius = 12
        commonTableView.clipsToBounds = true
        commonTableView.registerTVCells(["SelectedCarRentalTVCell",
                                         "CRFareSummaryTVCell",
                                         "DriverDetailsTVCell",
                                         "TermsAgreeTVCell",
                                         "SelectedServiceTVCell",
                                         "SelectedAdditionalOptionsTVCell",
                                         "ChooseAdditionalOptionsTVCell",
                                         "SelectedCRPackageTVCell",
                                         "AddonTableViewCell",
                                         "EmptyTVCell"])
        
        
    }
    
    
    //MARK: - didTapOnBackBtnAction
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        callapibool = false
        dismiss(animated: true)
    }
    
    
    //MARK: - didTapOnSelectPackageBtnAction  ChoosePackageTVCell
    override func didTapOnSelectPackageBtnAction(cell: ChoosePackageTVCell) {
        print("didTapOnSelectPackageBtnAction")
    }
    
    
    
    
    //MARK: - Addon didSelectAddon  didDeselectAddon
    override func didDeselectAddon(index: Int, origen: String) {
        
        if index == 0 {
            hotelnotificationCheck = false
            updateTotalAndReload()
        } else  {
            hotelwhatsAppCheck = false
            updateTotalAndReload()
        }
        
        
    }
    
    
    override  func didSelectAddon(index: Int, origen: String,price:String) {
        
        if index == 0 {
            
            hotelnotificationPrice = price
            hotelnotificationCheck = true
            
            updateTotalAndReload()
        } else  {
            hotelwhatsAppPrice = price
            hotelwhatsAppCheck = true
            updateTotalAndReload()
            
        }
        
    }
    
    
    func updateTotalAndReload() {
        // Update total price or any related data
        // totlConvertedGrand = newTotal
        
        reloadPriceSummaryTVCell()
        
//        MySingleton.shared.setAttributedTextnew(str1: defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "",
//                                                str2: String(format: "%.2f", totlConvertedGrand) ,
//                                                lbl: kwdlbl,
//                                                str1font: .LatoBold(size: 12),
//                                                str2font: .LatoBold(size: 18),
//                                                str1Color: .WhiteColor,
//                                                str2Color: .WhiteColor)
    }
    
    func reloadPriceSummaryTVCell() {
        if let indexPath = indexPathForPriceSummaryTVCell() {
            commonTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func indexPathForPriceSummaryTVCell() -> IndexPath? {
        if let row = MySingleton.shared.tablerow.firstIndex(where: { $0.cellType == .CRFareSummaryTVCell }) {
            return IndexPath(row: row, section: 0)
        }
        return nil
    }
    
    
    //MARK: - editingTextFieldChanged DriverDetailsTVCell Delegate Methods
    override func editingTextFieldChanged(tf: UITextField) {

        print(tf.tag)
        switch tf.tag {
        case 1:
            fname = tf.text ?? ""
            break
            
        case 2:
            lname = tf.text ?? ""
            break
            
        case 3:
            email = tf.text ?? ""
            break
            
        case 4:
            mobile = tf.text ?? ""
            break
            
        case 5:
            nationality = tf.text ?? ""
            break
            
        case 6:
            city = tf.text ?? ""
            break
            
        case 7:
            postal = tf.text ?? ""
            break
            
            
        default:
            break
        }
    }
    
    
    
    
    override func didTapOnTitleSelectBtnAction(cell:DriverDetailsTVCell) {
        mrtitlecode = cell.mrtitle
    }
    
    override func didTapOnCountryCodeBtn(cell:DriverDetailsTVCell) {
        countryode = cell.isoCountryCode
    }
    
    
    //MARK: - didTapOnSelectServiceBtnAction
    override func didTapOnSelectServiceBtnAction(cell: SelectedServiceTVCell) {
        commonTableView.reloadData()
    }
    
    
    //MARK: - didTapOnSelectedAdditionalOptionsBtnAction  SelectedAdditionalOptionsTVCell
    override func didTapOnSelectedAdditionalOptionsBtnAction(cell: SelectedAdditionalOptionsTVCell) {
        commonTableView.reloadData()
    }
    
    
    @objc func didTapOnContinueBtnAction() {
        
        if fname.isEmpty == true {
            showToast(message: "Enter First Name")
            return
        }else if lname.isEmpty == true {
            showToast(message: "Enter Last Name")
            return
        }else if self.email.isEmpty == true {
            showToast(message: "Enter Email Address")
            return
        }else if email.isValidEmail() == false {
            showToast(message: "Enter Valid Email Address")
            return
        }else if countryode.isEmpty == true {
            showToast(message: "Please Select Country Code")
            return
        }else if mobile.isEmpty == true {
            showToast(message: "Enter Mobile Number")
            return
        }else if nationality.isEmpty == true {
            showToast(message: "Please select Nationality")
            return
        }else if city.isEmpty == true {
            showToast(message: "Enter City")
            return
        }else if postal.isEmpty == true {
            showToast(message: "Enter Postal Code")
            return
        }else if MySingleton.shared.checkTermsAndCondationStatus == false {
            showToast(message: "Please select option to continue")
            return
        }else {
            showToast(message: "Go to Voucher page......")
        }
        
    }
    
    
    
}



extension CRBookingDetailsVC {

    
    func callAPI() {
        MySingleton.shared.loderString = "fdetails"
        MySingleton.shared.afterResultsBool = true
        loderBool = true
        showLoadera()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [unowned self] in
            loderBool = false
            hideLoadera()
            
            setupTVCells()
        }
    }
    
    
    
    func setupTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        
        //        MySingleton.shared.tablerow.append(TableRow(cellType:.SelectedCarRentalTVCell))
        //        MySingleton.shared.tablerow.append(TableRow(cellType:.SelectedServiceTVCell))
        //        MySingleton.shared.tablerow.append(TableRow(cellType:.SelectedAdditionalOptionsTVCell))
        //        MySingleton.shared.tablerow.append(TableRow(cellType:.DriverDetailsTVCell))
        //        MySingleton.shared.tablerow.append(TableRow(cellType:.CRFareSummaryTVCell))
        
        
        
        MySingleton.shared.tablerow.append(TableRow(title:"",moreData: cardetails,cellType:.SelectedCarRentalTVCell))
        
        
        MySingleton.shared.carproductarray.forEach { i in
            MySingleton.shared.tablerow.append(TableRow(key:"bookingdetails",
                                                        moreData: i,
                                                        cellType:.SelectedCRPackageTVCell))
        }
        
        
        MySingleton.shared.tablerow.append(TableRow(moreData:MySingleton.shared.extraOption,
                                                    cellType:.ChooseAdditionalOptionsTVCell))
        
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.DriverDetailsTVCell))
        
        MySingleton.shared.tablerow.append(TableRow(key: "hotel", moreData: services, cellType:.AddonTableViewCell))
        
        MySingleton.shared.tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        
        MySingleton.shared.carproductarray.forEach { i in
            MySingleton.shared.tablerow.append(TableRow(moreData: i,cellType:.CRFareSummaryTVCell))
            
        }
        
        
        
        
        MySingleton.shared.tablerow.append(TableRow(title:"* By booking this item, you agree to pay the total amount shown, which includes Service Fees. You also agree to the Terms and Conditions and privacy policy",
                                                    cellType:.TermsAgreeTVCell))
        
        
        MySingleton.shared.tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
        
    }
    
    
}


