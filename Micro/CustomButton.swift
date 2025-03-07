//
//  CustomButton.swift
//  Micro
//
//  Created by pinocchio22 on 2/21/25.
//

import SwiftUI

struct CustomButton: View {
    let title: String
    let foregroundColor: Color
    let backgroundColor: Color
    let borderColor: Color
    let isEnabled: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(Font.system(size: 16).weight(.bold))
                .multilineTextAlignment(.center)
                .foregroundColor(foregroundColor)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
//                .padding(.horizontal, 16)
//                .padding(.vertical, 10)
                .background(backgroundColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .inset(by: 0.5)
                        .stroke(borderColor, lineWidth: 1)
                )
                .cornerRadius(10)
        }
        .frame(maxWidth: .infinity, maxHeight: 52, alignment: .center)
        .disabled(!isEnabled)
    }
}
