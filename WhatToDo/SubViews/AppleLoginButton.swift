//
//  AppleLoginButton.swift
//  WhatToDo
//
//  Created by chulyeon kim on 2023/06/08.
//

import Foundation
import SwiftUI
import AuthenticationServices

struct AppleLoginButton: UIViewRepresentable {
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        return ASAuthorizationAppleIDButton(authorizationButtonType: .default, authorizationButtonStyle: .black)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
