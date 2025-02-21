//
//  Color+.swift
//  Micro
//
//  Created by pinocchio22 on 2/21/25.
//

import SwiftUI

extension Color {
    static let primitive = Primitive()
    static let label = Label()
    static let overlay = Overlay()

    struct Primitive {
        let green = Color(red: 19, green: 189, blue: 126, opacity: 1)
        let lightGreen = Color(red: 19, green: 189, blue: 126, opacity: 0.1)
        let black = Color(red: 0, green: 0, blue: 0, opacity: 1)
        let darkGray = Color(red: 108, green: 108, blue: 108, opacity: 1)
        let lightGray = Color(red: 224, green: 224, blue: 224, opacity: 1)
        let white = Color(red: 255, green: 255, blue: 255, opacity: 1)
    }

    struct Button {
        static let backgroud = Background()
        static let text = Text()
        
        struct Background {
            let primary = primitive.green
            let secondary = primitive.white
            let disabled = primitive.lightGray
        }
        
        struct Text {
            let primary = primitive.white
            let secondary = primitive.green
            let disabled = primitive.darkGray
        }
    }
    
    struct Label {
        let primary = primitive.lightGreen
    }
    
    struct Overlay {
        let overlay = Color(red: 0, green: 0, blue: 0, opacity: 0.2)
    }
}

