//
//  BookViewModel.swift
//  Micro
//
//  Created by pinocchio22 on 3/4/25.
//

import SwiftUI

class BookViewModel: ObservableObject {
    @State var book: Book
    @Published var selectedIndex = 0
    @Published var goals = [Goal]()
    @Published var attributedText = AttributedString()
    @Published var goalState = GoalState.empty
    @Published var isPresentMakeView = false

    var goalList: [Goal] {
        switch selectedIndex {
        case 1:
            return goals.filter { $0.isComplete }
        case 2:
            return goals.filter { !$0.isComplete }
        default:
            return goals
        }
    }

    var totalGoalCount: Int { goalList.count }
    var completeGoalCount: Int { goals.filter { $0.isComplete }.count }
    var notCompleteGoalCount: Int { goals.filter { !$0.isComplete }.count }

    init(book: Book) {
        self.book = book
        fetchGoals(bookID: book.iD)
        setTodayGoal()
    }

    func setIndex(index: Int) {
        selectedIndex = index
    }

    func fetchGoals(bookID: UUID?) {
        goals = CoreDataRepository.shared.fetchGoals(bookID: bookID)
    }

    func setTodayGoal() {
        if let goal = CoreDataRepository.shared.fetchTodayGoal(),
           let todayGoal = goal.todayGoal {
            let string = goal.isComplete ? "\(todayGoal) 도전 완료🤸‍♂" : "\(todayGoal) 도전 중"
            attributedText = string.toAttributedString(highlightText: todayGoal, color: .primitive.green)
            goalState = goal.isComplete ? .complete : .notComplete
        } else {
            attributedText = "도전 중인 목표가 없어요".toAttributedString(highlightText: "도전 중인 목표가 없어요", color: .primitive.lightGray)
            goalState = .empty
        }
    }
    
    func clickButton() {
        switch goalState {
        case .complete:
            isPresentMakeView = true
        default:
            break
        }
    }
}

extension BookViewModel {
    enum GoalState {
        case complete
        case notComplete
        case empty
        
        var isEnabled: Bool {
            switch self {
            case .complete:
                return true
            case .notComplete:
                return false
            case .empty:
                return true
            }
        }
        
        var foregroundColor: Color {
            switch self {
            case .complete, .empty:
                return .primitive.white
            case .notComplete:
                return .primitive.darkGray
            }
        }
        
        var backgroundColor: Color {
            switch self {
            case .complete, .empty:
                return .primitive.green
            case .notComplete:
                return .primitive.lightGray
            }
        }
        
        var title: String {
            switch self {
            case .complete:
                return "8일의 도전들을 책으로 만들기"
            case .notComplete:
                return "오늘의 목표를 완료해주세요"
            case .empty:
                return "목표 설정하러 가기"
            }
        }
    }
}
