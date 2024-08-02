//
//  FlightTripsTVCell.swift
//  Travrate
//
//  Created by Admin on 21/07/24.
//

import UIKit

class FlightTripsTVCell: TableViewCell, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var summeryTV: UITableView!
    @IBOutlet weak var tvheight: NSLayoutConstraint!
    @IBOutlet weak var kwdlbl: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        tvheight.constant = CGFloat((2) * 133)
        // Initialization code
    }
    
    func setupUI() {
      //  bookNowlbl.font = .InterRegular(size: 12)
        setupTV()
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
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension FlightTripsTVCell {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? FlightResultSummeryTVCell {
            
            cell.selectionStyle = .none
            //            let data = flightsummery[indexPath.row]
            //
            //            cell.flightDetailsTapBtn.addTarget(self, action: #selector(didTapFlightDetailsPopupBrtnBtnAction(_:)), for: .touchUpInside)
            //            cell.fromCityTimelbl.text = data.origin?.time
            //            cell.fromCityNamelbl.text = "\(data.origin?.city ?? "")(\(data.origin?.loc ?? ""))"
            //            cell.toCityTimelbl.text = data.destination?.time
            //            cell.toCityNamelbl.text = "\(data.destination?.city ?? "")(\(data.destination?.loc ?? ""))"
            //            cell.hourslbl.text = data.duration
            //            cell.noOfStopslbl.text = "\(data.no_of_stops ?? 0) Stop"
            //            cell.inNolbl.text = "\(data.operator_code ?? "") - \(data.flight_number ?? "")"
            //            cell.logoImg.sd_setImage(with: URL(string: data.operator_image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            //            cell.classlbl.text = data.fclass?.name
            //
            //
            //            cell.luggagelbl.text = "7kg"
            //
            //            if let convertedString = MySingleton.shared.convertToPC(input: data.weight_Allowance ?? "") {
            //                cell.worklbl.text = convertedString
            //            } else {
            //                print("Invalid input format")
            //            }
            //
            //
            //
            //            if summeryTV.isLast(for: indexPath) {
            //                cell.ul.isHidden = true
            //            }
            //
            //
            //            if data.operator_code == "J9" {
            //                self.bookNowlbl.text = "Select Fare"
            //            }else {
            //                self.bookNowlbl.text = "Book Now"
            //            }
            //
            
            c = cell
            
        }
        return c
    }
    
    
}
