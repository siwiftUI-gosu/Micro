//
//  BookView.swift
//  Micro
//
//  Created by SeoJunYoung on 3/4/25.
//

import SwiftUI

struct BookView: View {
    @Binding var isEditMode: Bool
    var title: String?
    var isWrite: Bool
    var completePercent: Double
    @Binding var isSelected: Bool
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(spacing: 10) {
                ZStack(alignment: .topLeading) {
                    Rectangle()
                        .fill(Color(red: 0.94, green: 0.95, blue: 0.95))
                    
                    Rectangle()
                        .fill(Color(red: 0.07, green: 0.74, blue: 0.49))
                        .opacity(completePercent)
                    
                    GeometryReader { geometry in
                        Rectangle()
                            .fill(Color.black.opacity(0.1))
                            .frame(width: geometry.size.width / 4)
                    }
                    
                    if isWrite {
                        Text("작성 중")
                            .foregroundStyle(Color(red: 0.42, green: 0.42, blue: 0.42))
                            .font(.system(size: 12, weight: .regular))
                            .frame(width: 53, height: 26)
                            .background(Color.white)
                            .cornerRadius(6)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .offset(x: -8, y: 8)
                    }
                }
                .cornerRadius(6)
                
                Text(title ?? "")
                    .font(.system(size: 13, weight: isWrite ? .bold : .regular))
            }
            .scaleEffect(isSelected ? 0.8 : 1) // 크기 조정
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isSelected) // 스프링 애니메이션 적용
            
            if isSelected {
                Rectangle()
                    .fill(Color(red: 0.42, green: 0.42, blue: 0.42))
                    .opacity(isSelected ? 0.6 : 0)
                    .cornerRadius(6)
                    .animation(.easeInOut, value: isSelected)
            }
            
            if isEditMode && !isWrite {
                CheckBoxRadioButton(isSelected: isSelected)
                    .offset(x: 4, y: 4)
            }
        }
    }
}

#Preview {
    BookView(isEditMode: .constant(true), title: "테스트", isWrite: true, completePercent: 1, isSelected: .constant(true))
}


