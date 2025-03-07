//
//  CoreDataRepository.swift
//  Micro
//
//  Created by SeoJunYoung on 2/22/25.
//

import CoreData
import Foundation

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
    
    func printAllData() {
        print("=== Core Data 모든 데이터 ===")
            
        // 1. Goal 데이터 출력
        let goalRequest: NSFetchRequest<Goal> = Goal.fetchRequest()
        do {
            let goals = try context.fetch(goalRequest)
            print("Goals (\(goals.count)개):")
            for goal in goals {
                print("  - ID: \(goal.iD?.uuidString ?? "nil"), CreateDate: \(goal.createDate?.toString() ?? "nil"), TodayGoal: \(goal.todayGoal ?? "nil"), IsComplete: \(goal.isComplete), Book: \(goal.book?.title ?? "nil")")
            }
        } catch {
            print("Goal 조회 실패: \(error)")
        }
            
        // 2. Book 데이터 출력
        let bookRequest: NSFetchRequest<Book> = Book.fetchRequest()
        do {
            let books = try context.fetch(bookRequest)
            print("Books (\(books.count)개):")
            for book in books {
                let goalCount = (book.goalList?.allObjects as? [Goal])?.count ?? 0
                print("  - ID: \(book.iD?.uuidString ?? "nil"), Title: \(book.title ?? "nil"), IsWrite: \(book.isWrite), CreateDate: \(book.createDate?.description ?? "nil"), GoalCount: \(goalCount)")
            }
        } catch {
            print("Book 조회 실패: \(error)")
        }
            
        // 3. FirstAccess 데이터 출력
        let firstAccessRequest: NSFetchRequest<FirstAccess> = FirstAccess.fetchRequest()
        do {
            let firstAccesses = try context.fetch(firstAccessRequest)
            print("FirstAccess (\(firstAccesses.count)개):")
            for firstAccess in firstAccesses {
                print("  - IsFirst: \(firstAccess.isFirst)")
            }
        } catch {
            print("FirstAccess 조회 실패: \(error)")
        }
        print("======================")
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
    ) -> Goal {
        let newGoal = Goal(context: context)
        newGoal.createDate = createDate
        newGoal.iD = iD
        newGoal.isComplete = isComplete
        newGoal.todayGoal = todayGoal
        newGoal.book = book
        saveContext()
        return newGoal
    }
    
    func fetchGoals(bookID: UUID?) -> [Goal] {
        // bookID로 Book을 조회
        guard let book = fetchBook(iD: bookID),
              let goalList = book.goalList
        else {
            return [] // Book이 없거나 goalList가 nil이면 빈 배열 반환
        }
        
        // NSSet을 [Goal]로 변환
        return goalList.allObjects as? [Goal] ?? []
    }
    
    func fetchTodayGoal() -> Goal? {
        let fetchRequest: NSFetchRequest<Goal> = Goal.fetchRequest()
            
            do {
                let goals = try context.fetch(fetchRequest)
                
                return goals.first { $0.createDate?.toString() == Date().toString() }
            } catch {
                print("Goal 객체 조회 실패: \(error)")
                return nil
            }
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
        book: Book?
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
            print("업데이트 성공")
        } catch {
            print("업데이트 실패: \(error)")
        }
    }
    
    func resetGoals() {
        let fetchRequest: NSFetchRequest<Goal> = Goal.fetchRequest()
        
        do {
            let goals = try context.fetch(fetchRequest)
            for goal in goals {
                context.delete(goal)
            }
            saveContext()
        } catch {
            print("삭제 실패: \(error)")
        }
    }
}

// MARK: - Book CRUD Methods

extension CoreDataRepository {
    func createNewBook(
        title: String?,
        isWrite: Bool = true,
        createDate: Date?,
        goalList: [Goal],
        iD: UUID?
    ) -> Book {
        let newBook = Book(context: context)
        newBook.title = title
        newBook.isWrite = isWrite
        newBook.createDate = createDate
        newBook.iD = iD
        newBook.goalList = .init(array: goalList)
        saveContext()
        return newBook
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
            for book in books {
                context.delete(book)
            }
            saveContext()
        } catch {
            print("삭제 실패: \(error)")
        }
    }
}

// MARK: - FirstAccess CRUD Methods

extension CoreDataRepository {
    func createFirstAccess() {
        let fetchRequest: NSFetchRequest<FirstAccess> = FirstAccess.fetchRequest()
        if try! context.fetch(fetchRequest).isEmpty {
            let firstAccess = FirstAccess(context: context)
            firstAccess.isFirst = true
            saveContext()
        }
    }
    
    func fetchFirstAccess() -> Bool {
        let fetchRequest: NSFetchRequest<FirstAccess> = FirstAccess.fetchRequest()
        do {
            let results = try context.fetch(fetchRequest)
            if let firstAccess = results.first {
                return firstAccess.isFirst
            }
            return false
        } catch {
            return false
        }
    }
    
    func resetFirstAccess() {
        let fetchRequest: NSFetchRequest<FirstAccess> = FirstAccess.fetchRequest()
        
        do {
            let accesses = try context.fetch(fetchRequest)
            for access in accesses {
                context.delete(access)
            }
            saveContext()
        } catch {
            print("삭제 실패: \(error)")
        }
    }
}
