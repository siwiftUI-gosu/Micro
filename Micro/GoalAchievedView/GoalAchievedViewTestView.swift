//
//  GoalAchievedViewTestView.swift
//  Micro
//
//  Created by SeoJunYoung on 2/26/25.
//

import SwiftUI

import SwiftUI

struct GoalAchievedViewTestView: View {
    @State private var isGoalAchievedViewVisible = false
    
    var body: some View {
        ZStack {
            VStack {
                Text("TempTextTempText")
                Text("TempTexTempTextt")
                Text("TempTextTempText")
                Text("TempTextTempText")

                Button("MoveToGoal") {
                    print("Tapped")
                    withAnimation {
                        isGoalAchievedViewVisible.toggle()
                    }
                }

                Text("TempTextTempText")
                Text("TempTextTempText")
                Text("TempTextTempText")
                Text("TempTextTempText")
            }
            .blur(radius: isGoalAchievedViewVisible ? 10 : 0)

            if isGoalAchievedViewVisible {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .transition(.opacity)
                
                GoalAchievedView(isGoalAchievedViewVisible: $isGoalAchievedViewVisible, todayGoalButtonAction: {
                    print("위에버튼 누를 때 동작쓰")
                })
                    .frame(maxWidth: .infinity, alignment: .center) // GoalAchievedView가 전체 너비를 차지하도록
                    .transition(.opacity)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    GoalAchievedViewTestView()
}

