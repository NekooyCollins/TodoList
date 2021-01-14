//
//  TodoListApp.swift
//  TodoList
//
//  Created by 陈子迪 on 2020/12/30.
//

import SwiftUI

@main
struct TodoListApp: App {
    var body: some Scene {
        WindowGroup {
            MainPageView(inputuser: userDataSet[0])
                .environmentObject(TaskData())
                .environmentObject(UserData())
        }
    }
}
