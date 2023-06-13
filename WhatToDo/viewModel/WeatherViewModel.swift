//
//  WeatherViewModel.swift
//  WhatToDo
//
//  Created by chulyeon kim on 2023/06/13.
//

import Foundation
import SwiftUI
import WeatherKit
import Combine
import CoreLocation

class WeatherViewModel: ObservableObject {
    @Published var cityName: String = ""
    @Published var currentTemperature: String = ""
    @Published var lowTemperature: String = ""
    @Published var highTemperature: String = ""
    @Published var weatherImage: UIImage = UIImage(named: "haze")!
    @Published var weather: Weather?

    var cancellables = Set<AnyCancellable>()

    let locationManager: LocationManager
    let weatherService = WeatherService.shared

    init(locationManager: LocationManager) {
        self.locationManager = locationManager
        subscribeToLocationUpdates()
    }

    private func subscribeToLocationUpdates() {
        locationManager.$currentLocation
            .compactMap { $0 }
            .sink { location in
                Task {
                    do {
                        await self.setCityName(location: location)
                        try await self.configureUI(with: location)
                    } catch {
                        print("❌ Error while get current location with \(error.localizedDescription)")
                    }
                }
        }
        .store(in: &cancellables)
    }

    @MainActor func setCityName(location: CLLocation) async {
        if let cityName = await locationManager.getCityName(location: location) {
            self.cityName = cityName
        }
    }

    @MainActor func configureUI(with location: CLLocation) async throws {
        self.weather = try await weatherService.weather(for: location)
        self.currentTemperature = self.weather?.currentWeather.temperature.description ?? "-"

        guard let forecast = self.weather?.dailyForecast.forecast else {
            print("❌ Error no forecast")
            return
        }

        let todayForecast = forecast.filter { DateUtil.formatDate(date: $0.date) == DateUtil.formatDate(date: Date()) }

        if let lowTemp = todayForecast.first?.lowTemperature,
           let highTemp = todayForecast.first?.highTemperature {

            self.lowTemperature = lowTemp.description
            self.highTemperature = highTemp.description
        }
    }
}
