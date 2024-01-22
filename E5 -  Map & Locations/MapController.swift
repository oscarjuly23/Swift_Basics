//
//  mapController.swift
//  oscar.julian_bernat.segura
//
//  Created by Alumne on 02/11/2021.
//

import Foundation
import UIKit
import MapKit

class MapController : UIViewController {
    
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var map: MKMapView!
    
    var locationManager : CLLocationManager?
    var auth : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Location
        initLocation()
        
        // Map
        initMap()
        
        //SeearchBar
        self.txtField.delegate = self
        
    }
    
    @IBAction func btnSearch(_ sender: UIButton?) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = txtField.text
        
        searchRequest.region = map.region
        
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { response, error in
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error").")
                return
            }

            let place = response.mapItems.first?.placemark
                
            self.setLocation(place!.coordinate, place?.title)
        }
    }
    
    @IBAction func btnCurrLocation(_ sender: UIButton) {
        if auth {
            locationManager?.requestLocation()
        } else {
            print("L'usuari ens ha denegat l'acces a la ubi")
        }
    }
    
    func initLocation () {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        let status = locationManager?.authorizationStatus
        
        switch status {
        case .notDetermined:
            locationManager?.requestWhenInUseAuthorization()
        case .restricted, .denied:
            print("L'usuari es nega a cedir l'ubicacio!")
            auth = false
        case .authorizedAlways, .authorizedWhenInUse, .authorized:
            print("Tenim l'autorització de l'usuari")
            auth = true
        default:
            print("")
        }
    }
    
    func initMap () {
        let location = CLLocation(latitude: 41.408981, longitude: 2.129499)
        
        setLocation(location.coordinate, "Home")
    }
    
    func setLocation(_ coordinate: CLLocationCoordinate2D ,_ title: String?) {
        //Movem el mapa
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: CLLocationDistance(1000) , longitudinalMeters: CLLocationDistance(1000))
        
        map.setRegion(region, animated: true)
        
        //Borrem totes les anotacions existents
        self.map.removeAnnotations(self.map.annotations)
        
        //Creem la nova anotacio
        let annotation = MKPointAnnotation()
        annotation.title = title
        annotation.coordinate = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        map.addAnnotation(annotation)
        
    }
}

extension MapController : CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        let status = locationManager?.authorizationStatus
        
        switch status {
        case .notDetermined:
            locationManager?.requestWhenInUseAuthorization()
        case .restricted, .denied:
            print("L'usuari es nega a cedir l'ubicacio!")
            auth = false
        case .authorizedAlways, .authorizedWhenInUse, .authorized:
            print("Tenim l'autorització de l'usuari")
            auth = true
        default:
            print("")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            setLocation(location.coordinate, "You are here")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
  
    }
}

extension MapController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtField.resignFirstResponder()
        
        btnSearch(nil)
        
        return true
        
    }
}
