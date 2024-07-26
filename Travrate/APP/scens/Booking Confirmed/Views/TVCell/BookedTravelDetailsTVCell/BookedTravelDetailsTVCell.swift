//
//  BookedTravelDetailsTVCell.swift
//  BabSafar
//
//  Created by MA673 on 26/07/22.
//

import UIKit

class BookedTravelDetailsTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var labelsView: UIView!
    @IBOutlet weak var passengerTypelbl: UILabel!
    @IBOutlet weak var travellerNamelbl: UILabel!
    @IBOutlet weak var emaillbl: UILabel!
    @IBOutlet weak var mobilelbl: UILabel!
    @IBOutlet weak var ulView: UIView!
    @IBOutlet weak var adultDetailsTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    
    var keystr = String()
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    override func updateUI() {
    
        keystr = cellInfo?.key ?? ""
        
        
        if keystr == "BC" {
            if Customerdetails.count > 0 {
                tvHeight.constant = CGFloat(Customerdetails.count * 48)
            }
        }else if keystr == "hotel"{
            passengerTypelbl.text = "Guest"
            travellerNamelbl.text = "Name"
            emaillbl.text = "Email"
            mobilelbl.text = "Mobile"
          
            if travelerArray.count > 0 {
                tvHeight.constant = CGFloat(travelerArray.count * 48)
            }
            
        }else if keystr == "sports" {
            passengerTypelbl.text = "Name"
            travellerNamelbl.text = "Passport No"
            emaillbl.text = "City"
            mobilelbl.isHidden = true
          
            if MySingleton.shared.sports_passengers.count > 0 {
                tvHeight.constant = CGFloat(MySingleton.shared.sports_passengers.count * 48)
            }
        }else if keystr == "car" {
            passengerTypelbl.text = "Name"
            travellerNamelbl.text = "Email Id"
            emaillbl.text = "Mobile"
            mobilelbl.isHidden = true
          
            if MySingleton.shared.carpassengerDetails.count > 0 {
                tvHeight.constant = CGFloat(MySingleton.shared.carpassengerDetails.count * 48)
            }
        }else if keystr == "transfer" {
            passengerTypelbl.text = "Type"
            travellerNamelbl.text = "Name"
            emaillbl.text = "Email Id"
            mobilelbl.text = "Mobile"
          
            if travelerArray.count > 0 {
                tvHeight.constant = CGFloat(travelerArray.count * 48)
            }
        }else {
            passengerTypelbl.text = "Passenger"
            travellerNamelbl.text = "Name"
            emaillbl.text = "Email"
            mobilelbl.text = "Mobile"
          
            if travelerArray.count > 0 {
                tvHeight.constant = CGFloat(travelerArray.count * 48)
            }
            
        }
            
        adultDetailsTV.reloadData()
    }
    
    

    
    func setupUI() {
        
        holderView.backgroundColor = .WhiteColor
        holderView.layer.cornerRadius = 10
        holderView.clipsToBounds = true
        holderView.layer.borderColor = UIColor.AppBorderColor.cgColor
        holderView.layer.borderWidth = 1
        setupViews(v: labelsView, radius: 0, color: .WhiteColor)
        labelsView.layer.borderColor = UIColor.WhiteColor.cgColor
        // labelsView.addBottomBorderWithColor(color: .SubTitleColor, width: 1)
        ulView.backgroundColor = HexColor("#E6E8E7")
        
        setuplabels(lbl: passengerTypelbl, text: "Traveller Name", textcolor: HexColor("#5B5B5B"), font: .OpenSansBold(size: 14), align: .center)
        setuplabels(lbl: travellerNamelbl, text: "Ticket No", textcolor: HexColor("#5B5B5B"), font: .OpenSansBold(size: 14), align: .center)
        setuplabels(lbl: emaillbl, text: "Status", textcolor: HexColor("#5B5B5B"), font: .OpenSansBold(size: 14), align: .center)
        passengerTypelbl.text = "Passenger Name"
        travellerNamelbl.text = "Passport No"
        emaillbl.text = "    Country"
        
        
        setupTV()
    }
    
    func setupTV() {
        adultDetailsTV.register(UINib(nibName: "BookedAdultDetailsTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        adultDetailsTV.register(UINib(nibName: "BookedAdultDetailsTVCell", bundle: nil), forCellReuseIdentifier: "cell1")
        adultDetailsTV.register(UINib(nibName: "BookedAdultDetailsTVCell", bundle: nil), forCellReuseIdentifier: "sports")
        adultDetailsTV.register(UINib(nibName: "BookedAdultDetailsTVCell", bundle: nil), forCellReuseIdentifier: "transfer")
        
        adultDetailsTV.delegate = self
        adultDetailsTV.dataSource = self
        adultDetailsTV.tableFooterView = UIView()
        adultDetailsTV.showsHorizontalScrollIndicator = false
        
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.4
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    
}


extension BookedTravelDetailsTVCell:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if keystr == "BC" {
            return Customerdetails.count
        }else if keystr == "sports" {
            return MySingleton.shared.sports_passengers.count
        }else if keystr == "car" {
            return MySingleton.shared.carpassengerDetails.count
        }else if keystr == "transfer" {
            return travelerArray.count
        }else{
            return travelerArray.count
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        
        
        if keystr == "BC" {
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? BookedAdultDetailsTVCell {
                cell.selectionStyle = .none
                
                let data = Customerdetails[indexPath.row]
                cell.passengerTypelbl.text = "\(data.first_name ?? "") \(data.last_name ?? "")"
                cell.travellerNamelbl.text = data.passport_number ?? ""
                cell.emaillbl.text = data.passenger_nationality_name ?? ""
                if indexPath.row == 0{
                    cell.setAttributedText(str1: "\(data.first_name ?? "") \(data.last_name ?? "")", str2: "\n\(cellInfo?.title ?? "")")
                }
                
                c = cell
            }
        }else if keystr == "sports" {
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "sports") as? BookedAdultDetailsTVCell {
                cell.selectionStyle = .none
                
                let data = MySingleton.shared.sports_passengers[indexPath.row]
                cell.passengerTypelbl.text = "\(data.first_name ?? "") \(data.last_name ?? "")"
                cell.travellerNamelbl.text = data.passportNumber
                cell.emaillbl.text = data.city_of_birth
                cell.mobileLbl.isHidden = true
                
                c = cell
            }
        }else if keystr == "car" {
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "sports") as? BookedAdultDetailsTVCell {
                cell.selectionStyle = .none
                
                let data = MySingleton.shared.carpassengerDetails[indexPath.row]
                cell.passengerTypelbl.text = "\(data.first_name ?? "") \(data.last_name ?? "")"
                cell.travellerNamelbl.text = data.email
                cell.emaillbl.text = "\(data.phone_code ?? "")"
                cell.mobileLbl.isHidden = true
                
                c = cell
            }
        }else if keystr == "transfer" {
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "transfer") as? BookedAdultDetailsTVCell {
                cell.selectionStyle = .none
                
                let data = travelerArray[indexPath.row]
                
                cell.setAttributedText(str1: "\(cellInfo?.title ?? "")", str2: "")
                cell.passengerTypelbl.text = ""
                cell.travellerNamelbl.text = "\(data.firstName ?? "") \(data.lastName ?? "")"
                cell.emaillbl.text = data.email
                cell.mobileLbl.text = "\(data.mobilecountrycode ?? "") \(data.mobile ?? "")"
                
                
                if indexPath.row == 0{
                    cell.passengerTypelbl.text = "Lead"
                }
                
                
                c = cell
            }
            
            
        }else{
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as? BookedAdultDetailsTVCell {
                cell.selectionStyle = .none
                
                let data = travelerArray[indexPath.row]
                
                
                
                cell.passengerTypelbl.text = data.passengertype
                cell.travellerNamelbl.text = data.firstName
                cell.emaillbl.text = "----"
                cell.mobileLbl.text = "----"
                
                
                if indexPath.row == 0{
                    cell.setAttributedText(str1: "\(cellInfo?.title ?? "")", str2: "")
                    cell.passengerTypelbl.text = "Lead"
                    cell.travellerNamelbl.text = data.firstName
                    cell.emaillbl.text = MySingleton.shared.payemail
                    cell.mobileLbl.text = MySingleton.shared.paymobile
                }
                
               
                
                
                c = cell
            }
            
            
        }
        
        return c
    }
    
    
    
}
