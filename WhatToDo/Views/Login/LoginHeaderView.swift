//
//  LoginHeaderView.swift
//  WhatToDo
//
//  Created by chulyeon kim on 2023/06/08.
//

import SwiftUI

struct LoginHeaderView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("습관처럼 꺼내는 앱")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("왓투두에서 편리하게")
                        .font(.title)
                        .fontWeight(.bold)
                }//{VStack}
                .padding(.leading, 20)
                Spacer()
            }//{HStack}

            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    HStack(spacing: 0) {
                        Text("오늘 ")
                        Text("날씨")
                            .foregroundColor(Color.MyColor.primary)
                            .fontWeight(.bold)
                        Text("는 어떤지")
                    }
                        .font(.callout)
                    HStack(spacing: 0) {
                        Text("주변")
                            .foregroundColor(Color.MyColor.primary)
                            .fontWeight(.bold)
                        Text("에 뭐가 있나")
                    }
                        .font(.callout)
                    HStack(spacing: 0) {
                        Text("요즘 볼만한 ")
                        Text("영화")
                            .foregroundColor(Color.MyColor.primary)
                            .fontWeight(.bold)
                        Text("는 뭐가 있는지")
                    }
                        .font(.callout)
                }//{VStack}
                .padding(.leading, 20)
                Spacer()
            }//{HStack}
            .padding(.top, 10)
        }//{VStack}
        .padding(.top, 60)
    }
}

struct LoginHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoginHeaderView()
    }
}
