//
//  FlightResultTVCell.swift
//  TravgateApp
//
//  Created by FCI on 05/01/24.
//

import UIKit

protocol FlightResultTVCellDelegate: AnyObject {
    
    func didTapOnFlightDetails(cell:FlightResultTVCell)
    func didTapOnBookNowBtnAction(cell:FlightResultTVCell)
    func didTapOnMoreSimilarFlightBtnAction(cell:FlightResultTVCell)
    func didTapFlightDetailsPopupBrtnBtnAction(cell:FlightResultTVCell)
    func didTapOnReturnDateBtnAction(cell:FlightResultTVCell)
    func didTapOnSelectFareBtnAction(cell:FlightResultTVCell)
    func didTapOnShareBtnAction(cell:FlightResultTVCell)
    
}

class FlightResultTVCell: TableViewCell {
    
    
    @IBOutlet weak var summeryTV: UITableView!
    @IBOutlet weak var tvheight: NSLayoutConstraint!
    @IBOutlet weak var fareTypelbl: UILabel!
    @IBOutlet weak var strikekwdlbl: UILabel!
    @IBOutlet weak var kwdlbl: UILabel!
    @IBOutlet weak var moreSimilarBtn: UIButton!
    @IBOutlet weak var moreSimilarImage: UIImageView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var returnBtn: UIButton!
    
    @IBOutlet weak var bookNowBtnView: BorderedView!
    @IBOutlet weak var bookNowlbl: UILabel!
    @IBOutlet weak var simalarView: UIView!
    @IBOutlet weak var simalrViewHeight: NSLayoutConstraint!
    @IBOutlet weak var totlapricecurrencylbl: UILabel!
    @IBOutlet weak var strikekwdcurrencylbl: UILabel!
    
    
    var shareresultaccesskey = String()
    var shareresultrandomid = String()
    var shareresultbookingsource = String()
    var selectedResult = String()
    var newsimilarList = [[FlightList]]()
    weak var delegate:FlightResultTVCellDelegate?
    var flightsummery = [Summary]()
    var journeyKeystr = String()
    var flightlist :FlightList?
    var farerulesrefKey = [[String]]()
    var farerulesrefContent = [[String]]()
    var bookingsource = String()
    var bookingsourcekey = String()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    func setupUI() {
        simalarView.isHidden = true
        setupTV()
    }
    
    override func updateUI() {
        
        
        shareresultbookingsource = cellInfo?.subTitle ?? ""
        shareresultaccesskey = cellInfo?.tempText ?? ""
        shareresultrandomid = cellInfo?.key1 ?? ""
        returnBtn.layer.cornerRadius = 4
        selectedResult = cellInfo?.title ?? ""
        flightsummery = cellInfo?.data1 as! [Summary]
        flightlist = cellInfo?.moreData as? FlightList
        farerulesrefKey = cellInfo?.tempInfo as? [[String]] ?? [[]]
        farerulesrefContent = cellInfo?.data2 as? [[String]] ?? [[]]
        fareTypelbl.text = flightlist?.fareType ?? ""
        let kwdprice = String(format: "%.2f", flightlist?.price?.api_total_display_fare ?? 0.0)
        let strikekwdprice = String(format: "%.2f", flightlist?.price?.api_total_display_fare_withoutmarkup ?? 0.0)
        
        
        
        MySingleton.shared.setAttributedTextnew(str1: "\(flightlist?.price?.api_currency ?? "")",
                                                str2: "",
                                                lbl: totlapricecurrencylbl,
                                                str1font: .InterBold(size: 12),
                                                str2font: .InterBold(size: 20),
                                                str1Color: .BackBtnColor,
                                                str2Color: .BackBtnColor)
        
        MySingleton.shared.setAttributedTextnew(str1: "",
                                                str2: "",
                                                lbl: strikekwdcurrencylbl,
                                                str1font: .InterBold(size: 12),
                                                str2font: .InterBold(size: 20),
                                                str1Color: .BackBtnColor,
                                                str2Color: .BackBtnColor)
        
        
        MySingleton.shared.setAttributedTextnew(str1: "",
                                                str2: "\(kwdprice)",
                                                lbl: kwdlbl,
                                                str1font: .InterBold(size: 12),
                                                str2font: .InterBold(size: 20),
                                                str1Color: .BackBtnColor,
                                                str2Color: .BackBtnColor)
        
        
        MySingleton.shared.setAttributedTextnew(str1: "\(flightlist?.price?.api_currency ?? ""):",
                                                str2: "\(strikekwdprice)",
                                                lbl: strikekwdlbl,
                                                str1font: .InterBold(size: 12),
                                                str2font: .InterBold(size: 12),
                                                str1Color: .BackBtnColor,
                                                str2Color: .BackBtnColor)
        
        
        
     
        
        if kwdprice == strikekwdprice {
            strikekwdlbl.isHidden = true
           strikekwdcurrencylbl.isHidden = true
        }else {
            strikekwdlbl.isHidden = false
            strikekwdcurrencylbl.isHidden = false
        }
        
        if kwdprice < strikekwdprice {
            strikekwdlbl.isHidden = true
            strikekwdcurrencylbl.isHidden = true
        }
        
        setAttributedString1(str1: strikekwdlbl.text ?? "")
        checkSimelarFlights()
        
        if fareTypelbl.text == "Refundable" {
            fareTypelbl.textColor = HexColor("#00711F")
        }else {
            fareTypelbl.textColor = .BooknowBtnColor
        }
        
        
        if cellInfo?.key == "similar" {
            bottomView.isHidden = false
            moreSimilarBtn.isHidden = true
            moreSimilarImage.isHidden = true
            
        }
        
        let journytype = defaults.string(forKey: UserDefaultsKeys.journeyType)
        if journytype == "circle" {
            returnBtn.isHidden = true
            tvheight.constant = CGFloat((flightsummery.count ) * 133)
        }else {
            returnBtn.isHidden = false
            tvheight.constant = CGFloat((flightsummery.count ) * 170)
        }
        
        
        journeyKeystr = cellInfo?.headerText ?? ""
        
        bookingsource = cellInfo?.subTitle ?? ""
        bookingsourcekey = cellInfo?.text ?? ""
        
        summeryTV.reloadData()
        
        
       
    }
    
    
    @IBAction func didTapOnMoreSimilarFlightBtnAction(_ sender: Any) {
        
        print(newsimilarList.count)
//        simalarView.isHidden = false
//        simalrViewHeight.constant = CGFloat(80 * newsimilarList.count)
        
        delegate?.didTapOnMoreSimilarFlightBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnFlightDetails(_ sender: Any) {
        delegate?.didTapOnFlightDetails(cell: self)
    }
    
    @IBAction func didTapOnBookNowBtnAction(_ sender: Any) {
        
        if self.bookNowlbl.text == "Select Fare" {
            delegate?.didTapOnSelectFareBtnAction(cell: self)
        }else {
            delegate?.didTapOnBookNowBtnAction(cell: self)
        }
    }
    
    @IBAction func didTapOnReturnDateBtnAction(_ sender: Any) {
       
        MySingleton.shared.returnDateTapbool = true
        delegate?.didTapOnReturnDateBtnAction(cell: self)
    }
    
    
    
    @objc func didTapFlightDetailsPopupBrtnBtnAction(_ sender: UIButton) {
        delegate?.didTapFlightDetailsPopupBrtnBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnShareBtnAction(_ sender: Any) {
        delegate?.didTapOnShareBtnAction(cell: self)
    }
    
}


extension FlightResultTVCell:UITableViewDelegate,UITableViewDataSource {
    
    
    
    func setupTV() {
        summeryTV.register(UINib(nibName: "FlightResultSummeryTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        summeryTV.delegate = self
        summeryTV.dataSource = self
        summeryTV.tableFooterView = UIView()
        summeryTV.showsHorizontalScrollIndicator = false
        summeryTV.separatorStyle = .singleLine
        summeryTV.isScrollEnabled = false
        summeryTV.separatorStyle = .none
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flightsummery.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? FlightResultSummeryTVCell {
            
            cell.selectionStyle = .none
            let data = flightsummery[indexPath.row]
            
            cell.flightDetailsTapBtn.addTarget(self, action: #selector(didTapFlightDetailsPopupBrtnBtnAction(_:)), for: .touchUpInside)
            cell.fromCityTimelbl.text = data.origin?.time
            cell.fromCityNamelbl.text = "\(data.origin?.city ?? "")"
            cell.toCityTimelbl.text = data.destination?.time
            cell.toCityNamelbl.text = "\(data.destination?.city ?? "")"
            cell.hourslbl.text = data.duration
            cell.noOfStopslbl.text = "\(data.no_of_stops ?? 0) Stop"
            cell.inNolbl.text = "\(data.operator_code ?? "") - \(data.flight_number ?? "")"
            cell.logoImg.sd_setImage(with: URL(string: data.operator_image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            cell.classlbl.text = data.fclass?.name
            
           
            cell.luggagelbl.text = "7kg"
            
            if let convertedString = MySingleton.shared.convertToPC(input: data.weight_Allowance ?? "") {
                cell.worklbl.text = convertedString
            } else {
                print("Invalid input format")
            }
            
            
            
            if summeryTV.isLast(for: indexPath) {
                cell.ul.isHidden = true
            }
            
            
            if data.operator_code == "J9" {
                self.bookNowlbl.text = "Select Fare"
            }else {
                self.bookNowlbl.text = "Book Now"
            }
            
            if data.no_of_stops == 0 {
                cell.noOfStopslbl.text = "Non Stop"
            }
            
            
            c = cell
            
        }
        return c
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //delegate?.didTaponRoundTripCell(cell: self)
    }
    
}


//MARK: - hideSimilarlbl showSimilarlbl
extension FlightResultTVCell {
    
    
    
    func checkSimelarFlights() {
        
        if let similarList1 = cellInfo?.data as? [[FlightList]] {
            newsimilarList = similarList1
            let similarListCount = similarList1.count
            
            // Debugging: Print the count of similarList1
            
            if similarListCount > 1 {
                
                if similarListCount == 1 {
                    hideSimilarlbl()
                }else {
                    moreSimilarBtn.setTitle("More similar options(\(similarListCount - 1))", for: .normal)
                    showSimilarlbl()
                }
               
                //showSimilarlbl()
            } else {
                hideSimilarlbl()
            }
        }else {
            hideSimilarlbl() // Handle the case when cellInfo?.data is not a valid [[J_flight_list]]
        }
        
        
    }
    
    
    
    func hideSimilarlbl(){
        bottomView.isHidden = false
        moreSimilarBtn.isHidden = true
        moreSimilarImage.isHidden = true
    }
    
    func showSimilarlbl(){
        bottomView.isHidden = false
        moreSimilarBtn.isHidden = false
        moreSimilarImage.isHidden = false
    }
    
    
    
    func setAttributedString1(str1:String) {
        
        let atter1 = [NSAttributedString.Key.foregroundColor:UIColor.BackBtnColor,NSAttributedString.Key.font:UIFont.InterMedium(size: 11),NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue] as [NSAttributedString.Key : Any]
      
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        
        
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        
        strikekwdlbl.attributedText = combination
        
    }
    
}
