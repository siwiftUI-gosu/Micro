//
//  GoalAchievedView.swift
//  Micro
//
//  Created by SeoJunYoung on 2/26/25.
//

import SwiftUI

struct GoalAchievedView: View {
    
    @Binding var isGoalAchievedViewVisible: Bool
    var todayGoalButtonAction: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            Text("축하해요! 🎉")
                .font(.system(size: 32, weight: .bold))
                .foregroundStyle(.white)
                .frame(maxHeight: 51)
            
            Text("하나의 목표를 마쳤어요")
                .font(.system(size: 26, weight: .bold))
                .foregroundStyle(.white)
                .frame(maxHeight: 39)
            
            Rectangle().frame(height: 64).foregroundStyle(Color.clear)
            
            Button(action: {
                withAnimation {
                    todayGoalButtonAction()
                    isGoalAchievedViewVisible.toggle()
                }
            }) {
                Text("책에 등록된 오늘 목표 보기")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .padding() // 버튼 내부 콘텐츠 패딩
                    .frame(maxWidth: .infinity) // 내부 콘텐츠가 전체 너비를 차지하도록
                    .background(Color.button.backgroud.primary)
                    .cornerRadius(10)
            }
            .frame(maxWidth: .infinity, maxHeight: 52) // 버튼 자체의 크기 설정
            .padding(.horizontal, 10) // 좌우 패딩으로 여백 확보
            Rectangle().frame(height: 8).foregroundStyle(Color.clear)
            Button(action: {
                withAnimation {
                    isGoalAchievedViewVisible.toggle()
                }
            }) {
                Text("목표로 돌아가기")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color.button.backgroud.primary)
                    .padding() // 버튼 내부 콘텐츠 패딩
                    .frame(maxWidth: .infinity) // 내부 콘텐츠가 전체 너비를 차지하도록
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.button.backgroud.primary, lineWidth: 1) // 둥근 테두리 적용
                    )
                    
            }
            .frame(maxWidth: .infinity, maxHeight: 52) // 버튼 자체의 크기 설정
            .padding(.horizontal, 10) // 좌우 패딩으로 여백 확보
            
        }
        .frame(maxWidth: .infinity) // VStack 전체가 부모 너비를 차지하도록
    }
}

#Preview {
    GoalAchievedView(isGoalAchievedViewVisible: .constant(true), todayGoalButtonAction: {
        print("Tapped")
    })
}
