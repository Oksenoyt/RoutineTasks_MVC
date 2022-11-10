//
//  Task+CoreDataProperties.swift
//  RoutineTasks
//
//  Created by Elenka on 09.11.2022.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var color: String
    @NSManaged public var title: String
    @NSManaged public var id: Int16
    @NSManaged public var completion: NSSet
    @NSManaged public var schedule: Schedule
    @NSManaged public var user: User?

}

// MARK: Generated accessors for completion
extension Task {

    @objc(addCompletionObject:)
    @NSManaged public func addToCompletion(_ value: CompletionDays)

    @objc(removeCompletionObject:)
    @NSManaged public func removeFromCompletion(_ value: CompletionDays)

    @objc(addCompletion:)
    @NSManaged public func addToCompletion(_ values: NSSet)

    @objc(removeCompletion:)
    @NSManaged public func removeFromCompletion(_ values: NSSet)

}

extension Task : Identifiable {

}
