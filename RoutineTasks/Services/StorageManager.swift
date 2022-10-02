//
//  StorageManager.swift
//  RoutineTasks
//
//  Created by Elenka on 29.09.2022.
//

import CoreData

class StorageManager {
    
    static let shared = StorageManager()
    
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
    func create(_ taskName: String, color: String, curentData: Date, completion: (Task) -> Void) {
        let task = Task(context: viewContext)
        let completionDays = CompletionDays(context: viewContext)
        
        task.title = taskName
        task.color = color
        completionDays.task = task
        completionDays.date = curentData
        completionDays.isDone = Bool.random()//убрать
        
        completion(task)
        saveContext()
    }
    
    func fetchData(completion: (Result<[Task], Error>) -> Void) {
        let fetchRequest = Task.fetchRequest()
        
        do {
            let tasks = try viewContext.fetch(fetchRequest)
            completion(.success(tasks))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func updateData(currentTask: String, currentDate: Date, completion: (Result<[CompletionDays], Error>) -> Void) {
        let fetchRequest = CompletionDays.fetchRequest()
        do {
            let taskPredicate = NSPredicate(
                format: "task == %@", currentTask
            )

            let datePredicate = NSPredicate(
                format: "date == %@", currentDate as CVarArg
            )
            fetchRequest.predicate = NSCompoundPredicate(
                andPredicateWithSubpredicates: [
                    taskPredicate,
                    datePredicate
                ]
            )
            
            let objects = try viewContext.fetch(fetchRequest)
            print("objects1")
            print(objects)
            objects.first?.isDone.toggle()
            saveContext()
            print("objects2")
            print(objects)
            completion(.success(objects))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    
    
    func update(_ task: Task, newName: String, isDone: Bool ) {
        task.title = newName
        
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
