//
//  BDTransferVC.swift
//  Travgate
//
//  Created by FCI on 08/05/24.
//

import UIKit

class BDTransferVC: BaseTableVC, TransferPreBookingVMDelegate {
    
    
    
    @IBOutlet weak var gifimg: UIImageView!
    @IBOutlet weak var continuetoPaymentBtnView: UIView!
    @IBOutlet weak var continuetoPaymentBtnlbl: UILabel!
    @IBOutlet weak var continuebtn: UIButton!
    
    
    static var newInstance: BDTransferVC? {
        let storyboard = UIStoryboard(name: Storyboard.Transfers.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? BDTransferVC
        return vc
    }
    
    var transfer_data : Transfer_data?
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        
        MySingleton.shared.transferPreBookingVM = TransferPreBookingVM(self)
    }
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        callapibool = false
        dismiss(animated: true)
    }
    
    
    override func doneTimePicker(cell: TFlighDetailsTVCell) {
        self.view.endEditing(true)
    }
    
    override func cancelTimePicker(cell: TFlighDetailsTVCell) {
        self.view.endEditing(true)
    }
    
    
    override func didTapOnCountryCodeBtn(cell: TContactDetailsTVCell) {
        print(cell.countrycodeTF.text ?? "")
    }
    
    
    
    @IBAction func didTapOnContinueBtnAction(_ sender: Any) {
        gotoBDTransferVC()
    }
    
    
    func gotoBDTransferVC() {
        callapibool = true
       guard let vc = SelectPaymentMethodsVC.newInstance.self else {return}
       vc.modalPresentationStyle = .fullScreen
       self.present(vc, animated: true)
   }
    
    
    
    override func didTapOnCheckBoxBtnAction(cell:TermsAgreeTVCell) {
        if cell.checkBool {
            continuetoPaymentBtnView.backgroundColor = .BooknowBtnColor
            gifimg.isHidden = false
        }else {
            continuetoPaymentBtnView.backgroundColor = .Buttoncolor
            gifimg.isHidden = true
        }
    }
    
}



extension BDTransferVC {
    
    
    func setupUI(){
        
        continuetoPaymentBtnView.backgroundColor = .Buttoncolor
        continuetoPaymentBtnView.isUserInteractionEnabled = true
        continuetoPaymentBtnlbl.text = "Continue To Next"
        
        guard let gifURL = Bundle.main.url(forResource: "pay", withExtension: "gif") else { return }
        guard let imageData = try? Data(contentsOf: gifURL) else { return }
        guard let image = UIImage.gifImageWithData(imageData) else { return }
        gifimg.image = image
        gifimg.isHidden = true
        
        commonTableView.registerTVCells(["BDTransfersInf0TVCell",
                                         "EmptyTVCell",
                                         "TContactDetailsTVCell",
                                         "TermsAgreeTVCell",
                                         "TFlighDetailsTVCell"])
       // setupVisaTVCells(keystr: "oneway")
        
    }
    
    
    
    func callAPI() {
        
        MySingleton.shared.loderString = "fdetails"
        MySingleton.shared.afterResultsBool = true
        loderBool = true
        showLoadera()
        
        
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["search_id"] = MySingleton.shared.transfer_searchid
        MySingleton.shared.payload["token"] = MySingleton.shared.transfer_token
        
        MySingleton.shared.transferPreBookingVM?.CALL_PRE_BOOKING_API(dictParam: MySingleton.shared.payload)
       
    }
    
    func preBookingResponse(response: TransferPreBookingModel) {
        loderBool = false
        hideLoadera()
        
        transfer_data = response.transfer_data
        
        DispatchQueue.main.async {
            self.setupTVCells()
        }
    }
    
    
    
    
    func setupTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(moreData:transfer_data,cellType:.BDTransfersInf0TVCell))
        MySingleton.shared.tablerow.append(TableRow(moreData:transfer_data,cellType:.TFlighDetailsTVCell))
        MySingleton.shared.tablerow.append(TableRow(moreData:transfer_data,cellType:.TContactDetailsTVCell))
        MySingleton.shared.tablerow.append(TableRow(title:"By Booking This item, You agree to pay the total amount shown, with includes service fees. you also agree to the terms ans conditions and privacy policy .",cellType:.TermsAgreeTVCell))
        MySingleton.shared.tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
}





//MARK: - addObserver
extension BDTransferVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(nointrnetreload), name: Notification.Name("nointrnetreload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        
        
        if callapibool == true {
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
