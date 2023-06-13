//
//  DateUtil.swift
//  WhatToDo
//
//  Created by chulyeon kim on 2023/06/13.
//

import Foundation

class DateUtil: NSObject {
    /// 날짜 포맷 yyyy-mm-dd
    static func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}
