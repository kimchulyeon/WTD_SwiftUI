//
//  CommonButton.swift
//  WhatToDo
//
//  Created by chulyeon kim on 2023/06/08.
//

import SwiftUI

struct CommonButton: View {
    var title: String = ""
    var buttonAction: () -> Void
    
    var body: some View {
        Button(self.title) {
            self.buttonAction()
        }//{Button}
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .background(Color.MyColor.primary)
        .cornerRadius(16)
        .padding(.horizontal)
        .font(.title3)
//        .foregroundColor(.white)
        .foregroundColor(.white)
    }
}

struct CommonButton_Previews: PreviewProvider {
    static var previews: some View {
        CommonButton(title: "Hello World", buttonAction: {
            print("Hello World")
        })
            .previewLayout(.sizeThatFits)
    }
}
