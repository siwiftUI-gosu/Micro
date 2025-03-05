//
//  CheckBoxRadioButton.swift
//  Micro
//
//  Created by SeoJunYoung on 3/4/25.
//

import SwiftUI

struct CheckBoxRadioButton: View {
    var isSelected: Bool
    
    var body: some View {
        ZStack {
            Image(isSelected ? "checkBoxRadioButton_selected" : "checkBoxRadioButton_default")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
        }
    }
}
