//
//  CommonButton.swift
//  WhatToDo
//
//  Created by chulyeon kim on 2023/06/08.
//

import SwiftUI

struct CommonButton: View {
    var title: String = ""
    var isSystemImageNeed: Bool
    var isAssetImageNeed: Bool
    var buttonColor: Color = Color.MyColor.primary
    var fontColor: Color = Color.white
    var buttonAction: () -> Void
    
    var body: some View {
        Button {
            self.buttonAction()
        } label: {
            HStack {
                if self.isSystemImageNeed {
                    Image(systemName: "globe")
                } else if self.isAssetImageNeed {
                    Image("google")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                }//{if}
                Text(self.title)
            }//{HStack}
            .tint(self.fontColor)
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .background(self.buttonColor)
            .cornerRadius(6)
            .padding(.horizontal)
            .font(.title3)
        }
    }
}

struct CommonButton_Previews: PreviewProvider {
    static var previews: some View {
        CommonButton(title: "Sign in with Google", isSystemImageNeed: false, isAssetImageNeed: true, buttonAction: {})
            .previewLayout(.sizeThatFits)
    }
}
