//
//  LocationUtil.swift
//  WhatToDo
//
//  Created by chulyeon kim on 2023/06/09.
//

import Foundation
import CoreLocation
import Combine
import UIKit

class LocationManager: NSObject, ObservableObject {
	@Published var authorizationStatus: CLAuthorizationStatus? {
		didSet {
			print("📌 현재 상태 : \(String(describing: self.authorizationStatus))")
		}
	}
	@Published var currentLocation: CLLocation? {
		didSet {
			print("✅ 현재 위치 : \(String(describing: self.currentLocation))")
		}
	}

	private let locationManager = CLLocationManager()
	private let SEOUL_LOCATION: CLLocation = CLLocation(latitude: 37.5519, longitude: 126.9918)

	//MARK: - INIT ==================
	override init() {
		super.init()

		self.locationManager.delegate = self
		self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
		self.locationManager.distanceFilter = kCLDistanceFilterNone

		if
		self.locationManager.authorizationStatus == .authorizedAlways ||
			self.locationManager.authorizationStatus == .notDetermined ||
			self.locationManager.authorizationStatus == .authorizedWhenInUse {

			self.locationManager.requestAlwaysAuthorization()
			self.locationManager.requestWhenInUseAuthorization()
			self.locationManager.startUpdatingLocation()
		}
	}
}

//MARK: - DELEGATE ==================
extension LocationManager: CLLocationManagerDelegate {
	func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
		switch manager.authorizationStatus {
		case .notDetermined:
			self.authorizationStatus = .notDetermined
			self.locationManager.requestLocation()
			break
		case .restricted:
			self.authorizationStatus = .restricted
			self.currentLocation = self.SEOUL_LOCATION
			break
		case .denied:
			self.authorizationStatus = .denied
			self.currentLocation = self.SEOUL_LOCATION
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
		guard let location = locations.last, self.currentLocation != self.SEOUL_LOCATION else { return }

		DispatchQueue.main.async {
			self.currentLocation = location
		}
	}

	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		if let error = error as? CLError {
			switch error.code {
			case .denied:
				print("❌ Error Location authorization denied with \(error.localizedDescription)")
			case .network:
				print("❌ Error network with \(error.localizedDescription)")
			default:
				print("❌ Error unknown location with \(error.localizedDescription)")
			}
		} else {
			print("❌ Error while requesting locating with \(error.localizedDescription)")
		}
	}
}

//MARK: - EXTENSION ==================
extension LocationManager {
	/// 툴바 종이비행기 클릭 사용자 위치 업데이트 (denied일 경우 설정 페이지 이동)
	func requestAgain() {
		switch self.authorizationStatus {
		case .notDetermined, .restricted, .denied:
            // 앱 설정 페이지로 이동
			guard let url = URL(string: UIApplication.openSettingsURLString) else { return }

			if UIApplication.shared.canOpenURL(url) {
				UIApplication.shared.open(url)
			}
		case .authorizedAlways, .authorizedWhenInUse:
			// 위치 업데이트
			self.locationManager.startUpdatingLocation()
			break
		default:
			break
		}
	}

	/// 사용자 위치 도시명 가져오기
	func getCityName(location: CLLocation) async -> String? {
		let geocoder = CLGeocoder()

		let placemarks = try? await geocoder.reverseGeocodeLocation(location)

		if let placemark = placemarks?.first, let city = placemark.locality {
			print(city)
			return city
		} else {
			return nil
		}
	}
}
