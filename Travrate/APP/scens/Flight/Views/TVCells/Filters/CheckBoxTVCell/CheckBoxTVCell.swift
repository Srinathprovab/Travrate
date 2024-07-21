//
//  CheckBoxTVCell.swift
//  BabSafar
//
//  Created by MA673 on 26/07/22.
//

import UIKit




protocol CheckBoxTVCellDelegate {
    func didTapOnCheckBoxDropDownBtn(cell:CheckBoxTVCell)
    func didTapOnShowMoreBtn(cell:CheckBoxTVCell)
    
    func didTapOnCheckBox(cell:checkOptionsTVCell)
    func didTapOnDeselectCheckBox(cell:checkOptionsTVCell)
}

class CheckBoxTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var checkOptionsTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    @IBOutlet weak var downImg: UIImageView!
    @IBOutlet weak var downBtn: UIButton!
    // @IBOutlet weak var showMoreBtn: UIButton!
    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var btnViewHeight: NSLayoutConstraint!
    @IBOutlet weak var btnlbl: UILabel!
    @IBOutlet weak var showMoreBtn: UIButton!
    
    
    var timeArray = ["time1","time2","time3","time4"]
    var b = true
    var nameArray = [String]()
    var tvheight = CGFloat()
    var selectedIndices = [IndexPath]()
    var showbool = true
    var delegate:CheckBoxTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        setupTV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
        if selected == true {
            expand()
        }else {
            hide()
        }
    }
    
    override func prepareForReuse() {
        expand()
    }
    
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title
        nameArray = cellInfo?.data as? [String] ?? []
        //  showMoreBtn.isHidden = true
        
        tvHeight.constant = CGFloat(nameArray.count * 50)
        
        switch titlelbl.text {
            
            
        case "multicity":
            titlelbl.text = ""
            tvHeight.constant = CGFloat(nameArray.count * 50)
            break
        default:
            break
        }
        
        
        
        expand()
        checkOptionsTV.reloadData()
    }
    
    func setupUI() {
        
        //     showMoreBtn.setTitle("", for: .normal)
        btnView.isHidden = true
        //        btnViewHeight.constant = 0
        //        tvHeight.constant = 0
        //    downImg.image = UIImage(named: "down")
        holderView.backgroundColor = .WhiteColor
        titlelbl.textColor = .AppLabelColor
        titlelbl.font = UIFont.OpenSansMedium(size: 16)
        titlelbl.numberOfLines = 0
        
        btnlbl.text = "+ Show More"
        btnlbl.textColor = .AppTabSelectColor
        btnlbl.font = UIFont.LatoRegular(size: 18)
        btnlbl.isHidden = true
        
        downBtn.setTitle("", for: .normal)
        downBtn.addTarget(self, action: #selector(didTapOnCheckBoxDropDownBtn(_:)), for: .touchUpInside)
        downBtn.isHidden = true
    }
    
    func setupTV() {
        checkOptionsTV.register(UINib(nibName: "checkOptionsTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        checkOptionsTV.delegate = self
        checkOptionsTV.dataSource = self
        checkOptionsTV.separatorStyle = .none
        checkOptionsTV.tableFooterView = UIView()
        checkOptionsTV.isScrollEnabled = false
        checkOptionsTV.allowsMultipleSelection = true
    }
    
    
    @objc func didTapOnCheckBoxDropDownBtn(_ sender: UIButton){
        delegate?.didTapOnCheckBoxDropDownBtn(cell: self)
    }
    
    
    func hide() {
        downImg.image = UIImage(named: "downarrow")
        tvHeight.constant = 0
        btnView.isHidden = true
        btnViewHeight.constant = 0
    }
    
    func expand() {
        downImg.image = UIImage(named: "dropup")
        tvHeight.constant = CGFloat(nameArray.count * 50)
        if nameArray.count > 3 {
            btnView.isHidden = false
            btnViewHeight.constant = 30
        }else {
            btnView.isHidden = true
            btnViewHeight.constant = 0
        }
    }
    
    @IBAction func didTapOnShowMoreBtn(_ sender: Any) {
        delegate?.didTapOnShowMoreBtn(cell: self)
    }
    
    
}



extension CheckBoxTVCell: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! checkOptionsTVCell
        cell.selectionStyle = .none
        cell.titlelbl.text = nameArray[indexPath.row]
        cell.filtertitle = self.titlelbl.text ?? ""
        
        // Check if this indexPath is in the selectedIndices array
        if selectedIndices.contains(indexPath) {
            cell.checkImg.image = UIImage(named: "check")?.withRenderingMode(.alwaysOriginal)
        } else {
            cell.checkImg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal)
        }
        
        // Explicitly set the cell's appearance here
        cell.setSelected(selectedIndices.contains(indexPath), animated: false)
        
        if let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect) {
            if tabselect == "Flight" {
                showSelectedFlightsFilterValues(cell: cell, indexPath: indexPath)
            } else if tabselect == "Sports" {
                showSelectedSportFilterValues(cell: cell, indexPath: indexPath)
            }else if tabselect == "CarRental" {
                showSelectedCarrentalFilterValues(cell: cell, indexPath: indexPath)
            }else if tabselect == "transfers" {
                showSelectedTransfersFilterValues(cell: cell, indexPath: indexPath)
            }else if tabselect == "Activities" {
                showSelectedActivitiesFilterValues(cell: cell, indexPath: indexPath)
            } else  {
                showSelectedHotelFilterValues(cell: cell, indexPath: indexPath)
            }
        }
        
        
        if cellInfo?.key == "time" {
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? checkOptionsTVCell {
            if !selectedIndices.contains(indexPath) {
                selectedIndices.append(indexPath)
                cell.checkImg.image = UIImage(named: "check")?.withRenderingMode(.alwaysOriginal)
            }
            delegate?.didTapOnCheckBox(cell: cell)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? checkOptionsTVCell {
            if let index = selectedIndices.firstIndex(of: indexPath) {
                selectedIndices.remove(at: index)
                cell.checkImg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal)
            }
            delegate?.didTapOnDeselectCheckBox(cell: cell)
        }
    }
}


extension CheckBoxTVCell {
    
    //MARK: - showSelectedFlightsFilterValues checkOptionsTVCell
    
    func showSelectedFlightsFilterValues(cell:checkOptionsTVCell,indexPath:IndexPath) {
        
        
        
        // Check the section title to determine which filter to apply
        switch titlelbl.text {
            
            
        case "Departurn Time":
            if !filterModel.departureTime.isEmpty {
                // Check if the cell's title matches any value in the luggage array
                
                
                if filterModel.departureTime.contains(cell.titlelbl.text ?? "") {
                    
                    DispatchQueue.main.async {
                        cell.checkImg.image = UIImage(named: "check")?.withRenderingMode(.alwaysOriginal)
                        self.selectedIndices.append(indexPath)
                        self.checkOptionsTV.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                    }
                    print("Selected: \(cell.titlelbl.text ?? "")")
                } else {
                    
                    DispatchQueue.main.async {
                        cell.checkImg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal)
                    }
                    print("Deselected: \(cell.titlelbl.text ?? "")")
                }
            }else {
                DispatchQueue.main.async {
                    cell.unselected() // Deselect the cell
                }
            }
            
            
            
        case "Arrival Time":
            if !filterModel.arrivalTime.isEmpty {
                // Check if the cell's title matches any value in the luggage array
                
                
                if filterModel.arrivalTime.contains(cell.titlelbl.text ?? "") {
                    
                    DispatchQueue.main.async {
                        cell.checkImg.image = UIImage(named: "check")?.withRenderingMode(.alwaysOriginal)
                        self.selectedIndices.append(indexPath)
                        self.checkOptionsTV.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                    }
                    print("Selected: \(cell.titlelbl.text ?? "")")
                } else {
                    
                    DispatchQueue.main.async {
                        cell.checkImg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal)
                    }
                    print("Deselected: \(cell.titlelbl.text ?? "")")
                }
            }else {
                DispatchQueue.main.async {
                    cell.unselected() // Deselect the cell
                }
            }
            
            
            
            
        case "No Overnight Flight":
            
            
            if !filterModel.noOvernightFlight.isEmpty {
                // Check if the cell's title matches any value in the luggage array
                if filterModel.noOvernightFlight.contains(cell.titlelbl.text ?? "") {
                    
                    DispatchQueue.main.async {
                        cell.sele()
                        self.selectedIndices.append(indexPath)
                        self.checkOptionsTV.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                        
                    }
                    print("Selected: \(cell.titlelbl.text ?? "")")
                } else {
                    
                    DispatchQueue.main.async {
                        cell.unselected() // Deselect the cell
                        self.selectedIndices.append(indexPath)
                    }
                    print("Deselected: \(cell.titlelbl.text ?? "")")
                }
            }else {
                DispatchQueue.main.async {
                    cell.unselected() // Deselect the cell
                }
            }
            
            
        case "Luggage":
            if !filterModel.luggage.isEmpty {
                // Check if the cell's title matches any value in the luggage array
                if filterModel.luggage.contains(cell.titlelbl.text ?? "") {
                    
                    DispatchQueue.main.async {
                        cell.sele()
                        self.selectedIndices.append(indexPath)
                        self.checkOptionsTV.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                    }
                    print("Selected: \(cell.titlelbl.text ?? "")")
                } else {
                    
                    DispatchQueue.main.async {
                        cell.unselected() // Deselect the cell
                        self.selectedIndices.append(indexPath)
                    }
                    print("Deselected: \(cell.titlelbl.text ?? "")")
                }
            }else {
                DispatchQueue.main.async {
                    cell.unselected() // Deselect the cell
                }
            }
            
            
            
            
        case "Refundable Type":
            if !filterModel.refundableTypes.isEmpty {
                // Check if the cell's title matches any value in the luggage array
                
                
                if filterModel.refundableTypes.contains(cell.titlelbl.text ?? "") {
                    
                    DispatchQueue.main.async {
                        cell.sele()
                        self.selectedIndices.append(indexPath)
                        self.checkOptionsTV.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                    }
                    print("Selected: \(cell.titlelbl.text ?? "")")
                } else {
                    
                    DispatchQueue.main.async {
                        cell.unselected() // Deselect the cell
                    }
                    print("Deselected: \(cell.titlelbl.text ?? "")")
                }
            }else {
                DispatchQueue.main.async {
                    cell.unselected() // Deselect the cell
                }
            }
            
            
        case "No. Of Stops":
            
            if !filterModel.noOfStops.isEmpty {
                // Check if the cell's title matches any value in the luggage array
                if let labelText = cell.titlelbl.text {
                    let words = labelText.components(separatedBy: " ")
                    
                    // Check if any word in words exists in filterModel.noOfStops
                    if words.contains(where: { stop in
                        return filterModel.noOfStops.contains(stop)
                    }) {
                        DispatchQueue.main.async {
                            cell.sele()
                            self.selectedIndices.append(indexPath)
                            self.checkOptionsTV.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                        }
                        print("Selected: \(cell.titlelbl.text ?? "")")
                    } else {
                        DispatchQueue.main.async {
                            cell.unselected() // Deselect the cell
                        }
                        print("Deselected: \(cell.titlelbl.text ?? "")")
                    }
                }
            } else {
                DispatchQueue.main.async {
                    cell.unselected() // Deselect the cell
                }
            }
            
            
            
        case "Airlines":
            if !filterModel.airlines.isEmpty {
                // Check if the cell's title matches any value in the luggage array
                if filterModel.airlines.contains(cell.titlelbl.text ?? "") {
                    
                    DispatchQueue.main.async {
                        cell.sele()
                        self.selectedIndices.append(indexPath)
                        self.checkOptionsTV.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                    }
                    print("Selected: \(cell.titlelbl.text ?? "")")
                } else {
                    
                    DispatchQueue.main.async {
                        cell.unselected() // Deselect the cell
                    }
                    print("Deselected: \(cell.titlelbl.text ?? "")")
                }
            }else {
                DispatchQueue.main.async {
                    cell.unselected() // Deselect the cell
                }
            }
            
            
        case "Connecting Flights":
            if !filterModel.connectingFlights.isEmpty {
                // Check if the cell's title matches any value in the luggage array
                if filterModel.connectingFlights.contains(cell.titlelbl.text ?? "") {
                    
                    DispatchQueue.main.async {
                        cell.sele()
                        self.selectedIndices.append(indexPath)
                        self.checkOptionsTV.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                    }
                    print("Selected: \(cell.titlelbl.text ?? "")")
                } else {
                    
                    DispatchQueue.main.async {
                        cell.unselected() // Deselect the cell
                    }
                    print("Deselected: \(cell.titlelbl.text ?? "")")
                }
            }else {
                DispatchQueue.main.async {
                    cell.unselected() // Deselect the cell
                }
            }
            
            
        case "Connecting Airports":
            if !filterModel.connectingAirports.isEmpty {
                // Check if the cell's title matches any value in the luggage array
                if filterModel.connectingAirports.contains(cell.titlelbl.text ?? "") {
                    
                    DispatchQueue.main.async {
                        cell.sele()
                        self.selectedIndices.append(indexPath)
                        self.checkOptionsTV.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                    }
                    print("Selected: \(cell.titlelbl.text ?? "")")
                } else {
                    
                    DispatchQueue.main.async {
                        cell.unselected() // Deselect the cell
                    }
                    print("Deselected: \(cell.titlelbl.text ?? "")")
                }
            }else {
                DispatchQueue.main.async {
                    cell.unselected() // Deselect the cell
                }
            }
        default:
            break
        }
    }
    
    
    
    
    
    //MARK: - showSelectedHotelFilterValues checkOptionsTVCell
    
    func showSelectedHotelFilterValues(cell:checkOptionsTVCell,indexPath:IndexPath) {
        
        
        
        // Check the section title to determine which filter to apply
        switch titlelbl.text {
            
        case "Booking Type":
            if !hotelfiltermodel.refundableTypes.isEmpty {
                // Check if the cell's title matches any value in the luggage array
                
                
                if hotelfiltermodel.refundableTypes.contains(cell.titlelbl.text ?? "") {
                    
                    DispatchQueue.main.async {
                        cell.sele()
                        self.selectedIndices.append(indexPath)
                        self.checkOptionsTV.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                    }
                    print("Selected: \(cell.titlelbl.text ?? "")")
                } else {
                    
                    DispatchQueue.main.async {
                        cell.unselected() // Deselect the cell
                    }
                    print("Deselected: \(cell.titlelbl.text ?? "")")
                }
            }else {
                DispatchQueue.main.async {
                    cell.unselected() // Deselect the cell
                }
            }
            
            
            
        case "Neighbourhood":
            if !hotelfiltermodel.niberhoodA.isEmpty {
                // Check if the cell's title matches any value in the luggage array
                
                
                if hotelfiltermodel.niberhoodA.contains(cell.titlelbl.text ?? "") {
                    
                    DispatchQueue.main.async {
                        cell.sele()
                        self.selectedIndices.append(indexPath)
                        self.checkOptionsTV.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                    }
                    print("Selected: \(cell.titlelbl.text ?? "")")
                } else {
                    
                    DispatchQueue.main.async {
                        cell.unselected() // Deselect the cell
                    }
                    print("Deselected: \(cell.titlelbl.text ?? "")")
                }
            }else {
                DispatchQueue.main.async {
                    cell.unselected() // Deselect the cell
                }
            }
            
            
            
        case "Near By Location's":
            if !hotelfiltermodel.nearByLocA.isEmpty {
                // Check if the cell's title matches any value in the luggage array
                
                
                if hotelfiltermodel.nearByLocA.contains(cell.titlelbl.text ?? "") {
                    
                    DispatchQueue.main.async {
                        cell.sele()
                        self.selectedIndices.append(indexPath)
                        self.checkOptionsTV.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                    }
                    print("Selected: \(cell.titlelbl.text ?? "")")
                } else {
                    
                    DispatchQueue.main.async {
                        cell.unselected() // Deselect the cell
                    }
                    print("Deselected: \(cell.titlelbl.text ?? "")")
                }
            }else {
                DispatchQueue.main.async {
                    cell.unselected() // Deselect the cell
                }
            }
            
            
            
        case "Amenities":
            if !hotelfiltermodel.aminitiesA.isEmpty {
                // Check if the cell's title matches any value in the luggage array
                
                
                if hotelfiltermodel.aminitiesA.contains(cell.titlelbl.text ?? "") {
                    
                    DispatchQueue.main.async {
                        cell.sele()
                        self.selectedIndices.append(indexPath)
                        self.checkOptionsTV.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                    }
                    print("Selected: \(cell.titlelbl.text ?? "")")
                } else {
                    
                    DispatchQueue.main.async {
                        cell.unselected() // Deselect the cell
                    }
                    print("Deselected: \(cell.titlelbl.text ?? "")")
                }
            }else {
                DispatchQueue.main.async {
                    cell.unselected() // Deselect the cell
                }
            }
            
            
            
        default:
            break
        }
    }
    
    
    
    
    
    //MARK: - showSelectedSportFilterValues checkOptionsTVCell
    
    func showSelectedSportFilterValues(cell:checkOptionsTVCell,indexPath:IndexPath) {
        
        
        //
        // Check the section title to determine which filter to apply
        switch titlelbl.text {
            
        case "Tournament":
            if !sportsfilterModel.TournamentA.isEmpty {
                // Check if the cell's title matches any value in the luggage array
                
                
                if sportsfilterModel.TournamentA.contains(cell.titlelbl.text ?? "") {
                    
                    DispatchQueue.main.async {
                        cell.sele()
                        self.selectedIndices.append(indexPath)
                        self.checkOptionsTV.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                    }
                    print("Selected: \(cell.titlelbl.text ?? "")")
                } else {
                    
                    DispatchQueue.main.async {
                        cell.unselected() // Deselect the cell
                    }
                    print("Deselected: \(cell.titlelbl.text ?? "")")
                }
            }else {
                DispatchQueue.main.async {
                    cell.unselected() // Deselect the cell
                }
            }
            
            
            
        case "Events":
            if !sportsfilterModel.EventsA.isEmpty {
                // Check if the cell's title matches any value in the luggage array
                
                
                if sportsfilterModel.EventsA.contains(cell.titlelbl.text ?? "") {
                    
                    DispatchQueue.main.async {
                        cell.sele()
                        self.selectedIndices.append(indexPath)
                        self.checkOptionsTV.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                    }
                    print("Selected: \(cell.titlelbl.text ?? "")")
                } else {
                    
                    DispatchQueue.main.async {
                        cell.unselected() // Deselect the cell
                    }
                    print("Deselected: \(cell.titlelbl.text ?? "")")
                }
            }else {
                DispatchQueue.main.async {
                    cell.unselected() // Deselect the cell
                }
            }
            
            
        case "City":
            if !sportsfilterModel.SportsCityA.isEmpty {
                // Check if the cell's title matches any value in the luggage array
                
                
                if sportsfilterModel.SportsCityA.contains(cell.titlelbl.text ?? "") {
                    
                    DispatchQueue.main.async {
                        cell.sele()
                        self.selectedIndices.append(indexPath)
                        self.checkOptionsTV.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                    }
                    print("Selected: \(cell.titlelbl.text ?? "")")
                } else {
                    
                    DispatchQueue.main.async {
                        cell.unselected() // Deselect the cell
                    }
                    print("Deselected: \(cell.titlelbl.text ?? "")")
                }
            }else {
                DispatchQueue.main.async {
                    cell.unselected() // Deselect the cell
                }
            }
            
            
        case "Country":
            if !sportsfilterModel.SportsCountryA.isEmpty {
                // Check if the cell's title matches any value in the luggage array
                
                
                if sportsfilterModel.SportsCountryA.contains(cell.titlelbl.text ?? "") {
                    
                    DispatchQueue.main.async {
                        cell.sele()
                        self.selectedIndices.append(indexPath)
                        self.checkOptionsTV.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                    }
                    print("Selected: \(cell.titlelbl.text ?? "")")
                } else {
                    
                    DispatchQueue.main.async {
                        cell.unselected() // Deselect the cell
                    }
                    print("Deselected: \(cell.titlelbl.text ?? "")")
                }
            }else {
                DispatchQueue.main.async {
                    cell.unselected() // Deselect the cell
                }
            }
            
            
            
        default:
            break
        }
    }
    
}




//MARK: - CAR RENTAL

extension CheckBoxTVCell {
    
    
    
    
    func showSelectedCarrentalFilterValues(cell:checkOptionsTVCell,indexPath:IndexPath) {
        
        
        //
        // Check the section title to determine which filter to apply
        switch titlelbl.text {
            
        case "Care Fule":
            if !carfilterModel.fuleA.isEmpty {
                // Check if the cell's title matches any value in the luggage array
                
                
                if carfilterModel.fuleA.contains(cell.titlelbl.text ?? "") {
                    
                    DispatchQueue.main.async {
                        cell.sele()
                        self.selectedIndices.append(indexPath)
                        self.checkOptionsTV.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                    }
                    print("Selected: \(cell.titlelbl.text ?? "")")
                } else {
                    
                    DispatchQueue.main.async {
                        cell.unselected() // Deselect the cell
                    }
                    print("Deselected: \(cell.titlelbl.text ?? "")")
                }
            }else {
                DispatchQueue.main.async {
                    cell.unselected() // Deselect the cell
                }
            }
            
            
            
        case "Menual/Auto":
            if !carfilterModel.carmanualA.isEmpty {
                // Check if the cell's title matches any value in the luggage array
                
                
                if carfilterModel.carmanualA.contains(cell.titlelbl.text ?? "") {
                    
                    DispatchQueue.main.async {
                        cell.sele()
                        self.selectedIndices.append(indexPath)
                        self.checkOptionsTV.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                    }
                    print("Selected: \(cell.titlelbl.text ?? "")")
                } else {
                    
                    DispatchQueue.main.async {
                        cell.unselected() // Deselect the cell
                    }
                    print("Deselected: \(cell.titlelbl.text ?? "")")
                }
            }else {
                DispatchQueue.main.async {
                    cell.unselected() // Deselect the cell
                }
            }
            
            
        case "Door Count":
            if !carfilterModel.doorcountA.isEmpty {
                // Check if the cell's title matches any value in the luggage array
                
                
                if carfilterModel.doorcountA.contains(cell.titlelbl.text ?? "") {
                    
                    DispatchQueue.main.async {
                        cell.sele()
                        self.selectedIndices.append(indexPath)
                        self.checkOptionsTV.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                    }
                    print("Selected: \(cell.titlelbl.text ?? "")")
                } else {
                    
                    DispatchQueue.main.async {
                        cell.unselected() // Deselect the cell
                    }
                    print("Deselected: \(cell.titlelbl.text ?? "")")
                }
            }else {
                DispatchQueue.main.async {
                    cell.unselected() // Deselect the cell
                }
            }
            
            
        default:
            break
        }
    }
    
    
    
    func showSelectedTransfersFilterValues(cell:checkOptionsTVCell,indexPath:IndexPath) {
        
        
        //
        // Check the section title to determine which filter to apply
        switch titlelbl.text {
            
        case "Car Type":
            if !transferfilterModel.carTypeA.isEmpty {
                // Check if the cell's title matches any value in the luggage array
                
                
                if transferfilterModel.carTypeA.contains(cell.titlelbl.text ?? "") {
                    
                    DispatchQueue.main.async {
                        cell.sele()
                        self.selectedIndices.append(indexPath)
                        self.checkOptionsTV.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                    }
                    print("Selected: \(cell.titlelbl.text ?? "")")
                } else {
                    
                    DispatchQueue.main.async {
                        cell.unselected() // Deselect the cell
                    }
                    print("Deselected: \(cell.titlelbl.text ?? "")")
                }
            }else {
                DispatchQueue.main.async {
                    cell.unselected() // Deselect the cell
                }
            }
            
            
            
            
        default:
            break
        }
    }
    
    
    
    
    func showSelectedActivitiesFilterValues(cell:checkOptionsTVCell,indexPath:IndexPath) {
        
        
        //
        // Check the section title to determine which filter to apply
        switch titlelbl.text {
            
            
        case "Duration Type":
            if !activitiesfiltermodel.durationTypeA.isEmpty {
                // Check if the cell's title matches any value in the luggage array
                
                
                if activitiesfiltermodel.durationTypeA.contains(cell.titlelbl.text ?? "") {
                    
                    DispatchQueue.main.async {
                        cell.sele()
                        self.selectedIndices.append(indexPath)
                        self.checkOptionsTV.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                    }
                    print("Selected: \(cell.titlelbl.text ?? "")")
                } else {
                    
                    DispatchQueue.main.async {
                        cell.unselected() // Deselect the cell
                    }
                    print("Deselected: \(cell.titlelbl.text ?? "")")
                }
            }else {
                DispatchQueue.main.async {
                    cell.unselected() // Deselect the cell
                }
            }
            
            
        case "Activities Type":
            if !activitiesfiltermodel.activitiesTypeA.isEmpty {
                // Check if the cell's title matches any value in the luggage array
                
                
                if activitiesfiltermodel.activitiesTypeA.contains(cell.titlelbl.text ?? "") {
                    
                    DispatchQueue.main.async {
                        cell.sele()
                        self.selectedIndices.append(indexPath)
                        self.checkOptionsTV.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                    }
                    print("Selected: \(cell.titlelbl.text ?? "")")
                } else {
                    
                    DispatchQueue.main.async {
                        cell.unselected() // Deselect the cell
                    }
                    print("Deselected: \(cell.titlelbl.text ?? "")")
                }
            }else {
                DispatchQueue.main.async {
                    cell.unselected() // Deselect the cell
                }
            }
            
            
            
            
        default:
            break
        }
    }
}
