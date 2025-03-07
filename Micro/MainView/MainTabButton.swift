//
//  TabButton.swift
//  Micro
//
//  Created by pinocchio22 on 3/4/25.
//

import SwiftUI

struct MainTabButton: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Text(title)
                .font(isSelected ? Font.system(size: 16).weight(.bold) : Font.system(size: 16))
                .multilineTextAlignment(.center)
                .foregroundColor(isSelected ? .primitive.black : .primitive.darkGray)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 10)
        .frame(width: 56, height: 48, alignment: .center)
        .overlay(
            Rectangle()
                .frame(height: 4)
                .foregroundColor(isSelected ? .primitive.black : .clear),
            alignment: .bottom
        )
        .onTapGesture {
            action()
        }
    }
}
