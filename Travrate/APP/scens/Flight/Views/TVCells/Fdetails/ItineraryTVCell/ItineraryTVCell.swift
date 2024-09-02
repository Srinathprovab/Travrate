//
//  ItineraryTVCell.swift
//  TravgateApp
//
//  Created by FCI on 06/01/24.
//

import UIKit

class ItineraryTVCell: TableViewCell {
    
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    @IBOutlet weak var additinararyTV: UITableView!
    
    
    
    var depFind = Int()
    var fdetais = [ItinearyFlightDetails]()
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
        
        depFind = Int(cellInfo?.title ?? "") ?? 0
        fdetais = cellInfo?.moreData as! [ItinearyFlightDetails]
        
        tvHeight.constant = CGFloat((fdetais.count * 230))
        additinararyTV.reloadData()
        
        
        // updateHeight()
    }
    
    
    func updateHeight() {
        var totalHeight: CGFloat = 0
        for index in 0..<fdetais.count {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = additinararyTV.cellForRow(at: indexPath) as? AddItineraryTVCell {
                totalHeight += cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            }
        }
        tvHeight.constant = CGFloat((fdetais.count)) * totalHeight
        additinararyTV.reloadData()
    }
    
    
    
    func setupUI() {
        setupTV()
    }
    
    
    func setupTV() {
        additinararyTV.register(UINib(nibName: "AddItineraryTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        additinararyTV.delegate = self
        additinararyTV.dataSource = self
        additinararyTV.tableFooterView = UIView()
        additinararyTV.showsVerticalScrollIndicator = false
        additinararyTV.separatorStyle = .none
        additinararyTV.isScrollEnabled = false
        
        additinararyTV.estimatedRowHeight = 240
    }
    
}




extension ItineraryTVCell:UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fdetais.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AddItineraryTVCell {
            
            cell.selectionStyle = .none
            let data = fdetais[indexPath.row]
            cell.totalJourneyTimelbl.text = "Total Journey Time: \(data.duration ?? "")"
            
            cell.economylbl.text = "\(data.cabin_class ?? "")"
            
            cell.flightnumber.text = "(\(data.operator_code ?? "")-\(data.flight_number ?? ""))"
            cell.fromcitylbl.text = "\(data.origin?.city ?? "") (\(data.origin?.loc ?? ""))"
            cell.fromcitylbl.numberOfLines = 0
            cell.fromdatelbl.text = "\(data.origin?.date ?? "") \(data.origin?.time ?? "")"
            cell.fromairportlbl.text = "\(data.origin?.airport_name ?? "")"
            
            
            cell.tocitylbl.text = "\(data.destination?.city ?? "") (\(data.destination?.loc ?? ""))"
            cell.tocitylbl.numberOfLines = 0
            cell.todatelbl.text = "\(data.destination?.date ?? "") \(data.destination?.time ?? "")"
            cell.toairportlbl.text = "\(data.destination?.airport_name ?? "")"
            
            
            if let operatorImageURL = data.operator_image {
                cell.operatorimg.sd_setImage(with: URL(string: operatorImageURL), placeholderImage: UIImage(named: "placeholder.png"))
            }
            
            if let journeyType = UserDefaults.standard.string(forKey: UserDefaultsKeys.journeyType) {
                if journeyType == "oneway" {
                    if indexPath.row == 0 {
                        cell.depimg.image = UIImage(named: "depflight")
                    }
                } else {
                    if indexPath.row == 0 {
                        if depFind == indexPath.row {
                            cell.depimg.image = UIImage(named: "depflight")?.withRenderingMode(.alwaysOriginal).withTintColor(HexColor("#279EFF"))
                        } else {
                            cell.depimg.image = UIImage(named: "retflight")?.withRenderingMode(.alwaysOriginal).withTintColor(HexColor("#44B50C"))
                        }
                    }
                }
            }
            
            if tableView.isLast(for: indexPath) {
                cell.timeView.isHidden = true
                cell.depimg.isHidden = true
                cell.imgwidth.constant = 0
                cell.imgleft.constant = 0
                cell.totalJourneyTimelbl.isHidden = true
            }
            
            var totalDuration: TimeInterval = 0
            var totalLayoverTime: TimeInterval = 0
            
            for i in 0..<fdetais.count {
                let flight = fdetais[i]
                if let duration = flight.duration {
                    totalDuration += parseFlightDuration(duration)
                }
                
                if i < fdetais.count - 1 {
                    let currentFlight = fdetais[i]
                    let nextFlight = fdetais[i + 1]
                    if let layoverTime = addAllDurationandLayoverTime(startDateString: currentFlight.destination?.datetime ?? "", endDateString: nextFlight.origin?.datetime ?? "") {
                        totalLayoverTime += layoverTime
                    }
                }
            }
            
            let totalJourneyTime = totalDuration + totalLayoverTime
            cell.totalJourneyTimelbl.text = "Total Journey Time: \(formatDuration(totalJourneyTime))"
            
            if fdetais.count <= 1 {
                cell.hourslbl.text = "\(data.duration ?? "")"
            } else {
                cell.hourslbl.text = "\(data.duration ?? "")"
                
                if indexPath.row < fdetais.count - 1 {
                    let currentFlight = fdetais[indexPath.row]
                    let nextFlight = fdetais[indexPath.row + 1]
                    
                    if let layoverTime = calculateLayoverTime(startDateString: currentFlight.destination?.datetime ?? "", endDateString: nextFlight.origin?.datetime ?? "") {
                        cell.timelbl.text = "Layover Duration \(nextFlight.origin?.city ?? "") (\(nextFlight.origin?.loc ?? "")) \(layoverTime)"
                    } else {
                        print("Could not calculate layover time")
                        cell.timelbl.text = "Layover Duration: N/A"
                    }
                } else {
                    cell.timelbl.text = ""
                }
            }
            
            
            if data.destination?.terminal?.isEmpty == true || data.destination?.terminal == "" {
                cell.toterminallbl.text = "Terminal: TBC"
            }else {
                cell.toterminallbl.text = "Terminal: \(data.destination?.terminal ?? "")"
            }
            
            if data.origin?.terminal?.isEmpty == true || data.destination?.terminal == "" {
                cell.fromterminallbl.text = "Terminal: TBC"
            }else {
                cell.fromterminallbl.text = "Terminal: \(data.origin?.terminal ?? "")"
            }
            
            
            if indexPath.row == 0 {
                cell.totalJourneyTimelbl.isHidden = false
            }else {
                cell.totalJourneyTimelbl.isHidden = true
            }
            
            
            
            c = cell
        }
        
        return c
    }
    
    
    
    
    func calculateLayoverTime(startDateString: String, endDateString: String) -> String? {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        guard let startDate = dateFormatter.date(from: startDateString),
              let endDate = dateFormatter.date(from: endDateString) else {
            print("Invalid date format")
            return nil
        }
        
        let layoverInterval = endDate.timeIntervalSince(startDate)
        let layoverHours = Int(layoverInterval) / 3600
        let layoverMinutes = (Int(layoverInterval) % 3600) / 60
        
        return String(format: "%02dh %02dm", layoverHours, layoverMinutes)
    }
    
    
    
    
    func formatDuration(_ totalSeconds: TimeInterval) -> String {
        let hours = Int(totalSeconds) / 3600
        let minutes = (Int(totalSeconds) % 3600) / 60
        return String(format: "%02dh %02dm", hours, minutes)
    }
    
    
    func parseFlightDuration(_ duration: String) -> TimeInterval {
        let components = duration.split(separator: " ")
        var totalSeconds: TimeInterval = 0
        
        for component in components {
            if component.hasSuffix("h") {
                if let hours = Double(component.dropLast()) {
                    totalSeconds += hours * 3600
                }
            } else if component.hasSuffix("m") {
                if let minutes = Double(component.dropLast()) {
                    totalSeconds += minutes * 60
                }
            }
        }
        return totalSeconds
    }
    
    
    
    
    func addAllDurationandLayoverTime(startDateString: String, endDateString: String) -> TimeInterval? {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        guard let startDate = dateFormatter.date(from: startDateString),
              let endDate = dateFormatter.date(from: endDateString) else {
            print("Invalid date format")
            return nil
        }
        
        return endDate.timeIntervalSince(startDate)
    }
    
    
}
