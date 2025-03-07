//
//  BookView.swift
//  Micro
//
//  Created by pinocchio22 on 3/4/25.
//

import SwiftUI

struct BookDetailView: View {
    @ObservedObject private var viewModel: BookViewModel
    
    init(viewModel: BookViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("나는 오늘")
                    .font(Font.system(size: 16).weight(.bold))
                Text(viewModel.attributedText)
                    .font(Font.system(size: 34).weight(.bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 40)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity)
        
        Rectangle()
            .foregroundColor(.clear)
            .frame(maxWidth: .infinity, minHeight: 6, maxHeight: 6)
            .background(Color.primitive.lightGray)
        
        VStack(alignment: .leading, spacing: 16) {
            Text("도전했던 하나의 목표")
                .font(Font.system(size: 16).weight(.bold))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                BookTabButton(title: "전체(\(viewModel.totalGoalCount))", isSelected: viewModel.selectedIndex == 0) {
                    viewModel.setIndex(index: 0)
                }
                BookTabButton(title: "달성(\(viewModel.completeGoalCount))", isSelected: viewModel.selectedIndex == 1) {
                    viewModel.setIndex(index: 1)
                }
                BookTabButton(title: "미달성(\(viewModel.notCompleteGoalCount))", isSelected: viewModel.selectedIndex == 2) {
                    viewModel.setIndex(index: 2)
                }
            }
            
            switch viewModel.goalState {
            case .empty:
                Text("아직 도전한 목표가 없어요 😞")
                    .font(Font.system(size: 14))
                    .foregroundStyle(Color.primitive.darkGray)
                    .padding(.vertical, 40)
                    .padding(.horizontal, 16)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                Spacer()
            case .notComplete:
                Text("하루가 지나면 이 곳에서 볼 수 있어요! 💪")
                    .font(Font.system(size: 14))
                    .foregroundStyle(Color.primitive.darkGray)
                    .padding(.vertical, 40)
                    .padding(.horizontal, 16)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                Spacer()
            case .complete:
                List {
                    ForEach(viewModel.goalList, id: \.iD) { goal in
                        GoalListItem(date: goal.createDate ?? Date(), goal: goal.todayGoal ?? "No Goal", isComplete: goal.isComplete)
                            .listRowInsets(EdgeInsets())
                    }
                }
                .scrollIndicators(.never)
                .listStyle(.plain)
                .padding(0)
            }
            
            CustomButton(title: viewModel.goalState.title, foregroundColor: viewModel.goalState.foregroundColor, backgroundColor: viewModel.goalState.backgroundColor, borderColor: .clear, isEnabled: viewModel.goalState.isEnabled) {}
        }
        .padding(.horizontal, 16)
        .padding(.top, 40)
    }
}

#Preview {
    let book = CoreDataRepository.shared.fetchBookList().first ?? Book(context: CoreDataRepository.shared.context)
    BookDetailView(viewModel: BookViewModel(book: book))
        .onAppear {
            print(book)
        }
}
