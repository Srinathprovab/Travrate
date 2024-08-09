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
    @IBOutlet weak var carrentalView: UIView!
    @IBOutlet weak var carRentalNamelbl: UILabel!
    @IBOutlet weak var carRentalDateslbl: UILabel!
    @IBOutlet weak var flightEconomylbl: UILabel!
    @IBOutlet weak var waitView: UIView!
    
    
    var searchdata:SearchData?
    var searchHoteldata:SearchHotelData?
    var gifImages: [UIImage] = []
    var currentFrame: Int = 0
    var timer: Timer?
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        setuplabels(lbl: triptypelbl, text: "", textcolor: .TitleColor, font: .InterBold(size: 16), align: .center)
        setuplabels(lbl: cityslbl, text: "", textcolor: .TitleColor, font: .InterBold(size: 16), align: .center)
        setuplabels(lbl: datelbl, text: "", textcolor: .TitleColor, font: .InterBold(size: 16), align: .center)
        setuplabels(lbl: locationslbl, text: "", textcolor: .TitleColor, font: .InterBold(size: 16), align: .center)
        setuplabels(lbl: checkinlbl, text: "", textcolor: .TitleColor, font: .InterBold(size: 16), align: .right)
        setuplabels(lbl: checkoutlbl, text: "", textcolor: .TitleColor, font: .InterBold(size: 16), align: .right)
        setuplabels(lbl: guestlbl, text: "", textcolor: .TitleColor, font: .InterBold(size: 16), align: .right)
        setuplabels(lbl: nightslbl, text: "", textcolor: .TitleColor, font: .InterBold(size: 16), align: .right)
        setuplabels(lbl: roomslbl, text: "", textcolor: .TitleColor, font: .InterBold(size: 16), align: .right)
        setuplabels(lbl: flightEconomylbl, text: "", textcolor: .TitleColor, font: .InterBold(size: 16), align: .center)
        setuplabels(lbl: sporteventlbl, text: "", textcolor: .TitleColor, font: .InterBold(size: 16), align: .center)
        setuplabels(lbl: sportvenulbl, text: "", textcolor: .TitleColor, font: .InterBold(size: 16), align: .center)
        setuplabels(lbl: sportdateslbl, text: "", textcolor: .TitleColor, font: .InterBold(size: 16), align: .center)
        setuplabels(lbl: carRentalNamelbl, text: "", textcolor: .TitleColor, font: .InterBold(size: 16), align: .center)
        setuplabels(lbl: carRentalDateslbl, text: "", textcolor: .TitleColor, font: .InterBold(size: 16), align: .center)
        
        
        
        if MySingleton.shared.afterResultsBool == false {
            waitView.isHidden = true
            
            callAPI()
        }else {
            flightinfo.isHidden = true
            hotelinfoView.isHidden = true
            img.image = UIImage(named: "travlogo")
           
            // img.sd_setImage(with: URL(string: "MySingleton.shared.loderimgurl" ), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            
            if MySingleton.shared.loderString == "payment"  {
                waitView.isHidden = true
            }else {
                waitView.isHidden = false
            }
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        img.layer.cornerRadius = 70
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
            
            
            
            
            let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType)
            if journyType == "oneway" {
                
                cityslbl.text = "\(defaults.string(forKey: UserDefaultsKeys.fcity) ?? "") - \(defaults.string(forKey: UserDefaultsKeys.tcity) ?? "")"
                datelbl.text = "\(MySingleton.shared.convertDateFormat(inputDate: searchdata?.from_date ?? "", f1: "dd-MM-yyyy", f2: "EEE, dd MMM"))"
                flightEconomylbl.text = defaults.string(forKey: UserDefaultsKeys.selectClass)
                triptypelbl.text = "Oneway - \(defaults.string(forKey: UserDefaultsKeys.totalTravellerCount) ?? "") Travellers"
                
            }else {
                
                cityslbl.text = "\(defaults.string(forKey: UserDefaultsKeys.fcity) ?? "") - \(defaults.string(forKey: UserDefaultsKeys.tcity) ?? "") - \(defaults.string(forKey: UserDefaultsKeys.fcity) ?? "")"
                datelbl.text = "\(MySingleton.shared.convertDateFormat(inputDate: searchdata?.from_date ?? "", f1: "dd-MM-yyyy", f2: "EEE, dd MMM")) - \(MySingleton.shared.convertDateFormat(inputDate: searchdata?.to_date ?? "", f1: "dd-MM-yyyy", f2: "EEE, dd MMM"))"
                
                flightEconomylbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectClass) ?? "") - \(defaults.string(forKey: UserDefaultsKeys.rselectClass) ?? "")"
                triptypelbl.text = "RoundTrip - \(defaults.string(forKey: UserDefaultsKeys.totalTravellerCount) ?? "") Travellers"
                
            }
            
            
        }else if tabselect == "Sports" {
            
            sportsView.isHidden = false
            
        }else if tabselect == "CarRental" {
            
            carrentalView.isHidden = false
            
        }else if tabselect == "transfers" {
            
            sportsView.isHidden = false
            
        }else if tabselect == "Activities" {
            
            sportsView.isHidden = false
            
        }else {
            
            flightinfo.isHidden = true
            hotelinfoView.isHidden = false
            
            img.sd_setImage(with: URL(string: searchHoteldata?.image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            
            locationslbl.text = defaults.string(forKey: UserDefaultsKeys.locationcity)
            checkinlbl.text = MySingleton.shared.convertDateFormat(inputDate: searchHoteldata?.check_in ?? "", f1: "dd/MM/yyyy", f2: "dd-MMM-yyyy")
            checkoutlbl.text = MySingleton.shared.convertDateFormat(inputDate: searchHoteldata?.check_out ?? "", f1: "dd/MM/yyyy", f2: "dd-MMM-yyyy")
            
            
            let adultcount = MySingleton.shared.hoteladultscount
            let childcount = MySingleton.shared.hotelchildcount
            var labelText = "\(adultcount) Adults"
            if childcount > 0 {
                labelText += " - \(childcount) Child"
            }
           
            guestlbl.text = labelText
           
            
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
        }else if tabselect == "Sports" {
            
            sportsView.isHidden = false
            sporteventlbl.text = MySingleton.shared.sportsTeamName
            sportvenulbl.text = MySingleton.shared.sportsVenuName
            sportdateslbl.text = "\(MySingleton.shared.convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.sportcalDepDate) ?? "", f1: "dd-MM-yyyy", f2: "dd-MMM-yyyy")) To \(MySingleton.shared.convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.sportcalRetDate) ?? "", f1: "dd-MM-yyyy", f2: "dd-MMM-yyyy"))"
            
        }else if tabselect == "CarRental" {
            
            
            guard let pickuplocationname =  defaults.string(forKey: UserDefaultsKeys.pickuplocationname) else {return}
            guard let pickuplocDate =  defaults.string(forKey: UserDefaultsKeys.pickuplocDate) else {return}
            guard let dropuplocDate =  defaults.string(forKey: UserDefaultsKeys.dropuplocDate) else {return}
            
            
            carrentalView.isHidden = false
            carRentalNamelbl.text = pickuplocationname
            carRentalDateslbl.text = "\(pickuplocDate) to \(dropuplocDate)"
            
        }else if tabselect == "transfers" {
            
            
            let journytype =  defaults.string(forKey: UserDefaultsKeys.transferjournytype)
            let fromcity =  defaults.string(forKey: UserDefaultsKeys.transferfromcityname)
            let tocity =  defaults.string(forKey: UserDefaultsKeys.transfertocityname)
            
            let fromdate = MySingleton.shared.convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.transfercalDepDate) ?? "", f1: "dd-MM-yyyy", f2: "dd-MMM-yyyy")
            let todate = MySingleton.shared.convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.transfercalRetDate) ?? "", f1: "dd-MM-yyyy", f2: "dd-MMM-yyyy")
            
            sportsView.isHidden = false
            sporteventlbl.text = fromcity
            sportvenulbl.text = tocity
            sportdateslbl.text = journytype == "oneway" ? "\(fromdate)": "\(fromdate) to \(todate)"
            
            
            
        }else if tabselect == "Activities" {
            
            
            let cityname = defaults.string(forKey: UserDefaultsKeys.activitescityname)
            let fromdate = MySingleton.shared.convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.calActivitesDepDate) ?? "", f1: "dd-MM-yyyy", f2: "dd-MMM-yyyy")
            let todate = MySingleton.shared.convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.calActivitesRetDate) ?? "", f1: "dd-MM-yyyy", f2: "dd-MMM-yyyy")
            let adultcount = defaults.integer(forKey: UserDefaultsKeys.activitesadultCount)
            let childcount = defaults.integer(forKey: UserDefaultsKeys.activiteschildCount)
            let infantcount = defaults.integer(forKey: UserDefaultsKeys.activitesinfantsCount)
            
            
            
            sportsView.isHidden = false
            sporteventlbl.text = cityname
            sportvenulbl.text = "\(fromdate) To \(todate)"
            var labelText = adultcount > 1 ? "Adults \(adultcount)" : "Adult \(adultcount)"
            if childcount > 0 {
                labelText += ", Child \(childcount)"
            }
            if infantcount > 0 {
                labelText += ", Infant \(infantcount)"
            }
            sportdateslbl.text = labelText
            
            
            
            
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
