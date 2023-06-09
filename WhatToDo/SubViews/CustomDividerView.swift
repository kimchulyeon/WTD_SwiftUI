//
//  CustomDividerView.swift
//  WhatToDo
//
//  Created by chulyeon kim on 2023/06/09.
//

import SwiftUI

struct CustomDividerView: View {
    var body: some View {
        Capsule()
            .fill(Color.MyColor.primary)
            .frame(height: 2, alignment: .center)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 10)
    }
}

struct CustomDividerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomDividerView()
            .previewLayout(.sizeThatFits)
    }
}
