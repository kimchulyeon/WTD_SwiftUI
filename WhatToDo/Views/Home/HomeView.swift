//
//  HomeView.swift
//  WhatToDo
//
//  Created by chulyeon kim on 2023/06/08.
//

import SwiftUI

struct HomeView: View {
    //MARK: - PROPERTY ==================
    @StateObject var locationManager: LocationManager
    
    //MARK: - BODY ==================
    var body: some View {
        TabView {
            //MARK: - 날씨 ==================
            NavigationView {
                WeatherView(viewModel: WeatherViewModel(locationManager: self.locationManager))
            }//{NavigationView}
            .tabItem {
                VStack {
                    Image(systemName: "sun.max.circle")
                    Text("날씨")
                }//{VStack}
            }//{tabItem}
            
            //MARK: - 2 ==================
            Text("hello")
            .tabItem {
                VStack {
                    Image(systemName: "film.circle")
                    Text("영화")
                }//{VStack}
            }//{tabItem}
            
            //MARK: - 3 ==================
            Text("hello")
            .tabItem {
                VStack {
                    Image(systemName: "map.circle")
                    Text("내 주변")
                }//{VStack}
            }//{tabItem}

            //MARK: - 4 ==================
            Text("hello")
            .tabItem {
                VStack {
                    Image(systemName: "person.circle")
                    Text("프로필")
                }//{VStack}
            }//{tabItem}
        }//{TabView}
        .tint(Color.MyColor.primary)
        .onAppear(perform: {
            CommonUtil.shared.configureNavigationBar()
            CommonUtil.shared.configureTabBar()
        })//{onAppear}
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(locationManager: LocationManager())
    }
}
