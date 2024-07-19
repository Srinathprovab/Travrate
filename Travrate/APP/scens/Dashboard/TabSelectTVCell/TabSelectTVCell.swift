//
//  TabSelectTVCell.swift
//  TravgateApp
//
//  Created by FCI on 02/01/24.
//

import UIKit
import EasyTipView


protocol TabSelectTVCellDelegate {
    
    func didTapOnMenuBtnAction(cell:TabSelectTVCell)
    func didTapOnSelectCurrencyBtnAction(cell:TabSelectTVCell)
    func didTapOnFlightTabSelectBtnAction(cell:TabSelectTVCell)
    func didTapOnHotelTabSelect(cell:TabSelectTVCell)
    func didTapOnMoreServiceBtnAction(cell:TabSelectTVCell)
    func didTapOnClosebtnAction(cell:TabSelectTVCell)
    func didTapOnVisabtnAction(cell:TabSelectTVCell)
    func didTapOnHolidaysbtnAction(cell:TabSelectTVCell)
    func didTapOnTransfersbtnAction(cell:TabSelectTVCell)
    func didTapOnSportsbtnAction(cell:TabSelectTVCell)
    func didTapOnCruisebtnAction(cell:TabSelectTVCell)
    func didTapOnActivitiesbtnAction(cell:TabSelectTVCell)
    func didTapOnInsurencebtnAction(cell:TabSelectTVCell)
    func didTapOnCarRentalBtnAction(cell:TabSelectTVCell)
}


class TabSelectTVCell: TableViewCell {
    
    
    @IBOutlet weak var currencylbl: UILabel!
    @IBOutlet weak var flightView: UIView!
    @IBOutlet weak var hotelView: UIView!
    @IBOutlet weak var moreView: UIView!
    @IBOutlet weak var moreserviceView: UIView!
    @IBOutlet weak var moreServiceCV: UICollectionView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var moreServicelbl: UILabel!
    
    //    var serviceArray1 = ["Visa","Holidays","Transfers","Sports","Cruise","Auto pay","Insurence"]
    //    var serviceImgsArray1 = ["s1","s2","s3","sports","s5","s6","s7"]
    
    
    var indexxPathArray = [IndexPath]()
    var serviceArray = ["Transfers","Sports","Car rental","Activities","Holidays","Cruise"]
    var serviceImgsArray = ["transfer","sports","s3","activitiestrip","s2","s5",]
    var delegate:TabSelectTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupmoreServiceCV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        currencylbl.text = defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD"
        switch MySingleton.shared.tabselect {
            
        case "flight":
            
            flightView.layer.borderColor = UIColor.AppBtnColor.cgColor
            flightView.backgroundColor = .LayoverColor
            
            hotelView.layer.borderColor = UIColor.BorderColor.cgColor
            hotelView.backgroundColor = .WhiteColor
            
            moreView.layer.borderColor = UIColor.BorderColor.cgColor
            moreView.backgroundColor = .WhiteColor
            
            break
            
        case "hotel":
            
            hotelView.layer.borderColor = UIColor.AppBtnColor.cgColor
            hotelView.backgroundColor = .LayoverColor
            
            
            moreView.layer.borderColor = UIColor.BorderColor.cgColor
            moreView.backgroundColor = .WhiteColor
            
            flightView.layer.borderColor = UIColor.BorderColor.cgColor
            flightView.backgroundColor = .WhiteColor
            break
            
        case "more":
            moreView.layer.borderColor = UIColor.AppBtnColor.cgColor
            moreView.backgroundColor = .LayoverColor
            
            hotelView.layer.borderColor = UIColor.BorderColor.cgColor
            hotelView.backgroundColor = .WhiteColor
            
            flightView.layer.borderColor = UIColor.BorderColor.cgColor
            flightView.backgroundColor = .WhiteColor
            
            moreserviceView.isHidden = false
            break
            
            
        case "close":
            
            flightView.layer.borderColor = UIColor.BorderColor.cgColor
            flightView.backgroundColor = .WhiteColor
            
            hotelView.layer.borderColor = UIColor.BorderColor.cgColor
            hotelView.backgroundColor = .WhiteColor
            
            moreView.layer.borderColor = UIColor.BorderColor.cgColor
            moreView.backgroundColor = .WhiteColor
            
            break
            
            
        default:
            flightView.layer.borderColor = UIColor.BorderColor.cgColor
            flightView.backgroundColor = .WhiteColor
            
            hotelView.layer.borderColor = UIColor.BorderColor.cgColor
            hotelView.backgroundColor = .WhiteColor
            
            moreView.layer.borderColor = UIColor.BorderColor.cgColor
            moreView.backgroundColor = .WhiteColor
            break
        }
        
        
        
    }
    
    
    
    func setupmoreServiceCV() {
        
        moreServicelbl.text = "More Services"
        let nib = UINib(nibName: "MoreServiceCVCell", bundle: nil)
        moreServiceCV.register(nib, forCellWithReuseIdentifier: "cell1")
        moreServiceCV.delegate = self
        moreServiceCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 110, height: 90)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 6, left: 10, bottom: 6, right: 10)
        moreServiceCV.collectionViewLayout = layout
        moreServiceCV.isScrollEnabled = false
        
    }
    
    @IBAction func didTapOnClosebtnAction(_ sender: Any) {
        MySingleton.shared.tabselect = "close"
        moreserviceView.isHidden = true
        delegate?.didTapOnClosebtnAction(cell: self)
    }
    
    @IBAction func didTapOnSelectCurrencyBtnAction(_ sender: Any) {
        delegate?.didTapOnSelectCurrencyBtnAction(cell: self)
    }
    
    @IBAction func didTapOnFlightTabSelectBtnAction(_ sender: Any) {
        MySingleton.shared.tabselect = "flight"
        delegate?.didTapOnFlightTabSelectBtnAction(cell: self)
    }
    
    @IBAction func didTapOnHotelTabSelect(_ sender: Any) {
        MySingleton.shared.tabselect = "hotel"
        delegate?.didTapOnHotelTabSelect(cell: self)
    }
    
    
    @IBAction func didTapOnMenuBtnAction(_ sender: Any) {
        delegate?.didTapOnMenuBtnAction(cell: self)
    }
    
    @IBAction func didTapOnMoreServiceBtnAction(_ sender: Any) {
        MySingleton.shared.tabselect = "more"
        moreserviceView.isHidden = false
        delegate?.didTapOnMoreServiceBtnAction(cell: self)
    }
    
    
}



extension TabSelectTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return serviceArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as? MoreServiceCVCell {
            cell.titlelbl.text = serviceArray[indexPath.row]
            cell.img.image = UIImage(named: serviceImgsArray[indexPath.row])?.withRenderingMode(.alwaysOriginal)
          
            
            
            
            if indexxPathArray.contains(indexPath) {
                print("=== select ===")
                print(indexPath.row)
                cell.holderView.backgroundColor = .LayoverColor
                cell.holderView.layer.borderWidth = 1
                cell.holderView.layer.borderColor = UIColor.Buttoncolor.cgColor
            }else {
                print("=== Deselect ===")
                print(indexPath.row)
                cell.holderView.backgroundColor = .WhiteColor
                cell.holderView.layer.borderWidth = 1
                cell.holderView.layer.borderColor = UIColor.BorderColor.cgColor
            }
            
            
            commonCell = cell
        }
        return commonCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? MoreServiceCVCell {
            
            cell.holderView.backgroundColor = .LayoverColor
            cell.holderView.layer.borderWidth = 1
            cell.holderView.layer.borderColor = UIColor.Buttoncolor.cgColor
            indexxPathArray.append(indexPath)
            
            switch cell.titlelbl.text {
                
            case "Visa":
                delegate?.didTapOnVisabtnAction(cell: self)
                break
                
            case "Holidays":
                delegate?.didTapOnHolidaysbtnAction(cell: self)
                break
                
            case "Transfers":
                delegate?.didTapOnTransfersbtnAction(cell: self)
                break
                
            case "Sports":
                delegate?.didTapOnSportsbtnAction(cell: self)
                break
                
            case "Cruise":
                delegate?.didTapOnCruisebtnAction(cell: self)
                break
                
            case "Activities":
                delegate?.didTapOnActivitiesbtnAction(cell: self)
                break
                
                
            case "Car rental":
                delegate?.didTapOnCarRentalBtnAction(cell: self)
                break
                
                
            default:
                break
            }
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? MoreServiceCVCell {
            cell.holderView.backgroundColor = .WhiteColor
            cell.holderView.layer.borderWidth = 1
            cell.holderView.layer.borderColor = UIColor.BorderColor.cgColor
            
            
            if let index = indexxPathArray.firstIndex(of: indexPath) {
                indexxPathArray.remove(at: index)
            }
            
        }
        
    }
    
    
}
