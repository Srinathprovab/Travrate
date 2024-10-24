//
//  HotelDetailsVC.swift
//  BabSafar
//
//  Created by MA673 on 01/08/22.
//

import UIKit

class HotelDetailsVC: BaseTableVC, HotelDetailsViewModelDelegate, TimerManagerDelegate {
    
    @IBOutlet weak var holderView: UIView!
    // @IBOutlet weak var kwdlbl: UILabel!
    // @IBOutlet weak var bookNowView: UIView!
    @IBOutlet weak var bookNowlbl: UILabel!
    // @IBOutlet weak var bookNowBtn: UIButton!
    @IBOutlet weak var citylbl: UILabel!
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var paxlbl: UILabel!
    
    @IBOutlet weak var gifimg: UIImageView!
    @IBOutlet weak var continuetoPaymentBtnView: UIView!
    @IBOutlet weak var continuetoPaymentBtnlbl: UILabel!
    @IBOutlet weak var continueBtn: UIButton!
    
    
    static var newInstance: HotelDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? HotelDetailsVC
        return vc
    }
    
    
    
    var selectedCell: NewRoomDetailsTVCell?
    var tablerow = [TableRow]()
    var viewmodel:HotelDetailsViewModel?
    var payload = [String:Any]()
    var bookingsource = String()
    var hotelid = String()
    var searchid = String()
    var hotelDetails:Hotel_details?
    var kwdprice = String()
    var img = String()
    
    
    //MARK: - Loading function
    override func viewWillAppear(_ animated: Bool) {
        
        selectedCellStates = [:]
        addObserver()
        
        if callapibool == true{
            
            holderView.isHidden = true
            callAPI()
        }
        
    }
    
    
    //MARK: - show BookNow Btn
    @objc func showBookNowBtn() {
        //        bookNowView.isUserInteractionEnabled = true
        //        bookNowView.alpha = 1
    }
    
    
    //MARK: - Loading function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        viewmodel = HotelDetailsViewModel(self)
        MySingleton.shared.delegate = self
        
    }
    
    
    //MARK: - setupUI
    func setupUI() {
        
        guard let gifURL = Bundle.main.url(forResource: "pay", withExtension: "gif") else { return }
        guard let imageData = try? Data(contentsOf: gifURL) else { return }
        guard let image = UIImage.gifImageWithData(imageData) else { return }
        gifimg.image = image
        gifimg.isHidden = true
        
        continuetoPaymentBtnView.backgroundColor = .Buttoncolor
        continuetoPaymentBtnView.isUserInteractionEnabled = true
        
        setuplabels(lbl: citylbl, text: "", textcolor: .BackBtnColor, font: .InterBold(size: 14), align: .center)
        setuplabels(lbl: datelbl, text: "", textcolor: .BackBtnColor, font: .InterRegular(size: 14), align: .center)
        setuplabels(lbl: paxlbl, text: "", textcolor: .BackBtnColor, font: .InterRegular(size: 14), align: .center)
        
        holderView.backgroundColor = .WhiteColor
        self.citylbl.text = defaults.string(forKey: UserDefaultsKeys.locationcity) ?? ""
        self.datelbl.text = "\(MySingleton.shared.convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.checkin) ?? "", f1: "dd-MM-yyyy", f2: "MMM dd")) - \(MySingleton.shared.convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.checkout) ?? "", f1: "dd-MM-yyyy", f2: "MMM dd"))"
        
        let roomscount = defaults.integer(forKey: UserDefaultsKeys.roomcount)
        let adultcount = defaults.integer(forKey: UserDefaultsKeys.hoteladultscount)
        let childcount = defaults.integer(forKey: UserDefaultsKeys.hotelchildcount)
        
        
        let roomcount = roomscount > 1 ? "\(roomscount) Rooms" : "\(roomscount) Room"
        let adultsCoutntStr = adultcount > 1 ? "\(roomcount) | \(adultcount) Adults" : "\(roomcount) | \(adultcount) Adult"
        
        var labelText = adultsCoutntStr
        //  var labelText = adultcount > 1 ? "Room \(roomscount) | Adults \(adultcount)" : "Adult \(adultcount)"
        if childcount > 0 {
            let newchildcount = childcount > 1 ? "\(childcount) Children" : "\(childcount) Child"
            labelText += ", \(newchildcount)"
        }
        paxlbl.text = labelText
        
        
        //        bookNowView.backgroundColor = .AppBtnColor
        //        setuplabels(lbl: kwdlbl, text: "Book Now", textcolor: .WhiteColor, font: .LatoMedium(size: 18), align: .right)
        //        bookNowBtn.setTitle("", for: .normal)
        //        bookNowBtn.addTarget(self, action: #selector(didTapOnBookNowBtn(_:)), for: .touchUpInside)
        commonTableView.registerTVCells(["HotelImagesTVCell",
                                         "EmptyTVCell",
                                         "NewRoomTVCell",
                                         "AmenitiesTVCell",
                                         "TitleLabelTVCell",
                                         "NoDataFoundTVCell",
                                         "RoomsTVcell"])
        
    }
    
    
    
    @objc func didTapOnBackBtn(_ sender:UIButton) {
        callapibool = false
        dismiss(animated: true)
    }
    
    
    //MARK: - didTapOnBookNowBtn
    @objc func didTapOnBookNowBtn(_ sender: UIButton) {
        
        
        
    }
    
    
    func gotoHotelBookingDetailsVC(){
        MySingleton.shared.callboolapi = true
        guard let vc = HotelBookingDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        self.present(vc, animated: true)
    }
    
    
    //MARK: - didTapOnRoomsBtn
    override func didTapOnRoomsBtn(cell: RoomsTVcell) {
        //        hotelDetailsTapBool = true
        //        cell.key = "rooms"
        //        cell.roomDetailsTV.reloadData()
        
        setuptv()
    }
    
    
    //MARK: - didTapOnHotelsDetailsBtn
    override func didTapOnHotelsDetailsBtn(cell: RoomsTVcell) {
        //        cell.key = "hotels details"
        //        hotelDetailsTapBool = false
        //        cell.roomDetailsTV.reloadData()
        
        setuptv()
    }
    
    
    //MARK: - didTapOnAmenitiesBtn
    override func didTapOnAmenitiesBtn(cell: RoomsTVcell) {
        //        cell.key = "amenities"
        //        hotelDetailsTapBool = false
        //        cell.roomDetailsTV.reloadData()
        
        setuptv()
    }
    
    //MARK: - didTapOnCancellationPolicyBtnAction
    //    override func didTapOnCancellationPolicyBtnAction(cell:NewRoomDetailsTVCell){
    //        MySingleton.shared.cancellationRoomStringArray = cell.cancellatonStringArray
    //
    //
    //        guard let vc = CancellationPolicyPopupVC.newInstance.self else {return}
    //        vc.modalPresentationStyle = .overCurrentContext
    //        self.present(vc, animated: false)
    //
    //    }
    
    
    //MARK: - didTapOnSelectRoomBtnAction
    //    override func didTapOnSelectRoomBtnAction(cell:NewRoomDetailsTVCell){
    //        hotelDetailsTapBool = true
    //        continuetoPaymentBtnView.backgroundColor = .BooknowBtnColor
    //        gifimg.isHidden = false
    //
    //        MySingleton.shared.cancellationRoomStringArray = cell.cancellatonStringArray
    //
    //        bookNowlbl.isHidden = false
    //
    //        // Toggle the selected state
    //        cell.isSelectedCell.toggle()
    //
    //        // Update the button color
    //        cell.updateButtonColor()
    //
    //        // Check if a different cell was previously selected
    //        if let previouslySelectedCell = selectedCell {
    //            // Deselect the previously selected cell
    //            previouslySelectedCell.isSelectedCell = false
    //            previouslySelectedCell.updateButtonColor()
    //        }
    //
    //        // Select the tapped cell
    //        cell.isSelectedCell = true
    //        cell.updateButtonColor()
    //
    //        // Update the selectedCell reference
    //        selectedCell = cell
    //
    //        //        bookNowView.isUserInteractionEnabled = true
    //        //        bookNowView.alpha = 1
    //        grandTotal = cell.pricelbl.text ?? ""
    //        setuplabels(lbl: bookNowlbl, text: cell.pricelbl.text ?? "" , textcolor: .WhiteColor, font: .LatoMedium(size: 18), align: .left)
    //
    //
    //        selectedrRateKeyArray = cell.ratekey
    //
    //        MySingleton.shared.setAttributedTextnew(str1: "\(cell.currency )",
    //                                                str2: "\(cell.exactprice )",
    //                                                lbl: bookNowlbl,
    //                                                str1font: .LatoBold(size: 12),
    //                                                str2font: .LatoBold(size: 18),
    //                                                str1Color: .WhiteColor,
    //                                                str2Color: .WhiteColor)
    //
    //
    //        roomselected = cell.selectedRoom
    //        print("roomselected : \(roomselected)")
    //
    //
    //    }
    
    
    //MARK: - didTapOnBackBtnAction
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        callapibool = false
        dismiss(animated: true)
    }
    
    
    //MARK: - didTapOnMoreBtnAction HotelImagesTVCell
    override func didTapOnMoreBtnAction(cell: HotelImagesTVCell) {
        
        if imagesArray.count > 0 {
            guard let vc = HotelImagesVC.newInstance.self else {return}
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        
    }
    
    
    
    @IBAction func didTapOnReserveNowBtnAction(_ sender: Any) {
        if hotelDetailsTapBool == true {
            if selectedrRateKeyArray.isEmpty == false {
                gotoHotelBookingDetailsVC()
            }else {
                showToast(message: "Select Room")
            }
        }else {
            NotificationCenter.default.post(name: NSNotification.Name("gotoroom"), object: false)
        }
    }
    
    
    
    
    override func didTapOnCancellationPolicyBtnAction(cell: NewRoomDetailsTVCell) {
        MySingleton.shared.cancellationRoomStringArray = cell.cancellatonStringArray
        
        
        guard let vc = CancellationPolicyPopupVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    override func didTapOnSelectRoomBtnAction(cell: NewRoomDetailsTVCell) {
        
        
    
        //        if let indexPath = roomInfoTV.indexPath(for: cell) {
        //            // Toggle the selected state
        //            selectedCellStates[indexPath] = !selectedCellStates[indexPath, default: false]
        //
        //            // Update the button color
        //            cell.updateButtonColor()
        //
        //            // Deselect the previously selected cell, if any
        //            for (index, isSelected) in selectedCellStates {
        //                if index != indexPath && isSelected {
        //                    selectedCellStates[index] = false
        //                    if let previouslySelectedCell = cell.roomInfoTV.cellForRow(at: index) as? NewRoomDetailsTVCell {
        //                        previouslySelectedCell.updateButtonColor()
        //                    }
        //                }
        //            }
        //
        //
        //        }
        
        
        
        hotelDetailsTapBool = true
        continuetoPaymentBtnView.backgroundColor = .BooknowBtnColor
        gifimg.isHidden = false
        
        MySingleton.shared.cancellationRoomStringArray = cell.cancellatonStringArray
        
        bookNowlbl.isHidden = false
        
        // Toggle the selected state
        cell.isSelectedCell.toggle()
        
        // Update the button color
        cell.updateButtonColor()
        
        // Check if a different cell was previously selected
        if let previouslySelectedCell = selectedCell {
            // Deselect the previously selected cell
            previouslySelectedCell.isSelectedCell = false
            previouslySelectedCell.updateButtonColor()
        }
        
        // Select the tapped cell
        cell.isSelectedCell = true
        cell.updateButtonColor()
        
        // Update the selectedCell reference
        selectedCell = cell
        
        //        bookNowView.isUserInteractionEnabled = true
        //        bookNowView.alpha = 1
        grandTotal = cell.pricelbl.text ?? ""
        setuplabels(lbl: bookNowlbl, text: cell.pricelbl.text ?? "" , textcolor: .WhiteColor, font: .LatoMedium(size: 18), align: .left)
        
        
        selectedrRateKeyArray = cell.ratekey
        
        MySingleton.shared.setAttributedTextnew(str1: "\(cell.currency )",
                                                str2: "\(cell.exactprice )",
                                                lbl: bookNowlbl,
                                                str1font: .LatoBold(size: 12),
                                                str2font: .LatoBold(size: 18),
                                                str1Color: .WhiteColor,
                                                str2Color: .WhiteColor)
        
        
        roomselected = cell.selectedRoom
        print("roomselected : \(roomselected)")
        
        
        
    }
}



extension HotelDetailsVC {
    
    
    //MARK: - CALL HOTEL DETAILS API
    func callAPI() {
        
        
        
        MySingleton.shared.loderString = "fdetails"
        MySingleton.shared.afterResultsBool = true
        loderBool = true
        showLoadera()
        
        
        payload["booking_source"] = bookingsource
        payload["hotel_id"] = hotelid
        payload["search_id"] = hsearchid
        
        viewmodel?.CALL_HOTEL_DETAILS_API(dictParam: payload)
    }
    
    func hotelDetails(response: HotelSelectedDetailsModel) {
        
        selectedrRateKeyArray = ""
        loderBool = false
        hideLoadera()
        
        hotelroomtap = "room"
        holderView.isHidden = false
        hsearchid = response.params?.search_id ?? ""
        htoken = response.hotel_details?.token ?? ""
        htokenkey = response.hotel_details?.tokenKey ?? ""
        
        MySingleton.shared.hotelDetails = response.hotel_details
        hotelDetails = response.hotel_details
        roomsDetails = response.hotel_details?.rooms ?? [[]]
        imagesArray = response.hotel_details?.images ?? []
        formatAmeArray = response.hotel_details?.format_ame ?? []
        
        formatDesc = response.hotel_details?.format_desc ?? []
        img = response.hotel_details?.image ?? ""
        
        bookNowlbl.isHidden = true
        
        DispatchQueue.main.async {[self] in
            setuptv()
        }
    }
    
    
    
    func setuptv() {
        tablerow.removeAll()
        
        if roomsDetails.count > 0 {
            
            TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
            
            tablerow.append(TableRow(title:hotelDetails?.name ?? "",
                                     subTitle: "\(hotelDetails?.address ?? "")|\(hotelDetails?.city_name ?? "")",
                                     image:img,
                                     cellType:.HotelImagesTVCell))
            
            
            tablerow.append(TableRow(title:hotelDetails?.latitude ?? "",
                                     subTitle: hotelDetails?.longitude ?? "",
                                     text: hotelDetails?.token,
                                     buttonTitle: hotelDetails?.name ?? "",
                                     moreData:roomsDetails,
                                     tempText: hotelDetails?.tokenKey,
                                     cellType:.RoomsTVcell))
            
            
            if hotelroomtap == "room" {
                
//                roomsDetails.forEach { i in
//                    tablerow.append(TableRow(title:"",moreData:i,cellType:.NewRoomTVCell))
//                }
                
                for (index,value) in roomsDetails.enumerated() {
                    tablerow.append(TableRow(title:"Room\(index)",moreData:value,cellType:.NewRoomTVCell))
                }
                
                
            }else  if hotelroomtap == "details" {
                
                formatDesc.forEach { i in
                    tablerow.append(TableRow(title:i.heading,subTitle: i.content,key: "hoteldisc",cellType:.TitleLabelTVCell))
                }
                
                
            }else {
                if formatAmeArray.count > 0 {
                    formatAmeArray.forEach { i in
                        if i.ame != "" {
                            tablerow.append(TableRow(title:i.ame,cellType:.AmenitiesTVCell))
                        }
                    }
                }else {
                    tablerow.append(TableRow(height: 200,cellType:.NoDataFoundTVCell))
                }
            }
            
            
            
            tablerow.append(TableRow(height:80,cellType:.EmptyTVCell))
            
        }else {
            TableViewHelper.EmptyMessage(message: "No data found", tableview: commonTableView, vc: self)
        }
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
}

extension HotelDetailsVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(roomtapbool), name: Notification.Name("roomtapbool"), object: nil)
        
    }
    
    @objc func roomtapbool(notify:NSNotification) {
        //        if let tapbool = notify.object as? Bool {
        //            if tapbool == true {
        //                kwdlbl.text = "Book Now"
        //            }else {
        //                kwdlbl.text = "Select Now"
        //            }
        //        }
    }
    
    @objc func reload() {
        DispatchQueue.main.async {[self] in
            callAPI()
        }
    }
    
    //MARK: - resultnil
    @objc func resultnil() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = "noresult"
        self.present(vc, animated: true)
    }
    
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = "nointernet"
        self.present(vc, animated: true)
    }
    
    
    //MARK: - updateTimer
    func updateTimer() {
        let totalTime = MySingleton.shared.totalTime
        let minutes =  totalTime / 60
        let seconds = totalTime % 60
        let formattedTime = String(format: "%02d:%02d", minutes, seconds)
        
        
        //        MySingleton.shared.setAttributedTextnew(str1: "\(formattedTime)",
        //                                                str2: "",
        //                                                lbl: sessionTimelbl,
        //                                                str1font: .OpenSansMedium(size: 12),
        //                                                str2font: .OpenSansMedium(size: 12),
        //                                                str1Color: .BooknowBtnColor,
        //                                                str2Color: .BooknowBtnColor)
        
        
    }
    
    
    func timerDidFinish() {
        gotoPopupScreen()
    }
    
    
    func gotoPopupScreen() {
        guard let vc = PopupVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    
}
