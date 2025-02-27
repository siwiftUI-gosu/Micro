//
//  MainViewModel.swift
//  Micro
//
//  Created by pinocchio22 on 2/22/25.
//

import SwiftUI

class MainViewModel: ObservableObject {
    @Published var firstLabelText: String = "오늘 단 하나,"
    @Published var goalText: String = ""
    @Published var secondLabelText: String = "을/를 할거야"
    @Published var isButtonEnabled: Bool = false
    @Published var isShowToast: Bool = false
    @Published var selectedIndex: Int = 0
    @Published var textColor: Color = .primitive.green

    @Published var state: MainViewState = .beforeEdit
    @Published var isTextFieldHidden = false
    
    // coachMark
    @Published var tabItemX: CGFloat = 0
    @Published var tabItemY: CGFloat = 0
    @Published var textFieldX: CGFloat = 0
    @Published var textFieldY: CGFloat = 0
    @Published var buttonY: CGFloat = 0
    
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
        switch state {
        case .beforeEdit, .editing:
            self.state = goalText.isEmpty ? .beforeEdit : .editing
        default:
            if state == .completEdit {
                isShowToast = true
                print(Timer().timeInterval)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) { [weak self] in
                    print(print(Timer().timeInterval))
                    self?.isShowToast = false
                }
            }
            self.state = state
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
            setState(state: .completEdit)
        case .completEdit:
            isTextFieldHidden = true
            setState(state: .achieveGoal)
            firstLabelText = "하나의 목표와 함께"
            secondLabelText = "내일 다시 뵈어요 ✨"
        case .achieveGoal:
            break
        }
    }
    
    func setIndex(index: Int) {
        selectedIndex = index
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
                .primitive.lightGray
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
                .primitive.darkGray
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
