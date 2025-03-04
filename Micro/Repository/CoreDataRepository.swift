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

    func createNewGoal(
        createDate: Date?,
        iD: UUID?,
        isComplete: Bool,
        todayGoal: String?,
        book: Book
    ) {
        let newGoal = Goal(context: context)
        newGoal.createDate = createDate
        newGoal.iD = iD
        newGoal.isComplete = isComplete
        newGoal.todayGoal = todayGoal
        newGoal.book = book
        saveContext()
    }
    
    func fetchGoals(bookID: UUID?) -> [Goal] {
        // bookID로 Book을 조회
        guard let book = fetchBook(iD: bookID),
              let goalList = book.goalList else {
            return [] // Book이 없거나 goalList가 nil이면 빈 배열 반환
        }
        
        // NSSet을 [Goal]로 변환
        return goalList.allObjects as? [Goal] ?? []
    }
    
    func deleteGoal(iD: UUID?) {
        let fetchRequest: NSFetchRequest<Goal> = Goal.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "iD == %@", iD?.uuidString ?? "")
        do {
            guard let goal = try context.fetch(fetchRequest).first else { return }
            context.delete(goal)
            saveContext()
        } catch {
            print("업데이트 실패: \(error)")
        }
    }
    
    func updateGoal(
        createDate: Date?,
        iD: UUID?,
        isComplete: Bool,
        todayGoal: String?,
        book: Book
    ) {
        let fetchRequest: NSFetchRequest<Goal> = Goal.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "iD == %@", iD?.uuidString ?? "")
        do {
            guard let goal = try context.fetch(fetchRequest).first else { return }
            goal.createDate = createDate
            goal.iD = iD
            goal.isComplete = isComplete
            goal.todayGoal = todayGoal
            goal.book = book
            saveContext()
        } catch {
            print("업데이트 실패: \(error)")
        }
    }
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
    
    func fetchBookList() -> [Book] {
        let fetchRequest: NSFetchRequest<Book> = Book.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest).reversed()
        } catch {
            print("유저 조회 실패: \(error)")
            return []
        }
    }
    
    func fetchBook(iD: UUID?) -> Book? {
        let fetchRequest: NSFetchRequest<Book> = Book.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "iD == %@", iD?.uuidString ?? "")
        do {
            guard let book = try context.fetch(fetchRequest).first else { return nil }
            return book
        } catch {
            print("업데이트 실패: \(error)")
            return nil
        }
    }
    
    func deleteBook(iD: UUID?) {
        let fetchRequest: NSFetchRequest<Book> = Book.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "iD == %@", iD?.uuidString ?? "")
        do {
            guard let book = try context.fetch(fetchRequest).first else { return }
            context.delete(book)
            saveContext()
        } catch {
            print("업데이트 실패: \(error)")
        }
    }
    
    func updateBook(
        title: String?,
        isWrite: Bool,
        createDate: Date?,
        goalList: [Goal],
        iD: UUID?
    ) {
        
        let fetchRequest: NSFetchRequest<Book> = Book.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "iD == %@", iD?.uuidString ?? "")
        
        do {
            guard let book = try context.fetch(fetchRequest).first else { return }
            book.title = title
            book.isWrite = isWrite
            book.createDate = createDate
            book.goalList = .init(array: goalList)
            saveContext()
        } catch {
            print("업데이트 실패: \(error)")
        }
    }
    
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
}
