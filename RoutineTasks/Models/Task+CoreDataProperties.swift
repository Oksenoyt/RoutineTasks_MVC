//
//  Task+CoreDataProperties.swift
//  RoutineTasks
//
//  Created by Elenka on 30.09.2022.
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
    @NSManaged public var completion: CompletionDays
}

extension Task : Identifiable {

}
