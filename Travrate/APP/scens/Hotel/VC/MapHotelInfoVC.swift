//
//  MapHotelInfoVC.swift
//  HolidaysCenter
//
//  Created by FCI on 16/05/24.
//

import UIKit

class MapHotelInfoVC: UIViewController {
    
    static var newInstance: MapHotelInfoVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? MapHotelInfoVC
        return vc
    }
    
    var mapModel: MapModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .orange
    }
    

   
}
