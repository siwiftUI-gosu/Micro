//
//  CoreDataTestView.swift
//  Micro
//
//  Created by SeoJunYoung on 2/23/25.
//

import SwiftUI

struct CoreDataTestView: View {

    var body: some View {
        VStack(spacing: 30) {
            Button {
                CoreDataRepository.shared.createNewBook(title: "", isWrite: true, createDate: Date(), goalList: [], iD: .init())
            } label: {
                Text("createNewBook")
            }
            Button {
                let books = CoreDataRepository.shared.fetchBookList()
                print(books.map { $0.goalList?.allObjects as? [Goal] ?? [] })
            } label: {
                Text("fetchAllBook")
            }
            Button {
                CoreDataRepository.shared.resetBooks()
            } label: {
                Text("resetBooks")
            }
            Button {
                if let targetBook = CoreDataRepository.shared.fetchBookList().first {
                    
                    CoreDataRepository.shared.deleteBook(iD: targetBook.iD)
                }
            } label: {
                Text("UpdateBook")
            }
            
            Button {
                if let targetBook = CoreDataRepository.shared.fetchBookList().first {
                    CoreDataRepository.shared.createNewGoal(createDate: .init(), iD: .init(), isComplete: false, todayGoal: "영차", book: targetBook)
                }
            } label: {
                Text("Create Goal")
            }
            
            Button {
                if let targetBook = CoreDataRepository.shared.fetchBookList().first {
                    let book = CoreDataRepository.shared.fetchGoals(bookID: targetBook.iD)
                    print(book.first?.todayGoal)
                }
            } label: {
                Text("fetch Goal")
            }
            
            Button {
                if let targetBook = CoreDataRepository.shared.fetchBookList().first {
                    guard let goal = CoreDataRepository.shared.fetchGoals(bookID: targetBook.iD).first else { return }
                    CoreDataRepository.shared.updateGoal(createDate: goal.createDate, iD: goal.iD, isComplete: goal.isComplete, todayGoal: "영차차", book: targetBook)
                }
            } label: {
                Text("update Goal")
            }
            
            Button {
                if let targetBook = CoreDataRepository.shared.fetchBookList().first {
                    guard let goal = CoreDataRepository.shared.fetchGoals(bookID: targetBook.iD).first else { return }
                    CoreDataRepository.shared.deleteGoal(iD: goal.iD)
                }
            } label: {
                Text("Delete Goal")
            }
            
            Button {
                CoreDataRepository.shared.resetFirstAccess()
            } label: {
                Text("ResetFirstAccess")
            }
            
            Button {
                CoreDataRepository.shared.resetGoals()
            } label: {
                Text("ResetGoals")
            }
        }
    }
}

#Preview {
    CoreDataTestView()
}

