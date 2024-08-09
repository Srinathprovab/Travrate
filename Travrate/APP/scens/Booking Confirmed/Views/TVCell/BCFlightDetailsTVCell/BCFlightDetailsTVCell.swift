//
//  BCFlightDetailsTVCell.swift
//  BabSafar
//
//  Created by FCI on 29/08/23.
//

import UIKit
import SDWebImage

protocol BCFlightDetailsTVCellDelegate: AnyObject {
    func didTapOnViewVoucherBtnAction(cell:BCFlightDetailsTVCell)
}

class BCFlightDetailsTVCell: TableViewCell {
    
    
    @IBOutlet weak var flightDetaillsTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    
    weak var delegate:BCFlightDetailsTVCellDelegate?
    var bookingFlightDetails = [Booking_itinerary_summary]()
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
        bookingFlightDetails = cellInfo?.moreData as? [Booking_itinerary_summary] ?? []
        tvHeight.constant = CGFloat(bookingFlightDetails.count * 108)
        flightDetaillsTV.reloadData()
    }
    
    func setupUI() {
        setupTV()
    }
    
    @IBAction func didTapOnViewVoucher(_ sender: Any) {
        delegate?.didTapOnViewVoucherBtnAction(cell: self)
    }
    
    
}



extension BCFlightDetailsTVCell: UITableViewDelegate,UITableViewDataSource {
    
    
    
    func setupTV() {
        let nib = UINib(nibName: "BookedFlightInfoTVCell", bundle: nil)
        flightDetaillsTV.register(nib, forCellReuseIdentifier: "cell")
        flightDetaillsTV.delegate = self
        flightDetaillsTV.dataSource = self
        flightDetaillsTV.tableFooterView = UIView()
        flightDetaillsTV.separatorStyle = .none
        flightDetaillsTV.isScrollEnabled = false
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookingFlightDetails.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? BookedFlightInfoTVCell {
            cell.selectionStyle = .none
            
            let data = bookingFlightDetails[indexPath.row]
            
            cell.deplogoImg.isHidden = false
            cell.fromCityTimelbl.text = data.origin?.time
            cell.fromCityNamelbl.text = "\(data.origin?.city ?? "")(\(data.origin?.loc ?? ""))"
            cell.toCityTimelbl.text = data.destination?.time
            cell.toCityNamelbl.text = "\(data.destination?.city ?? "")(\(data.destination?.loc ?? ""))"
            cell.hourslbl.text = data.duration
            //   cell.noOfStopslbl.text = "\(data.no_of_stops ?? 0) Stop"
            cell.inNolbl.text = "\(data.operator_code ?? "") \(data.flight_number ?? "")"
            cell.logoImg.sd_setImage(with: URL(string: data.operator_image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            cell.classlbl.text = data.cabin_class ?? ""
            
            cell.luggagelbl.text = "7kg"
            
            if let convertedString = MySingleton.shared.convertToPC(input: data.weight_Allowance ?? "") {
                cell.worklbl.text = convertedString
            } else {
                print("Invalid input format")
            }
            
            //            cell.widthconst.constant = 0
            //            cell.heightconst.constant = 0
            //            cell.stopsview.isHidden = true
            
            cell.ul.isHidden = true
            cell.deplogoImg.image = UIImage(named: "depflight")
            if flightDetaillsTV.isLast(for: indexPath) {
                cell.ul.isHidden = false
                cell.ul.isHidden = true
                cell.deplogoImg.image = UIImage(named: "retflight")
            }
            
            
            
            ccell = cell
        }
        return ccell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    
    
}
