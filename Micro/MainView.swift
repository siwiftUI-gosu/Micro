//
//  MainView.swift
//  Micro
//
//  Created by pinocchio22 on 2/19/25.
//

import CoreData
import SwiftUI

struct MainView: View {
    @State var text = ""
    var attributedString: AttributedString {
        var string = AttributedString("오늘 단 하나,")
        if let this = string.range(of: "하나,") {
            string[this].foregroundColor = text.isEmpty ? .primitive.green : .primitive.black
        }
        return string
    }

    @State private var selectedIndex: Int = 0

    @State private var isButtonEnabled = false

    var body: some View {
        VStack(spacing: 40) {
            HStack(alignment: .center, spacing: 16) {
                HStack(alignment: .center, spacing: 10) {
                    Text("목표")
                        .font(selectedIndex == 0 ? Font.system(size: 16).weight(.bold) : Font.system(size: 16))
                        .multilineTextAlignment(.center)
                        .foregroundColor(selectedIndex == 0 ? .primitive.black : .primitive.darkGray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 10)
                .frame(minWidth: 56, maxWidth: 56, maxHeight: .infinity, alignment: .center)
                .overlay(
                    Rectangle()
                        .frame(height: 4)
                        .foregroundColor(selectedIndex == 0 ? .primitive.black : .clear),
                    alignment: .bottom
                )
                .onTapGesture {
                    selectedIndex = 0
                }

                HStack(alignment: .center, spacing: 10) {
                    Text("내 책")
                        .font(selectedIndex == 1 ? Font.system(size: 16).weight(.bold) : Font.system(size: 16))
                        .multilineTextAlignment(.center)
                        .foregroundColor(selectedIndex == 1 ? .primitive.black : .primitive.darkGray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 10)
                .frame(minWidth: 56, maxWidth: 56, maxHeight: .infinity, alignment: .center)
                .overlay(
                    Rectangle()
                        .frame(height: 4)
                        .foregroundColor(selectedIndex == 1 ? .primitive.black : .clear),
                    alignment: .bottom
                )
                .onTapGesture {
                    selectedIndex = 1
                }
            }
            .padding(.vertical, 0)
            .frame(maxWidth: .infinity, minHeight: 48, maxHeight: 48, alignment: .leading)
            .background(.white)

            TabView(selection: $selectedIndex) {
                VStack(spacing: 0) {
                    Text(attributedString)
                        .font(
                            Font.system(size: 32)
                                .weight(.bold)
                        )
                        .foregroundColor(.primitive.black)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    TextField("목표를 작성해주세요", text: $text)
                        .font(
                            Font.system(size: 32)
                                .weight(.bold)
                        )
                        .onChange(of: text, initial: false) {
                            isButtonEnabled = !text.isEmpty
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 10)
                        .background(Color.primitive.white)
                        .cornerRadius(Constants.button.largeRadius)

                    Text("을/를 할거야")
                        .font(
                            Font.system(size: 32)
                                .weight(.bold)
                        )
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Spacer()

                    CustomButton(title: "목표를 작성해주세요", isEnabled: isButtonEnabled) {
                        print("버튼 클릭됨")
                    }
                    .padding(.vertical, 6)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .tag(0)
                }

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
        .padding(16)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

#Preview {
    MainView(text: "")
}
