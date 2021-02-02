//
//  TodoListApp.swift
//  TodoList
//
//  Created by 陈子迪 on 2020/12/30.
//

import SwiftUI
import CoreData


@main
struct TodoListApp: App {
    var body: some Scene {
        WindowGroup {
            if  UserDefaults.standard.value(forKey: "isLogin") == nil{
                let _ = HandleLocalFile.createLocalFile()
                LoginView()
            }else{
                let _ = localUserData = HandleLocalFile.loadUserJson()
                let _ = localTaskList = HandleLocalFile.loadTaskJson()
                let _ = localRankList = HandleLocalFile.loadRankJson()
                let _ = localFriendList = HandleLocalFile.loadFriendsJson()
                MainPageView()
            }
        }
    }
}
