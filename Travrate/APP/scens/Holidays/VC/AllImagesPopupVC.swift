//
//  AllImagesPopupVC.swift
//  Travrate
//
//  Created by FCI on 30/05/24.
//

import UIKit

class AllImagesPopupVC: UIViewController {
    
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var previousBtn: UIButton!
    @IBOutlet weak var img: UIImageView!
    
    
    static var newInstance: AllImagesPopupVC? {
        let storyboard = UIStoryboard(name: Storyboard.Holidays.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? AllImagesPopupVC
        return vc
    }
    
    
    var imagesArray = [String]()
    var currentIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    func setupUI() {
        nextBtn.layer.cornerRadius = 4
        previousBtn.layer.cornerRadius = 4
        img.layer.cornerRadius = 8
        
        
        
        updateUI()
    }
    
    func updateUI() {
        if !imagesArray.isEmpty {
            self.img.sd_setImage(with: URL(string: imagesArray[currentIndex] ), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            previousBtn.isEnabled = currentIndex > 0
            nextBtn.isEnabled = currentIndex < imagesArray.count - 1
        }
    }
    
    
    @IBAction func didTapOnCloseBtnAction(_ sender: Any) {
        callapibool = false
        dismiss(animated: false)
    }
    
    
    
    @IBAction func didTaspOnNextButtonAction(_ sender: Any) {
        if currentIndex < imagesArray.count - 1 {
            currentIndex += 1
            updateUI()
        }
        
    }
    
    @IBAction func didTapOnPrevoousBtnAction(_ sender: Any) {
        if currentIndex < imagesArray.count {
            currentIndex -= 1
            updateUI()
        }
    }
    
    
}
