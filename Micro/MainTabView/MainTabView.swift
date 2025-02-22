//
//  MainTabView.swift
//  Micro
//
//  Created by SeoJunYoung on 2/22/25.
//

import SwiftUI

struct MainTabView: View {
    @State var currentPageIndex: Int = 0
    
    // 탭 아이템 데이터 (텍스트와 태그로 구성)
    private let tabItems: [(title: String, tag: Int)] = [
        ("목표", 0),
        ("내 책", 1)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 16) {
                ForEach(tabItems, id: \.tag) { item in
                    TabItem(
                        title: item.title,
                        tag: item.tag,
                        currentPageIndex: $currentPageIndex
                    )
                }
                Spacer() // 왼쪽 정렬 유지
            }
            .padding(.horizontal, 16)
            
            // 콘텐츠 영역
            TabView(selection: $currentPageIndex) {
                MainView()
                    .tag(0)
                TabViewTestView()
                    .tag(1)
            }
        }
    }
}

// 재사용 가능한 탭 아이템 뷰
struct TabItem: View {
    let title: String
    let tag: Int
    @Binding var currentPageIndex: Int
    
    var body: some View {
        VStack(spacing: 0) {
            Button(action: { currentPageIndex = tag }) {
                Text(title)
                    .font(currentPageIndex == tag ? .system(size: 16, weight: .bold) : .system(size: 16, weight: .regular))
                    .foregroundColor(currentPageIndex == tag ? .black : Color(UIColor.darkGray))
                    .frame(width: 56, height: 24) // 너비 56, 높이 24로 고정
                    .padding(.vertical, 10)
            }
            Rectangle()
                .frame(width: 56, height: 4) // 언더라인 너비 56으로 고정
                .foregroundColor(currentPageIndex == tag ? .black : .clear)
                .animation(.easeInOut, value: currentPageIndex)
        }
    }
}

#Preview {
    MainTabView()
}
