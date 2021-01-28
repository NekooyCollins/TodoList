//
//  HandleLocalFile.swift
//  TodoList
//
//  Created by Xizhen Huang on 27.01.21.
//

import Foundation

public class HandleLocalFile {
    
    class func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
    class func createLocalFile() {
        let fileManager = FileManager.default
        let appPath = self.getDocumentsDirectory()
        
        let userFilePath = appPath.appendingPathComponent("userdata.json")
        let taskFilePath = appPath.appendingPathComponent("taskdata.json")
        let rankFilePath = appPath.appendingPathComponent("ranking.json")
        let friendsFilePath = appPath.appendingPathComponent("friends.json")
        print(userFilePath)
        

        // check file
        var exist1 = false
        var exist2 = false
        var exist3 = false
        var exist4 = false
        
        do {
            exist1 = fileManager.fileExists(atPath: try String(contentsOf: userFilePath))
            exist2 = fileManager.fileExists(atPath: try String(contentsOf:taskFilePath))
            exist3 = fileManager.fileExists(atPath: try String(contentsOf:rankFilePath))
            exist4 = fileManager.fileExists(atPath: try String(contentsOf: friendsFilePath))
            
            print("json exist1" + String(exist1))
            print("json exist2" + String(exist2))
            print("json exist3" + String(exist3))
            print("json exist4" + String(exist4))
        } catch {
            print("no file!")
        }
        
        // no such file, creat one and init it
        if exist1 == false {
            let dictionary:NSDictionary = ["id":0, "name":"", "email":"", "passwd":""]
            dictionary.write(to: userFilePath, atomically: true)
        } else{
            print("user is already existed!")
        }

        if exist2 == false {
            let dictionary:NSDictionary = ["title" : "",
                                           "id" : 0,
                                           "description" : "",
                                           "duration" : 0,
                                           "remaintime" : 0,
                                           "typestr" : "",
                                           "isfinish" : false,
                                           "isgrouptask" : false]
            dictionary.write(to: taskFilePath, atomically: true)
        } else{
            print("task is already existed!")
        }

        if exist3 == false {
            let dictionary:NSDictionary = ["username" : "", "totalfocustime" : 0]
            dictionary.write(to: rankFilePath, atomically: true)
        } else{
            print("rank is already existed!")
        }

        if exist4 == false {
            let dictionary:NSDictionary = ["id":0, "name":"", "email":"", "passwd":""]
            dictionary.write(to: friendsFilePath, atomically: true)
        } else{
            print("friends is already existed!")
        }
    }
    
    class func loadUserJson() -> UserDataStructure {
        let homePath = HandleLocalFile.getDocumentsDirectory()
        let userFilePath = homePath.appendingPathComponent("userdata.json")
        
        var person = UserDataStructure()
        var isDataNull = false
        
        let getData = try? Data(contentsOf: userFilePath)
        do{
            try JSONSerialization.jsonObject(with: getData!, options:[.mutableContainers, .mutableLeaves])
        } catch {
            isDataNull = true
            print("no data here!")
        }

        if isDataNull == false{
            person = try! JSONDecoder().decode(UserDataStructure.self, from: getData!)
        }
        return person
    }
    
    class func loadTaskJson() -> [TaskDataStructure] {
        let homePath = HandleLocalFile.getDocumentsDirectory()
        let taskFilePath = homePath.appendingPathComponent("taskdata.json")
        var taskList: [TaskDataStructure] = []
        var isDataNull = false
        
        let getData = try? Data(contentsOf: taskFilePath)
        do{
            try JSONSerialization.jsonObject(with: getData!, options:[.mutableContainers, .mutableLeaves])
        } catch {
            isDataNull = true
            print("no data here!")
        }

        if isDataNull == false{
            taskList = try! JSONDecoder().decode([TaskDataStructure].self, from: getData!)
        }
        return taskList
    }
    
    class func loadFriendsJson() -> [UserDataStructure] {
        let homePath = HandleLocalFile.getDocumentsDirectory()
        let friendFilePath = homePath.appendingPathComponent("friends.json")
        var friendList: [UserDataStructure] = []
        var isDataNull = false
        
        let getData = try? Data(contentsOf: friendFilePath)
        do{
            try JSONSerialization.jsonObject(with: getData!, options:[.mutableContainers, .mutableLeaves])
        } catch {
            isDataNull = true
            print("no data here!")
        }

        if isDataNull == false{
            friendList = try! JSONDecoder().decode([UserDataStructure].self, from: getData!)
        }
        return friendList
    }
    
    class func loadRankJson() -> [RankStructure] {
        let homePath = HandleLocalFile.getDocumentsDirectory()
        let rankFilePath = homePath.appendingPathComponent("ranking.json")
        var rankList: [RankStructure] = []
        var isDataNull = false
        
        let getData = try? Data(contentsOf: rankFilePath)
        do{
            try JSONSerialization.jsonObject(with: getData!, options:[.mutableContainers, .mutableLeaves])
        } catch {
            isDataNull = true
            print("no data here!")
        }

        if isDataNull == false{
            rankList = try! JSONDecoder().decode([RankStructure].self, from: getData!)
        }
        return rankList
    }
}
