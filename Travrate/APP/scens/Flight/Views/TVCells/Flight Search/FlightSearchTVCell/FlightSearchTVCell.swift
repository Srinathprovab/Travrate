//
//  FlightSearchTVCell.swift
//  TravgateApp
//
//  Created by FCI on 03/01/24.
//

import UIKit
import DropDown

protocol FlightSearchTVCellDelegate: AnyObject {
    func didTapOnAdvanceOption(cell:FlightSearchTVCell)
    func didTapOnClassBtnAction(cell:FlightSearchTVCell)
    func didTapOnSwipeCityBtnAction(cell: FlightSearchTVCell)
    func donedatePicker(cell:FlightSearchTVCell)
    func cancelDatePicker(cell:FlightSearchTVCell)
    func didTapOnHideReturnDateBtnAction(cell:FlightSearchTVCell)
    func didTapOnFlightSearchBtnAction(cell:FlightSearchTVCell)
    func didTapOnReturnDateBtnAction(cell:FlightSearchTVCell)
    func didTapOnAirlineTimeBtnAction(cell:FlightSearchTVCell)
}

class FlightSearchTVCell: TableViewCell, SelectCityViewModelProtocal {
    
    
    @IBOutlet weak var holderView: BorderedView!
    @IBOutlet weak var advanceSearchlbl: UILabel!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var infoCV: UICollectionView!
    
    @IBOutlet weak var fromlbl: UILabel!
    @IBOutlet weak var classlbl: UILabel!
    @IBOutlet weak var onewayclassView: UIView!
    @IBOutlet weak var tolbl: UILabel!
    @IBOutlet weak var roundtripclasslbl: UILabel!
    @IBOutlet weak var roundtripclassView: UIView!
    @IBOutlet weak var depDatelbl: UILabel!
    @IBOutlet weak var depTF: UITextField!
    @IBOutlet weak var returnDateView: BorderedView!
    @IBOutlet weak var retlbl: UILabel!
    @IBOutlet weak var retTF: UITextField!
    @IBOutlet weak var adultDecBtn: UIButton!
    @IBOutlet weak var adultCountlbl: UILabel!
    @IBOutlet weak var adultIncBtn: UIButton!
    @IBOutlet weak var childDecBtn: UIButton!
    @IBOutlet weak var childCountlbl: UILabel!
    @IBOutlet weak var childIncBtn: UIButton!
    @IBOutlet weak var infantDecBtn: UIButton!
    @IBOutlet weak var infantCountlbl: UILabel!
    @IBOutlet weak var infantIncBtn: UIButton!
    @IBOutlet weak var fromtv: UITableView!
    @IBOutlet weak var fromtvHeight: NSLayoutConstraint!
    @IBOutlet weak var totv: UITableView!
    @IBOutlet weak var totvHeight: NSLayoutConstraint!
    @IBOutlet weak var fromTF: UITextField!
    @IBOutlet weak var toTF: UITextField!
    @IBOutlet weak var directFlightCheckImg: UIImageView!
    @IBOutlet weak var hideRoundTripBtn: UIButton!
    @IBOutlet weak var outwardTimeView: BorderedView!
    @IBOutlet weak var outwardTimelbl: UILabel!
    @IBOutlet weak var returnTimeView: BorderedView!
    @IBOutlet weak var returnTimelbl: UILabel!
    @IBOutlet weak var airlineView: BorderedView!
    @IBOutlet weak var airlinelbl: UILabel!
    @IBOutlet weak var airlineTF: UITextField!
    @IBOutlet weak var returnDateBtn: UIButton!
    @IBOutlet weak var additionalView: UIView!
    @IBOutlet weak var selectadditionallbl: UILabel!
    @IBOutlet weak var swapimg: UIImageView!
    
    
    @IBOutlet weak var fromtitlelb: UILabel!
    @IBOutlet weak var totitlelb: UILabel!
    @IBOutlet weak var class1titlelb: UILabel!
    @IBOutlet weak var class2titlelb: UILabel!
    @IBOutlet weak var departurettlelb: UILabel!
    @IBOutlet weak var returntitlelb: UILabel!
    @IBOutlet weak var adulttitlelb: UILabel!
    @IBOutlet weak var childtitlelb: UILabel!
    @IBOutlet weak var infanttitlelb: UILabel!
    @IBOutlet weak var directflighttitlelb: UILabel!
    @IBOutlet weak var selectoptionalstitlelb: UILabel!
    @IBOutlet weak var flightSearchBtnlbl: UILabel!
    
    
   
    
    
    var timeArray = ["ALL times","12:00 AM - 06:00 AM","06:00 AM - 12:00 PM","12:00 PM - 12:00 PM","06:00 PM - 12:00 AM"]
    var selectClassArray = ["Economy","P.Economy","First","Business"]
    var selectClassArray_ar = ["اقتصادي", "درجة اقتصادية ممتازة", "أولى", "رجال الأعمال"]

    // var selectClassArray = ["Economy","Premium","First","Business"]
    var infoimgArray = ["in1","in2","in3","in4"]
    // var infoimgArray1 = ["in1","in2","in3","in4","in5","in6"]
    //  var infoArray1 = ["Add Baggage","Meal","Add Insurance","Add Special assistance","Add Seat","Add airport Transfers"]
    var infoArray_en = ["Add Baggage","Meal","Add Insurance","Add Special assistance"]
    var infoArray = ["Add Baggage","Meal","Add Insurance","Add Special assistance"]
    var infoArray_ar = ["إضافة أمتعة", "وجبة", "إضافة تأمين", "إضافة مساعدة خاصة"]

    weak var delegate:FlightSearchTVCellDelegate?
    var infoViewbool = false
    let onewayclassDropdown = DropDown()
    let roundtripclassDropdown = DropDown()
    let outwardtimeDropdown = DropDown()
    let returntimeDropdown = DropDown()
    let airlinetimeDropdown = DropDown()
    
    var cityViewModel: SelectCityViewModel?
    var payload = [String:Any]()
    var cityList:[SelectCityModel] = []
    let dropDown = DropDown()
    let dropDown1 = DropDown()
    var txtbool = Bool()
    
    let depDatePicker = UIDatePicker()
    let retDatePicker = UIDatePicker()
    
    var filterdcountrylist = [AirlineDate]()
    var countryNames = [String]()
    var countrycodesArray = [String]()
    var originArray = [String]()
    var isocountrycodeArray = [String]()
    var isSearchBool = Bool()
    var searchText = String()
    
    let dateFormat = "dd-MM-yyyy"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        
        cityViewModel = SelectCityViewModel(self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setupUI() {
        
        MySingleton.shared.newdateFormatter.dateFormat = dateFormat
        MySingleton.shared.newdateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        setAttributedString(str1: "    Advanced search options")
        setAttributedString1(str1: "    Select Aditional options")
        setupinfoCV()
        
        fromTF.tag = 1
        fromTF.textColor = .TitleColor
        fromTF.font = .OpenSansMedium(size: 16)
        fromTF.delegate = self
        fromTF.addTarget(self, action: #selector(textFiledEditingChanged(_:)), for: .editingChanged)
        fromTF.setLeftPaddingPoints(0)
        
        toTF.tag = 2
        toTF.textColor = .TitleColor
        toTF.font = .OpenSansMedium(size: 16)
        toTF.delegate = self
        toTF.addTarget(self, action: #selector(textFiledEditingChanged(_:)), for: .editingChanged)
        toTF.setLeftPaddingPoints(0)
        
        //        fromlbl.isHidden = true
        //        tolbl.isHidden = true
        
        adultIncBtn.addTarget(self, action: #selector(didTapOnAdultIncrementBtnAction(_:)), for: .touchUpInside)
        adultDecBtn.addTarget(self, action: #selector(didTapOnAdultDecrementBtnAction(_:)), for: .touchUpInside)
        childIncBtn.addTarget(self, action: #selector(didTapOnChildIncrementBtnAction(_:)), for: .touchUpInside)
        childDecBtn.addTarget(self, action: #selector(didTapOnChildDecrementBtnAction(_:)), for: .touchUpInside)
        infantIncBtn.addTarget(self, action: #selector(didTapOnInfantIncrementBtnAction(_:)), for: .touchUpInside)
        infantDecBtn.addTarget(self, action: #selector(didTapOnInfantDecrementBtnAction(_:)), for: .touchUpInside)
        
        
        setupOnewayClassDropDown()
        setupRoundTripClassDropDown()
        setupOutwardTimeDropDown()
        setupReturnTimeDropDown()
        setupAirlineDropDown()
        
        airlineTF.addTarget(self, action: #selector(searchTextChanged(textField:)), for: .editingChanged)
        airlineTF.addTarget(self, action: #selector(searchTextBegin(textField:)), for: .editingDidBegin)
        
        
        fromtv.layer.borderWidth = 1
        fromtv.layer.borderColor = UIColor.AppBorderColor.cgColor
        
        
        totv.layer.borderWidth = 1
        totv.layer.borderColor = UIColor.AppBorderColor.cgColor
        
        
        airlineTF.isHidden = true
        directFlightCheckImg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal).withTintColor(.TitleColor)
        
        
       // advanceSearchlbl.text = "    + Advanced search options"
        
       

        if LanguageManager.shared.currentLanguage() == "ar" {
            
            infoArray = infoArray_ar
            
            fromtitlelb.text = "من"
            totitlelb.text = "إلى"
            class1titlelb.text = "الدرجة"
            class2titlelb.text = "الدرجة"
            departurettlelb.text = "المغادرة"
            returntitlelb.text = "العودة"
            adulttitlelb.text = "بالغ (12+)"
            childtitlelb.text = "طفل (2-11)"
            infanttitlelb.text = "رضيع (0-2)"
            directflighttitlelb.text = "رحلة مباشرة"
            advanceSearchlbl.text = "خيار البحث المتقدم"
            selectoptionalstitlelb.text = "اختر الخيارات الإضافية، سيتم إضافتها في صفحة الحجز النهائي"
            flightSearchBtnlbl.text = "بحث الرحلات"
            
            fromTF.placeholder = ""
            
            
        } else {
            
            infoArray = infoArray_en
            
            fromtitlelb.text = "From"
            totitlelb.text = "To"
            class1titlelb.text = "Class"
            class2titlelb.text = "Class"
            departurettlelb.text = "Departure"
            returntitlelb.text = "Return"
            adulttitlelb.text = "Adult (12+)"
            childtitlelb.text = "Child (2-11)"
            infanttitlelb.text = "Infant (0-2)"
            directflighttitlelb.text = "Direct Flight"
            advanceSearchlbl.text = "    + Advanced search options"
            selectoptionalstitlelb.text = "Select the additional options it will be added in Final booking page"
            flightSearchBtnlbl.text = "Flight Search"
            
            fromTF.placeholder = ""
        }
    }
    
    override func updateUI() {
        let currentLang = LanguageManager.shared.currentLanguage()
       // fromtitlelb.text = NSLocalizedString("from", comment: "")
     
        
        MySingleton.shared.getCountryList()
        
        setupTV()
        fromtvHeight.constant = 0
        totvHeight.constant = 0
      //  CallShowCityListAPI(str: "")
        
        
        adultCountlbl.text = defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1"
        childCountlbl.text = defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0"
        infantCountlbl.text = defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0"
        
        
        MySingleton.shared.adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "") ?? 1
        MySingleton.shared.childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "") ?? 0
        MySingleton.shared.infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "") ?? 0
        
        
        
        if cellInfo?.key == "oneway" {
            fromTF.text = ""
            fromTF.resignFirstResponder()
            fromTF.placeholder = ""
            hideRoundTripBtn.isUserInteractionEnabled = false
            
            roundtripclassView.isHidden = true
            if currentLang == "ar" {
                classlbl.text = defaults.string(forKey: UserDefaultsKeys.selectClass_ar) ?? "رجال الأعمال"
                defaults.setValue("رجال الأعمال", forKey: UserDefaultsKeys.rselectClass)
                
                fromlbl.text = defaults.string(forKey: UserDefaultsKeys.fromcityname_ar) ?? "المنشأ"
                tolbl.text = defaults.string(forKey: UserDefaultsKeys.tocityname_ar) ?? "الوجهة"
                
            }else {
                classlbl.text = defaults.string(forKey: UserDefaultsKeys.selectClass) ?? "Economy"
                defaults.setValue("Economy", forKey: UserDefaultsKeys.rselectClass)
                
                fromlbl.text = defaults.string(forKey: UserDefaultsKeys.fromcityname) ?? "Origin"
                tolbl.text = defaults.string(forKey: UserDefaultsKeys.tocityname) ?? "Destination"
                
            }
            
           
            
            //  self.depDatelbl.text = defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "Add Date"
            
            self.depDatelbl.text = MySingleton.shared.updateIfDateIsPast(dateKey: UserDefaultsKeys.calDepDate, defaultLabel: "Add Date")
            
            
            returnDateView.alpha = 0.5
            retlbl.text = "Add Date"
            defaults.set("Add Date", forKey: UserDefaultsKeys.calRetDate)
            self.depTF.isHidden = false
            self.retTF.isHidden = true
            showdepDatePicker()
            
            returnDateBtn.isHidden = false
            
        }else {
            fromTF.text = ""
            fromTF.resignFirstResponder()
            toTF.text = ""
            toTF.resignFirstResponder()
            fromTF.placeholder = ""
            toTF.placeholder = ""
            
            
            hideRoundTripBtn.isUserInteractionEnabled = true
            roundtripclassView.isHidden = false
           
            if currentLang == "ar" {
                classlbl.text = defaults.string(forKey: UserDefaultsKeys.selectClass_ar) ?? "رجال الأعمال"
                roundtripclasslbl.text = defaults.string(forKey: UserDefaultsKeys.rselectClass_ar) ?? "رجال الأعمال"
                
                fromlbl.text = defaults.string(forKey: UserDefaultsKeys.fromcityname_ar) ?? "المنشأ"
                tolbl.text = defaults.string(forKey: UserDefaultsKeys.tocityname_ar) ?? "الوجهة"
                
            }else {
                classlbl.text = defaults.string(forKey: UserDefaultsKeys.selectClass) ?? "Economy"
                roundtripclasslbl.text = defaults.string(forKey: UserDefaultsKeys.rselectClass) ?? "Economy"
                
                fromlbl.text = defaults.string(forKey: UserDefaultsKeys.fromcityname) ?? "Origin"
                tolbl.text = defaults.string(forKey: UserDefaultsKeys.tocityname) ?? "Destination"
            }
            
            
           
            
            
            self.depDatelbl.text = MySingleton.shared.updateIfDateIsPast(dateKey: UserDefaultsKeys.calDepDate, defaultLabel: "Add Date")
            self.retlbl.text = MySingleton.shared.updateIfDateIsPast(dateKey: UserDefaultsKeys.calRetDate, defaultLabel: "Add Date")
            
            returnDateView.alpha = 1
            self.depTF.isHidden = false
            self.retTF.isHidden = false
            
            showdepDatePicker()
            showretDatePicker()
            
            returnDateBtn.isHidden = true
            
            
        }
        
        
        airlinelbl.text = defaults.string(forKey: UserDefaultsKeys.fcariername) ?? "ALL"
        
        
        if MySingleton.shared.directflightString == "on" {
            directFlightCheckImg.image = UIImage(named: "check")?.withRenderingMode(.alwaysOriginal).withTintColor(.Buttoncolor)
        }else {
            directFlightCheckImg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal).withTintColor(.TitleColor)
        }
        
        updateLabelColor(label: fromlbl, defaultText: "Origin", defaultColor: .subtitleNewcolor, selectedColor: .TitleColor)
        updateLabelColor(label: tolbl, defaultText: "Destination", defaultColor: .subtitleNewcolor, selectedColor: .TitleColor)
        updateLabelColor(label: depDatelbl, defaultText: "Add Date", defaultColor: .subtitleNewcolor, selectedColor: .TitleColor)
        updateLabelColor(label: retlbl, defaultText: "Add Date", defaultColor: .subtitleNewcolor, selectedColor: .TitleColor)
        
        func updateLabelColor(label: UILabel, defaultText: String, defaultColor: UIColor, selectedColor: UIColor) {
            label.textColor = label.text == defaultText ? defaultColor : selectedColor
        }
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(returndate), name: Notification.Name("returndate"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(roundtripTap), name: Notification.Name("roundtripTap"), object: nil)
        
        
    }
    
    
    @objc func returndate() {
        showretDatePicker()
    }
    
    @objc func roundtripTap() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.10) { [unowned self] in
            retTF.becomeFirstResponder()
        }
    }
    
    
    
    @IBAction func didTapOnOnewayClassBtnAction(_ sender: Any) {
        onewayclassDropdown.show()
    }
    
    @IBAction func didTapOnRoundTripClassBtnAction(_ sender: Any) {
        roundtripclassDropdown.show()
    }
    
    @IBAction func didTapOnDirectFlightCheckBtnAction(_ sender: Any) {
        MySingleton.shared.directFlightBool.toggle()
        if MySingleton.shared.directFlightBool {
            directFlightCheckImg.image = UIImage(named: "check")?.withRenderingMode(.alwaysOriginal).withTintColor(.Buttoncolor)
            MySingleton.shared.directflightString = "on"
        }else {
            directFlightCheckImg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal).withTintColor(.TitleColor)
            MySingleton.shared.directflightString = ""
        }
    }
    
    
    @IBAction func didTaponSwapCitysBtnAction(_ sender: Any) {
        
        
        if  fromlbl.text != "Origin" && tolbl.text != "Destination" && fromlbl.text != "" && tolbl.text != ""{
            
            let a = fromlbl.text
            let b = tolbl.text
            
            fromlbl.text = b
            tolbl.text = a
            
            defaults.set(fromlbl.text, forKey: UserDefaultsKeys.fromcityname)
            defaults.set(tolbl.text, forKey: UserDefaultsKeys.tocityname)
            
            
            let m = defaults.string(forKey: UserDefaultsKeys.fromCity)
            let n = defaults.string(forKey: UserDefaultsKeys.toCity)
            
            defaults.setValue(m, forKey: UserDefaultsKeys.toCity)
            defaults.setValue(n, forKey: UserDefaultsKeys.fromCity)
            
            let y = defaults.string(forKey: UserDefaultsKeys.fromlocid)
            let z = defaults.string(forKey: UserDefaultsKeys.tolocid)
            
            
            defaults.setValue(y, forKey: UserDefaultsKeys.tolocid)
            defaults.setValue(z, forKey: UserDefaultsKeys.fromlocid)
            
            let c = "\(defaults.string(forKey: UserDefaultsKeys.fcity) ?? "")"
            let d = "\(defaults.string(forKey: UserDefaultsKeys.tcity) ?? "")"
            
            defaults.setValue(d, forKey: UserDefaultsKeys.fcity)
            defaults.setValue(c, forKey: UserDefaultsKeys.tcity)
            
            
            let u = "\(defaults.string(forKey: UserDefaultsKeys.fromCode) ?? "")"
            let v = "\(defaults.string(forKey: UserDefaultsKeys.toCode) ?? "")"
            
            defaults.setValue(v, forKey: UserDefaultsKeys.fromCode)
            defaults.setValue(u, forKey: UserDefaultsKeys.toCode)
            
            
            let p = "\(defaults.string(forKey: UserDefaultsKeys.fromcitynameshow) ?? "")"
            let q = "\(defaults.string(forKey: UserDefaultsKeys.tocitynameshow) ?? "")"
            
            defaults.setValue(p, forKey: UserDefaultsKeys.tocitynameshow)
            defaults.setValue(q, forKey: UserDefaultsKeys.fromcitynameshow)
            
        }
        
        
        rotateImageView()
    }
    
    @IBAction func didTapOnFlightSearchBtnAction(_ sender: Any) {
        delegate?.didTapOnFlightSearchBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnHideReturnDateBtnAction(_ sender: Any) {
        delegate?.didTapOnHideReturnDateBtnAction(cell: self)
    }
    
    
    //MARK: - Text Filed Editing Changed
    
    @objc func textFiledEditingChanged(_ textField:UITextField) {
        
        
        if textField == fromTF {
            txtbool = true
            if textField.text?.isEmpty == true {
                dropDown.hide()
            }else {
                self.fromlbl.text = ""
                
                CallShowCityListAPI(str: textField.text ?? "")
                //dropDown.show()
            }
        }else {
            txtbool = false
            if textField.text?.isEmpty == true {
                dropDown1.hide()
            }else {
                self.tolbl.text = ""
                
                CallShowCityListAPI(str: textField.text ?? "")
                // dropDown1.show()
            }
        }
        
        
    }
    
    
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == fromTF {
            defaults.setValue("Origin", forKey: UserDefaultsKeys.fromcityname)
            fromTF.placeholder = "Origin"
            self.fromlbl.text = ""
            fromtvHeight.constant = 0
            // CallShowCityListAPI(str: textField.text ?? "")
            //  dropDown.show()
            
        }else {
            defaults.setValue("Destination", forKey: UserDefaultsKeys.tocityname)
            toTF.placeholder = "Destination"
            self.tolbl.text = ""
            totvHeight.constant = 0
            //  CallShowCityListAPI(str: textField.text ?? "")
            //  dropDown1.show()
            
        }
    }
    
    
    func ShowCityList(response: [SelectCityModel]) {
        cityList = response
        print(cityList)
        if txtbool == true {
            if cityList.count >= 3 {
                fromtvHeight.constant = 250
            }else {
                fromtvHeight.constant = CGFloat(cityList.count * 80)
            }
            
            DispatchQueue.main.async {[self] in
                fromtv.reloadData()
            }
        }else {
           
            if cityList.count >= 3 {
                totvHeight.constant = 250
            }else {
                totvHeight.constant = CGFloat(cityList.count * 80)
            }
            DispatchQueue.main.async {[self] in
                totv.reloadData()
            }
        }
        
    }
    
    @IBAction func didTapOnOutwardTimeBtnAction(_ sender: Any) {
        outwardtimeDropdown.show()
    }
    
    @IBAction func didTapOnReturnTimeBtnAction(_ sender: Any) {
        returntimeDropdown.show()
    }
    
    @IBAction func didTapOnAirlineTimeBtnAction(_ sender: Any) {
        delegate?.didTapOnAirlineTimeBtnAction(cell: self)
    }
    
    
    
    @IBAction func didTapOnReturnDateBtnAction(_ sender: Any) {
        delegate?.didTapOnReturnDateBtnAction(cell: self)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.10) { [unowned self] in
            retTF.becomeFirstResponder()
        }
    }
    
    
    func rotateImageView() {
        UIView.animate(withDuration: 0.5) {
            self.swapimg?.transform = (self.swapimg?.transform.rotated(by: .pi))!
        }
    }
    
    
    
}

extension FlightSearchTVCell {
    
    
    func setAttributedString(str1:String) {
        
        
        let atter1 : [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor:UIColor.TitleColor,
                                                      NSAttributedString.Key.font:UIFont.InterMedium(size: 14),
                                                      .underlineStyle: NSUnderlineStyle.single.rawValue]
        
        
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        advanceSearchlbl.attributedText = combination
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        advanceSearchlbl.addGestureRecognizer(tapGesture)
        advanceSearchlbl.isUserInteractionEnabled = true
        
        
    }
    
    @objc func labelTapped(gesture:UITapGestureRecognizer) {
        if gesture.didTapAttributedString("   + Advanced search options", in: advanceSearchlbl) {
            
            infoView.isHidden = false
            advanceSearchlbl.textColor = .BooknowBtnColor
            advanceSearchlbl.text = "    - less search options"
            
            delegate?.didTapOnAdvanceOption(cell: self)
        }else {
            infoView.isHidden = true
            advanceSearchlbl.textColor = .TitleColor
            advanceSearchlbl.text = "    + Advanced search options"
            
            delegate?.didTapOnAdvanceOption(cell: self)
        }
        
        
    }
    
    
    
    func setAttributedString1(str1:String) {
        
        
        let atter1 : [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor:UIColor.TitleColor,
                                                      NSAttributedString.Key.font:UIFont.InterMedium(size: 14),
                                                      .underlineStyle: NSUnderlineStyle.single.rawValue]
        
        
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        selectadditionallbl.attributedText = combination
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped1))
        selectadditionallbl.addGestureRecognizer(tapGesture)
        selectadditionallbl.isUserInteractionEnabled = true
        
        
    }
    
    @objc func labelTapped1(gesture:UITapGestureRecognizer) {
        if gesture.didTapAttributedString("Select Aditional options", in: selectadditionallbl) {
            infoViewbool.toggle()
            if infoViewbool {
                additionalView.isHidden = false
                selectadditionallbl.textColor = .BooknowBtnColor
            }else {
                additionalView.isHidden = true
                selectadditionallbl.textColor = .TitleColor
            }
            
            delegate?.didTapOnAdvanceOption(cell: self)
        }
    }
    
}

extension FlightSearchTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func setupinfoCV() {
        
        let nib = UINib(nibName: "InfoCVCell", bundle: nil)
        infoCV.register(nib, forCellWithReuseIdentifier: "cell1")
        infoCV.delegate = self
        infoCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 50)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        infoCV.collectionViewLayout = layout
        infoCV.isScrollEnabled = false
        infoCV.allowsMultipleSelection = true
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return infoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as? InfoCVCell {
            
            cell.titlelbl.text = infoArray[indexPath.row]
            cell.img.image = UIImage(named: infoimgArray[indexPath.row])
            
            
            // Check if the item is selected and update the checkbox accordingly
            if MySingleton.shared.infoArray.contains(cell.titlelbl.text ?? "") {
                cell.checkimg.image = UIImage(named: "check")
                infoCV.selectItem(at: indexPath, animated: false, scrollPosition: .left)
            } else {
                cell.checkimg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal).withTintColor(.Buttoncolor)
            }
            
            
            commonCell = cell
        }
        return commonCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? InfoCVCell {
            cell.checkimg.image = UIImage(named: "check")
            MySingleton.shared.infoArray.append(cell.titlelbl.text ?? "")
            
            
            // Update the boolean value based on the selected item
            updateBoolValue(for: cell.titlelbl.text, isSelected: true)
            
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? InfoCVCell {
            cell.checkimg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal).withTintColor(.Buttoncolor)
            
            if let index =  MySingleton.shared.infoArray.firstIndex(of: cell.titlelbl.text ?? "") {
                MySingleton.shared.infoArray.remove(at: index)
            }
            
            // Update the boolean value based on the deselected item
            updateBoolValue(for: cell.titlelbl.text, isSelected: false)
            
            
        }
    }
    
    
    func updateBoolValue(for title: String?, isSelected: Bool) {
        guard let title = title else { return }
        
        switch title {
        case "Add Baggage":
            MySingleton.shared.addBaggageBool = isSelected
        case "Meal":
            MySingleton.shared.addMealBool = isSelected
        case "Add Insurance":
            MySingleton.shared.addInsuranceBool = isSelected
        case "Add Special assistance":
            MySingleton.shared.addSpecialAssistanceBool = isSelected
        case "Add Seat":
            MySingleton.shared.addSeatBool = isSelected
        case "Add airport Transfers":
            MySingleton.shared.addAirportTransfersBool = isSelected
        default:
            break
        }
    }
    
}


extension FlightSearchTVCell {
    
    func setupOnewayClassDropDown() {
        
        onewayclassDropdown.direction = .bottom
        onewayclassDropdown.backgroundColor = .WhiteColor
        onewayclassDropdown.anchorView = self.onewayclassView
        
        
        // Check current language and adjust offset for RTL
            let currentLang = LanguageManager.shared.currentLanguage()
            
        if currentLang == "ar" {
            onewayclassDropdown.dataSource = selectClassArray_ar
                // RTL Mode: Shift dropdown to the right (relative to the anchor view)
                let anchorWidth = onewayclassView.frame.size.width + 50
                let dropdownWidth = onewayclassDropdown.width
                
                // Adjust bottomOffset for RTL
            onewayclassDropdown.bottomOffset = CGPoint(x: anchorWidth - (dropdownWidth ?? 0), y: onewayclassView.frame.size.height + 10)
            } else {
                onewayclassDropdown.dataSource = selectClassArray
                // LTR Mode: Default bottom offset
                onewayclassDropdown.bottomOffset = CGPoint(x: 0, y: onewayclassView.frame.size.height + 10)
            }
        
        
        
       // onewayclassDropdown.bottomOffset = CGPoint(x: 0, y: onewayclassView.frame.size.height + 10)
        onewayclassDropdown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.classlbl.text = item
           
            if currentLang == "ar" {
                defaults.set(item, forKey: UserDefaultsKeys.selectClass_ar)
            }else {
                defaults.set(item, forKey: UserDefaultsKeys.selectClass)
            }
            
            self?.delegate?.didTapOnClassBtnAction(cell: self!)
        }
    }
    
    func setupRoundTripClassDropDown() {
        
        roundtripclassDropdown.direction = .bottom
        roundtripclassDropdown.backgroundColor = .WhiteColor
        roundtripclassDropdown.anchorView = self.roundtripclassView
        
        
        
        // Check current language and adjust offset for RTL
            let currentLang = LanguageManager.shared.currentLanguage()
            
        if currentLang == "ar" {
            
            roundtripclassDropdown.dataSource = selectClassArray_ar
                let dropdownWidth = roundtripclassDropdown.width
                let viewWidth = roundtripclassView.frame.size.width
                
            roundtripclassDropdown.bottomOffset = CGPoint(x: viewWidth - (dropdownWidth ?? 0), y: roundtripclassView.frame.size.height + 10)
            } else {
                
                roundtripclassDropdown.dataSource = selectClassArray
                roundtripclassDropdown.bottomOffset = CGPoint(x: 0, y: onewayclassView.frame.size.height + 10)
            }
        
        
     //   roundtripclassDropdown.bottomOffset = CGPoint(x: 0, y: roundtripclassView.frame.size.height + 10)
        roundtripclassDropdown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.roundtripclasslbl.text = item
            
            if currentLang == "ar" {
                defaults.set(item, forKey: UserDefaultsKeys.rselectClass_ar)
            }else {
                defaults.set(item, forKey: UserDefaultsKeys.rselectClass)
            }
            
            self?.delegate?.didTapOnClassBtnAction(cell: self!)
        }
    }
}


extension FlightSearchTVCell:UITableViewDelegate, UITableViewDataSource {
    
    
    func setupTV() {
        fromtv.delegate = self
        fromtv.dataSource = self
        fromtv.register(UINib(nibName: "FromCityTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        totv.delegate = self
        totv.dataSource = self
        totv.register(UINib(nibName: "FromCityTVCell", bundle: nil), forCellReuseIdentifier: "cell1")
    }
    
    
    func CallShowCityListAPI(str:String) {
        payload["term"] = str
        cityViewModel?.CallShowCityListAPI(dictParam: payload)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        
        if tableView == fromtv {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? FromCityTVCell {
                cell.selectionStyle = .none
                cell.titlelbl.text = cityList[indexPath.row].label
                cell.subTitlelbl.text = cityList[indexPath.row].name
                cell.id = cityList[indexPath.row].id ?? ""
                cell.cityname = cityList[indexPath.row].name ?? ""
                cell.citycode = cityList[indexPath.row].code ?? ""
                ccell = cell
            }
        }else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as? FromCityTVCell {
                cell.selectionStyle = .none
                cell.titlelbl.text = cityList[indexPath.row].label
                cell.subTitlelbl.text = cityList[indexPath.row].name
                cell.id = cityList[indexPath.row].id ?? ""
                cell.cityname = cityList[indexPath.row].name ?? ""
                cell.citycode = cityList[indexPath.row].code ?? ""
                ccell = cell
            }
        }
        
        return ccell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? FromCityTVCell {
            
            if tableView == fromtv {
                fromlbl.text = "\(cityList[indexPath.row].city ?? "") (\(cityList[indexPath.row].code ?? ""))"
                fromlbl.textColor = .TitleColor
                fromTF.text = ""
                fromTF.placeholder = ""
                fromTF.resignFirstResponder()
                if tolbl.text?.isEmpty == true {
                    toTF.placeholder = "Destination"
                }else {
                    toTF.placeholder = ""
                }
                
                
                
                defaults.set(cityList[indexPath.row].city ?? "", forKey: UserDefaultsKeys.fromcitynameshow)
                defaults.set(cityList[indexPath.row].code ?? "", forKey: UserDefaultsKeys.fromCode)
                defaults.set(cityList[indexPath.row].label ?? "", forKey: UserDefaultsKeys.fromCity)
                defaults.set(cityList[indexPath.row].id ?? "", forKey: UserDefaultsKeys.fromlocid)
                //         defaults.set("\(cityList[indexPath.row].city ?? "") (\(cityList[indexPath.row].code ?? ""))", forKey: UserDefaultsKeys.fromairport)
                defaults.set("\(cityList[indexPath.row].city ?? "") (\(cityList[indexPath.row].code ?? ""))", forKey: UserDefaultsKeys.fromcityname)
                
                defaults.set("\(cityList[indexPath.row].city ?? "")", forKey: UserDefaultsKeys.fcity)
                
                fromtvHeight.constant = 0
                totvHeight.constant = 0
            }else {
                tolbl.text = "\(cityList[indexPath.row].city ?? "") (\(cityList[indexPath.row].code ?? ""))"
                tolbl.textColor = .TitleColor
                toTF.text = ""
                toTF.placeholder = ""
                toTF.resignFirstResponder()
                
                
                defaults.set(cityList[indexPath.row].city ?? "", forKey: UserDefaultsKeys.tocitynameshow)
                defaults.set(cityList[indexPath.row].code ?? "", forKey: UserDefaultsKeys.toCode)
                defaults.set(cityList[indexPath.row].label ?? "", forKey: UserDefaultsKeys.toCity)
                defaults.set(cityList[indexPath.row].id ?? "", forKey: UserDefaultsKeys.tolocid)
                //     defaults.set("\(cityList[indexPath.row].city ?? "") (\(cityList[indexPath.row].code ?? ""))", forKey: UserDefaultsKeys.toairport)
                defaults.set("\(cityList[indexPath.row].city ?? "") (\(cityList[indexPath.row].code ?? ""))", forKey: UserDefaultsKeys.tocityname)
                defaults.set("\(cityList[indexPath.row].city ?? "")", forKey: UserDefaultsKeys.tcity)
                
                
                totvHeight.constant = 0
                fromtvHeight.constant = 0
            }
        }
    }
}


extension FlightSearchTVCell {
    
    
    //MARK: - showdepDatePicker
    func showdepDatePicker(){
        //Formate Date
        depDatePicker.datePickerMode = .date
        depDatePicker.minimumDate = Date()
        depDatePicker.preferredDatePickerStyle = .wheels
        
       
        
        let formter = DateFormatter()
        formter.dateFormat = "dd-MM-yyyy"
        
        
        if let calDepDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "") {
            depDatePicker.date = calDepDate
            
            if self.retlbl.text == "Add Date" {
                retDatePicker.date = calDepDate
            }
            
            
            // Check if returnDate date is smaller than calDepDate date
            if let returnDate = formter.date(from: self.retlbl.text ?? ""),
               returnDate < calDepDate {
                retDatePicker.date = calDepDate
                
                // Also update the label to reflect the change
                self.retlbl.text = formter.string(from: calDepDate)
            }
            
            
        }
        
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        
        let label = UILabel()
        label.sizeToFit()
        label.font = .OpenSansMedium(size: 16)
        let labelButton = UIBarButtonItem(customView: label)
        
        let currentLang = LanguageManager.shared.currentLanguage()
        if currentLang == "ar" {
            
            label.text = "تاريخ المغادرة"

            depDatePicker.locale = Locale(identifier: "ar")
            
            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(title: "تم", style: .plain, target: self, action: #selector(donedatePicker));
            let cancelButton = UIBarButtonItem(title: "إلغاء", style: .plain, target: self, action: #selector(cancelDatePicker));
            toolbar.setItems([doneButton,flexibleSpace,flexibleSpace,labelButton,flexibleSpace,flexibleSpace, cancelButton], animated: false)
        } else {
            
            label.text = "Departure Date"
            depDatePicker.locale = Locale(identifier: "en")
            
            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
            let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
            toolbar.setItems([doneButton,flexibleSpace,flexibleSpace,labelButton,flexibleSpace,flexibleSpace, cancelButton], animated: false)
        }
        
        
        
        self.depTF.inputAccessoryView = toolbar
        self.depTF.inputView = depDatePicker
        
    }
    
    
    //MARK: - showretDatePicker
    func showretDatePicker(){
        //Formate Date
        retDatePicker.datePickerMode = .date
        //        retDatePicker.minimumDate = Date()
        // Set minimumDate for retDatePicker based on depDatePicker or retDatePicker
        let selectedDate = self.depTF.isFirstResponder ? depDatePicker.date : depDatePicker.date
        retDatePicker.minimumDate = selectedDate
        
        retDatePicker.preferredDatePickerStyle = .wheels
        
        
        
        
        let formter = DateFormatter()
        formter.dateFormat = "dd-MM-yyyy"
        
        
        if key == "hotel" {
            if let checkoutDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.checkout) ?? "") {
                retDatePicker.date = checkoutDate
            }
        }else {
            
            
            if let calDepDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "") {
                
                if self.retlbl.text == "Add Date" {
                    retDatePicker.date = calDepDate
                    
                }else {
                    if let rcalRetDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.calRetDate) ?? "") {
                        retDatePicker.date = rcalRetDate
                    }
                }
            }
        }
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        let label = UILabel()
       // Initial text, can be changed dynamically
        label.sizeToFit()
        label.font = .OpenSansMedium(size: 16)
        let labelButton = UIBarButtonItem(customView: label)
        
       
        
        let currentLang = LanguageManager.shared.currentLanguage()
        if currentLang == "ar" {
            
            label.text = "تاريخ العودة"

            retDatePicker.locale = Locale(identifier: "ar")
            
            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(title: "تم", style: .plain, target: self, action: #selector(donedatePicker));
            let cancelButton = UIBarButtonItem(title: "إلغاء", style: .plain, target: self, action: #selector(cancelDatePicker));
            toolbar.setItems([doneButton,flexibleSpace,flexibleSpace,labelButton,flexibleSpace,flexibleSpace, cancelButton], animated: false)
        } else {
            
            label.text = "Return Date"
            retDatePicker.locale = Locale(identifier: "en")
            
            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
            let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
            toolbar.setItems([doneButton,flexibleSpace,flexibleSpace,labelButton,flexibleSpace,flexibleSpace, cancelButton], animated: false)
        }
        
        
        
        self.retTF.inputAccessoryView = toolbar
        self.retTF.inputView = retDatePicker
        
        if MySingleton.shared.returnDateTapbool == true {
            
        }
        self.retTF.becomeFirstResponder()
        
    }
    
    
    @objc func donedatePicker(){
        delegate?.donedatePicker(cell:self)
    }
    
    
    @objc func cancelDatePicker(){
        delegate?.cancelDatePicker(cell:self)
    }
    
}


extension FlightSearchTVCell {
    
    //MARK: - Adult
    @objc func didTapOnAdultIncrementBtnAction(_ sender:UIButton) {
        
        // Increment adults, but don't exceed 9 travelers in total
        if (MySingleton.shared.adultsCount + MySingleton.shared.childCount) < 9 {
            MySingleton.shared.adultsCount += 1
            self.adultCountlbl.text = "\(MySingleton.shared.adultsCount)"
        }
        
        updateTotalTravelerCount()
    }
    
    @objc func didTapOnAdultDecrementBtnAction(_ sender:UIButton) {
        
        // Ensure child count doesn't go below 1
        if MySingleton.shared.adultsCount > 1 {
            MySingleton.shared.adultsCount -= 1
            adultCountlbl.text = "\(MySingleton.shared.adultsCount)"
            
            MySingleton.shared.infantsCount = 0
            infantCountlbl.text = "0"
        }
        
        updateTotalTravelerCount()
    }
    
    //MARK: - Child
    @objc func didTapOnChildIncrementBtnAction(_ sender:UIButton) {
        
        // Increment adults and children, but don't exceed 9 travelers in total
        if (MySingleton.shared.adultsCount + MySingleton.shared.childCount) < 9 {
            MySingleton.shared.childCount += 1
            self.childCountlbl.text = "\(MySingleton.shared.childCount)"
        }
        
        updateTotalTravelerCount()
    }
    
    @objc func didTapOnChildDecrementBtnAction(_ sender:UIButton) {
        
        // Ensure adult count doesn't go below 1
        if MySingleton.shared.childCount >= 1 {
            MySingleton.shared.childCount -= 1
            childCountlbl.text = "\(MySingleton.shared.childCount)"
        }
        
        updateTotalTravelerCount()
    }
    
    //MARK: - Infant
    @objc func didTapOnInfantIncrementBtnAction(_ sender:UIButton) {
        
        // Increment infants based on the selected adult count, but don't exceed the selected adult count
        if MySingleton.shared.adultsCount > MySingleton.shared.infantsCount {
            MySingleton.shared.infantsCount += 1
            self.infantCountlbl.text = "\(MySingleton.shared.infantsCount)"
        }
        
        updateTotalTravelerCount()
    }
    
    @objc func didTapOnInfantDecrementBtnAction(_ sender:UIButton) {
        
        // Ensure infant count doesn't go below 1
        if MySingleton.shared.infantsCount >= 1 {
            MySingleton.shared.infantsCount -= 1
            infantCountlbl.text = "\(MySingleton.shared.infantsCount)"
        }
        
        updateTotalTravelerCount()
    }
    
    
    func updateTotalTravelerCount() {
        
        let totalTravelers = MySingleton.shared.adultsCount + MySingleton.shared.childCount + MySingleton.shared.infantsCount
        print("Total Count === \(totalTravelers)")
        
        defaults.set(totalTravelers, forKey: UserDefaultsKeys.totalTravellerCount)
        defaults.set(MySingleton.shared.adultsCount, forKey: UserDefaultsKeys.adultCount)
        defaults.set(MySingleton.shared.childCount, forKey: UserDefaultsKeys.childCount)
        defaults.set(MySingleton.shared.infantsCount, forKey: UserDefaultsKeys.infantsCount)
        
    }
    
    
}


extension FlightSearchTVCell {
    
    
    func setupOutwardTimeDropDown() {
        outwardtimeDropdown.dataSource = timeArray
        outwardtimeDropdown.direction = .bottom
        outwardtimeDropdown.backgroundColor = .WhiteColor
        outwardtimeDropdown.anchorView = self.outwardTimeView
        outwardtimeDropdown.bottomOffset = CGPoint(x: 0, y: outwardTimeView.frame.size.height + 10)
        outwardtimeDropdown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.outwardTimelbl.text = item
            //            defaults.set(item, forKey: UserDefaultsKeys.rselectClass)
            //            self?.delegate?.didTapOnClassBtnAction(cell: self!)
        }
    }
    
    
    func setupReturnTimeDropDown() {
        returntimeDropdown.dataSource = timeArray
        returntimeDropdown.direction = .bottom
        returntimeDropdown.backgroundColor = .WhiteColor
        returntimeDropdown.anchorView = self.returnTimeView
        returntimeDropdown.bottomOffset = CGPoint(x: 0, y: returnTimeView.frame.size.height + 10)
        returntimeDropdown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.returnTimelbl.text = item
            //            defaults.set(item, forKey: UserDefaultsKeys.rselectClass)
            //            self?.delegate?.didTapOnClassBtnAction(cell: self!)
        }
    }
    
    
    func setupAirlineDropDown() {
        // airlinetimeDropdown.dataSource = timeArray
        airlinetimeDropdown.direction = .bottom
        airlinetimeDropdown.backgroundColor = .WhiteColor
        airlinetimeDropdown.anchorView = self.airlineView
        airlinetimeDropdown.bottomOffset = CGPoint(x: 0, y: airlineView.frame.size.height + 10)
        airlinetimeDropdown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.airlinelbl.text = item
            self?.airlineTF.text = ""
            self?.airlineTF.resignFirstResponder()
            
            defaults.set(item, forKey: UserDefaultsKeys.fcariername)
            defaults.set(self?.countrycodesArray[index], forKey: UserDefaultsKeys.fcariercode)
            
            self?.delegate?.didTapOnClassBtnAction(cell: self!)
        }
    }
    
    
}


extension FlightSearchTVCell {
    
    @objc func searchTextBegin(textField: UITextField) {
        airlineTF.text = ""
        airlinelbl.text = ""
        filterdcountrylist.removeAll()
        filterdcountrylist = MySingleton.shared.airlinelist
        loadCountryNamesAndCode()
        airlinetimeDropdown.show()
        
    }
    
    
    @objc func searchTextChanged(textField: UITextField) {
        searchText = textField.text ?? ""
        if searchText == "" {
            isSearchBool = false
            filterContentForSearchText(searchText)
        }else {
            isSearchBool = true
            filterContentForSearchText(searchText)
        }
        
        
    }
    
    func filterContentForSearchText(_ searchText: String) {
        print("Filterin with:", searchText)
        
        filterdcountrylist.removeAll()
        filterdcountrylist = MySingleton.shared.airlinelist.filter { thing in
            return "\(thing.name?.lowercased() ?? "")".contains(searchText.lowercased())
        }
        
        loadCountryNamesAndCode()
        airlinetimeDropdown.show()
        
    }
    
    
    func loadCountryNamesAndCode(){
        countryNames.removeAll()
        countrycodesArray.removeAll()
        
        
        countryNames.append("ALL")
        countrycodesArray.append("ALL")
        
        filterdcountrylist.forEach { i in
            countryNames.append(i.name ?? "")
            countrycodesArray.append(i.code ?? "")
        }
        
        DispatchQueue.main.async {[self] in
            airlinetimeDropdown.dataSource = countryNames
            
        }
    }
}

