//
//  MyBooksView.swift
//  Micro
//
//  Created by SeoJunYoung on 3/4/25.
//

import SwiftUI

struct MyBooksView: View {
    @State var isEditMode: Bool = false
    
    let items = CoreDataRepository.shared.fetchBookList()
    
    var body: some View {
        GeometryReader { geometry in
            let spacing: CGFloat = 20
            let totalSpacing: CGFloat = 16 * 2  // 좌우 여백 포함
            let columnWidth = (geometry.size.width - totalSpacing - (spacing * 2)) / 3  // 3개의 셀 + 2개의 간격
            
            let columns = [
                GridItem(.fixed(columnWidth), spacing: spacing),
                GridItem(.fixed(columnWidth), spacing: spacing),
                GridItem(.fixed(columnWidth), spacing: spacing)
            ]
            
            
            VStack(alignment: .trailing, spacing: 0) {
                HStack(spacing: 0) {
                    if isEditMode {
                        Button {
                            isEditMode = false
                        } label: {
                            Text("취소")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundStyle(Color(red: 0, green: 0, blue: 0))
                                .frame(height: 50)
                        }
                    }
                    
                    Spacer()
                    
                    if !isEditMode {
                        Button {
                            isEditMode = true
                        } label: {
                            Text("삭제하기")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundStyle(Color(red: 0.42, green: 0.42, blue: 0.42))
                                .frame(height: 50)
                        }
                    }
                }
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 32) {
                        ForEach(items, id: \.self) { item in
                            if let nsSet = item.goalList {
                                let goals: [Goal] = nsSet.allObjects.compactMap { $0 as? Goal }
                                let completePercent = goals.count == 0 ? 1 : Double(goals.filter { $0.isComplete == true }.count) / Double(goals.count)
                                BookView(
                                    isEditMode: $isEditMode,
                                    title: item.title,
                                    isWrite: item.isWrite,
                                    completePercent: completePercent,
                                    isSelected: .constant(false)
                                )
                                .frame(width: columnWidth)
                                .aspectRatio(1 / 1.45, contentMode: .fit)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 16)  // 좌우 패딩 설정
        }
    }
}


#Preview {
    MyBooksView()
}
