//
//  LoginHeaderView.swift
//  WhatToDo
//
//  Created by chulyeon kim on 2023/06/08.
//

import SwiftUI

struct LoginHeaderView: View {
    var body: some View {
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
        .padding(.top, 60)

        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("오늘 날씨는 어떤지")
                    .font(.callout)
                Text("주변에 뭐가 있나")
                    .font(.callout)
                Text("요즘 볼만한 영화는 뭐가 있는지")
                    .font(.callout)
            }//{VStack}
            .padding(.leading, 20)
            Spacer()
        }//{HStack}
        .padding(.top)
    }
}

struct LoginHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoginHeaderView()
    }
}
