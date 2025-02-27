//
//  Constants.swift
//  Micro
//
//  Created by pinocchio22 on 2/21/25.
//

import SwiftUI

struct Constants {
    static let button = Button()
    static let label = Label()
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    
    struct Button {
        let border: CGFloat = 1
        let largeRadius: CGFloat = 10
    }
    
    struct Label {
        let smallRadius: CGFloat = 6
    }
}
