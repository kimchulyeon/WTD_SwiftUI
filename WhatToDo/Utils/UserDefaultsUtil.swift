//
//  UserDefaultsService.swift
//  WhatToDo
//
//  Created by chulyeon kim on 2023/06/09.
//

import Foundation

class UserDefaultsUtil {
    static let shared = UserDefaultsUtil()

    private init() { }

    /// UsefDefaults에 name email userUID provider 저장
    func setAuthInfo(_ name: String, _ email: String, _ userUID: String, _ docID: String, _ provider: String) {
        UserDefaults.standard.setValue(name, forKey: CommonConstant.name)
        UserDefaults.standard.setValue(email, forKey: CommonConstant.email)
        UserDefaults.standard.setValue(docID, forKey: CommonConstant.docID)
        UserDefaults.standard.setValue(userUID, forKey: CommonConstant.userUID)
        UserDefaults.standard.setValue(provider, forKey: CommonConstant.provider)
    }
}
