//
//  MapViewVC.swift
//  BeeoonsApp
//
//  Created by MA673 on 23/08/22.
//

import UIKit
import MapKit
import GoogleMaps


struct MapModel {
    var longitude =  String()
    var latitude =  String()
    var hotelname = String()
    var hotelimg = String()
    var identifier = Int()
}



class MapViewVC: UIViewController, CLLocationManagerDelegate, UIPopoverPresentationControllerDelegate {
    
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var googleMapView: UIView!
    @IBOutlet weak var mapBtn: UIButton!
    @IBOutlet weak var satelliteBtn: UIButton!
    
    static var newInstance: MapViewVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? MapViewVC
        return vc
    }
    
    
    
    
    
    var gmsView: GMSMapView?
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        
        
        
    }
    
    func setupUI() {
        
        
        self.googleMapView.backgroundColor = .clear
        backButton.addTarget(self, action: #selector(backbtnAction), for: .touchUpInside)
        
        mapBtn.layer.cornerRadius = 4
        mapBtn.layer.borderWidth = 1
        mapBtn.layer.borderColor = UIColor.AppBorderColor.cgColor
        
        satelliteBtn.layer.cornerRadius = 4
        satelliteBtn.layer.borderWidth = 1
        satelliteBtn.layer.borderColor = UIColor.AppBorderColor.cgColor
        
        taponMapBtn()
        
        
        // Add the map view
        initializeGoogleMapView()
    }
    
    func initializeGoogleMapView() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        if !mapModelArray.isEmpty {
            let averageLatitude = mapModelArray.map { Double($0.latitude) ?? 0.0 }.reduce(0.0, +) / Double(mapModelArray.count)
            let averageLongitude = mapModelArray.map { Double($0.longitude) ?? 0.0 }.reduce(0.0, +) / Double(mapModelArray.count)
            
            let camera = GMSCameraPosition.camera(withLatitude: averageLatitude, longitude: averageLongitude, zoom: 12.0)
            gmsView = GMSMapView.map(withFrame: googleMapView.bounds, camera: camera)
            gmsView?.delegate = self
            
            if let gmsView = gmsView {
                googleMapView.addSubview(gmsView)
                addMarkersToMap(gmsView)
            }
        }
    }
    
    
    
    @objc func backbtnAction() {
        callapibool = false
        dismiss(animated: true)
    }
    
    
    @IBAction func didTaspOnShowMapViewBtnAction(_ sender: Any) {
           taponMapBtn()
        
    }
    
    func taponMapBtn() {
        mapBtn.setTitleColor(.WhiteColor, for: .normal)
        mapBtn.backgroundColor = .AppBtnColor
        
        satelliteBtn.setTitleColor(.black, for: .normal)
        satelliteBtn.backgroundColor = .WhiteColor
        
        switchToMapView()
        
    }
    
    
    @IBAction func didTapOnShowSatelliteViewBtnAction(_ sender: Any) {
        taponSatelliteBtn()
    }
    
    func taponSatelliteBtn() {
        satelliteBtn.setTitleColor(.WhiteColor, for: .normal)
        satelliteBtn.backgroundColor = .AppBtnColor
        
        mapBtn.setTitleColor(.black, for: .normal)
        mapBtn.backgroundColor = .WhiteColor
        
        switchToSatelliteView()
        
    }
    
    func switchToMapView() {
        if let mapView = googleMapView.subviews.first(where: { $0 is GMSMapView }) as? GMSMapView {
            mapView.mapType = .normal
        }
    }
    
    func switchToSatelliteView() {
        if let mapView = googleMapView.subviews.first(where: { $0 is GMSMapView }) as? GMSMapView {
            mapView.mapType = .satellite
        }
    }
    
    
}




// Implementing GMSMapViewDelegate
extension MapViewVC: GMSMapViewDelegate {
    
    func createMarkerButton(mapModel: MapModel) -> UIButton {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40) // Adjust size as needed
        button.setImage(UIImage(named: "hotel")?.withRenderingMode(.alwaysOriginal).withTintColor(.BooknowBtnColor), for: .normal) // Set your marker image here
        button.addTarget(self, action: #selector(markerButtonTapped(_:)), for: .touchUpInside)
        button.tag = mapModel.identifier // Assuming each mapModel has a unique identifier
        return button
    }
    
    func addMarkersToMap(_ mapView: GMSMapView) {
        for mapModel in mapModelArray {
            if let latitude = Double(mapModel.latitude), let longitude = Double(mapModel.longitude) {
                // Create and configure markers based on the mapModel data
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                marker.title = mapModel.hotelname
                marker.userData = mapModel
                mapView.delegate = self
                
                
                // Assign the custom button as the marker's icon view
                let markerButton = createMarkerButton(mapModel: mapModel)
                marker.iconView = markerButton
                
                // Add the marker to the map
                marker.map = mapView
            } else {
                print("Error: Invalid latitude or longitude values in mapModel.")
            }
        }
    }
    
    
    
    
    func findMapModelByIdentifier(_ identifier: Int) -> MapModel? {
        // Implement this function to find and return the MapModel by its identifier
        return mapModelArray.first { $0.identifier == identifier }
    }
    
    
    
    @objc func markerButtonTapped(_ sender: UIButton) {
        
        
        guard let mapModel = findMapModelByIdentifier(sender.tag) else {
            print("Map model not found for tag \(sender.tag)")
            return
        }
        
        print("Map model found: \(mapModel.hotelname)")
        
        let popVC = MapHotelInfoVC()
        popVC.modalPresentationStyle = .popover
        popVC.mapModel = mapModel
        
        if let popOverVC = popVC.popoverPresentationController {
            popOverVC.delegate = self
            popOverVC.sourceView = sender
            popOverVC.sourceRect = sender.bounds
            popOverVC.permittedArrowDirections = .up
            popVC.preferredContentSize = CGSize(width: 200, height: 200)
        } else {
            print("PopoverPresentationController is nil")
        }
        
        self.present(popVC, animated: true, completion: nil)
        print("Popover presented")
    }
    
    
}


extension MapViewVC {
    
    
//    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
//        // Handle marker tap event here
//        if let mapModel = marker.userData as? MapModel {
//            let popVC = MapHotelInfoVC()
//            popVC.modalPresentationStyle = .popover
//            popVC.mapModel = mapModel
//            
//            if let popOverVC = popVC.popoverPresentationController {
//                popOverVC.delegate = self
//                
//                // Set source view and source rect
//                popOverVC.sourceView = mapView
//                popOverVC.sourceRect = CGRect(x: 0, y: 0, width: 1, height: 1)
//                
//                // If the marker has an icon view, use its bounds to set the sourceRect
//                if let iconView = marker.iconView {
//                    popOverVC.sourceRect = mapView.convert(iconView.bounds, from: iconView)
//                } else {
//                    // Fallback: use the marker's position on the map view
//                    let point = mapView.projection.point(for: marker.position)
//                    popOverVC.sourceRect = CGRect(x: point.x, y: point.y, width: 1, height: 1)
//                }
//                
//                // Set arrow direction and content size
//                popOverVC.permittedArrowDirections = .up
//                popVC.preferredContentSize = CGSize(width: 200, height: 200)
//            }
//            
//            self.present(popVC, animated: true, completion: nil)
//        }
//        
//        return true // Return true to consume the tap event
//    }
    
    
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}
