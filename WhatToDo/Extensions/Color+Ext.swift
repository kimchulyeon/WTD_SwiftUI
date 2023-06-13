//
//  Color+Ext.swift
//  WhatToDo
//
//  Created by chulyeon kim on 2023/06/08.
//

import Foundation
import SwiftUI

extension Color {
    struct MyColor {
        static var primary: Color {
            return Color(red: 95/255, green: 65/255, blue: 245/255)
        }
        
        static var mediumGray: Color {
            return Color(red: 150/255, green: 150/255, blue: 150/255)
        }
        
        static var darkGray: Color {
            return Color(red: 80/255, green: 80/255, blue: 80/255)
        }
        
        static var lightGray: Color {
            return Color(red: 200/255, green: 200/255, blue: 200/255)
        }
        
        static var weakBlue: Color {
            return Color(red: 235/255, green: 242/255, blue: 255/255, opacity: 0.3)
        }
        
        static var weakBlueShadow: Color {
            return Color(red: 0/255, green: 0/255, blue: 0/255, opacity: 0.2)
        }
        
        static var myWhite: Color {
                return  Color(red: 240 / 255, green: 240 / 255, blue: 245 / 255)
        }
        
        static var myBlack: Color {
            return  Color(red: 28 / 255, green: 28 / 255, blue: 30 / 255)
        }
    }
}
