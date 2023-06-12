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
    @State var cityName: String = ""
    @State var temperature: String = ""
    @State var weatherImage: UIImage = UIImage(named: "haze")!
	@State var weather: Weather?
	@State var isShowAlert: Bool = false

    @ObservedObject var locationManager: LocationManager

    let weatherService = WeatherService.shared

    //MARK: - BODY ==================
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            if self.weather == nil {
                LottieView()
                    .scaleEffect(0.2)
            } else {
                VStack(alignment: .center, spacing: 8) {
                    Image(uiImage: self.weatherImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)

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
					self.isShowAlert.toggle()
                } label: {
                    Image(systemName: "paperplane.fill")
                        .tint(Color.MyColor.primary)
                }//{Button}
            }//{ToolbarItem}
			ToolbarItem(placement: .navigationBarLeading) {
				HStack {
					Image(systemName: "mappin.and.ellipse")
						.foregroundColor(Color.MyColor.primary)
					Text(self.cityName)
						.foregroundColor(Color.MyColor.primary)
				}//{HStack}
			}//{ToolbarItem}
        }//{toolbar}
		.alert("위치를 업데이트하시겠습니까?", isPresented: self.$isShowAlert, actions: {
			Button("OK", role: .destructive) {
				self.locationManager.requestAgain()
			}//{Button}
		})//{alert}
        .onAppear {
			self.locationManager.$currentLocation
                .compactMap { $0 }
                .sink { location in
                    Task {
                        do {
							if let cityName = await self.locationManager.getCityName(location: location) {
								self.cityName = cityName
							}
							
                            guard let location = self.locationManager.currentLocation else {
                                print("❌ NO LOCATION")
                                return
                            }
                            let weather = try await self.weatherService.weather(for: location)
							print("🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀")
							print(weather)

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
