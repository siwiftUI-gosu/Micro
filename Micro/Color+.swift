//
//  Color+.swift
//  Micro
//
//  Created by pinocchio22 on 2/21/25.
//

import SwiftUI

extension Color {
    static let primitive = Primitive()
    static let button = Button()
    static let label = Label()
    static let overlay = Overlay()

    struct Primitive {
        let green = Color(red: 19/255, green: 189/255, blue: 126/255, opacity: 1)
        let lightGreen = Color(red: 19/255, green: 189/255, blue: 126/255, opacity: 0.1)
        let black = Color(red: 0/255, green: 0/255, blue: 0/255, opacity: 1)
        let darkGray = Color(red: 108/255, green: 108/255, blue: 108/255, opacity: 1)
        let lightGray = Color(red: 224/255, green: 224/255, blue: 224/255, opacity: 1)
        let white = Color(red: 255/255, green: 255/255, blue: 255/255, opacity: 1)
    }

    struct Button {
        let backgroud = Background()
        let text = Text()
        
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
        let overlay = Color(red: 0/255, green: 0/255, blue: 0/255, opacity: 0.2)
    }
}

