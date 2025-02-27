//
//  MainView.swift
//  Micro
//
//  Created by pinocchio22 on 2/19/25.
//

import CoreData
import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()

    var body: some View {
        ZStack {
            // mainView
            VStack(spacing: 40) {
                HStack(alignment: .center, spacing: 16) {
                    TabButton(title: "목표", isSelected: viewModel.selectedIndex == 0) {
                        viewModel.setIndex(index: 0)
                    }

                    TabButton(title: "내 책", isSelected: viewModel.selectedIndex == 1) {
                        viewModel.setIndex(index: 1)
                    }
                    .background(
                        GeometryReader { geometry in
                            Color.clear
                                .onAppear {
                                    viewModel.tabItemX = geometry.frame(in: .global).midX - 28 + 8
                                    viewModel.tabItemY = geometry.frame(in: .global).minY - 28 - 6
//                                    print("내책 X \(viewModel.tabItemX)")
//                                    print("내책 Y \(viewModel.tabItemY)")
                                }
                        }
                    )
                }
                .padding(.vertical, 0)
                .frame(maxWidth: .infinity, minHeight: 48, maxHeight: 48, alignment: .leading)
                .background(.white)

                TabView(selection: $viewModel.selectedIndex) {
                    VStack(spacing: 0) {
                        Text(viewModel.attributedString)
                            .font(Font.system(size: 32).weight(.bold))
                            .foregroundColor(.primitive.black)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        if !viewModel.isTextFieldHidden {
                            TextField("목표를 작성해주세요", text: $viewModel.goalText, axis: .vertical)
                                .font(Font.system(size: 32).weight(.bold))
                                .foregroundColor(viewModel.textColor)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, 10)
                                .background(Color.primitive.white)
                                .cornerRadius(Constants.button.largeRadius)
                                .onChange(of: viewModel.goalText) {
                                    viewModel.setButtonEnable()
                                    viewModel.setState(state: .editing)
                                    viewModel.setTextColor()
                                }
                                .disabled(viewModel.state != .editing && viewModel.state != .beforeEdit)
                                .background(
                                    GeometryReader { geometry in
                                        Color.clear
                                            .onAppear {
                                                viewModel.textFieldX = geometry.frame(in: .global).midX - 16
//                                                print("텍스트필드 X \(viewModel.textFieldX)")
                                                viewModel.textFieldY = geometry.frame(in: .global).minY - 6
//                                                print("텍스트필드 Y \(viewModel.textFieldY)")
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
                                        viewModel.buttonY = geometry.frame(in: .global).minY - 26
//                                        print("하단버튼 Y \(viewModel.buttonY)")
                                    }
                            }
                        )
                    }
                    .padding(.vertical, 6)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .tag(0)

                    VStack {
                        Text("내 책")
                            .font(.largeTitle)
                            .foregroundColor(.black)
                    }
                    .tag(1)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
//            .onChange(of: viewModel.state) { newState in
//                print("State changed to: \(newState), Button Title: \(newState.btnTitle)")
//            }

            if viewModel.isCoachMarkVisible {
                // coachMark backGround
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.primitive.black)
    //                .opacity(0.86)
                    // 0.86 맞나?
                    .opacity(0.66)

                // coachMark
                ZStack {
                    ZStack {
                        Circle()
                            .foregroundColor(.primitive.white)
                            .frame(maxWidth: 48, maxHeight: 48)
                            .overlay {
                                Text("내책")
                                    .frame(width: 50, height: 20)
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
                        .position(x: Constants.screenWidth / 2 - 16, y: viewModel.buttonY - 6 - 4)
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

struct TabButton: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Text(title)
                .font(isSelected ? Font.system(size: 16).weight(.bold) : Font.system(size: 16))
                .multilineTextAlignment(.center)
                .foregroundColor(isSelected ? .primitive.black : .primitive.darkGray)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 10)
        .frame(minWidth: 56, maxWidth: 56, maxHeight: .infinity, alignment: .center)
        .overlay(
            Rectangle()
                .frame(height: 4)
                .foregroundColor(isSelected ? .primitive.black : .clear),
            alignment: .bottom
        )
        .onTapGesture {
            action()
        }
    }
}

#Preview {
    MainView()
}
