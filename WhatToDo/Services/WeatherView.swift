//
//  WeatherView.swift
//  WhatToDo
//
//  Created by chulyeon kim on 2023/06/09.
//

import SwiftUI
import WeatherKit
import Combine

struct WeatherView: View {
    //MARK: - PROPERTY ==================
    @State var cancellables = Set<AnyCancellable>()

    @State var cityName: String = "seoul"
    @State var temperature: String = ""
    @State var weatherImage: UIImage = UIImage(named: "haze")!
    @State var weather: Weather?

    @ObservedObject var locationManager: LocationManager

    let weatherService = WeatherService.shared

    //MARK: - BODY ==================
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            if self.weather == nil {
                LottieView()
                    .scaleEffect(0.4)
            } else {
                VStack(alignment: .center, spacing: 8) {
                    Text(self.cityName.uppercased())
                        .font(.title2)

                    Image(uiImage: self.weatherImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)

                    HStack(alignment: .center) {
                        VStack(alignment: .center) {
                            Text("최저온도")
                                .font(.callout)
                                .foregroundColor(Color.MyColor.darkGray)
                            CustomDividerView()
                            Text(self.temperature)
                                .font(.title3)
                        }//{VStack}
                        Spacer()
                        VStack(alignment: .center) {
                            Text("현재온도")
                                .font(.callout)
                                .foregroundColor(Color.MyColor.darkGray)
                            CustomDividerView()
                            Text(self.temperature)
                                .font(.title3)
                        }//{VStack}
                        Spacer()
                        VStack(alignment: .center) {
                            Text("최고온도")
                                .font(.callout)
                                .foregroundColor(Color.MyColor.darkGray)
                            CustomDividerView()
                            Text(self.temperature)
                                .font(.title3)
                        }//{VStack}
                    }//{HStack}
                    .padding(.horizontal, 45)
                }//{VStack}
            }
        }//{ScrollView}
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // 사용자 위치
                } label: {
                    Image(systemName: "paperplane.fill")
                        .tint(Color.MyColor.primary)
                }//{Button}
            }//{ToolbarItem}
        }//{toolbar}
        .onAppear {
            locationManager.currentLocationDidSet
                .compactMap { $0 }
                .sink { location in
                    Task {
                        do {
                            guard let location = self.locationManager.currentLocation else {
                                print("❌ NO LOCATION")
                                return
                            }
                            let weather = try await self.weatherService.weather(for: location)

                            self.weather = weather
                            self.temperature = self.weather?.currentWeather.temperature.description ?? "-"
//                            print(self.weather?.currentWeather.date)
//                            print(self.weather?.dailyForecast.forecast)
//                            print(self.weather?.hourlyForecast.forecast)
//                            print(self.weather?.minuteForecast?.forecast)
//                            print(weather)
                        } catch {
                            print("❌ Error while get current location with \(error.localizedDescription)")
                        }
                    }//{Task}
            }//{sink}
            .store(in: &cancellables)
        }//{onAppear}
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WeatherView(locationManager: LocationManager())
        }
    }
}
