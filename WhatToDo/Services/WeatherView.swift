//
//  WeatherView.swift
//  WhatToDo
//
//  Created by chulyeon kim on 2023/06/09.
//

import SwiftUI
import WeatherKit
import Combine
import CoreLocation

struct WeatherView: View {
    //MARK: - PROPERTY ==================
	@State var isShowAlert: Bool = false
    @ObservedObject var viewModel: WeatherViewModel

    //MARK: - BODY ==================
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            if self.viewModel.weather == nil {
                LottieView() // 로딩
                    .scaleEffect(0.2)
            } else {
                VStack(alignment: .center, spacing: 8) {
                    WeatherHeaderView(cityName: self.viewModel.cityName, date: self.viewModel.currentDate)
                    TodayWeatherView(weatherImage: self.viewModel.weatherImage,
                                     temperature: self.viewModel.currentTemperature,
                                     description: self.viewModel.description
                    )
                    ExtraWeatherInfoView(rainAmount: self.viewModel.rainAmount,
                                         rainChance: self.viewModel.rainChance,
                                         snowAmount: self.viewModel.snowAmount,
                                         windSpeed: self.viewModel.windSpeed)
                    CustomDividerView()
                        .padding(.vertical, 20)
                    
                    if let weatherHourly = self.viewModel.weatherHourly {
                        HourWeatherView(hourWeather: weatherHourly)
                    }
                    
                }//{VStack}
                .padding(.horizontal, 15)
            }
        }//{ScrollView}
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
					self.isShowAlert.toggle()
                } label: {
                    Image(systemName: "paperplane")
                        .tint(Color.MyColor.primary)
                }//{Button}
            }//{ToolbarItem}
        }//{toolbar}
		.alert("위치를 업데이트하시겠습니까?", isPresented: self.$isShowAlert, actions: {
			Button("OK", role: .destructive) {
                self.viewModel.locationManager.requestAgain()
			}//{Button}
		})//{alert}
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WeatherView(isShowAlert: false, viewModel: WeatherViewModel(locationManager: LocationManager()))
        }
    }
}
