//
//  TodoListApp.swift
//  TodoList
//
//  Created by 陈子迪 on 2020/12/30.
//

import SwiftUI

@main
struct TodoListApp: App {
    @ObservedObject var manager = RequestHandle()
    var body: some Scene {
        WindowGroup {
            if self.manager.authenticated{
                MainPageView(inputuser: userDataSet[0])
                    .environmentObject(TaskData())
                    .environmentObject(UserData())
            }else{
                LoginView()
            }
        }
    }
}
