//
//  MainViewModel.swift
//  Micro
//
//  Created by pinocchio22 on 2/22/25.
//

import SwiftUI

class MainViewModel: ObservableObject {
    @Published var text: String = ""
    @Published var buttonTitle: String = ""
    @Published var isButtonEnabled: Bool = false
    @Published var isShowToast: Bool = false
    @Published var selectedIndex: Int = 0
    @Published var textColor: Color = .primitive.green
    
    var attributedString: AttributedString {
        var string = AttributedString("오늘 단 하나,")
        if let this = string.range(of: "하나,") {
            string[this].foregroundColor = text.isEmpty ? .primitive.green : .primitive.black
        }
        return string
    }
    
    func setButtonEnable() {
        isButtonEnabled = !text.isEmpty
    }
    
    func setButtonTitle() {
        if text.isEmpty {
            buttonTitle = "목표를 작성해주세요"
        } else {
            buttonTitle = "작성 완료"
        }
    }
    
    func setTextColor() {
        textColor = text.count >= 43 ? Color(red: 249/255, green: 66/255, blue: 66/255) : .primitive.green
    }
    
    func showToast() {
        isShowToast = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.isShowToast = false
        }
    }
    
    func setIndex(index: Int) {
        selectedIndex = index
    }
}
