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
    
    
    @IBOutlet weak var viewVoucherView: UIView!
    @IBOutlet weak var viewVoucherlbl: UILabel!
    @IBOutlet weak var summeryTV: UITableView!
    @IBOutlet weak var tvheight: NSLayoutConstraint!
    
    weak var delegate:FlightTripsTVCellDelegate?
    var voutureurl = String()
    var flightSummery = [Booking]()
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
        
        flightSummery = cellInfo?.moreData as? [Booking] ?? []
        updateHeight(ccount: flightSummery.count)
    }
    
    func setupUI() {
        viewVoucherView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        viewVoucherView.layer.cornerRadius = 6
        viewVoucherlbl.text = "View Voucher"
        viewVoucherlbl.font = .InterBold(size: 14)
        viewVoucherlbl.textColor = .WhiteColor
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
        return flightSummery.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? FlightResultSummeryTVCell {
            
            cell.selectionStyle = .none
            let data = flightSummery[indexPath.row]
            
            cell.fromCityTimelbl.text = data.origin?.time
            cell.fromCityNamelbl.text = "\(data.origin?.city ?? "")(\(data.origin?.loc ?? ""))"
            cell.toCityTimelbl.text = data.destination?.time
            cell.toCityNamelbl.text = "\(data.destination?.city ?? "")(\(data.destination?.loc ?? ""))"
            cell.hourslbl.text = data.duration
            cell.noOfStopslbl.text = "\(data.no_of_stops ?? 0) Stop"
            cell.inNolbl.text = "\(data.operator_code ?? "") - \(data.flight_number ?? "")"
            //    cell.logoImg.sd_setImage(with: URL(string: data.operator_image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            cell.classlbl.text = data.cclass?.name
            
            
            cell.luggagelbl.text = "7kg"
            
            if let convertedString = MySingleton.shared.convertToPC(input: data.weight_Allowance ?? "") {
                cell.worklbl.text = convertedString
            } else {
                print("Invalid input format")
            }
            
            if indexPath.row == 0 {
                voutureurl = data.pdf_url ?? ""
            }
            
            
            
            if summeryTV.isLast(for: indexPath) {
                cell.ul.isHidden = true
            }
            
            
            
            c = cell
            
        }
        return c
    }
    
    
}
