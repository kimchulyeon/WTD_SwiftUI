//
//  ExtraWeatherInfoView.swift
//  WhatToDo
//
//  Created by chulyeon kim on 2023/06/13.
//

import SwiftUI

struct ExtraWeatherInfoView: View {
    @State var rainAmount: String
    @State var rainChance: String
    @State var snowAmount: String
    @State var windSpeed: String
    
    
    //MARK: - BODY ==================
    var body: some View {
        HStack {
            VStack(spacing: 6) {
                Image("umbrella")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                Text(self.rainAmount)
                    .font(.headline)
                Text("비")
                    .font(.callout)
                    .foregroundColor(Color.MyColor.darkGray)
            }//{VStack}
            Spacer()
            if self.snowAmount != "0.0 mm" {
                VStack(spacing: 6) {
                    Image("snow-info")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    Text(self.snowAmount)
                        .font(.headline)
                    Text("눈")
                        .font(.callout)
                        .foregroundColor(Color.MyColor.darkGray)
                }//{VStack}
                Spacer()
            }
            VStack(spacing: 6) {
                Image("wind")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                Text(self.windSpeed)
                    .font(.headline)
                Text("바람")
                    .font(.callout)
                    .foregroundColor(Color.MyColor.darkGray)
            }//{VStack}
            Spacer()
            VStack(spacing: 6) {
                Image("dust")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                Text("40%")
                    .font(.headline)
                Text("미세먼지")
                    .font(.callout)
                    .foregroundColor(Color.MyColor.darkGray)
            }//{VStack}
        }//{HStack}
        .padding()
        .background(Color.MyColor.weakBlue)
        .cornerRadius(15)
        .shadow(color: Color.MyColor.weakBlueShadow, radius: 6, y: 6)
    }//{body}
}

struct ExtraWeatherInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ExtraWeatherInfoView(rainAmount: "1mm", rainChance: "0.02", snowAmount: "1mm", windSpeed: "1km")
    }
}
