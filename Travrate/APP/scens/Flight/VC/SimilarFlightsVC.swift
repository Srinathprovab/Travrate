//
//  SimilarFlightsVC.swift
//  TravgateApp
//
//  Created by FCI on 05/01/24.
//

import UIKit

class SimilarFlightsVC: BaseTableVC {
    
    @IBOutlet weak var titlelbl: UILabel!
    
    
    static var newInstance: SimilarFlightsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Flight.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SimilarFlightsVC
        return vc
    }
    
    
    var privousjourneyType = String()
    var arrayIndex = 0
    var isFirstCell = true // Flag to check if it's the first cell
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setuplabels(lbl: titlelbl, text: "", textcolor: .BackBtnColor, font: .InterBold(size: 14), align: .center)

        commonTableView.registerTVCells(["FlightResultTVCell",
                                         "EmptyTVCell"])
        
        setupTVCell()
        
    }
    
    
    
    
    override func didTapOnFlightDetails(cell: FlightResultTVCell) {
        
        MySingleton.shared.callboolapi = true
        MySingleton.shared.selectedResult = cell.selectedResult
        MySingleton.shared.farerulesrefKey = cell.farerulesrefKey
        MySingleton.shared.farerulesrefContent = cell.farerulesrefContent
        MySingleton.shared.bookingsourceforpromocode = cell.bookingsource
        
        if cell.bookNowlbl.text != "Select Fare" {
            
            guard let vc = FlightDeatilsVC.newInstance.self else {return}
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false)
            
        }else {
            showToast(message: "Still Under Development")
        }
        
    }
    
    
    
    override func didTapOnBookNowBtnAction(cell: FlightResultTVCell) {
        
        MySingleton.shared.callboolapi = true
        MySingleton.shared.selectedResult = cell.selectedResult
        MySingleton.shared.bookingsourceforpromocode = cell.bookingsource
        
        MySingleton.shared.bookingsource = cell.bookingsourcekey
        MySingleton.shared.bookingsourcekey = cell.bookingsourcekey
        
        guard let vc = BookingDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    
    
    
    
    @IBAction func didTapOnCloseBtnAction(_ sender: Any) {
        MySingleton.shared.callboolapi = false
        dismiss(animated: true)
    }
    
    
    //MARK: - didTapOnSelectFareBtnAction
    override func didTapOnSelectFareBtnAction(cell:FlightResultTVCell) {
        MySingleton.shared.callboolapi = true
        MySingleton.shared.selectedResult = cell.selectedResult
        MySingleton.shared.bookingsourceforpromocode = cell.bookingsource
        
        MySingleton.shared.farekey = cell.journeyKeystr
        MySingleton.shared.bookingsource = cell.bookingsource
        MySingleton.shared.bookingsourcekey = cell.bookingsourcekey
        
        // gotoSelectFareVC()
        showToast(message: "Still Under Development")
    }
    
    func gotoSelectFareVC() {
        MySingleton.shared.selectedFares.removeAll()
        guard let vc = SelectFareVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    //MARK: - didTapOnReturnDateBtnAction
    override func didTapOnReturnDateBtnAction(cell:FlightResultTVCell) {
        defaults.setValue("circle", forKey: UserDefaultsKeys.journeyType)
        gotoFlightSearchVC()
    }
    
    func gotoFlightSearchVC() {
        guard let vc = FlightSearchVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.isfromVC = "resultsReturn"
        present(vc, animated: true)
    }
    
    
    
    //MARK: - didTapOnShareBtnAction  FlightResultTVCell
    override func didTapOnShareBtnAction(cell:FlightResultTVCell) {
        MySingleton.shared.shareresultrandomid = cell.shareresultrandomid
        MySingleton.shared.shareresultaccesskey = cell.shareresultaccesskey
        MySingleton.shared.shareresultbookingsource = cell.shareresultbookingsource
        
        print(MySingleton.shared.shareresultrandomid)
        print(MySingleton.shared.shareresultaccesskey)
        print(MySingleton.shared.shareresultbookingsource)
        
        gotoShareResultVC()
    }
    
    
    func gotoShareResultVC() {
        guard let vc = ShareResultVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}


extension SimilarFlightsVC {
    
    
    
    
    func setupTVCell() {
        MySingleton.shared.tablerow.removeAll()
        
        titlelbl.text = "\(MySingleton.shared.similarflightList.count - 1) Flights Found"
        
        
        
        MySingleton.shared.similarflightList.forEach { array in
            array.enumerated().forEach { (itemIndex, j) in
                
                let uniqueID = generateUniqueID(for: arrayIndex, bookingSource: j.booking_source!, itemIndex: itemIndex)
                if isFirstCell {
                    isFirstCell = false // Set to false after first iteration
                } else {
                    MySingleton.shared.tablerow.append(TableRow(title: j.selectedResult,
                                                                subTitle: j.booking_source,
                                                                refundable:j.fareType,
                                                                key: "similar",
                                                                text: j.booking_source_key,
                                                                headerText: j.serialized_journeyKey,
                                                                moreData: j,
                                                                tempText: j.access_key,
                                                                tempInfo: j.farerulesref_Key,
                                                                cellType:.FlightResultTVCell,
                                                                userCatdetails:j.journeyKey,
                                                                data1: j.flight_details?.summary,
                                                                data2: j.farerulesref_content))
                }
            }
            
            arrayIndex += 1
        }
        
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    func generateUniqueID(for arrayIndex: Int, bookingSource: String, itemIndex: Int) -> String {
        // Prefix for ID: Array index starting from 1
        let prefix = "\(arrayIndex + 1)"
        
        // Booking source part
        let bookingSourcePart = bookingSource
        
        // Suffix for ID: Zero-padded item index starting from 1 within the array
        let suffix = String(format: "%08d", itemIndex + 1)
        
        // Combine all parts to form the unique ID
        return "\(prefix)\(bookingSourcePart)\((Int(prefix) ?? 0) - 1)"
    }
    
    
    
}
