//
//  ContentView.swift
//  WhatToDo
//
//  Created by chulyeon kim on 2023/06/08.
//

import SwiftUI

struct ContentView: View {
    //MARK: - PROPERTY ==================
    @AppStorage(CommonConstant.name) var name: String?
    
    @StateObject var locationManager = LocationManager()
    
    //MARK: - BODY ==================
    var body: some View {
        if self.name != nil {
            HomeView(locationManager: self.locationManager)
        } else {
            LoginView()
        }
    }
    
    //MARK: - FUNC ==================
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
