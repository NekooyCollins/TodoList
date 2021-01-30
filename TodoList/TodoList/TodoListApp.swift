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
//                    .environment(\.managedObjectContext, persistentContainer.viewContext)
            }else{
                let _ = localUserData = HandleLocalFile.loadUserJson()
                let _ = localTaskList = HandleLocalFile.loadTaskJson()
                let _ = localRankList = HandleLocalFile.loadRankJson()
                let _ = localFriendList = HandleLocalFile.loadFriendsJson()
                MainPageView()
//                    .environment(\.managedObjectContext, persistentContainer.viewContext)
            }
        }
    }
    
    var persistentContainer: NSPersistentContainer = {
           let container = NSPersistentContainer(name: "TodoListApp")
           container.loadPersistentStores(completionHandler: { (storeDescription, error) in
               if let error = error as NSError? {
                   fatalError("Unresolved error \(error), \(error.userInfo)")
               }
           })
           return container
       }()
    
   func saveContext() {
       let context = persistentContainer.viewContext
       if context.hasChanges {
           do {
               try context.save()
           } catch {
               let nserror = error as NSError
               fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
           }
       }
   }
}
