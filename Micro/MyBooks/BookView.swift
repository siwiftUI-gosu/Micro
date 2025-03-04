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
        VStack(spacing: 10) {
            ZStack(alignment: .topLeading) { // 기본 정렬을 topLeading으로 설정
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
                        .frame(maxWidth: .infinity, alignment: .trailing) // 오른쪽 정렬
                        .offset(x: -8, y: 8) // 위쪽 여백만 설정
                } else {
                    if isEditMode {
                        CheckBoxRadioButton(isSelected: isSelected)
                            .offset(x: 4, y: 4)
                    }
                }
            }
            .cornerRadius(6)
            
            Text(title ?? "")
                .font(.system(size: 13, weight: isWrite ? .bold : .regular))
        }
    }
}

#Preview {
    BookView(isEditMode: .constant(true), title: "테스트", isWrite: true, completePercent: 1, isSelected: .constant(true))
}

