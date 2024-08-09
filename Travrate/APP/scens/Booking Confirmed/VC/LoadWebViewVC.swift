//
//  LoadWebViewVC.swift
//  AlghanimTravelApp
//
//  Created by FCI on 29/09/22.
//

import UIKit
import WebKit
import SwiftyJSON

class LoadWebViewVC: UIViewController, WKNavigationDelegate, MobileSecureBookingViewModelDelegate {
    
    
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var webview: WKWebView!
    
    
    static var newInstance: LoadWebViewVC? {
        let storyboard = UIStoryboard(name: Storyboard.Calender.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? LoadWebViewVC
        return vc
    }
    
    
    var urlString = String()
    var keystr = String()
    var apicallbool = true
    var openpaymentgatewaybool = false
    let activityIndicatorView = UIActivityIndicatorView(style: .large)
    
    
    override func viewWillAppear(_ animated: Bool) {
        //loderBool = false
        
        activityIndicatorView.startAnimating()
        self.webview.isUserInteractionEnabled = false
        
        
        //        if let url1 = URL(string: urlString) {
        //            webview.load(URLRequest(url: url1))
        //        }
        
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            
            // Add headers, including the token
            request.setValue(accessToken, forHTTPHeaderField: "Token")
            
            // Load the request into the WKWebView
            webview.load(request)
        }
        
        
        
        let seconds = 60.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
            if  openpaymentgatewaybool == false {
                showAlertOnWindow(title: "",message: "Somthing Went Wrong",titles: ["OK"]) { title in
                    self.gotoDashboard()
                }
            }
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        MySingleton.shared.viewmodel1 = MobileSecureBookingViewModel(self)
        // MySingleton.shared.mobilepaymentvm = MobilePaymentVM(self)
    }
    
    
    func setupUI() {
        
        
        
        holderView.backgroundColor = .WhiteColor
        // Do any additional setup after loading the view.
        activityIndicatorView.center = view.center
        activityIndicatorView.color = .Buttoncolor
        view.addSubview(activityIndicatorView)
        
        
        webview.navigationDelegate = self
        //        webview.isUserInteractionEnabled = true
        
        
        if keystr == "voucher" {
            titlelbl.text = "Voucher Details"
        }else {
            titlelbl.text = ""
        }
    }
    
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        if keystr == "voucher" {
            callapibool = false
            dismiss(animated: true)
        }else if keystr == "link" {
            callapibool = false
            dismiss(animated: true)
        }else{
            gotoDashboard()
        }
    }
    
    
    func gotoDashboard() {
        BASE_URL = BASE_URL1
        guard let vc = DashBoardTBVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.selectedIndex = 0
        present(vc, animated: true)
    }
    
}


extension LoadWebViewVC {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        if let response = navigationResponse.response as? HTTPURLResponse {
            print(response)
            
            if response.statusCode == 200 {
                openpaymentgatewaybool = true
            }
            
        }
        decisionHandler(.allow)
    }
    
    
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        openpaymentgatewaybool = true
        debugPrint("didCommit")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        
        
        // Simulate a time-consuming operation
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            // Stop the activity indicator after 3 seconds (replace this with your actual data-fetching logic)
            self.activityIndicatorView.stopAnimating()
            self.webview.isUserInteractionEnabled = true
            
        }
        
        
        let str = webView.url?.absoluteString ?? ""
        if str.containsIgnoringCase(find: "payment_gateway/GetHandlerResponse"){
            // MySingleton.shared.mobilepaymentvm?.CALL_MOBILE_PRE_PAYMENT_API(dictParam: [:], url: str)
            GetHandlerResponse(urlstr: str)
        }
        
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        debugPrint("didFail")
    }
    
    
    func GetHandlerResponse(urlstr:String) {
        MySingleton.shared.viewmodel1?.CALL_GET_HANDEL_RESPONSE_API(dictParam: [:], url: urlstr)
    }
    
    func getHandelResponseDetails(response: updatePaymentFlightModel) {
        print(" ====== getHandelResponseDetails    =======")
        print(response.data)
        callSecureBookingAPI(str: response.data ?? "")
    }
    
    
    func callSecureBookingAPI(str:String) {
        MySingleton.shared.viewmodel1?.Call_mobile_secure_booking_API(dictParam: [:], url: str)
    }
    
    
    
    func mobilesecurebookingDetails(response: MobilePrePaymentModel) {
        
        print(" ======= Voucher URL =======")
        print(response.url)
        
        MySingleton.shared.voucherurlsting = response.url ?? ""
        response.status == true ? gotoBookingSucessVC():showToast(message: response.message ?? "")
    }
    
    
    func gotoBookingSucessVC() {
        guard let vc = BookingSucessVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    func mobolePaymentDetails(response: PaymentModel) {
        //
    }
    

}




extension String {
    func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
    func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
}
