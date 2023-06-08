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
    }
}
