//
//  BookingConfirmedTVCell.swift
//  BabSafar
//
//  Created by MA673 on 26/07/22.
//

import UIKit

class BookingConfirmedTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var bclbl: UILabel!
    @IBOutlet weak var congratulationslbl: UILabel!
    @IBOutlet weak var bookingReflbl: UILabel!
    @IBOutlet weak var bookingDatelbl: UILabel!
    @IBOutlet weak var pnrNolbl: UILabel!
    
    
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
        
        
        bookingReflbl.text = "Booking Reference: \(cellInfo?.buttonTitle ?? "")"
        bookingDatelbl.text = "Booking Date: \(cellInfo?.text ?? "")"
        pnrNolbl.text = "PNR No: \(cellInfo?.tempText ?? "")"
        
        switch cellInfo?.key {
        case "visa":
            pnrNolbl.text = ""
            bookingReflbl.text = ""
            break
            
        case "booksucess":
            pnrNolbl.text = ""
            pnrNolbl.isHidden = true
            break
            
            
        case "hotel":
            pnrNolbl.isHidden = true
            break
            
            
            
        default:
            break
        }
    }
    
    func setupUI() {
        setupViews(v: holderView, radius: 10, color: HexColor("#EDF7ED"))
        
        setuplabels(lbl: bclbl, text: "Booking Confirmed", textcolor: HexColor("#4AA449"), font: .LatoSemibold(size: 18), align: .left)
        setuplabels(lbl: congratulationslbl, text: "Congratulations! your e-tickets  are successfuly booked.", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .left)
        congratulationslbl.numberOfLines = 2
     //   setuplabels(lbl: bookingIDlbl, text: "", textcolor: HexColor("#5B5B5B"), font: .LatoRegular(size: 14), align: .left)
        setuplabels(lbl: bookingReflbl, text: " ", textcolor: HexColor("#5B5B5B"), font: .LatoRegular(size: 14), align: .left)
        setuplabels(lbl: bookingDatelbl, text: "", textcolor: HexColor("#5B5B5B"), font: .LatoRegular(size: 14), align: .left)
        setuplabels(lbl: pnrNolbl, text: "", textcolor: .AppLabelColor, font: .LatoBold(size: 14), align: .center)
        
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.4
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
}
