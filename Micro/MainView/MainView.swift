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
                                    viewModel.tabItemX = frame.midX - 16
                                    viewModel.tabItemY = frame.midY - viewModel.safeHeight
                                }
                        }
                    )
                }
                .frame(maxWidth: .infinity, minHeight: 48, maxHeight: 48, alignment: .leading)
                    
                Spacer()
                    .frame(height: 40)
                    
                TabView(selection: $viewModel.selectedIndex) {
                    MainEditView(viewModel: viewModel)
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
                
            MainCoachMarkView(viewModel: viewModel)
            
        }.overlay(
            GeometryReader { geometry in
                Color.clear
                    .onAppear {
                        viewModel.safeHeight = geometry.frame(in: .global).minY
                    }
            }
        )
    }
}

#Preview {
    MainView()
}
