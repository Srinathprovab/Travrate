//
//  TransitTimeSliderTVCell.swift
//  Travrate
//
//  Created by Admin on 03/07/24.
//

import UIKit
import TTRangeSlider


protocol TransitTimeSliderTVCellDelegate:AnyObject {
    func didTapOnShowSliderBtn(cell:TransitTimeSliderTVCell)
}

class TransitTimeSliderTVCell: TableViewCell, TTRangeSliderDelegate {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var lblHolderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var downImg: UIImageView!
    @IBOutlet weak var downBtn: UIButton!
    @IBOutlet weak var sliderHolderView: UIView!
    @IBOutlet weak var sliderViewHeight: NSLayoutConstraint!
    @IBOutlet weak var rangeSlider: TTRangeSlider!
    @IBOutlet weak var minlbl: UILabel!
    @IBOutlet weak var maxlbl: UILabel!
    
    
    var minValue = Float()
    var maxValue = Float()
    var key = String()
    var minValue1 = Double()
    var maxValue1 = Double()
    var showbool = false
    weak var delegate:TransitTimeSliderTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override func updateUI() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(durationreset), name: Notification.Name("durationreset"), object: nil)
        
        
        titlelbl.text = "Transit Time"
        self.key = cellInfo?.key ?? ""
        expand()
        if self.key == "hotel" {
            downImg.isHidden = true
            expand()
        }
        
    }
    
    
    @objc func durationreset() {
        setupUI()
    }
    
    
    func setupUI() {
        
        holderView.backgroundColor = .WhiteColor
        lblHolderView.backgroundColor = .WhiteColor
        sliderHolderView.backgroundColor = .WhiteColor
        downImg.image = UIImage(named: "dropup")
        downBtn.setTitle("", for: .normal)
        setupLabels(lbl: titlelbl, text: "", textcolor: .TitleColor, font: .OpenSansMedium(size: 16))
        setuplabels(lbl: minlbl, text: "", textcolor: .TitleColor, font: .OpenSansBold(size: 16), align: .center)
        setuplabels(lbl: maxlbl, text: "", textcolor: .TitleColor, font: .OpenSansBold(size: 16), align: .center)
        rangeSlider.isHidden = true
        rangeSlider.backgroundColor = .WhiteColor
        

        
        // rangeSlider.step = 10
        rangeSlider.handleType = .rectangle
        rangeSlider.lineHeight = 5
        rangeSlider.tintColor = .lightGray.withAlphaComponent(0.5)
        rangeSlider.tintColorBetweenHandles = .Buttoncolor
        rangeSlider.lineBorderColor = .Buttoncolor
        rangeSlider.handleDiameter = 40.0
        rangeSlider.hideLabels = true
        rangeSlider.handleColor = .Buttoncolor
        rangeSlider.maxLabelColour = .black
        rangeSlider.minLabelColour = .black
        rangeSlider.delegate = self
        downBtn.isHidden = true
        
        
        
        DispatchQueue.main.async {[self] in
            // setupInitivalues()
            setupDurationSlider()
            
        }
        
        
    }
    
    
    
    func setupDurationSlider() {
        // Parse the duration strings into an array of Double values representing hours
        let parsedDurations = layoverdurationArray.map { parseDuration($0) }
        
        // Determine the minimum and maximum values from the parsed durations
        let minDurationValue = parsedDurations.min() ?? 0.0
        let maxDurationValue = parsedDurations.max() ?? 0.0
        
        // Check if filterModel has valid min and max duration values
        if let minDuration = filterModel.minTransitTimeDuration, let maxDuration = filterModel.maxTransitTimeDuration {
            
            
            // Both minPrice and maxPrice have values in filterModel
            minValue = Float(minDuration)
            maxValue = Float(maxDuration)
            
            
            rangeSlider.minValue = Float(minDurationValue)
            rangeSlider.maxValue = Float(maxDurationValue)
            
            // Set the thumbs to the values
            rangeSlider.selectedMinimum = minValue
            rangeSlider.selectedMaximum = maxValue
            
            //  Update the slider's appearance
            rangeSlider.setNeedsDisplay()
            
            // Update the labels to reflect the min and max values
            updateDurationLabels(minValue: minValue, maxValue: maxValue)
        }
        
        
        
    }
    
    
    
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    @objc func rangeSliderValueChanged(slider: TTRangeSlider) {
        print("maxValue \(slider.maxValue)")
    }
    
    
    func expand() {
        sliderViewHeight.constant = 120
        rangeSlider.isHidden = false
        downImg.image = UIImage(named: "dropup")
    }
    
    func hide() {
        sliderViewHeight.constant = 0
        rangeSlider.isHidden = true
        downImg.image = UIImage(named: "downarrow")
    }
    
    
    func rangeSlider(_ sender: TTRangeSlider!, didChangeSelectedMinimumValue selectedMinimum: Float, andMaximumValue selectedMaximum: Float) {
        let minLabelText = String(format: "%.1f", selectedMinimum)
        let maxLabelText = String(format: "%.1f", selectedMaximum)
        
        minValue1 = Double(String(format: "%.2f", Double(minLabelText) ?? 0.0)) ?? 0.0
        maxValue1 = Double(String(format: "%.2f", Double(maxLabelText) ?? 0.0)) ?? 0.0
        
        minlbl.text = "\(minValue1)"
        maxlbl.text = "\(maxValue1)"
        
        updateDurationLabels(minValue: Float(minValue1), maxValue: Float(maxValue1))
        
        delegate?.didTapOnShowSliderBtn(cell: self)
    }
    
    
    @IBAction func didTapOnShowSliderBtn(_ sender: Any) {
        delegate?.didTapOnShowSliderBtn(cell: self)
    }
    
    
    func updateDurationLabels(minValue: Float, maxValue: Float) {
        let minLabelText = formatDuration(hours: Double(minValue))
        let maxLabelText = formatDuration(hours: Double(maxValue))
        
        minlbl.text = "\(minLabelText)"
        maxlbl.text = "\(maxLabelText)"
    }
    
}


extension TransitTimeSliderTVCell {
    
    
    
        func parseDuration(_ duration: String) -> Double {
            var totalHours = 0.0
    
            // Extract days, hours, and minutes
            let dayMatches = duration.matchingStrings(regex: "(\\d+)D")
            let hourMatches = duration.matchingStrings(regex: "(\\d+)h")
            let minuteMatches = duration.matchingStrings(regex: "(\\d+)m")
    
            if let dayMatch = dayMatches.first, let days = Double(dayMatch[1]) {
                totalHours += days * 24.0
            }
    
            if let hourMatch = hourMatches.first, let hours = Double(hourMatch[1]) {
                totalHours += hours
            }
    
            if let minuteMatch = minuteMatches.first, let minutes = Double(minuteMatch[1]) {
                totalHours += minutes / 60.0
            }
    
            return totalHours
        }
    

    
    
    
    func formatDuration(hours: Double) -> String {
        if hours < 24 {
            return String(format: "%.1f Hours", hours)
        } else {
            let days = Int(hours / 24)
            let remainingHours = hours.truncatingRemainder(dividingBy: 24)
            return "\(days)D \(String(format: "%.1f Hours", remainingHours))"
        }
    }
    
}


