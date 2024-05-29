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
    
    @IBOutlet weak var scrollView: UIScrollView!
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
        
        setupImageView()
        
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
            img.sd_setImage(with: URL(string: MySingleton.shared.sport_mapUrl ), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
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


extension ViewStadiumVC {
    func setupImageView() {
        
        
        // Set the scroll view delegate
        scrollView.delegate = self
        
        // Configure the scroll view for zooming
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        
        // Set the initial zoom scale
        scrollView.zoomScale = 1.0
        
        // Configure the content size
        scrollView.contentSize = img.bounds.size
        
        // Enable user interaction on the image view
        img.isUserInteractionEnabled = true
        
        // Add gesture recognizer for double-tap to zoom in and out
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapRecognizer.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTapRecognizer)
    }
    
    @objc func handleDoubleTap(_ recognizer: UITapGestureRecognizer) {
        if scrollView.zoomScale == scrollView.minimumZoomScale {
            scrollView.setZoomScale(scrollView.maximumZoomScale, animated: true)
        } else {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        }
    }
    
    // UIScrollViewDelegate method to return the view to zoom
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return img
    }
    
    // Ensure the image view is centered after zooming
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let offsetX = max((scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5, 0.0)
        let offsetY = max((scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5, 0.0)
        img.center = CGPoint(x: scrollView.contentSize.width * 0.5 + offsetX,
                             y: scrollView.contentSize.height * 0.5 + offsetY)
    }
}
