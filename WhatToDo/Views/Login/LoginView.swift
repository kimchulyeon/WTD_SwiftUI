//
//  LoginView.swift
//  WhatToDo
//
//  Created by chulyeon kim on 2023/06/08.
//  소셜 로그인 => 파이어베이스 로그인 => 파이어스토어 저장 => UserDefaults 저장

import SwiftUI

struct LoginView: View {
    //MARK: - Property ==================
    @State var isShowErrorAlert: Bool = false
    
    //MARK: - BODY ==================
    var body: some View {
        VStack {
            LoginHeaderView()
            Spacer()
            VStack(spacing: 12) {
                Button {
                    AppleService.shared.startSignInWithAppleFlow(view: self)
                } label: {
                    AppleLoginButton()
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(6)
                        .padding(.horizontal)
                }//{Button}

                Button {
                    GoogleService.shared.startSignInWithGoogle(view: self)
                } label: {
                    HStack {
                        Image("google")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                        Text("Sign in with Google")
                    }//{HStack}
                    .tint(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(Color(red: 99/255, green: 202/255, blue: 242/255))
                    .cornerRadius(6)
                    .padding(.horizontal)
                    .font(.system(size: 22, weight: .medium, design: .default))
                }//{Button}
            }//{VStack}
            .padding(.bottom, 30)
        }//{VStack}
        .alert("로그인에 실패하였습니다", isPresented: self.$isShowErrorAlert) {
            Button("OK", role: .cancel, action: {})
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
