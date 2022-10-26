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
    
    // MARK: - CRUD TASK
    func createTask(taskName: String, color: String, date: String, selectedDays: [Bool], completion: (Task) -> Void) {
        let task = Task(context: viewContext)
        let completionDays = CompletionDays(context: viewContext)
        let schedule = Schedule(context: viewContext)
        let user = User(context: viewContext)
        task.title = taskName
        task.color = color
        completionDays.task = task
        completionDays.date = date
        completionDays.isDone = false
//        print(schedule.task)
        schedule.task = task
    
        print(" print(schedule.task)", schedule.task)
        
        //переделать
        schedule.monday = selectedDays[0]
        schedule.tuesday = selectedDays[1]
        schedule.wednesday = selectedDays[2]
        schedule.thursday = selectedDays[3]
        schedule.friday = selectedDays[4]
        schedule.saturday = selectedDays[5]
        schedule.sunday = selectedDays[6]
        
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
    
    func fetchCompletionDays(_ task: Task, completion: (Result<[CompletionDays], Error>) -> Void) {
        let fetchRequest = CompletionDays.fetchRequest()
        
        do {
            let CompletionDays = try viewContext.fetch(fetchRequest)
            completion(.success(CompletionDays))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    //    func updateTask(_ task: Task, newName: String, newColor: String) {
    //        task.title = newName
    //        task.color = newColor
    //        saveContext()
    //    }
    
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
    
    // MARK: - CRUD USER
    func createUser(name: String, email: String, password: String, completion: (User) -> Void) {
        let user = User(context: viewContext)
        user.name = name
        user.email = email
        user.password = password
        
        completion(user)
        saveContext()
    }
    
    func fetchUser(email: String, completion: (Result<User, Error>) -> Void) {
        let fetchRequest = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email = %@", email)
        do {
            let users = try viewContext.fetch(fetchRequest)
            guard let user = users.first else { return }
            completion(.success(user))
        } catch let error {
            completion(.failure(error))
        }
        saveContext()
    }
    
//    func updateUser(_ task: Task, date: String) {
//        let fetchRequest = CompletionDays.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "(task.title = %@) AND (date = %@)", task.title, date)
//        do {
//            let completionDays = try viewContext.fetch(fetchRequest)
//            if let completionDay = completionDays.first {
//                completionDay.isDone.toggle()
//            } else {
//                let newCompletionDay = CompletionDays(context: viewContext)
//                newCompletionDay.task = task
//                newCompletionDay.date = date
//                newCompletionDay.isDone = true
//            }
//        } catch let error {
//            print("Error fetch completionDays", error)
//        }
//        saveContext()
//    }
    func deleteUser(_ user: User) {
        viewContext.delete(user)
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
