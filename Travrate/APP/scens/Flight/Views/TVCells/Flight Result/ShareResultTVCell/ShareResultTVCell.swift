//
//  ShareResultTVCell.swift
//  Travrate
//
//  Created by Admin on 24/06/24.
//

import UIKit

protocol ShareResultTVCellDelegate {
    func texteditingchanged(tf:UITextField)
    func didTapOnSendBtnAction(cell:ShareResultTVCell)
    func didTapOnCopyWhatsapplinkBtnAction(cell:ShareResultTVCell)
    func didTapOnCopyLinkBtnAction(cell:ShareResultTVCell)
}

class ShareResultTVCell: TableViewCell {
    
    
    
    @IBOutlet weak var fnameTF: UITextField!
    @IBOutlet weak var lnameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var whatsappTF: UITextField!
    @IBOutlet weak var linkTF: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var whatsappCopybtn: UIButton!
    @IBOutlet weak var copylinkBtn: UIButton!
    
    
    var delegate:ShareResultTVCellDelegate?
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
        NotificationCenter.default.addObserver(self, selector: #selector(shareresultshow), name: Notification.Name("shareresultshow"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(shareresulthide), name: Notification.Name("shareresulthide"), object: nil)
    }
    
    
    
    @objc func shareresultshow(){
        sendBtn.alpha = 1
        sendBtn.isUserInteractionEnabled = true
        
    }
    
    @objc func shareresulthide(){
        sendBtn.alpha = 0.3
        sendBtn.isUserInteractionEnabled = false
    }
    
    
    func setupUI() {
        setupTF(tf: fnameTF, tag1: 1)
        setupTF(tf: lnameTF, tag1: 2)
        setupTF(tf: emailTF, tag1: 3)
        setupTF(tf: whatsappTF, tag1: 4)
        setupTF(tf: linkTF, tag1: 5)
        
        setupBTN(btn: sendBtn)
        setupBTN(btn: whatsappCopybtn)
        setupBTN(btn: copylinkBtn)
        
        whatsappTF.isUserInteractionEnabled = false
        whatsappTF.text = "https://travrate.com/index.php/flight/search/509182"
        linkTF.text = "https://travrate.com/index.php/flight/search/509182"
        linkTF.isUserInteractionEnabled = false
        
        sendBtn.alpha = 0.3
        sendBtn.isUserInteractionEnabled = false
        
    }
    
    
    
    
    func setupTF(tf:UITextField,tag1:Int) {
        tf.font = .OpenSansRegular(size: 14)
        tf.textColor = .TitleColor
        tf.tag = tag1
        tf.setLeftPaddingPoints(15)
        tf.addTarget(self, action: #selector(texteditingchanged(_:)), for: .editingChanged)
    }
    
    
    func setupBTN(btn:UIButton) {
        btn.layer.cornerRadius = 6
        btn.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        btn.layer.masksToBounds = true
    }
    
    
    @objc func texteditingchanged( _ tf:UITextField) {
        delegate?.texteditingchanged(tf: tf)
    }
    
    
    @IBAction func didTapOnSendBtnAction(_ sender: Any) {
        delegate?.didTapOnSendBtnAction(cell: self)
    }
    
    @IBAction func didTapOnCopyWhatsapplinkBtnAction(_ sender: Any) {
        delegate?.didTapOnCopyWhatsapplinkBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnCopyLinkBtnAction(_ sender: Any) {
        delegate?.didTapOnCopyLinkBtnAction(cell: self)
    }
    
}
