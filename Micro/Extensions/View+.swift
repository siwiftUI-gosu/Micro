//
//  View+.swift
//  Micro
//
//  Created by pinocchio22 on 3/19/25.
//

import SwiftUI

extension View {
    func customNavigationBar(title: String, showBackButton: Bool = true) -> some View {
        self
            .navigationBarBackButtonHidden(true)
            .toolbar {
                if showBackButton {
                    ToolbarItem(placement: .navigationBarLeading) {
                        BackButton()
                    }
                }

                ToolbarItem(placement: .principal) {
                    Text(title)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(Color.primitive.black)
                }
            }
    }
}
