//
//  ToastView.swift
//  Micro
//
//  Created by SeoJunYoung on 3/5/25.
//

import SwiftUI

struct ToastView: View {
    var message: String
    var backgroundColor: Color
    var textCoolor: Color
    
    var body: some View {
        Text(message)
            .font(.system(size: 14, weight: .regular))
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(backgroundColor)
            .foregroundColor(textCoolor)
            .cornerRadius(10)
//            .padding(.top, 24) // 화면 상단에 위치
            .frame(maxWidth: .infinity)
            .transition(.move(edge: .top).combined(with: .opacity)) // 애니메이션 효과 추가
    }
}

#Preview {
    ToastView(message: "삭제되었습니다! 🗑️", backgroundColor: Color(red: 0.957, green: 0.957, blue: 0.957), textCoolor: .black)
}

