//
//  BookView.swift
//  Micro
//
//  Created by pinocchio22 on 3/4/25.
//

import SwiftUI

struct BookDetailView: View {
    @ObservedObject private var viewModel: BookViewModel
    @ObservedObject private var mainViewModel: MainViewModel
    @Environment(\.dismiss) var dismiss
    
    init(viewModel: BookViewModel, mainViewModel: MainViewModel) {
        self.viewModel = viewModel
        self.mainViewModel = mainViewModel
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
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
                        
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(maxWidth: .infinity, minHeight: 6, maxHeight: 6)
                        .background(Color.primitive.lightGray)
                        
                    VStack(alignment: .leading, spacing: 16) {
                        Text("도전했던 하나의 목표")
                            .font(Font.system(size: 16).weight(.bold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                        HStack {
                            BookTabButton(title: "전체(\(viewModel.totalGoalList.count))", isSelected: viewModel.selectedIndex == 0) {
                                viewModel.setIndex(index: 0)
                            }
                            BookTabButton(title: "달성(\(viewModel.completeGoalList.count))", isSelected: viewModel.selectedIndex == 1) {
                                viewModel.setIndex(index: 1)
                            }
                            BookTabButton(title: "미달성(\(viewModel.notCompleteGoalList.count))", isSelected: viewModel.selectedIndex == 2) {
                                viewModel.setIndex(index: 2)
                            }
                        }
                            
                        switch viewModel.selectedIndex {
                        case 0:
                            if viewModel.totalGoalList.count == 0 {
                                switch viewModel.goalState {
                                case .empty:
                                    emptyMessageView(title: viewModel.goalState.emptyTitle)
                                case .notComplete:
                                    emptyMessageView(title: viewModel.goalState.emptyTitle)
                                case .complete:
                                    emptyMessageView(title: viewModel.goalState.emptyTitle)
                                }
                            } else {
                                goalListView(goals: viewModel.totalGoalList)
                            }

                        case 1:
                            if viewModel.completeGoalList.count == 0 {
                                emptyMessageView(title: "아직 기록이 없어요 🥺")
                            } else {
                                goalListView(goals: viewModel.completeGoalList)
                            }
                                
                        case 2:
                            if viewModel.notCompleteGoalList.count == 0 {
                                emptyMessageView(title: "아직 기록이 없어요 🥺")
                            } else {
                                goalListView(goals: viewModel.notCompleteGoalList)
                            }
                            
                        default:
                            emptyMessageView(title: "아직 기록이 없어요 🥺")
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 40)
                    .padding(.bottom, 58 + 10)
                    .frame(maxWidth: .infinity)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            CustomButton(
                title: viewModel.goalState.title,
                foregroundColor: viewModel.goalState.foregroundColor,
                backgroundColor: viewModel.goalState.backgroundColor,
                borderColor: .clear,
                isEnabled: viewModel.goalState.isEnabled
            ) {
                viewModel.clickButton()
                if viewModel.goalState == .empty {
                    // 준영아 여기서 탭바 바꿔줘야해
//                    mainViewModel.setIndex(index: 0)
//                    dismiss()
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationDestination(isPresented: $viewModel.isPresentMakeView) {
            MakeBookView(viewModel: MakeBookViewModel(book: viewModel.book))
                .onDisappear {
                    viewModel.isPresentMakeView = false
                }
        }
        .customNavigationBar(title: viewModel.book.title ?? "책 이름")
    }
}

private extension BookDetailView {
    func emptyMessageView(title: String) -> some View {
        Text(title)
            .font(.system(size: 14))
            .foregroundStyle(Color.primitive.darkGray)
            .padding(.vertical, 40)
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.center)
    }
    
    func goalListView(goals: [Goal]) -> some View {
        VStack(spacing: 0) {
            ForEach(goals, id: \.iD) { goal in
                GoalListItem(
                    date: goal.createDate ?? Date(),
                    goal: goal.todayGoal ?? "No Goal",
                    isComplete: goal.isComplete
                )
            }
        }
    }
}

#Preview {
    let book = CoreDataRepository.shared.fetchBookList().first ?? Book(context: CoreDataRepository.shared.context)
    BookDetailView(viewModel: BookViewModel(book: book), mainViewModel: MainViewModel())
        .onAppear {
            print(book)
        }
}
