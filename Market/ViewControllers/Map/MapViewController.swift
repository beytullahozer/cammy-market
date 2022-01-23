//
//  MapViewController.swift
//  Market
//
//  Created by Beytullah Özer on 24.12.2021.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: BaseViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let manager = CLLocationManager()
    
    let coordiantes = [
        CLLocationCoordinate2D(latitude: 41.047423, longitude: 28.987648),
        CLLocationCoordinate2D(latitude: 41.091425, longitude: 29.116824),
        CLLocationCoordinate2D(latitude: 40.993374, longitude: 29.055560),
        CLLocationCoordinate2D(latitude: 41.097464, longitude: 29.159313)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchLocation()
        
        coordiantes.forEach { coordinate in
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            mapView.addAnnotation(annotation)
        }
    }

    func fetchLocation() {
        
        manager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            manager.delegate = self
            manager.startUpdatingLocation()
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        
        if let coordinate = locations.last?.coordinate {
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: coordinate, span: span)
//            mapView.setRegion(region, animated: true)
            
            let camera = MKMapCamera(lookingAtCenter: coordinate, fromDistance: 50, pitch: 10, heading: .zero)
            mapView.setCamera(camera, animated: true)
        }
    }
}
