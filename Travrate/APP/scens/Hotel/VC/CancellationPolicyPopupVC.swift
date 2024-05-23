//
//  CancellationPolicyPopupVC.swift
//  Travrate
//
//  Created by FCI on 23/05/24.
//

import UIKit

class CancellationPolicyPopupVC: BaseTableVC {
    
    
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var tvheight: NSLayoutConstraint!
    
    
    static var newInstance: CancellationPolicyPopupVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? CancellationPolicyPopupVC
        return vc
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        commonTableView.registerTVCells(["CancellationStringTVCell"])
        tvheight.constant = CGFloat(MySingleton.shared.cancellationRoomStringArray.count * 43)
        setupTVCells()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        setupUI()
    }
    
    
    func setupUI() {
        okBtn.layer.cornerRadius = 3
        
    }
    
    
    func setupTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        
        
        MySingleton.shared.cancellationRoomStringArray.forEach { i in
            MySingleton.shared.tablerow.append(TableRow(title:i.policy,
                                                        cellType:.CancellationStringTVCell))
        }
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }

    @IBAction func didTapOnOkBtnAction(_ sender: Any) {
        callapibool = false
        dismiss(animated: false)
    }
    

}
