//
//  LocationUtil.swift
//  WhatToDo
//
//  Created by chulyeon kim on 2023/06/09.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject {
    @Published var authorizationStatus: CLAuthorizationStatus?
    
    var latitude: Double {
        return self.locationManager.location?.coordinate.latitude ?? 37.5519
    }
    
    var longitude: Double {
        return self.locationManager.location?.coordinate.longitude ?? 126.9918
    }
    
    private let locationManager = CLLocationManager()
    
    //MARK: - INIT ==================
    override init() {
        super.init()
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
//        self.locationManager.requestAlwaysAuthorization()
//        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
        self.locationManager.delegate = self
    }
}

//MARK: - EXTENSION ==================
extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            self.authorizationStatus = .notDetermined
            self.locationManager.requestLocation()
            break
        case .restricted:
            self.authorizationStatus = .restricted
            break
        case .denied:
            self.authorizationStatus = .denied
            break
        case .authorizedAlways:
            self.authorizationStatus = .authorizedAlways
            self.locationManager.requestLocation()
        case .authorizedWhenInUse:
            self.authorizationStatus = .authorizedWhenInUse
            self.locationManager.requestLocation()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("❌ Error while requesting locating with \(error.localizedDescription)")
    }
}
