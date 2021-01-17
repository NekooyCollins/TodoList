//
//  TaskData.swift
//  TodoList
//
//  Created by 陈子迪 on 2021/1/6.
//

import Foundation
import SwiftUI
import Combine

final class TaskData: ObservableObject  {
    @Published var dataset = taskDataSet
}
