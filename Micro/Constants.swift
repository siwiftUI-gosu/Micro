//
//  Constants.swift
//  Micro
//
//  Created by pinocchio22 on 2/21/25.
//

import Foundation

struct Constants {
    static let button = Button()
    static let label = Label()
    
    struct Button {
        let border: CGFloat = 1
        let largeRadius: CGFloat = 10
    }
    
    struct Label {
        let smallRadius: CGFloat = 6
    }
}
