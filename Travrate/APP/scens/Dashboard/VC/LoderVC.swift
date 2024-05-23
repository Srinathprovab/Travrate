//
//  LoderVC.swift
//  TravgateApp
//
//  Created by FCI on 08/02/24.
//

import UIKit

class LoderVC: UIViewController, SearchLoaderViewModelDelegate, SearchHotelLoderViewModelDelegate {
   
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var gifimg: UIImageView!
    @IBOutlet weak var triptypelbl: UILabel!
    @IBOutlet weak var cityslbl: UILabel!
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var flightinfo: UIStackView!
    @IBOutlet weak var hotelinfoView: UIView!
    @IBOutlet weak var locationslbl: UILabel!
    @IBOutlet weak var checkinlbl: UILabel!
    @IBOutlet weak var checkoutlbl: UILabel!
    @IBOutlet weak var guestlbl: UILabel!
    @IBOutlet weak var nightslbl: UILabel!
    @IBOutlet weak var roomslbl: UILabel!
    @IBOutlet weak var transfersInfoView: UIView!
    
    @IBOutlet weak var sportsView: UIView!
    @IBOutlet weak var sporteventlbl: UILabel!
    @IBOutlet weak var sportvenulbl: UILabel!
    @IBOutlet weak var sportdateslbl: UILabel!
    
    var searchdata:SearchData?
    var searchHoteldata:SearchHotelData?
    var gifImages: [UIImage] = []
    var currentFrame: Int = 0
    var timer: Timer?
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        
        if MySingleton.shared.afterResultsBool == false {
            callAPI()
        }else {
            flightinfo.isHidden = true
            hotelinfoView.isHidden = true
            img.image = UIImage(named: "travlogo")
           // img.sd_setImage(with: URL(string: "MySingleton.shared.loderimgurl" ), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
        }
        
        
    }
    
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
       
        img.layer.cornerRadius = 40
        loadGifFrames()
        startGifAnimation()
        
        MySingleton.shared.lodervm = SearchLoaderViewModel(self)
        MySingleton.shared.hotellodervm = SearchHotelLoderViewModel(self)
        
    }
    
    
    func setupUI() {
        
        let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect)
        if tabselect == "Flight" {
            
            flightinfo.isHidden = false
            hotelinfoView.isHidden = true
           
            img.sd_setImage(with: URL(string: searchdata?.image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            
            cityslbl.text = "\(searchdata?.from ?? "") To \(searchdata?.to ?? "")"
    
            let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType)
            if journyType == "oneway" {
                datelbl.text = "\(MySingleton.shared.convertDateFormat(inputDate: searchdata?.from_date ?? "", f1: "dd-MM-yyyy", f2: "EEE, dd MMM"))"
            }else {
                datelbl.text = "\(MySingleton.shared.convertDateFormat(inputDate: searchdata?.from_date ?? "", f1: "dd-MM-yyyy", f2: "EEE, dd MMM")) - \(MySingleton.shared.convertDateFormat(inputDate: searchdata?.to_date ?? "", f1: "dd-MM-yyyy", f2: "EEE, dd MMM"))"
            }
            
           
            triptypelbl.text = "\(searchdata?.trip_type ?? "") - \(defaults.string(forKey: UserDefaultsKeys.totalTravellerCount) ?? "") Travellers"
            
        }else if tabselect == "transfers" {
            
            flightinfo.isHidden = true
            hotelinfoView.isHidden = true
            transfersInfoView.isHidden = false
           
            MySingleton.shared.loderString = "fdetails"
           
            
        }else if tabselect == "Sports" {
            
            
            
        }else {
            
            flightinfo.isHidden = true
            hotelinfoView.isHidden = false
            
            img.sd_setImage(with: URL(string: searchHoteldata?.image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            
            locationslbl.text = searchHoteldata?.city_name ?? ""
            checkinlbl.text = searchHoteldata?.check_in ?? ""
            checkoutlbl.text = searchHoteldata?.check_out ?? ""
            guestlbl.text = searchHoteldata?.adult?[0] ?? ""
           
            // Example usage:
            let checkInDate = defaults.string(forKey: UserDefaultsKeys.checkin) ?? ""
            let checkOutDate = defaults.string(forKey: UserDefaultsKeys.checkout) ?? ""
            let nights = numberOfNights(checkInDate: checkInDate, checkOutDate: checkOutDate)
           
            MySingleton.shared.totalnights = "\(nights)"
            if MySingleton.shared.totalnights == "0" || MySingleton.shared.totalnights == "1" {
                self.nightslbl.text = "\(nights) Night"
            }else {
                self.nightslbl.text = "\(nights) Nights"
            }
            
            roomslbl.text = searchHoteldata?.rooms ?? ""
           
            
        }
    }
    
    
    func loadGifFrames() {
        // Replace "your_gif_file" with the name of your GIF file (without extension)
        if let gifURL = Bundle.main.url(forResource: MySingleton.shared.loderString, withExtension: "gif"),
           let gifSource = CGImageSourceCreateWithURL(gifURL as CFURL, nil) {
            let frameCount = CGImageSourceGetCount(gifSource)
            
            for index in 0..<frameCount {
                if let cgImage = CGImageSourceCreateImageAtIndex(gifSource, index, nil) {
                    let uiImage = UIImage(cgImage: cgImage)
                    gifImages.append(uiImage)
                }
            }
        }
    }
    
    func startGifAnimation() {
        timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(updateGifFrame), userInfo: nil, repeats: true)
    }
    
    @objc func updateGifFrame() {
        gifimg.image = gifImages[currentFrame]
        currentFrame += 1
        
        if currentFrame >= gifImages.count {
            currentFrame = 0
        }
    }
    
    // Don't forget to invalidate the timer when the view controller is deallocated
    deinit {
        timer?.invalidate()
    }
    

    
    func numberOfNights(checkInDate: String, checkOutDate: String) -> Int {
        // Create date formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        // Parse check-in and check-out dates
        guard let checkIn = dateFormatter.date(from: checkInDate),
              let checkOut = dateFormatter.date(from: checkOutDate) else {
            print("Error parsing dates.")
            return 0
        }
        
        // If check-in and check-out dates are the same, return 1
        if checkIn == checkOut {
            return 1
        }
        
        // Calculate the difference in days
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: checkIn, to: checkOut)
        
        // Extract the number of days
        guard let numberOfDays = components.day else {
            print("Error calculating the number of days.")
            return 0
        }
        
        // Return the number of nights
        return numberOfDays
    }
    
    
}


extension LoderVC {
    
    func callAPI() {
        
        
        let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect)
        if tabselect == "Flight" {
            MySingleton.shared.lodervm?.CALL_FLIGHT_LODER_DETAILS_API(dictParam: MySingleton.shared.payload)
        }else if tabselect == "transfers" {
            
            DispatchQueue.main.async {[self] in
                flightinfo.isHidden = true
                hotelinfoView.isHidden = true
                transfersInfoView.isHidden = false
               
                MySingleton.shared.loderString = "fdetails"
            }
            
        }else if tabselect == "Sports" {
            
            sportsView.isHidden = false
            MySingleton.shared.loderString = "fdetails"
            sporteventlbl.text = MySingleton.shared.sportsTeamName
            sportvenulbl.text = MySingleton.shared.sportsVenuName
            sportdateslbl.text = "\(MySingleton.shared.convertDateFormat(inputDate: MySingleton.shared.sportFromDate, f1: "dd-MM-yyyy", f2: "dd/MM/yyy")) To \(MySingleton.shared.convertDateFormat(inputDate: MySingleton.shared.sportToDate, f1: "dd-MM-yyyy", f2: "dd/MM/yyy"))"
           
        }else {
           // MySingleton.shared.hotellodervm?.CALL_HOTEL_LODER_DETAILS_API(dictParam: MySingleton.shared.payload)
            
            
            do {
                
                let arrJson = try JSONSerialization.data(withJSONObject: MySingleton.shared.payload, options: JSONSerialization.WritingOptions.prettyPrinted)
                let theJSONText = NSString(data: arrJson, encoding: String.Encoding.utf8.rawValue)
                print(theJSONText ?? "")
                MySingleton.shared.payload1["search_params"] = theJSONText
                
                
                MySingleton.shared.hotellodervm?.CALL_HOTEL_LODER_DETAILS_API(dictParam: MySingleton.shared.payload1)
                
            }catch let error as NSError{
                print(error.description)
            }
        }
    }
    
    
    func searchLoderData(response: SearchLoaderModel) {
        searchdata = response.searchdata
        MySingleton.shared.loderimgurl = response.searchdata?.image ?? ""
        DispatchQueue.main.async {
            self.setupUI()
        }
        
    }
    
    
    func searchLoderData(response: SearchHotelLoderModel) {
        searchHoteldata = response.searchdata
        DispatchQueue.main.async {
            self.setupUI()
        }
    }
    
    
}
