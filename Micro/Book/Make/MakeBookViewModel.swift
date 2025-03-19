//
//  MakeBookViewModel.swift
//  Micro
//
//  Created by pinocchio22 on 3/13/25.
//

import SwiftUI

class MakeBookViewModel: ObservableObject {
    @Published var bookTitle = ""
    @Published var bookTitleState = MakeBookState.beforeEdit
    @Published var isPresentCompleteView = false
    
    func setState() {
        if bookTitle.isEmpty {
            bookTitleState = .beforeEdit
        } else {
            if bookTitle.count <= 9 {
                bookTitleState = .editing
            } else {
                bookTitleState = .disabled
            }
        }
    }
}

extension MakeBookViewModel {
    enum MakeBookState {
        case beforeEdit
        case editing
        case disabled
        
        var titleColor: Color {
            switch self {
            case .beforeEdit:
                    .clear
            case .editing:
                    .primitive.green
            case .disabled:
                Color(red: 249/250, green: 66/250, blue: 66/250)
            }
        }
        
        var btnTitle: String {
            switch self {
            case .beforeEdit, .editing:
                "책 만들기"
            case .disabled:
                "최대 9자까지 입력 가능해요"
            }
        }
        
        var btnForegroundColor: Color {
            switch self {
            case .editing:
                    .primitive.white
            case .disabled, .beforeEdit:
                    .primitive.darkGray
            }
        }
        
        var btnBackgroundColor: Color {
            switch self {
            case .editing:
                    .primitive.green
            case .disabled, .beforeEdit:
                    .primitive.lightGray
            }
        }
        
        var isBtnEnabled: Bool {
            switch self {
            case .editing:
                true
            case .disabled, .beforeEdit:
                false
            }
        }
    }
}
