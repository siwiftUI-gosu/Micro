//
//  GoalListItem.swift
//  Micro
//
//  Created by pinocchio22 on 3/4/25.
//

import SwiftUI

struct GoalListItem: View {
    var date: Date
    var goal: String
    var isComplete: Bool

    var body: some View {
        HStack(spacing: 8) {
            Text(date.toString())
                .font(Font.system(size: 14))
                .foregroundColor(.primitive.darkGray)
            Text(goal)
                .font(Font.system(size: 14))
            Spacer()
            Text(isComplete ? "달성" : "미달성")
                .font(Font.system(size: 13))
                .padding(.horizontal, 6)
                .padding(.vertical, 4)
                .frame(width: 48, height: 28)
                .foregroundColor(isComplete ? Color.primitive.white : Color.primitive.darkGray)
                .background(isComplete ? Color.primitive.green : Color.primitive.lightGray)
                .cornerRadius(6)
        }
        .padding(.vertical, 16)
        .frame(maxWidth: .infinity, alignment: .top)
    }
}
