//
//  TaskDataStructure.swift
//  TodoList2
//
//  Created by 陈子迪 on 2020/12/30.
//

import Foundation
import SwiftUI
import CoreLocation

struct TaskDataStructure : Hashable, Codable, Identifiable {
    var id : Int
    var title: String
    var desc: String
    var members: [Int]
    var duration: TimeInterval
    var type: String
    var isFinish: Bool
    
    init(){
        title = ""
        id = getMaxTaskID(taskList: taskDataSet) + 1
        desc = ""
        members = []
        duration = 0.00
        type = ""
        isFinish = false
    }
}

func getMaxTaskID(taskList: [TaskDataStructure]) -> Int{
    var ret: Int = 0
    for task in taskList{
        if ret < task.id{
            ret = task.id
        }
    }
    return ret
}
