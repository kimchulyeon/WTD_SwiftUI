//
//  HourWeatherItemView.swift
//  WhatToDo
//
//  Created by chulyeon kim on 2023/06/13.
//

import SwiftUI
import WeatherKit

struct HourWeatherItemView: View {
    let weather: HourWeather
    
    var body: some View {
        HStack {
            Text("Wednesday")
            Image("haze")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
            Text("22")
            Text("12")
        }//{HStack}
    }//{body}
}

//struct HourWeatherItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        HourWeatherItemView()
//    }
//}
