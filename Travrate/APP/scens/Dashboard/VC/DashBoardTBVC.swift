//
//  DashBoardTBVC.swift
//  TravgateApp
//
//  Created by FCI on 02/01/24.
//

import UIKit

class DashBoardTBVC: UITabBarController {
    
    
    var pageViewController: UIPageViewController!
    var viewControllersList: [UIViewController] = []
    
    // @IBOutlet weak var myTabBar: UITabBar?
    
    static var newInstance: DashBoardTBVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? DashBoardTBVC
        return vc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBarItems()
        // setupPageViewController()
        
        // Add swipe gesture recognizers
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    @objc func handleSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            // Swipe left, go to the next tab
            if selectedIndex < (viewControllers?.count ?? 0) - 1 {
                selectedIndex += 1
            }
        } else if gesture.direction == .right {
            // Swipe right, go to the previous tab
            if selectedIndex > 0 {
                selectedIndex -= 1
            }
        }
    }
    
    
    func setTabBarItems(){
        
        
        let myTabBarItem1 = (self.tabBar.items?[0])! as UITabBarItem
        myTabBarItem1.image = UIImage(named: "tab1")
        myTabBarItem1.selectedImage = UIImage(named: "tab1")?.withRenderingMode(.alwaysOriginal).withTintColor(.Buttoncolor)
       
        myTabBarItem1.imageInsets = UIEdgeInsets(top: -3, left: 0, bottom: -6, right: 0)
        let titleAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.InterRegular(size: 14) // Set your desired font size
        ]
        myTabBarItem1.setTitleTextAttributes(titleAttributes, for: .normal)
        
        let myTabBarItem2 = (self.tabBar.items?[1])! as UITabBarItem
        myTabBarItem2.image = UIImage(named: "tab2")
        myTabBarItem2.selectedImage = UIImage(named: "tab2")?.withRenderingMode(.alwaysOriginal).withTintColor(.Buttoncolor)
       
        myTabBarItem2.imageInsets = UIEdgeInsets(top: -3, left: 0, bottom: -6, right: 0)
        let titleAttributes2: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.InterRegular(size: 14) // Set your desired font size
        ]
        myTabBarItem2.setTitleTextAttributes(titleAttributes2, for: .normal)
        
        
        let myTabBarItem3 = (self.tabBar.items?[2])! as UITabBarItem
        myTabBarItem3.image = UIImage(named: "tab3")
        myTabBarItem3.selectedImage = UIImage(named: "tab3")?.withRenderingMode(.alwaysOriginal).withTintColor(.Buttoncolor)
      
        myTabBarItem3.imageInsets = UIEdgeInsets(top: -3, left: 0, bottom: -6, right: 0)
        let titleAttributes3: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.InterRegular(size: 14) // Set your desired font size
        ]
        myTabBarItem3.setTitleTextAttributes(titleAttributes3, for: .normal)
        
        
        
        let myTabBarItem4 = (self.tabBar.items?[3])! as UITabBarItem
        myTabBarItem4.image = UIImage(named: "tab4")
        myTabBarItem4.selectedImage = UIImage(named: "tab4")?.withRenderingMode(.alwaysOriginal).withTintColor(.Buttoncolor)
       
        myTabBarItem4.imageInsets = UIEdgeInsets(top: -3, left: 0, bottom: -6, right: 0)
        let titleAttributes4: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.InterRegular(size: 14) // Set your desired font size
        ]
        myTabBarItem4.setTitleTextAttributes(titleAttributes4, for: .normal)
        
        if LanguageManager.shared.currentLanguage() == "ar" {
            myTabBarItem1.title = "الرئيسية"
            myTabBarItem2.title = "رحلات"
            myTabBarItem3.title = "الملف الشخصي"
            myTabBarItem4.title = "المزيد"
        } else {
            myTabBarItem1.title = "Home"
            myTabBarItem2.title = "Trips"
            myTabBarItem3.title = "Profile"
            myTabBarItem4.title = "More"
        }
        
       
    }
    
    
    
}


extension DashBoardTBVC: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func setupPageViewController() {
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.delegate = self
        pageViewController.dataSource = self
        pageViewController.view.isUserInteractionEnabled = true
        
        
        // Assume you have view controllers associated with each tab
        if let viewController1 = storyboard?.instantiateViewController(withIdentifier: "DashboardVC"),
           let viewController2 = storyboard?.instantiateViewController(withIdentifier: "TripsVC"),
           let viewController3 = storyboard?.instantiateViewController(withIdentifier: "MyAccountVC"),
           let viewController4 = storyboard?.instantiateViewController(withIdentifier: "MoreVC") {
            
            viewControllersList = [viewController1, viewController2, viewController3, viewController4]
        }
        
        // Set the initial view controller to display
        if let firstViewController = viewControllersList.first {
            pageViewController.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
        // Add the pageViewController as a child view controller
        self.addChild(pageViewController)
        self.view.insertSubview(pageViewController.view, at: 0)
        pageViewController.didMove(toParent: self)
        
        
    }
    
    // MARK: - UIPageViewController DataSource Methods
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = viewControllersList.firstIndex(of: viewController) else { return nil }
        print("Current Index Before: \(currentIndex)")
        let previousIndex = currentIndex - 1
        return previousIndex >= 0 ? viewControllersList[previousIndex] : nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = viewControllersList.firstIndex(of: viewController) else { return nil }
        print("Current Index Before: \(currentIndex)")
        let nextIndex = currentIndex + 1
        return nextIndex < viewControllersList.count ? viewControllersList[nextIndex] : nil
    }
    
    // MARK: - UIPageViewController Delegate Methods
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let viewController = pageViewController.viewControllers?.first,
           let index = viewControllersList.firstIndex(of: viewController) {
            
            print("Swiped to index: \(index)")
            tabBar.selectedItem = tabBar.items?[index]
        }
    }
    
    // Handle tab bar item selection manually
    //    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    //        guard let index = tabBar.items?.firstIndex(of: item) else { return }
    //        pageViewController.setViewControllers([viewControllersList[index]], direction: .forward, animated: true, completion: nil)
    //    }
    
    
    
}
