//
//  ViewStadiumVC.swift
//  Travrate
//
//  Created by FCI on 22/05/24.
//

import UIKit

class ViewStadiumVC: BaseTableVC {
    
    @IBOutlet weak var stadiumView: UIView!
    @IBOutlet weak var topview: UIView!
    @IBOutlet weak var img: UIImageView!
    
    var keystr = String()
    var str = "Lorem ipsum dolor sit amet consectetur. Laoreet tristique nibh ipsum eget. Blandit sed risus tellus ac at in. Nulla dolor tempor bibendum congue ipsum nec sapien. Praesent dignissim a tellus nunc id justo viverra pellentesque. Enim ipsum sit lectus tellus non massa. Molestie vulputate habitant quis phasellus dui. Lorem libero arcu est sit. Sodales habitant ultrices at scelerisque. Sed sagittis purus mi nam.\n\n Lorem ipsum dolor sit amet consectetur. Laoreet tristique nibh ipsum eget. Blandit sed risus tellus ac at in. Nulla dolor tempor bibendum congue ipsum nec sapien. Praesent dignissim a tellus nunc id justo viverra pellentesque. Enim ipsum sit lectus tellus non massa. Molestie vulputate habitant quis phasellus dui. Lorem libero arcu est sit. Sodales habitant ultrices at scelerisque. Sed sagittis purus mi nam."
    static var newInstance: ViewStadiumVC? {
        let storyboard = UIStoryboard(name: Storyboard.Sports.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ViewStadiumVC
        return vc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    
    
    @IBAction func didTaponCloseBtnAction(_ sender: Any) {
        callapibool = false
        dismiss(animated: false)
    }
    
    
    override func didTapOnCloseBtn(cell:LabelTVCell) {
        callapibool = false
        dismiss(animated: false)
    }
    
    
    
}


extension ViewStadiumVC {
    
    
    func setupUI() {
        if keystr == "stadium" {
            stadiumView.isHidden = false
        }else {
            topview.isHidden = false
            commonTableView.isHidden = false
            commonTableView.registerTVCells(["LabelTVCell","EmptyTVCell"])
            setupTVCell()
        }
    }
    
    func setupTVCell() {
        
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(title:str,cellType:.LabelTVCell))
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
        
    }
    
}
