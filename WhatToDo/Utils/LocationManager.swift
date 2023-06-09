//
//  LocationUtil.swift
//  WhatToDo
//
//  Created by chulyeon kim on 2023/06/09.
//

import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject {
    @Published var authorizationStatus: CLAuthorizationStatus?
    @Published var currentLocation: CLLocation? {
        didSet {
            self.currentLocationDidSet.send(self.currentLocation)
        }
    }
    
    private let locationManager = CLLocationManager()
    
    let currentLocationDidSet = PassthroughSubject<CLLocation?, Never>()
    
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
        guard let location = locations.last, self.currentLocation == nil else { return }
        
        DispatchQueue.main.async {
            self.currentLocation = location
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if self.currentLocation == nil {
            return
        }
        print("❌ Error while requesting locating with \(error.localizedDescription)")
    }
}
