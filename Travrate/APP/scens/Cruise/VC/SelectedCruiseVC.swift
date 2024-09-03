//
//  SelectedCruiseVC.swift
//  Travrate
//
//  Created by Admin on 03/09/24.
//

import UIKit

class SelectedCruiseVC: BaseTableVC, CruiseDetailsViewModelDelegate {
    
    
    
    
    @IBOutlet weak var bannerImage: UIImageView!
    
    
    
    
    static var newInstance: SelectedCruiseVC? {
        let storyboard = UIStoryboard(name: Storyboard.Cruise.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SelectedCruiseVC
        return vc
    }
    
    var imgsArray = [String]()
    var selectedCruiseOrigen = String()
    var fname = String()
    var emailid = String()
    var mobile = String()
    
   
    
    override func viewWillDisappear(_ animated: Bool) {
        MySingleton.shared.cruiseItinerary.removeAll()
        MySingleton.shared.cruiseDetails = nil
        selectedCruiseOrigen = ""
        MySingleton.shared.cruiseItinerary.removeAll()
        imgsArray.removeAll()
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        callGetCruiseDetailsAPI()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()

        MySingleton.shared.cruisedetailsvm = CruiseDetailsViewModel(self)
    }
    

    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        callapibool = false
        dismiss(animated: true)
    }
    

}


extension SelectedCruiseVC {
    
    
    func setupUI(){
        
        
        commonTableView.layer.borderWidth = 1
        commonTableView.layer.borderColor = UIColor.BorderColor.cgColor
        
        commonTableView.registerTVCells(["NewCruiseAddItineraryTVCell",
                                         "EmptyTVCell"])
        
        setupVisaTVCells()
        
    }
    
    func callGetCruiseDetailsAPI() {
        
        MySingleton.shared.loderString = "fdetails"
        MySingleton.shared.afterResultsBool = true
        loderBool = true
        showLoadera()
        
        MySingleton.shared.payload.removeAll()
        BASE_URL = ""
        MySingleton.shared.cruisedetailsvm?.CALL_CRUISE_DETAILS_API(dictParam:  [:])
    }
    
    
    func cruiseDetails(response: CruiseDetailsModel) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [unowned self] in
            loderBool = false
            hideLoadera()
        }
        
        BASE_URL = BASE_URL1
        MySingleton.shared.cruiseItinerary.removeAll()
        imgsArray.removeAll()
        
        
        self.bannerImage.sd_setImage(with: URL(string: MySingleton.shared.cruiseDetails?.cruise_data?.image_url ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"), options: [.retryFailed], completed: { (image, error, cacheType, imageURL) in
            if let error = error {
                // Handle error loading image
               // print("Error loading image: \(error.localizedDescription)")
                // Check if the error is due to a 404 Not Found response
                if (error as NSError).code == NSURLErrorBadServerResponse {
                    // Set placeholder image for 404 error
                    self.bannerImage.image = UIImage(named: "noimage")
                } else {
                    // Set placeholder image for other errors
                    self.bannerImage.image = UIImage(named: "noimage")
                }
            }
        })
        
    
        MySingleton.shared.cruiseDetails = response
        selectedCruiseOrigen = response.cruise_data?.origin ?? ""
        MySingleton.shared.cruiseItinerary = response.cruise_data?.itinerary ?? []
        imgsArray = response.cruise_data?.more_url ?? []
        
        
        DispatchQueue.main.async {
            self.setupVisaTVCells()
        }
    }
    
    
    func setupVisaTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        
        for (index,value) in MySingleton.shared.cruiseItinerary.enumerated() {
            MySingleton.shared.tablerow.append(TableRow(text:String(index),
                                                        moreData:value,
                                                        cellType:.NewCruiseAddItineraryTVCell))
        }
       
        
        MySingleton.shared.tablerow.append(TableRow(height:100,cellType:.EmptyTVCell))
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
        
        
    }
    
    func cruiseEnquireyDetails(response: LoginModel) {
        
    }
}
