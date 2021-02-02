//
//  TaskDataStructure.swift
//  TodoList2
//
//  Created by 陈子迪 on 2020/12/30.
//

import Foundation
import SwiftUI
import CoreLocation

struct TaskDataStructure : Hashable, Codable, Identifiable, Equatable {
    var id : UUID
    var title: String
    var description: String
    var duration: Int
    var remaintime: Int
    var typestr: String
    var isfinish: Bool
    var isgrouptask: Bool
    
    init(){
        title = ""
        id = UUID()
        description = ""
        duration = 60
        remaintime = 60
        typestr = ""
        isfinish = false
        isgrouptask = false
    }
    
    func convertToDictionary() -> [String : Any] {
        let dic: [String: Any] = ["id":self.id.uuidString, "title":self.title, "description":self.description, "duration":self.duration,
                                  "remaintime":self.remaintime, "typestr":self.typestr, "isfinish":self.isfinish,
                                  "isgrouptask":self.isgrouptask]
        return dic
    }
    
    static func == (left: TaskDataStructure, right: TaskDataStructure) -> Bool {
        return (left.title == right.title) &&
            (left.description == right.description) &&
            (left.typestr == right.typestr) &&
            (left.duration == right.duration)
    }
}
