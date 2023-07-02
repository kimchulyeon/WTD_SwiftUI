//
//  WeatherHeaderView.swift
//  WhatToDo
//
//  Created by chulyeon kim on 2023/06/13.
//

import SwiftUI

struct WeatherHeaderView: View {
    @State var cityName: String
    @State var date: String
    
    var body: some View {
        HStack {
            HStack {
                Image(uiImage: UIImage(named: "location-pin")!)
                    .resizable()
                    .frame(width: 30, height: 30)
                Text(self.cityName)
                    .foregroundColor(Color.MyColor.darkGray)
            }//{HStack}
            
            Spacer()
            
            Text(self.date)
                .foregroundColor(Color.MyColor.mediumGray)
        }//{HStack}
        .frame(height: 35)
        .padding(.horizontal)
    }//{body}
}

struct WeatherHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherHeaderView(cityName: "서울특별시", date: DateUtil.formatDateForToday(date: Date()))
            .previewLayout(.sizeThatFits)
    }
}
