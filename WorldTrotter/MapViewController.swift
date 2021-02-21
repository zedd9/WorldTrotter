//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by 신현욱 on 2021/02/21.
//

import UIKit
import MapKit

class MapViewController : UIViewController, MKMapViewDelegate
{
    var mapView: MKMapView!
    var locationManager:CLLocationManager!
    var userLocation: UISwitch!
    var nextPin: UIButton!
    
    var annoBorn = MKPointAnnotation()
    var annoCurrent = MKPointAnnotation()
    var annoInterest = MKPointAnnotation()
    
    var curAnnoIndex = 0
    
    override func loadView() {
        mapView = MKMapView()
        
        view = mapView
        
        let segmentedControl = UISegmentedControl(items: ["Standard", "hybrid", "Satellite"])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)
//        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor)
//        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor)

        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)

        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        segmentedControl.addTarget(self, action: #selector(mapTypeChanged(segControl:)), for: .valueChanged)
        
        
        locationManager = CLLocationManager()
        
        userLocation = UISwitch(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        userLocation.translatesAutoresizingMaskIntoConstraints = false
        mapView.addSubview(userLocation)
        
        userLocation.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant:20).isActive = true
        userLocation.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant:-20).isActive = true
        
        userLocation.addTarget(self, action: #selector(showUserLocation(showSwitch:)), for: .valueChanged)
        
        mapView.delegate = self
        
        annoBorn.coordinate.latitude = 37.715133
        annoBorn.coordinate.longitude = 126.734086
        annoBorn.title = "태어난 곳"

        annoCurrent.coordinate.latitude = 36.915133
        annoCurrent.coordinate.longitude = 128.8340
        annoCurrent.title = "현재 있는 곳"
        
        annoInterest.coordinate.latitude = 35.815133
        annoInterest.coordinate.longitude = 126.93
        annoInterest.title = "흥미로운 곳"
        mapView.addAnnotations([annoBorn, annoCurrent, annoInterest])
        
        nextPin = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 30))
        nextPin.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        nextPin.setTitle("다음 핀", for: .normal)
        
        nextPin.addTarget(self, action: #selector(nextPin(btn:)), for: .touchUpInside)
        nextPin.translatesAutoresizingMaskIntoConstraints = false
        mapView.addSubview(nextPin)
        
        nextPin.leadingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -50).isActive = true
        nextPin.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant:-20).isActive = true
        
    }
    
    @objc func nextPin(btn: UIButton)
    {
        //mapView
        switch curAnnoIndex {
        case 0:
            mapView.selectAnnotation(annoBorn, animated: true)
        case 1:
            mapView.selectAnnotation(annoCurrent, animated: true)
        case 2:
            mapView.selectAnnotation(annoInterest, animated: true)
        default:
            break
        }
        
        curAnnoIndex = curAnnoIndex + 1
        if curAnnoIndex > 2 {
            curAnnoIndex = 0
        }
    }
    
    @objc func showUserLocation(showSwitch: UISwitch)
    {
        mapView.showsUserLocation = showSwitch.isOn
    }
    
    @objc func mapTypeChanged(segControl: UISegmentedControl){
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MapViewController loaded its view.")
    }
    
    func mapViewWillStartLocatingUser(_ mapView: MKMapView)
    {
        locationManager.requestWhenInUseAuthorization()
    }

    func mapViewDidStopLocatingUser(_ mapView: MKMapView)
    {
        
    }
}
