//
//  StorageManager.swift
//  RoutineTasks
//
//  Created by Elenka on 29.09.2022.
//

import CoreData

class StorageManager {
    
    static let shared = StorageManager()
    let date = DateManager()
    
    // MARK: - Core Data stack
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Tasks")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    private let viewContext: NSManagedObjectContext
    
    private init() {
        viewContext = persistentContainer.viewContext
    }
    
    // MARK: - CRUD
    func createTask(taskName: String, color: String, date: String, completion: (Task) -> Void) {
        let task = Task(context: viewContext)
        let completionDays = CompletionDays(context: viewContext)
        task.title = taskName
        task.color = color
        completionDays.task = task
        completionDays.date = date
        completionDays.isDone = false
        completion(task)
        //уникальность названия
        saveContext()
    }
//
//    func createCompletionDay(task: Task, date: String, completion: (CompletionDays) -> Void) {
//        let completionDays = CompletionDays(context: viewContext)
//        completionDays.task = task
//        completionDays.date = date
//        completionDays.isDone = true
//        completion(completionDays)
//
//        saveContext()
//    }
    
    func fetchData(completion: (Result<[Task], Error>) -> Void) {
        let fetchRequest = Task.fetchRequest()
        
        do {
            let tasks = try viewContext.fetch(fetchRequest)
            completion(.success(tasks))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func fetchCompletionDays(_ task: Task, completion: (Result<[CompletionDays], Error>) -> Void) {
        let fetchRequest = CompletionDays.fetchRequest()
        
        do {
            let CompletionDays = try viewContext.fetch(fetchRequest)
            completion(.success(CompletionDays))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func updateTask(_ task: Task, newName: String, newColor: String) {
        task.title = newName
        task.color = newColor
        saveContext()
    }
    
    func updateStatus(_ task: Task, date: String) {
        let fetchRequest = CompletionDays.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "(task.title = %@) AND (date = %@)", task.title, date)
        do {
            let completionDays = try viewContext.fetch(fetchRequest)
            if let completionDay = completionDays.first {
                completionDay.isDone.toggle()
            } else {
                let newCompletionDay = CompletionDays(context: viewContext)
                newCompletionDay.task = task
                newCompletionDay.date = date
                newCompletionDay.isDone = true
            }
        } catch let error {
            print("Error fetch completionDays", error)
        }
        saveContext()
    }
    
    func delete(_ task: Task) {
        viewContext.delete(task)
        saveContext()
    }
    
    // MARK: - Core Data Saving support
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
