//
//  CarrentalPriceSliderTVCell.swift
//  Travrate
//
//  Created by Admin on 12/07/24.
//

import UIKit
import TTRangeSlider


protocol CarrentalPriceSliderTVCellDelegate:AnyObject {
    func didTapOnShowSliderBtn(cell:CarrentalPriceSliderTVCell)
}

class CarrentalPriceSliderTVCell: TableViewCell, TTRangeSliderDelegate {
    
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
    weak var delegate:CarrentalPriceSliderTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override func updateUI() {
        
        titlelbl.text = "Price"
        self.key = cellInfo?.key ?? ""
        expand()
        
        NotificationCenter.default.addObserver(self, selector: #selector(durationreset), name: Notification.Name("durationreset"), object: nil)
        
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
        if let minPrice = carfilterModel.minPriceRange, let maxPrice = carfilterModel.maxPriceRange {
            // Both minPrice and maxPrice have values in filterModel
            minValue = Float(minPrice)
            maxValue = Float(maxPrice)
            
            
            rangeSlider.minValue = carprices.compactMap { Float($0) }.min()!
            rangeSlider.maxValue = carprices.compactMap { Float($0) }.max()!
            
            // Set the thumbs to the values
            rangeSlider.selectedMinimum = minValue
            rangeSlider.selectedMaximum = maxValue
            
            //  Update the slider's appearance
            rangeSlider.setNeedsDisplay()
            
        }
        
        
        // Update labels and other UI elements as needed
        minValue1 = Double(String(format: "%.2f", Double(minValue))) ?? 0.0
        maxValue1 = Double(String(format: "%.2f", Double(maxValue))) ?? 100.0 // Update the default max value here
        minlbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "") \(minValue1)"
        maxlbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "") \(maxValue1)"
        
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
    
    
    @objc func rangeSlider(_ sender: TTRangeSlider!, didChangeSelectedMinimumValue selectedMinimum: Float, andMaximumValue selectedMaximum: Float) {
        let minLabelText = String(format: "%.1f", selectedMinimum)
        let maxLabelText = String(format: "%.1f", selectedMaximum)
        
        minValue1 = Double(String(format: "%.2f", Double(minLabelText) ?? 0.0)) ?? 0.0
        maxValue1 = Double(String(format: "%.2f", Double(maxLabelText) ?? 0.0)) ?? 0.0
        
        minlbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "") \(minValue1)"
        maxlbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "") \(maxValue1)"
        
        
        
        delegate?.didTapOnShowSliderBtn(cell: self)
    }
    
    
    @IBAction func didTapOnShowSliderBtn(_ sender: Any) {
        delegate?.didTapOnShowSliderBtn(cell: self)
    }
    
    
}

