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
//        NavigationStack {
        ZStack {
            // mainView
            VStack {
                HStack(alignment: .center, spacing: 16) {
                    MainTabButton(title: "목표", isSelected: viewModel.selectedIndex == 0) {
                        viewModel.setIndex(index: 0)
                    }
  
                    MainTabButton(title: "내 책", isSelected: viewModel.selectedIndex == 1) {
                        viewModel.setIndex(index: 1)
                    }
                    .overlay(
                        GeometryReader { geometry in
                            Color.clear
                                .onAppear {
                                    let frame = geometry.frame(in: .global)
//                                        print("midX2: \(frame.midX), midY2: \(frame.midY)")
                                    viewModel.tabItemX = frame.midX - 16
                                    viewModel.tabItemY = frame.midY - viewModel.safeHeight
//                                        viewModel.tabItemY = 24
                                }
                        }
                    )
                }
                .frame(maxWidth: .infinity, minHeight: 48, maxHeight: 48, alignment: .leading)
//                    .overlay(
//                        GeometryReader { geometry in
//                            Color.clear
//                                .onAppear {
//                                    let frame = geometry.frame(in: .global)
//                                    print("HStack Frame: \(frame)")
//                                }
//                        }
//                    )
                    
                Spacer()
                    .frame(width: .infinity, height: 40)
                    
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
                                .frame(maxWidth: .infinity, maxHeight: 58, alignment: .leading)
//                                    .padding(.vertical, 10)
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
                                                viewModel.textFieldX = geometry.frame(in: .global).midX - 16
                                                viewModel.textFieldY = geometry.frame(in: .global).midY - viewModel.safeHeight + 16 + 10
//                                                    print("tf x :", viewModel.textFieldX, "tf y :", viewModel.textFieldY)
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
//                                            viewModel.buttonY = geometry.frame(in: .global).minY
//                                            print(viewModel.safeHeight)
                                        viewModel.buttonY = geometry.frame(in: .global).midY - viewModel.safeHeight
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
                            .onTapGesture {
                                viewModel.isBookViewPresented = true
                            }
                    }
                    .tag(1)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .scrollDisabled(true)
            }
            .blur(radius: viewModel.isShowAchievedView ? 10 : 0)
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                
            // achievedView
            if viewModel.isShowAchievedView {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    
                GoalAchievedView(isGoalAchievedViewVisible: $viewModel.isShowAchievedView, todayGoalButtonAction: {
                    //                                print("위에버튼 누를 때 동작쓰")
                })
                .frame(maxWidth: .infinity, alignment: .center)
                .transition(.opacity)
            }
                
            if viewModel.isCoachMarkVisible {
                // coachMark backGround
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.primitive.black)
                    //                    .opacity(0.86)
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
                                print("click")
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
            
        }.overlay(
            GeometryReader { geometry in
                Color.clear
                    .onAppear {
                        viewModel.safeHeight = geometry.frame(in: .global).minY
                    }
            }
        )
//        .navigationDestination(isPresented: $viewModel.isBookViewPresented) {
//            BookView(viewModel: BookViewModel(book: CoreDataRepository.shared.fetchBookList().first ?? Book(context: CoreDataRepository.shared.context)))
//                .navigationTitle(CoreDataRepository.shared.fetchBookList().first?.title ?? "무제")
//                .navigationBarTitleDisplayMode(.inline)
//                .navigationBarBackButtonHidden(true)
//                .navigationBarItems(leading: Button(action: {
//                    viewModel.isBookViewPresented = false
//                }) {
//                    Image("icon_leftBack")
//                        .frame(width: 24, height: 24)
//                })
//        }
//        .frame()
//        .overlay(
//            GeometryReader { geometry in
//                Color.clear
//                    .onAppear {
//                        print("NavigationStack Frame: \(geometry.frame(in: .global))")
//                    }
//            }
//        )
//        }
    }
}

#Preview {
    MainView()
}
