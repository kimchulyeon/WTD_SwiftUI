//
//  WeatherView.swift
//  WhatToDo
//
//  Created by chulyeon kim on 2023/06/09.
//

import SwiftUI
import WeatherKit

struct WeatherView: View {
    //MARK: - PROPERTY ==================
    @State var cityName: String = "seoul"
    @State var weatherImage: UIImage = UIImage(named: "haze")!
    @State var weather: Weather?
    
    @ObservedObject var locationManager: LocationManager

    let weatherService = WeatherService.shared

    //MARK: - BODY ==================
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 15) {
                Text(self.cityName.uppercased())
                    .font(.title2)

                Image(uiImage: self.weatherImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
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
        .task {
            do {
                let weather = try await self.weatherService.weather(for: .init(latitude: self.locationManager.latitude, longitude: self.locationManager.longitude))
                self.weather = weather
                print(weather)
            } catch {
                print("❌ Error while get current location with \(error.localizedDescription)")
            }
        }//{task}
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WeatherView(locationManager: LocationManager())
        }
    }
}
