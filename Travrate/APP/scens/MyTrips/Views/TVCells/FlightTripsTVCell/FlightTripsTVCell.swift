//
//  FlightTripsTVCell.swift
//  Travrate
//
//  Created by Admin on 21/07/24.
//

import UIKit

protocol FlightTripsTVCellDelegate:AnyObject {
    func didTapOnViewVoutureBtnAction(cell:FlightTripsTVCell)
}

class FlightTripsTVCell: TableViewCell, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var summeryTV: UITableView!
    @IBOutlet weak var tvheight: NSLayoutConstraint!
    @IBOutlet weak var kwdlbl: UILabel!
    
    weak var delegate:FlightTripsTVCellDelegate?
    var voutureurl = String()
    var bookingItinearyDetails = [Flight_Trips_Booking_itinerary_details]()
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
        let bd = cellInfo?.moreData as? [Flight_trips_Booking_details]
        bookingItinearyDetails = bd?[0].booking_itinerary_details ?? []
        voutureurl = bd?[0].voucher_url ?? ""
        updateHeight(ccount: bookingItinearyDetails.count)
    }
    
    func setupUI() {
        setupTV()
    }
    
    
    @IBAction func didTapOnViewVoutureBtnAction(_ sender: Any) {
        delegate?.didTapOnViewVoutureBtnAction(cell: self)
    }
    
    
}

extension FlightTripsTVCell {
    
    
    func updateHeight(ccount:Int) {
        tvheight.constant = CGFloat((ccount) * 133)
        summeryTV.reloadData()
    }
    
    
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
        return bookingItinearyDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? FlightResultSummeryTVCell {
            
            cell.selectionStyle = .none
            let data = bookingItinearyDetails[indexPath.row]
            
            //            cell.fromCityTimelbl.text = data.
            //                        cell.fromCityNamelbl.text = "\(data.origin?.city ?? "")(\(data.origin?.loc ?? ""))"
            //                        cell.toCityTimelbl.text = data.destination?.time
            //                        cell.toCityNamelbl.text = "\(data.destination?.city ?? "")(\(data.destination?.loc ?? ""))"
            //                        cell.hourslbl.text = data.duration
            //                        cell.noOfStopslbl.text = "\(data.no_of_stops ?? 0) Stop"
            //                        cell.inNolbl.text = "\(data.operator_code ?? "") - \(data.flight_number ?? "")"
            //                        cell.logoImg.sd_setImage(with: URL(string: data.operator_image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            //                        cell.classlbl.text = data.fclass?.name
            //
            //
            //                        cell.luggagelbl.text = "7kg"
            //
            //                        if let convertedString = MySingleton.shared.convertToPC(input: data.weight_Allowance ?? "") {
            //                            cell.worklbl.text = convertedString
            //                        } else {
            //                            print("Invalid input format")
            //                        }
            //
            //
            //
            //                        if summeryTV.isLast(for: indexPath) {
            //                            cell.ul.isHidden = true
            //                        }
            //
            //
            //                        if data.operator_code == "J9" {
            //                            self.bookNowlbl.text = "Select Fare"
            //                        }else {
            //                            self.bookNowlbl.text = "Book Now"
            //                        }
            
            
            c = cell
            
        }
        return c
    }
    
    
}
