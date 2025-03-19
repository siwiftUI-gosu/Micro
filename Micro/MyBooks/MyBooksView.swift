//
//  MyBooksView.swift
//  Micro
//
//  Created by SeoJunYoung on 3/4/25.
//

import SwiftUI

struct MyBooksView: View {
    @State var isBookViewPresented = false
    @State var isEditMode: Bool = false
    @State var selectedItems: Set<Book> = []
    @State var showAlert = false
    @State var showToast = false
    @State private var items: [Book] = []
    @State var selectedItem: Book?
    
    var body: some View {
        GeometryReader { geometry in
            let spacing: CGFloat = 20
            let columnWidth = (geometry.size.width - (spacing * 2)) / 3 // 3개의 셀 + 2개의 간격
            
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
                            selectedItems.removeAll()
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
                    
                    if !selectedItems.isEmpty {
                        Button {
                            showAlert = true
                        } label: {
                            Text("삭제하기")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundStyle(Color(red: 0, green: 0, blue: 0))
                                .frame(height: 50)
                        }
                        .alert("경고", isPresented: $showAlert) {
                            Button("삭제", role: .destructive) {
                                let deleteIDs = selectedItems.map { $0.iD }
                                for id in deleteIDs {
                                    CoreDataRepository.shared.deleteBook(iD: id)
                                }
                                selectedItems.removeAll()
                                isEditMode = false
                                showToastMessage()
                                refreshItems()
                            }
                            Button("취소", role: .cancel) {}
                        } message: {
                            Text("정말 삭제하시겠습니까?")
                        }
                    }
                }
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 32) {
                        ForEach(items, id: \.self) { item in
                            if let nsSet = item.goalList {
                                let goals: [Goal] = nsSet.allObjects.compactMap { $0 as? Goal }
                                let completePercent = goals.count == 0 ? 1 : Double(goals.filter { $0.isComplete == true }.count) / Double(goals.count)
                                let isSelected = selectedItems.contains(item)
                                
                                NavigationLink(destination: {
                                    BookDetailView(viewModel: BookViewModel(book: item), mainViewModel: MainViewModel(writingBook: item))
                                }, label: {
                                    BookView(
                                        isEditMode: $isEditMode,
                                        title: item.title,
                                        isWrite: item.isWrite,
                                        completePercent: completePercent,
                                        isSelected: .constant(isSelected)
                                    )
                                    .frame(width: columnWidth)
                                    .aspectRatio(1 / 1.45, contentMode: .fit)
                                })
                                .onTapGesture {
                                    if isEditMode {
                                        if isSelected {
                                            selectedItems.remove(item)
                                        } else {
                                            if !item.isWrite {
                                                selectedItems.insert(item)
                                            }
                                        }
                                    } else {
                                        selectedItem = item
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .overlay(
                VStack {
                    if showToast {
                        ToastView(message: "삭제되었습니다! 🗑️", backgroundColor: Color(red: 0.957, green: 0.957, blue: 0.957), textCoolor: .black)
                            .transition(.opacity)
                            .animation(.easeInOut(duration: 0.3), value: showToast)
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .top) // 화면 맨 위 정렬
                .offset(y: showToast ? 0 : -24) // 위에서 시작하도록 설정
                .opacity(showToast ? 1 : 0)
                .animation(.easeInOut(duration: 0.3), value: showToast)
            )
            .onAppear {
                refreshItems()
            }
        }
    }
    
    private func refreshItems() {
        print("Refreshing items")
        items = CoreDataRepository.shared.fetchBookList()
    }
    
    private func showToastMessage() {
        showToast = true
        
        // 2초 후에 자동으로 사라지도록 설정
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                showToast = false
            }
        }
    }
}

#Preview {
    MyBooksView()
}
