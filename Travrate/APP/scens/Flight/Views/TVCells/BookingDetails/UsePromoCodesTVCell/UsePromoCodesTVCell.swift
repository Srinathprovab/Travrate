//
//  UsePromoCodesTVCell.swift
//  AlghanimTravelApp
//
//  Created by MA673 on 07/09/22.
//

import UIKit

protocol UsePromoCodesTVCellDelegate: AnyObject {
    func didTapClosepromoViewBtnAction(cell:UsePromoCodesTVCell)
    func didTapOnApplyPromosCodesBtn(cell:UsePromoCodesTVCell)
    func editingChanged(tf:UITextField)
}

class UsePromoCodesTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var codesTF: UITextField!
    @IBOutlet weak var errorlbl: UILabel!
    @IBOutlet weak var promoView: UIView!
    @IBOutlet weak var arrowimg: UIImageView!
    @IBOutlet weak var applybtn: UIButton!
    
    
    var promobool = false
    var promocodecode = String()
    var promocodeval = String()
    var index = Int()
    weak var delegate:UsePromoCodesTVCellDelegate?
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(InvalidPromocode), name: Notification.Name("invalidPromocode"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ValidPromocode), name: Notification.Name("validPromocode"), object: nil)
      
    }
    
    @objc func InvalidPromocode() {
        errorlbl.isHidden = false
    }
    
    @objc func ValidPromocode() {
        errorlbl.isHidden = true
        promobool = false
    }
    
    
    func setupUI() {
        arrowimg.image = UIImage(named: "downarrow")?.withRenderingMode(.alwaysOriginal).withTintColor(.black)
        promoView.isHidden = true
        codesTF.delegate = self
        codesTF.setLeftPaddingPoints(10)
        codesTF.placeholder = "Enter Promo Codes"
        codesTF.font = .poppinsMedium(size: 15)
        codesTF.isSecureTextEntry = false
        codesTF.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        
        applybtn.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        applybtn.layer.cornerRadius = 4

    }
    
    
    @objc func editingChanged(_ tf: UITextField){
        errorlbl.isHidden = true
        delegate?.editingChanged(tf: tf)
    }
    
    
    @IBAction func didTapOnApplyPromosCodesBtn(_ sender: Any) {
        codesTF.resignFirstResponder()
        delegate?.didTapOnApplyPromosCodesBtn(cell: self)
    }
    
    
    @IBAction func didTapClosepromoViewBtnAction(_ sender: Any) {
        promobool.toggle()
        
        if promobool {
            promoView.isHidden = false
            arrowimg.image = UIImage(named: "dropup")?.withRenderingMode(.alwaysOriginal).withTintColor(.black)
        }else {
            promoView.isHidden = true
            arrowimg.image = UIImage(named: "downarrow")?.withRenderingMode(.alwaysOriginal).withTintColor(.black)
        }
        
        delegate?.didTapClosepromoViewBtnAction(cell: self)
    }
   
    
    
}

