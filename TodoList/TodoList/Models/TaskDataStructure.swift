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
}
