//
//  LoginView.swift
//  WhatToDo
//
//  Created by chulyeon kim on 2023/06/08.
//

import SwiftUI

struct LoginView: View {
    //MARK: - BODY ==================
    var body: some View {
        VStack {
            LoginHeaderView()
            Spacer()
            VStack(spacing: 12) {
                Button {

                } label: {
                    AppleLoginButton()
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(6)
                        .padding(.horizontal)
                }//{Button}

                Button {
                    
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
                    .background(Color(red: 249/255, green: 123/255, blue: 90/255))
                    .cornerRadius(6)
                    .padding(.horizontal)
                    .font(.system(size: 22, weight: .medium, design: .default))
                }//{Button}
            }//{VStack}
            .padding(.bottom, 30)
        }//{VStack}
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
