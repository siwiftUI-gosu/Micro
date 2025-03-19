//
//  MainViewModel.swift
//  Micro
//
//  Created by pinocchio22 on 2/22/25.
//

import SwiftUI

class MainViewModel: ObservableObject {
    @Published var todayGoal: Goal?
    @Published var writingBook: Book
    
    @Published var firstLabelText: String = "오늘 단 하나,"
    @Published var goalText: String = ""
    @Published var secondLabelText: String = "을/를 할거야"
    @Published var isButtonEnabled: Bool = false
    @Published var isShowToast: Bool = false
    @Published var isShowAchievedView: Bool = false
    @Published var selectedIndex: Int = 0
    @Published var textColor: Color = .primitive.green
    
    @Published var isPresentDetailView = false

    @Published var state: MainViewState = .beforeEdit
    @Published var isTextFieldHidden = false
    
    // coachMark
    @Published var isCoachMarkVisible = true
    @Published var safeHeight: CGFloat = 0
    @Published var tabItemX: CGFloat = 0
    @Published var tabItemY: CGFloat = 0
    @Published var textFieldX: CGFloat = 0
    @Published var textFieldY: CGFloat = 0
    @Published var buttonY: CGFloat = 0
    
    init(writingBook: Book? = nil) {
        self.writingBook = CoreDataRepository.shared.fetchWritingBook() ?? CoreDataRepository.shared.createNewBook(title: "작성중", createDate: Date(), goalList: [], iD: UUID())
        fetchFirstAccessStatus()
    }
    
    var attributedString: AttributedString {
        var string = AttributedString(firstLabelText)
        switch state {
        case .beforeEdit:
            if let this = string.range(of: "하나,") {
                string[this].foregroundColor = goalText.isEmpty ? .primitive.green : .primitive.black
            }
        case .achieveGoal:
            if let this = string.range(of: "하나의 목표와 함께") {
                string[this].foregroundColor = .primitive.green
            }
        default:
            break
        }
        
        return string
    }
    
    func setState(state: MainViewState) {
        self.state = state

        switch state {
        case .beforeEdit, .editing:
            self.state = goalText.isEmpty ? .beforeEdit : .editing

        case .completEdit:
            isShowToast = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) { [weak self] in
                withAnimation {
                    self?.isShowToast = false
                }
            }
            break

        case .achieveGoal:
            isTextFieldHidden = true
            firstLabelText = "하나의 목표와 함께"
            secondLabelText = "내일 다시 뵈어요 ✨"
        }
    }
    
    func setButtonEnable() {
        isButtonEnabled = !goalText.isEmpty
    }
    
    func setTextColor() {
        textColor = goalText.count >= 43 ? Color(red: 249/255, green: 66/255, blue: 66/255) : .primitive.green
    }
    
    func clickButton() {
        switch state {
        case .beforeEdit:
            break
        case .editing:
            saveGoal()
            setState(state: .completEdit)
            guard let goal = todayGoal else { return }
            CoreDataRepository.shared.updateGoal(createDate: goal.createDate, iD: goal.iD, isComplete: false, todayGoal: goalText, book: goal.book)
        case .completEdit:
            DispatchQueue.main.async { [weak self] in
                withAnimation {
                    self?.isShowAchievedView = true
                }
            }
            setState(state: .achieveGoal)
            guard let goal = todayGoal else { return }
            CoreDataRepository.shared.updateGoal(createDate: goal.createDate, iD: goal.iD, isComplete: true, todayGoal: goalText, book: goal.book)
        case .achieveGoal:
            isPresentDetailView = true
            break
        }
    }
    
    func setIndex(index: Int) {
        selectedIndex = index
    }
    
    func fetchFirstAccessStatus() {
        isCoachMarkVisible = !CoreDataRepository.shared.fetchFirstAccess()
        if isCoachMarkVisible {
            CoreDataRepository.shared.createFirstAccess()
        }
        fetchTodayGoal()
        setButtonEnable()
    }
    
    func fetchTodayGoal() {
        todayGoal = CoreDataRepository.shared.fetchTodayGoal()
        if let goal = todayGoal,
           let todayGoal = goal.todayGoal
        {
            goalText = todayGoal
            if goal.isComplete {
                setState(state: .achieveGoal)
            } else {
                state = .completEdit
            }
        }
    }
    
    func saveGoal() {
        todayGoal = CoreDataRepository.shared.createNewGoal(createDate: Date(), iD: UUID(), isComplete: false, todayGoal: goalText, book: writingBook)
    }
}

extension MainViewModel {
    enum MainViewState {
        case beforeEdit
        case editing
        case completEdit
        case achieveGoal
        
        var btnTitle: String {
            switch self {
            case .beforeEdit:
                "목표를 작성해주세요"
            case .editing:
                "작성 완료"
            case .completEdit:
                "목표 달성"
            case .achieveGoal:
                "책에 등록된 오늘 목표 보기"
            }
        }
        
        var btnForegroundColor: Color {
            switch self {
            case .beforeEdit:
                .primitive.darkGray
            case .editing:
                .primitive.green
            case .completEdit:
                .primitive.white
            case .achieveGoal:
                .primitive.white
            }
        }
        
        var btnBackgroundColor: Color {
            switch self {
            case .beforeEdit:
                .primitive.lightGray
            case .editing:
                .primitive.white
            case .completEdit:
                .primitive.green
            case .achieveGoal:
                .primitive.green
            }
        }
        
        var btnBorderColor: Color {
            switch self {
            case .editing:
                .primitive.green
            default:
                .clear
            }
        }
    }
}
