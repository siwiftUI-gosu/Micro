//
//  CoreDataTestView.swift
//  Micro
//
//  Created by SeoJunYoung on 2/23/25.
//

import SwiftUI

struct CoreDataTestView: View {
    @Binding var text: String
    
    var body: some View {
        VStack(spacing: 30) {
            Button {
                CoreDataRepository.shared.createNewBook(title: "", isWrite: true, createDate: Date(), goalList: [], iD: .init())
            } label: {
                Text("createNewBook")
            }
            Button {
                let books = CoreDataRepository.shared.fetchBooks()
                text = books.map { $0.title ?? "" }.first ?? ""
                print(books.map(\.title))
            } label: {
                Text("fetchAllBook")
            }
            Button {
                CoreDataRepository.shared.resetBooks()
            } label: {
                Text("resetBooks")
            }
            Button {
                let targetBook = CoreDataRepository.shared.fetchBooks().first!
                targetBook.title = "updateTitle"
                CoreDataRepository.shared.updateBook(updateBook: targetBook)
            } label: {
                Text("updateBook")
            }
            
            Text(text)
        }
    }
}

#Preview {
    CoreDataTestView(text: .constant(""))
}
