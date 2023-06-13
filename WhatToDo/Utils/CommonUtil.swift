//
//  CommonUtil.swift
//  WhatToDo
//
//  Created by chulyeon kim on 2023/06/09.
//

import Foundation
import SwiftUI

class CommonUtil {
    static let shared = CommonUtil()

    private init() { }

    /// 네비게이션 바 투명
    func configureNavigationBar() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.shadowColor = .clear
        navigationBarAppearance.shadowImage = UIImage()
        navigationBarAppearance.backgroundColor = UIColor(white: 1, alpha: 0.98)
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
    }
    
    /// 탭바 배경 고정
    func configureTabBar() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        tabBarAppearance.shadowColor = .clear
        tabBarAppearance.shadowImage = UIImage()
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        UITabBar.appearance().standardAppearance = tabBarAppearance
    }
}
