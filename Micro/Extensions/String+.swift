//
//  String+.swift
//  Micro
//
//  Created by pinocchio22 on 3/5/25.
//

import SwiftUI

extension String {
    func toAttributedString(highlightText: String, color: Color) -> AttributedString {
        var attributedString = AttributedString(self)
        if let range = attributedString.range(of: highlightText) {
            attributedString[range].foregroundColor = color
        }
        return attributedString
    }
}
