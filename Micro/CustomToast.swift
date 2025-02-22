//
//  CustomToast.swift
//  Micro
//
//  Created by pinocchio22 on 2/22/25.
//

import SwiftUI

struct CustomToast: View {
    let title: String
    let direction: ToastDirection
    let function: ToastFunction
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            Text(title)
                .font(
                    Font.custom("SF Pro", size: 14)
                        .weight(.bold)
                )
                .multilineTextAlignment(.center)
                .foregroundColor(function == .noti ? .primitive.green : .primitive.black)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(function == .noti ? Color.primitive.lightGreen : Color.primitive.lightGray)
        .cornerRadius(10)
        .fixedSize()
    }
}

extension CustomToast {
    enum ToastDirection {
        case upToDown
        case downToUp
    }
    
    enum ToastFunction {
        case noti
        case delete
    }
}

#Preview {
    CustomToast(title: "달성까지 화이팅! ‍💪️", direction: .downToUp, function: .noti)
}
