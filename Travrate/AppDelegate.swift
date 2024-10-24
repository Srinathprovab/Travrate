//
//  AppDelegate.swift
//  Travrate
//
//  Created by FCI on 15/05/24.
//

import UIKit
import CoreData
import IQKeyboardManager
import GoogleMaps
import StoreKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    var fcmToken = String()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
       
        
        checkForAppUpdate()
        
        
        
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().keyboardDistanceFromTextField = 100 // Adjust this value as needed
        
        
        // Override point for customization after application launch.
        // set up your My Fatoorah Merchant details
        //        let token = "rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL"
        //        MFSettings.shared.configure(token: token, country: .kuwait, environment: .test)
        //        // you can change color and title of nvgigation bar
        //        let them = MFTheme(navigationTintColor: .white, navigationBarTintColor: .lightGray, navigationTitle: "Payment", cancelButtonTitle: "Cancel")
        //        MFSettings.shared.setTheme(theme: them)
        
        
        GMSServices.provideAPIKey("AIzaSyAfgpJ36EyQji0KETVN-UuooOpATS_zgb0")
        
        
        //        // Configure Firebase
        //        FirebaseApp.configure()
        //
        //        // Set Messaging delegate
        //        Messaging.messaging().delegate = self
        //
        //        // Request notification permissions
        //        UNUserNotificationCenter.current().delegate = self
        //        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        //        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { _, _ in }
        //        application.registerForRemoteNotifications()
        //
        //        // Get FCM token
        //        Messaging.messaging().token { token, error in
        //            if let error = error {
        //                print("Error fetching FCM registration token: \(error)")
        //            } else if let token = token {
        //                print("FCM registration token: \(token)")
        //            }
        //        }
        
        
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
    
    //    @objc func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
    //        print("Firebase registration token: \(String(describing: fcmToken))")
    //
    //        let dataDict: [String: Any] = ["token": fcmToken ?? ""]
    //        NotificationCenter.default.post(
    //            name: Notification.Name("FCMToken"),
    //            object: nil,
    //            userInfo: dataDict
    //        )
    //        // TODO: If necessary send token to application server.
    //        // Note: This callback is fired at each app startup and whenever a new token is generated.
    //    }
    
    //MARK: - applicationWillTerminate
    
    func applicationWillTerminate(_ application: UIApplication) {
        UserDefaults.standard.set(false, forKey: "ExecuteHotelOnce")
    }
    
    
    func checkForAppUpdate() {
        // Replace 'YOUR_APP_ID' with the actual App Store ID of your app
        let appID = "6651840936"
        let urlString = "https://itunes.apple.com/lookup?id=\(appID)"
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching app version info: \(String(describing: error?.localizedDescription))")
                return
            }
            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let results = jsonResponse["results"] as? [[String: Any]],
                   let appStoreVersion = results.first?["version"] as? String {
                    // Compare with the installed version
                    self.compareAppVersions(appStoreVersion)
                }
            } catch {
                print("Error parsing version info: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    
    
    func compareAppVersions(_ appStoreVersion: String) {
        if let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            if currentVersion != appStoreVersion {
                // If the versions don't match, show an alert prompting the user to update
                DispatchQueue.main.async {
                     self.promptUserToUpdate(appStoreVersion: appStoreVersion)
                }
            }
        }
    }
    
    
    
    func promptUserToUpdate(appStoreVersion: String) {
        let alertController = UIAlertController(
            title: "Update Available",
            message: "A new version (\(appStoreVersion)) of Travrate is available. Please update to the latest version for the best experience.",
            preferredStyle: .alert
        )
        
        let updateAction = UIAlertAction(title: "Update", style: .default) { _ in
            // Redirect user to the App Store
            if let url = URL(string: "https://apps.apple.com/app/id6651840936") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            // Navigate to HomeVC after canceling
            self.gotoDashBoardTBVC()
        }
        
        alertController.addAction(updateAction)
        alertController.addAction(cancelAction)
        
        DispatchQueue.main.async {
            if let topController = self.topViewController() {
                topController.present(alertController, animated: true) {
                    // Dismiss after 5 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        MySingleton.shared.callboolapi = false
                        alertController.dismiss(animated: true) {
                            // After dismissing the alert, go to dashboard/home
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                self.gotoDashBoardTBVC()
                            }
                        }
                    }
                }
            }
        }
    }

    func gotoDashBoardTBVC() {
        MySingleton.shared.callboolapi = true
        guard let vc = DashBoardTBVC.newInstance else { return }
        vc.modalPresentationStyle = .fullScreen
        vc.selectedIndex = 0
        
        DispatchQueue.main.async {
            // Access the active window scene
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = scene.windows.first(where: { $0.isKeyWindow }),
               let rootViewController = window.rootViewController {
                rootViewController.present(vc, animated: false, completion: nil)
            }
        }
    }

    
    
    
    func topViewController() -> UIViewController? {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first(where: { $0.isKeyWindow }),
              var topController = window.rootViewController else {
            return nil
        }
        
        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
        }
        return topController
    }
    
    
}



//extension AppDelegate {
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                willPresent notification: UNNotification,
//                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        let userInfo = notification.request.content.userInfo
//
//        Messaging.messaging().appDidReceiveMessage(userInfo)
//
//        // Change this to your preferred presentation option
//        completionHandler([.banner, .sound])
//    }
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                didReceive response: UNNotificationResponse,
//                                withCompletionHandler completionHandler: @escaping () -> Void) {
//        let userInfo = response.notification.request.content.userInfo
//
//        Messaging.messaging().appDidReceiveMessage(userInfo)
//
//        completionHandler()
//    }
//
//    func application(_ application: UIApplication,
//                     didReceiveRemoteNotification userInfo: [AnyHashable : Any],
//                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//        Messaging.messaging().appDidReceiveMessage(userInfo)
//        completionHandler(.noData)
//    }
//}



//NOTIFICATIOn
//func sendMessageToTopic() {
//    let urlString = "https://fcm.googleapis.com/fcm/send"
//    guard let url = URL(string: urlString) else { return }
//
//    var request = URLRequest(url: url)
//    request.httpMethod = "POST"
//    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//    request.setValue("key=YOUR_SERVER_KEY", forHTTPHeaderField: "Authorization") // Not recommended to include in client code
//
//    let notification: [String: Any] = [
//        "to": "/topics/timerUpdates",
//        "notification": [
//            "title": "Time Alert",
//            "body": "The timer is about to expire!"
//        ]
//    ]
//
//    request.httpBody = try? JSONSerialization.data(withJSONObject: notification, options: [])
//
//    let task = URLSession.shared.dataTask(with: request) { data, response, error in
//        if let error = error {
//            print("Error sending FCM notification: \(error)")
//            return
//        }
//
//        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
//            print("Failed to send FCM notification, status code: \(httpResponse.statusCode)")
//        } else {
//            print("FCM notification sent successfully")
//        }
//    }
//    task.resume()
//}



//HANDEL DOMAINS
// In AppDelegate.swift
//func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
//    if userActivity.activityType == NSUserActivityTypeBrowsingWeb,
//       let url = userActivity.webpageURL {
//        handleUniversalLink(url)
//    }
//    return true
//}
//
//// In SceneDelegate.swift (for apps with scenes)
//func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
//    if userActivity.activityType == NSUserActivityTypeBrowsingWeb,
//       let url = userActivity.webpageURL {
//        handleUniversalLink(url)
//    }
//}
//
//private func handleUniversalLink(_ url: URL) {
//    // Handle the URL in your app
//    print("Received Universal Link: \(url)")
//    // Add custom logic to route the URL to the appropriate part of your app
//}



//private func handleUniversalLink(_ url: URL) {
//    print("Received Universal Link: \(url)")
//
//    // Extract the path components from the URL
//    let pathComponents = url.pathComponents
//    guard pathComponents.count > 1 else {
//        return
//    }
//
//    // Route the URL to the appropriate part of your app
//    switch pathComponents[1] {
//    case "home":
//        navigateToHome()
//    case "profile":
//        navigateToProfile()
//    case "item":
//        if pathComponents.count > 2, let itemId = pathComponents[2] {
//            navigateToItem(withId: itemId)
//        }
//    default:
//        break
//    }
//}
//
//private func navigateToHome() {
//    // Code to navigate to the home screen
//    if let navigationController = UIApplication.shared.windows.first?.rootViewController as? UINavigationController {
//        navigationController.popToRootViewController(animated: true)
//    }
//}
//
//private func navigateToProfile() {
//    // Code to navigate to the profile screen
//    if let navigationController = UIApplication.shared.windows.first?.rootViewController as? UINavigationController {
//        let profileViewController = ProfileViewController()
//        navigationController.pushViewController(profileViewController, animated: true)
//    }
//}
//
//private func navigateToItem(withId itemId: String) {
//    // Code to navigate to a specific item screen
//    if let navigationController = UIApplication.shared.windows.first?.rootViewController as? UINavigationController {
//        let itemViewController = ItemViewController()
//        itemViewController.itemId = itemId
//        navigationController.pushViewController(itemViewController, animated: true)
//    }
//}

