//
//  MakeBookView.swift
//  Micro
//
//  Created by pinocchio22 on 3/12/25.
//

import SwiftUI

struct MakeBookView: View {
    @ObservedObject var viewModel: MakeBookViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
            VStack {
                Spacer()
                    .frame(height: 40)
                    
                VStack(spacing: 0) {
                    Text("이 책의 제목은")
                        .font(Font.system(size: 32).weight(.bold))
                        .foregroundColor(.primitive.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                    TextField("책의 제목을 알려주세요", text: $viewModel.bookTitle, axis: .vertical)
                        .font(Font.system(size: 32).weight(.bold))
                        .foregroundColor(viewModel.bookTitleState.titleColor)
                        .frame(maxWidth: .infinity, maxHeight: 58, alignment: .leading)
                        .background(Color.primitive.white)
                        .cornerRadius(Constants.button.largeRadius)
                        .onChange(of: viewModel.bookTitle, initial: true) {
                            viewModel.setState()
                        }
                        
                    Text("에요")
                        .font(Font.system(size: 32).weight(.bold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                    
                Spacer()
                    
                HStack(spacing: 8) {
                    Image("icon_warning")
                        .frame(width: 20, height: 20)
                        
                    Text("책의 제목은 만들면 수정할 수 없어요")
                        .font(Font.system(size: 14))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(Color(red: 244/255, green: 244/255, blue: 244/255))
                .cornerRadius(10)
                    
                CustomButton(
                    title: viewModel.bookTitleState.btnTitle,
                    foregroundColor: viewModel.bookTitleState.btnForegroundColor,
                    backgroundColor: viewModel.bookTitleState.btnBackgroundColor,
                    borderColor: .clear,
                    isEnabled: viewModel.bookTitleState.isBtnEnabled
                ) {
                    viewModel.isPresentCompleteView = true
                }
                .padding(.horizontal, 10)
            }
            .padding(.horizontal, 16)
            .customNavigationBar(title: "")
            .fullScreenCover(isPresented: $viewModel.isPresentCompleteView, content: {
                let goals = viewModel.book.goalList?.allObjects as? [Goal] ?? []
                let successCount = goals.filter { $0.isComplete == true }.count
                let title = viewModel.bookTitle
                AddBookCompleteView(
                    successCount: successCount,
                    failCount: goals.count - successCount,
                    bookTitle: title
                )
            })
        
    }
}
