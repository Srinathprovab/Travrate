//
//  ShareResultVC.swift
//  Travrate
//
//  Created by Admin on 24/06/24.
//

import UIKit


class ShareResultVC: BaseTableVC, ShareResultViewModelDelegate {
   
    
    @IBOutlet weak var holderView: UIView!
    
    
    
    static var newInstance: ShareResultVC? {
        let storyboard = UIStoryboard(name: Storyboard.Flight.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ShareResultVC
        return vc
    }
    var fname = String()
    var lname = String()
    var emailid = String()
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUI()
        
        MySingleton.shared.shareresultvm = ShareResultViewModel(self)
    }
    
    
    func setUI() {
        
        commonTableView.registerTVCells(["ShareResultTVCell"])
        setupTVCells()
        
    }
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        callapibool = false
        MySingleton.shared.callboolapi = false
        dismiss(animated: true)
    }
    
    
    //MARK: - ShareResultTVCell Delegate Methods
    override func texteditingchanged(tf: UITextField) {
        
        print(tf.tag)
        switch tf.tag {
        case 1:
            self.fname = tf.text ?? ""
            break
            
        case 2:
            self.lname = tf.text ?? ""
            break
            
        case 3:
            self.emailid = tf.text ?? ""
            break
            
        default:
            break
        }
        
        
        if self.fname == "" || fname.isEmpty == true{
            NotificationCenter.default.post(name: NSNotification.Name("shareresulthide"), object: nil)
        }else if self.lname == "" || lname.isEmpty == true{
            NotificationCenter.default.post(name: NSNotification.Name("shareresulthide"), object: nil)
        }else if self.emailid == "" || emailid.isEmpty == true{
            NotificationCenter.default.post(name: NSNotification.Name("shareresulthide"), object: nil)
        }else if self.emailid.isValidEmail() == false {
            NotificationCenter.default.post(name: NSNotification.Name("shareresulthide"), object: nil)
        }else {
            NotificationCenter.default.post(name: NSNotification.Name("shareresultshow"), object: nil)
        }
        
    }
    
    
    override func didTapOnCopyWhatsapplinkBtnAction(cell: ShareResultTVCell) {
        guard let textToCopy = cell.whatsappTF.text else { return }
        UIPasteboard.general.string = textToCopy
        
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.showToast(message: "Copied")
        }
    }
    
    override func didTapOnCopyLinkBtnAction(cell: ShareResultTVCell) {
        guard let textToCopy = cell.linkTF.text else { return }
        UIPasteboard.general.string = textToCopy
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.showToast(message: "Copied")
        }
    }
    
    
    
    override func didTapOnSendBtnAction(cell: ShareResultTVCell) {
        if fname == "" || fname.isEmpty == true {
            showToast(message: "Enter First Name")
        }else  if lname == "" || lname.isEmpty == true {
            NotificationCenter.default.post(name: NSNotification.Name("shareresulthide"), object: nil)
            showToast(message: "Enter Last Name")
        }else  if emailid == "" || emailid.isEmpty == true {
            NotificationCenter.default.post(name: NSNotification.Name("shareresulthide"), object: nil)
            showToast(message: "Enter Email Address")
        }else if emailid.isValidEmail() == false {
            showToast(message: "Enter Valid Email Address")
        }else {
            
            let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect)
            if tabselect == "Flight" {
                callAPI()
            }else {
                callHotelAPI()
            }
            
            
        }
    }
    
    
}




extension ShareResultVC {
    
   
    
    func callAPI() {
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["token"] = MySingleton.shared.shareresultaccesskey
        MySingleton.shared.payload["booking_source"] = MySingleton.shared.shareresultbookingsource
        MySingleton.shared.payload["id"] = MySingleton.shared.shareresultrandomid
        MySingleton.shared.payload["search_id"] = MySingleton.shared.searchid
        MySingleton.shared.payload["to_email"] = emailid
        MySingleton.shared.payload["from"] = "\(fname) \(lname)"
        
        MySingleton.shared.shareresultvm?.CALL_SHARE_RESULT_API(dictParam: MySingleton.shared.payload)
    }
    
    
    
    func sahreResultResponse(response: LoginModel) {
        if response.status == false {
            showToast(message: response.msg ?? "")
        }else {
            showToast(message: "Link Sended To Your Mail ... ")
            let seconds = 2.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                MySingleton.shared.callboolapi = false
                self.dismiss(animated: true)
            }
        }
    }
    
    
    
    
    
    func setupTVCells() {
        
        MySingleton.shared.tablerow.removeAll()
        
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.ShareResultTVCell))
        
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
        
    }
    
    
}


extension ShareResultVC {
    func callHotelAPI() {
        MySingleton.shared.payload.removeAll()

        MySingleton.shared.payload["search_id"] = hsearchid
        MySingleton.shared.payload["to_email"] = emailid
        MySingleton.shared.payload["first_name"] = "\(fname)"
        MySingleton.shared.payload["last_name"] = "\(lname)"
        

        
        MySingleton.shared.shareresultvm?.CALL_Hotel_SHARE_RESULT_API(dictParam: MySingleton.shared.payload)
    }
    
    
    func sahreHotelResultResponse(response: LoginModel) {
        if response.status == false {
            showToast(message: response.msg ?? "")
        }else {
            showToast(message: "Link Sended To Your Mail ... ")
            let seconds = 2.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                callapibool = false
                self.dismiss(animated: true)
            }
        }
    }
    
    
}



//MARK: - addObserver
extension ShareResultVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(nointrnetreload), name: Notification.Name("nointrnetreload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        
        
        if MySingleton.shared.callboolapi == true {
            // callAPI()
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
