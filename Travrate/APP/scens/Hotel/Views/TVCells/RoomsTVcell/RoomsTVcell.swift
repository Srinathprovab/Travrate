//
//  RoomsTVcell.swift
//  BabSafar
//
//  Created by MA673 on 01/08/22.
//

import UIKit
import CoreLocation
import GoogleMaps


protocol RoomsTVcellDelegate:AnyObject {
    func didTapOnRoomsBtn(cell:RoomsTVcell)
    func didTapOnHotelsDetailsBtn(cell:RoomsTVcell)
    func didTapOnAmenitiesBtn(cell:RoomsTVcell)
    func didTapOnCancellationPolicyBtnAction(cell:NewRoomDetailsTVCell)
    func didTapOnSelectRoomBtnAction(cell:NewRoomDetailsTVCell)
}

class RoomsTVcell: TableViewCell, NewRoomTVCellDelegate {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var roomsView: UIView!
    @IBOutlet weak var roomslbl: UILabel!
    @IBOutlet weak var roomsUL: UIView!
    @IBOutlet weak var roomsBtn: UIButton!
    
    @IBOutlet weak var hotelsDetailsView: UIView!
    @IBOutlet weak var hotelsDetailslbl: UILabel!
    @IBOutlet weak var hotelsDetailsUL: UIView!
    @IBOutlet weak var hotelsDetailsBtn: UIButton!
    
    @IBOutlet weak var amenitiesView: UIView!
    @IBOutlet weak var amenitieslbl: UILabel!
    @IBOutlet weak var amenitiesUL: UIView!
    @IBOutlet weak var amenitiesBtn: UIButton!
    //    @IBOutlet weak var roomDetailsTV: UITableView!
    //    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    //    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    
    
    var latString = ""
    var longString = ""
    var locname = ""
    
    var bookingsrc = String()
    var htoken = String()
    var htokenkey = String()
    
    let locationManager = CLLocationManager()
    var selectedCell: NewRoomDetailsTVCell?
    weak var delegate:RoomsTVcellDelegate?
    var key = "rooms"
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
        NotificationCenter.default.addObserver(self, selector: #selector(gotoroom), name: Notification.Name("gotoroom"), object: nil)
        
        latString = cellInfo?.title ?? ""
        longString = cellInfo?.subTitle ?? ""
        locname = cellInfo?.buttonTitle ?? ""
        
        
        // updateHeight(height: 200)
        
        
        
        
    }
    
    
    
    @objc func gotoroom(){
        roomtaped()
    }
    
    
    func setupUI() {
        
        setupViews(v: holderView, radius: 0, color: .WhiteColor)
        holderView.layer.borderColor = UIColor.WhiteColor.cgColor
        setupViews(v: roomsView, radius: 0, color: .WhiteColor)
        roomsView.layer.borderColor = UIColor.WhiteColor.cgColor
        
        
        
        setupViews(v: hotelsDetailsView, radius: 0, color: .WhiteColor)
        hotelsDetailsView.layer.borderColor = UIColor.WhiteColor.cgColor
        
        setupViews(v: amenitiesView, radius: 0, color: .WhiteColor)
        amenitiesView.layer.borderColor = UIColor.WhiteColor.cgColor
        
        roomsUL.backgroundColor = .AppTabSelectColor
        hotelsDetailsUL.backgroundColor = .WhiteColor
        amenitiesUL.backgroundColor = .WhiteColor
        
        setuplabels(lbl: roomslbl, text: "Rooms", textcolor: .AppTabSelectColor, font: .LatoBold(size: 14), align: .center)
        
        setuplabels(lbl: hotelsDetailslbl, text: "Hotels Details", textcolor: .AppLabelColor.withAlphaComponent(0.5), font: .LatoBold(size: 14), align: .center)
        setuplabels(lbl: amenitieslbl, text: "Amenities", textcolor: .AppLabelColor.withAlphaComponent(0.5), font: .LatoBold(size: 14), align: .center)
        
        roomsBtn.setTitle("", for: .normal)
        
        hotelsDetailsBtn.setTitle("", for: .normal)
        amenitiesBtn.setTitle("", for: .normal)
        
        
        // setuTV()
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
    }
    
    
    //    func setuTV() {
    //        roomDetailsTV.register(UINib(nibName: "NewRoomTVCell", bundle: nil), forCellReuseIdentifier: "rooms")
    //        roomDetailsTV.register(UINib(nibName: "TitleLabelTVCell", bundle: nil), forCellReuseIdentifier: "hdetails")
    //        roomDetailsTV.register(UINib(nibName: "AmenitiesTVCell", bundle: nil), forCellReuseIdentifier: "amenities")
    //
    //
    //        roomDetailsTV.isScrollEnabled = false
    //        roomDetailsTV.delegate = self
    //        roomDetailsTV.dataSource = self
    //        roomDetailsTV.tableFooterView = UIView()
    //        roomDetailsTV.separatorStyle = .none
    //        roomDetailsTV.showsHorizontalScrollIndicator = false
    //    }
    
    
    
    @IBAction func didTapOnRoomsBtn(_ sender: Any) {
        roomtaped()
    }
    
    func roomtaped() {
        hotelroomtap = "room"
        //    roomDetailsTV.isHidden = false
        roomslbl.textColor = .AppTabSelectColor
        roomsUL.backgroundColor = .AppTabSelectColor
        
        
        hotelsDetailslbl.textColor = .AppLabelColor.withAlphaComponent(0.5)
        hotelsDetailsUL.backgroundColor = .WhiteColor
        amenitieslbl.textColor = .AppLabelColor.withAlphaComponent(0.5)
        amenitiesUL.backgroundColor = .WhiteColor
        
        NotificationCenter.default.post(name: NSNotification.Name("roomtapbool"), object: true)
        
        //  updateHeight(height: 200)
        delegate?.didTapOnRoomsBtn(cell:self)
    }
    
    
    @IBAction func didTapOnHotelsDetailsBtn(_ sender: Any) {
        hotelroomtap = "details"
        //  roomDetailsTV.isHidden = false
        hotelsDetailslbl.textColor = .AppTabSelectColor
        hotelsDetailsUL.backgroundColor = .AppTabSelectColor
        roomslbl.textColor = .AppLabelColor.withAlphaComponent(0.5)
        roomsUL.backgroundColor = .WhiteColor
        amenitieslbl.textColor = .AppLabelColor.withAlphaComponent(0.5)
        amenitiesUL.backgroundColor = .WhiteColor
        
        NotificationCenter.default.post(name: NSNotification.Name("roomtapbool"), object: false)
        //  tvHeight.constant = 356
        delegate?.didTapOnHotelsDetailsBtn(cell:self)
    }
    
    
    @IBAction func didTapOnAmenitiesBtn(_ sender: Any) {
        hotelroomtap = "aminities"
        //   roomDetailsTV.isHidden = false
        amenitieslbl.textColor = .AppTabSelectColor
        amenitiesUL.backgroundColor = .AppTabSelectColor
        roomslbl.textColor = .AppLabelColor.withAlphaComponent(0.5)
        roomsUL.backgroundColor = .WhiteColor
        hotelsDetailslbl.textColor = .AppLabelColor.withAlphaComponent(0.5)
        hotelsDetailsUL.backgroundColor = .WhiteColor
        
        NotificationCenter.default.post(name: NSNotification.Name("roomtapbool"), object: false)
        
        //   tvHeight.constant = 356
        delegate?.didTapOnAmenitiesBtn(cell:self)
    }
    
    @IBAction func didTapOnMapBtnAction(_ sender: Any) {
        //  roomDetailsTV.isHidden = true
        amenitieslbl.textColor = .AppLabelColor.withAlphaComponent(0.5)
        amenitiesUL.backgroundColor = .WhiteColor
        roomslbl.textColor = .AppLabelColor.withAlphaComponent(0.5)
        roomsUL.backgroundColor = .WhiteColor
        hotelsDetailslbl.textColor = .AppLabelColor.withAlphaComponent(0.5)
        hotelsDetailsUL.backgroundColor = .WhiteColor
        
        hotelDetailsTapBool = false
        NotificationCenter.default.post(name: NSNotification.Name("roomtapbool"), object: false)
        
        //  delegate?.didTapOnAmenitiesBtn(cell:self)
    }
    
    
    
    func didTapOnCancellationPolicyBtnAction(cell: NewRoomDetailsTVCell) {
        delegate?.didTapOnCancellationPolicyBtnAction(cell: cell)
    }
    
    func didTapOnSelectRoomBtnAction(cell: NewRoomDetailsTVCell) {
        delegate?.didTapOnSelectRoomBtnAction(cell: cell)
    }
    
    
}


//extension RoomsTVcell: UITableViewDataSource ,UITableViewDelegate {
//
//    func updateHeight(height:Int) {
//
//        if self.key == "rooms" {
//           // tvHeight.constant = CGFloat(height * roomsDetails.count)
//            tvHeight.constant = 0
//            roomDetailsTV.reloadData()
//        }else {
//            viewHeight.constant = 356
//        }
//
//    }
//
//
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        if self.key == "rooms" {
//            return roomsDetails.count
//        }else {
//            return 1
//        }
//
//
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if self.key == "rooms" {
//            return roomsDetails[section].count
//        }
//        else if self.key == "hotels details"{
//            return formatDesc.count
//        }
//        else {
//            return 1
//        }
//
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var ccell = UITableViewCell()
//
//        if self.key == "rooms" {
//
//        }else if self.key == "hotels details"{
//
//
//        }else {
//
//        }
//        return ccell
//    }
//
//
//
//}


