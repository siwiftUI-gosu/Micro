//
//  CustomButton.swift
//  Micro
//
//  Created by pinocchio22 on 2/21/25.
//

import SwiftUI

struct CustomButton: View {
    let title: String
    let isEnabled: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(Font.system(size: 16).weight(.bold))
                .multilineTextAlignment(.center)
                .foregroundColor(isEnabled ? .button.text.primary : .button.text.disabled)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(isEnabled ? Color.primitive.green : Color.button.backgroud.disabled)
                .cornerRadius(10)
        }
        .frame(width: .infinity, height: 52, alignment: .center)
        .disabled(!isEnabled)
    }
}
