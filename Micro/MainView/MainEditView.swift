//
//  MainEditView.swift
//  Micro
//
//  Created by pinocchio22 on 3/7/25.
//

import SwiftUI

struct MainEditView: View {
    @StateObject var viewModel: MainViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Text(viewModel.attributedString)
                .font(Font.system(size: 32).weight(.bold))
                .foregroundColor(.primitive.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                
            if !viewModel.isTextFieldHidden {
                TextField("목표를 작성해주세요", text: $viewModel.goalText, axis: .vertical)
                    .font(Font.system(size: 32).weight(.bold))
                    .foregroundColor(viewModel.textColor)
                    .frame(maxWidth: .infinity, maxHeight: 58, alignment: .leading)
                    .background(Color.primitive.white)
                    .cornerRadius(Constants.button.largeRadius)
                    .onChange(of: viewModel.goalText) {
                        viewModel.setState(state: .editing)
                        viewModel.setButtonEnable()
                        viewModel.setTextColor()
                    }
                    .disabled(viewModel.state != .editing && viewModel.state != .beforeEdit)
                    .background(
                        GeometryReader { geometry in
                            Color.clear
                                .onAppear {
                                    let frame = geometry.frame(in: .global)
                                    viewModel.textFieldX = frame.midX - 16
                                    viewModel.textFieldY = frame.midY - viewModel.safeHeight + 16 + 10
                                }
                        }
                    )
            }
                
            Text(viewModel.secondLabelText)
                .font(Font.system(size: 32).weight(.bold))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                
            Spacer()
                
            if viewModel.isShowToast {
                CustomToast(title: "달성까지 화이팅! 💪️", direction: .downToUp, function: .noti)
                    .padding(.vertical, 16)
            }
                
            CustomButton(title: viewModel.state.btnTitle, foregroundColor: viewModel.state.btnForegroundColor, backgroundColor: viewModel.state.btnBackgroundColor, borderColor: viewModel.state.btnBorderColor, isEnabled: viewModel.isButtonEnabled) {
                viewModel.clickButton()
            }
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .onAppear {
                            viewModel.buttonY = geometry.frame(in: .global).midY - viewModel.safeHeight
                        }
                }
            )
        }
    }
}
