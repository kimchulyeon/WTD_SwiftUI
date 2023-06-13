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

    let weatherService = WeatherService.shared

    //MARK: - BODY ==================
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            if self.viewModel.weather == nil {
                LottieView() // 로딩
                    .scaleEffect(0.2)
            } else {
                VStack(alignment: .center, spacing: 8) {
                    Image(uiImage: self.viewModel.weatherImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)

                    HStack(alignment: .center) {
                        VStack(alignment: .center) {
                            Text("최저온도")
                                .font(.callout)
                                .foregroundColor(Color.MyColor.darkGray)
                            CustomDividerView()
                            Text(self.viewModel.lowTemperature)
                                .font(.title3)
                        }//{VStack}
                        Spacer()
                        VStack(alignment: .center) {
                            Text("현재온도")
                                .font(.callout)
                                .foregroundColor(Color.MyColor.darkGray)
                            CustomDividerView()
                            Text(self.viewModel.currentTemperature)
                                .font(.title3)
                        }//{VStack}
                        Spacer()
                        VStack(alignment: .center) {
                            Text("최고온도")
                                .font(.callout)
                                .foregroundColor(Color.MyColor.darkGray)
                            CustomDividerView()
                            Text(self.viewModel.highTemperature)
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
                    Text(self.viewModel.cityName)
						.foregroundColor(Color.MyColor.primary)
				}//{HStack}
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
            WeatherView(viewModel: WeatherViewModel(locationManager: LocationManager()))
        }
    }
}
