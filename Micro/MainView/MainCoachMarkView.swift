//
//  MainCoachMarkView.swift
//  Micro
//
//  Created by pinocchio22 on 3/7/25.
//

import SwiftUI

struct MainCoachMarkView: View {
    @StateObject var viewModel: MainViewModel
    
    var body: some View {
        if viewModel.isCoachMarkVisible {
            // coachMark backGround
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.primitive.black)
                .opacity(0.66)
                
            // coachMark
            ZStack {
                ZStack {
                    Circle()
                        .foregroundColor(.primitive.white)
                        .frame(maxWidth: 48, maxHeight: 48)
                        .overlay {
                            Text("내 책")
                                .frame(width: 40, height: 28)
                        }
                        .position(x: viewModel.tabItemX, y: viewModel.tabItemY)
                       
                    Image("icon_cancel")
                        .frame(width: 40, height: 40)
                        .position(x: Constants.screenWidth - 40, y: viewModel.tabItemY)
                        .onTapGesture {
                            viewModel.isCoachMarkVisible = false
                        }
                        
                    HStack {
                        Image("icon_arrow1")
                            
                        Text("예전 목표들은 이곳에서\n확인할 수 있어요.")
                            .font(Font.system(size: 14).weight(.bold))
                            .foregroundColor(.white)
                    }
                    // 화살표 가로 24, 텍스트 가로 137
                    .position(x: viewModel.tabItemX + 28 + (24 + 137) / 2, y: viewModel.tabItemY + 28 + 4)
                }
                    
                VStack(spacing: 0) {
                    TextField("목표를 작성해주세요", text: $viewModel.goalText) {}
                        .padding(.horizontal, 4)
                        .padding(.vertical, 10)
                        .font(Font.system(size: 32).weight(.bold))
                        .background(Color.primitive.white)
                        .cornerRadius(Constants.button.largeRadius)
                        .disabled(true)
                        .frame(maxWidth: .infinity, maxHeight: 58)
                        
                    HStack {
                        Image("icon_arrow2")
                            
                        Spacer()
                            .frame(width: Constants.screenWidth / 3)
                    }
                        
                    Spacer()
                        .frame(height: 7)
                        
                    HStack(spacing: 0) {
                        Text("하루에 ")
                            .font(Font.system(size: 16).weight(.bold))
                            .foregroundColor(.white)
                        Text("하나의 목표만")
                            .font(Font.system(size: 16).weight(.bold))
                            .foregroundColor(.primitive.green)
                        Text(" 작성하고")
                            .font(Font.system(size: 16).weight(.bold))
                            .foregroundColor(.white)
                    }
                }
                .position(x: viewModel.textFieldX, y: viewModel.textFieldY)
                    
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Text("목표를 ")
                            .font(Font.system(size: 16).weight(.bold))
                            .foregroundColor(.white)
                        Text("달성")
                            .font(Font.system(size: 16).weight(.bold))
                            .foregroundColor(.primitive.green)
                        Text("하면 눌러주세요.")
                            .font(Font.system(size: 16).weight(.bold))
                            .foregroundColor(.white)
                    }
                        
                    Spacer()
                        .frame(height: 9)
                        
                    Image("icon_arrow3")
                }
                .position(x: Constants.screenWidth / 2 - 16, y: viewModel.buttonY - 6 - 56)
                    
                CustomButton(title: "목표를 달성했어요", foregroundColor: .primitive.white, backgroundColor: .primitive.green, borderColor: .clear, isEnabled: false) {}
                    .position(x: Constants.screenWidth / 2 - 16, y: viewModel.buttonY)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 16)
        }
    }
}
