//
//  Task+CoreDataProperties.swift
//  TodoList
//
//  Created by 陈子迪 on 2021/1/27.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var id: Int16
    @NSManaged public var title: String?
    @NSManaged public var taskDescription: String?
    @NSManaged public var duration: Int16
    @NSManaged public var remaintime: Int16
    @NSManaged public var typestr: String?
    @NSManaged public var isfinish: Bool
    @NSManaged public var isgrouptask: Bool
    @NSManaged public var isupdate: Bool

}

extension Task : Identifiable {

}
