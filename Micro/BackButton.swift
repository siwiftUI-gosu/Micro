//
//  BackButton.swift
//  Micro
//
//  Created by pinocchio22 on 3/19/25.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.dismiss) var dismiss
    @State private var isTapped = false

    var body: some View {
        Button(action: {
            dismiss()
        }) {
            Image("icon_leftBack")
                .frame(width: 24, height: 24)
                .scaleEffect(isTapped ? 1.1 : 1.0)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.1)) {
                        isTapped = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        isTapped = false
                        dismiss()
                    }
                }
        }
    }
}
