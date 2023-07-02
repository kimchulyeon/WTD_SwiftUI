//
//  HourWeatherView.swift
//  WhatToDo
//
//  Created by chulyeon kim on 2023/06/13.
//

import SwiftUI
import WeatherKit

struct HourWeatherView: View {
    let hourWeather: [HourWeather]
    
    var body: some View {
        ForEach(self.hourWeather, id: \.date) { weather in
            HourWeatherItemView(weather: weather)
        }
    }//{body}
}

//struct HourWeatherView_Previews: PreviewProvider {
//    static var previews: some View {
//        HourWeatherView()
//    }
//}
