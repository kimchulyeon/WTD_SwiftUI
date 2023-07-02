//
//  TodayWeatherView.swift
//  WhatToDo
//
//  Created by chulyeon kim on 2023/06/13.
//

import SwiftUI

struct TodayWeatherView: View {
    @State var weatherImage: UIImage
    @State var temperature: String
    @State var description: String
    
    var body: some View {
        HStack {
            Image(uiImage: self.weatherImage)
                .resizable()
                .scaledToFit()
            
            VStack {
                Text(self.temperature)
                    .font(.system(size: 35))
                    .fontWeight(.bold)
                
                Text(self.description)
                    .font(.system(size: 20))
                    .foregroundColor(Color.MyColor.mediumGray)
                    .minimumScaleFactor(0.6)
            }//{VStack}
            .padding(.trailing, 15)
        }//{HStack}
        .frame(height: 200)
        .frame(maxWidth: .infinity)
    }//{body}
}

struct TodayWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        TodayWeatherView(weatherImage: UIImage(named: "haze")!, temperature: "20", description: "Very Cloudy")
            .previewLayout(.sizeThatFits)
    }
}
