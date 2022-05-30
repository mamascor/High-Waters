//
//  ViewController.swift
//  High Waters
//
//  Created by Marco Mascorro on 5/29/22.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    
    
    //MARK: - Properties
    private var floods = [FloodModel]() {
        didSet{
           configureAnnotation()
        }
    }
    
    private lazy var locationManager = CLLocationManager()
    
    private lazy var map: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus")?.withTintColor(.white), for: .normal)
        button.backgroundColor = .black
        button.tintColor = .white
        button.layer.cornerRadius = 60 / 2
        button.setDimensions(width: 60, height: 60)
        button.addTarget(self, action: #selector(handleAnotation), for: .touchUpInside)
        return button
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        fetchData()
        configureUserLocation()
        configureUI()
    }

    //MARK: - Selectors
    @objc func handleAnotation(){
        guard let location = locationManager.location else { return }
        
        
        let coordinate = location.coordinate
        let flood = Flood(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        FloodService.shared.uploadFloor(location: flood) { success in
            if success {
                self.addAnotation(coordinate.latitude, coordinate.longitude)
            }
        }
        
    }
    
    
    
    //MARK: - Helpers
    private func configureUI(){
        view.addSubview(map)
        map.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        view.addSubview(button)
        button.centerX(inView: view)
        button.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 20)
        
    }
    
    private func configureUserLocation(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        
        locationManager.requestWhenInUseAuthorization()
        
        map.showsUserLocation = true
        map.delegate = self
        
        locationManager.startUpdatingLocation()
        locationManager.stopUpdatingLocation()
        
    }
    
    private func addAnotation(_ lad: CLLocationDegrees,_ lon: CLLocationDegrees){
        let floodAnotation = MKPointAnnotation()
        floodAnotation.coordinate = CLLocationCoordinate2D(latitude: lad, longitude: lon)
        map.addAnnotation(floodAnotation)
    }
    
    private func fetchData(){
        FloodService.shared.fetchFloodData { floods in
            self.floods = floods
        }
    }
    
    private func configureAnnotation(){
        for i in 0..<(floods.count) {
             let latitude = floods[i].latitude
             let longitude = floods[i].longitude
            
            DispatchQueue.main.async {
                self.addAnotation(latitude, longitude)
            }
                    
                    
        }
    }


}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first  else { return  }
        let coordinate = location.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        map.setRegion(region, animated: true)
       
    }
}

extension ViewController: MKMapViewDelegate{
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//
//    }
}
