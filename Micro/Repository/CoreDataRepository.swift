//
//  CoreDataRepository.swift
//  Micro
//
//  Created by SeoJunYoung on 2/22/25.
//

import Foundation
import CoreData

class CoreDataRepository {
    // MARK: - Singleton
    static let shared = CoreDataRepository()
    private init() {} // 싱글톤을 위해 private 초기화

    // MARK: - Core Data Stack
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Micro")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("데이터 저장소를 로드하지 못했습니다: \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    // 메인 컨텍스트 (UI 작업용)
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    // MARK: - Save Context
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("데이터가 성공적으로 저장되었습니다.")
            } catch {
                let nsError = error as NSError
                print("저장 실패: \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

// MARK: - Goal CRUD Methods
extension CoreDataRepository {
    
}

// MARK: - Book CRUD Methods
extension CoreDataRepository {
    
    func createNewBook(
        title: String?,
        isWrite: Bool,
        createDate: Date?,
        goalList: [Goal],
        iD: UUID?
    ) {
        let newBook = Book(context: context)
        newBook.title = title
        newBook.isWrite = isWrite
        newBook.createDate = createDate
        newBook.iD = iD
        newBook.goalList = .init(array: goalList)
        saveContext()
    }

    func fetchBooks() -> [Book] {
        let fetchRequest: NSFetchRequest<Book> = Book.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("유저 조회 실패: \(error)")
            return []
        }
    }
    // MARK: - Delete
    func resetBooks() {
        let fetchRequest: NSFetchRequest<Book> = Book.fetchRequest()
        
        do {
            let books = try context.fetch(fetchRequest)
            books.forEach { book in
                context.delete(book)
            }
            saveContext()
        } catch {
            print("삭제 실패: \(error)")
        }
    }
    
    //    // 특정 조건으로 조회
    //    func fetchUsers(withName name: String) -> [User] {
    //        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
    //        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
    //
    //        do {
    //            return try context.fetch(fetchRequest)
    //        } catch {
    //            print("조건 조회 실패: \(error)")
    //            return []
    //        }
    //    }
    //
    // MARK: - Update
    func updateBook(updateBook: Book) {
        let fetchRequest: NSFetchRequest<Book> = Book.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "iD == %@", updateBook.iD?.uuidString ?? "")
        
        do {
            let books = try context.fetch(fetchRequest)
            if let book = books.first {
                book.title = updateBook.title
                book.createDate = updateBook.createDate
                book.goalList = updateBook.goalList
                book.isWrite = updateBook.isWrite
                saveContext()
            }
        } catch {
            print("업데이트 실패: \(error)")
        }
    }
    
}
