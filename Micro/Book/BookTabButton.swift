//
//  BookTabButton.swift
//  Micro
//
//  Created by pinocchio22 on 3/4/25.
//

import SwiftUI

struct BookTabButton: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        HStack {
            Text(title)
                .font(Font.system(size: 14))
                .multilineTextAlignment(.center)
                .foregroundColor(isSelected ? .primitive.green : .primitive.darkGray)
                .frame(maxHeight: .infinity, alignment: .center)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 6)
        .frame(maxHeight: 33, alignment: .center)
        .background(isSelected ? Color.primitive.white : Color.primitive.lightGray)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .inset(by: 0.5)
                .stroke(isSelected ? Color.primitive.green : .clear, lineWidth: 1)
        )
        .cornerRadius(6)
        .onTapGesture {
            action()
        }
    }
}
