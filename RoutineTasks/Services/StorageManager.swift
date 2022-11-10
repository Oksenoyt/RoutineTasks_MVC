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
    func createTask(id: Int, name: String, color: String, date: String, dayWeek: String, selectedDays: [Bool], completion: (Task) -> Void) {
        var task = Task(context: viewContext)
        task.title = name
        task.color = color
        task.id = Int16(id)
        task = createCD(task, date: date, dayWeek: dayWeek, isDone: false)
        task = createSchedule(task, selectedDays: selectedDays)
        
        completion(task)
        saveContext()
    }
    
    func fetchTasks(completion: (Result<[Task], Error>) -> Void) {
        let fetchRequest = Task.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        do {
            let tasks = try viewContext.fetch(fetchRequest)
            print(tasks)
            completion(.success(tasks))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func updateTask(_ taskList: [Task], sourceIndexPath: Int, destinationIndexPath: Int, completion: ([Task]) -> Void) {
        let taskList: [Task] = taskList
        taskList[sourceIndexPath].id = Int16(destinationIndexPath)
        taskList[destinationIndexPath].id = Int16(sourceIndexPath)
        completion(taskList)
        saveContext()
    }
    
    func deleteTask(_ task: Task) {
        viewContext.delete(task)
        saveContext()
    }
    
    // MARK: - CRUD CompletionDay
    func createCompletionDay(_ task: Task, date: String, dayWeek: String, isDone: Bool, completion: (CompletionDays) -> Void) {
        let completionDay = CompletionDays(context: viewContext)
        completionDay.task = task
        completionDay.date = date
        completionDay.isDone = isDone
        completionDay.dayWeek = dayWeek
        
        completion(completionDay)
        saveContext()
    }
    
    func updateCompletionDay(_ completionDay: CompletionDays) {
        completionDay.isDone.toggle()
        saveContext()
    }
    
    func fetchCompletionDays(_ task: Task, completion: (Result<[CompletionDays], Error>) -> Void) {
        let fetchRequest = CompletionDays.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "(task = %@)", task)
        do {
            let completionDays = try viewContext.fetch(fetchRequest)
            completion(.success(completionDays))
        } catch let error {
            completion(.failure(error))
        }
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
    
    private func createCD(_ taskTemp: Task, date: String, dayWeek: String, isDone: Bool) -> Task{
        let task = taskTemp
        let completionDay = CompletionDays(context: viewContext)
        completionDay.task = task
        completionDay.date = date
        completionDay.isDone = false
        completionDay.dayWeek = dayWeek
        
        return task
    }
    
    private func createSchedule(_ taskTemp: Task, selectedDays: [Bool]) -> Task {
        let task = taskTemp
        let schedule = Schedule(context: viewContext)
        schedule.task = task //переделать
        schedule.monday = selectedDays[0]
        schedule.tuesday = selectedDays[1]
        schedule.wednesday = selectedDays[2]
        schedule.thursday = selectedDays[3]
        schedule.friday = selectedDays[4]
        schedule.saturday = selectedDays[5]
        schedule.sunday = selectedDays[6]
        
        return task
    }
}
