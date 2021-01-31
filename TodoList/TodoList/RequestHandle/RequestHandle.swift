//
//  RequestHandle.swift
//  TodoList
//
//  Created by Xizhen Huang on 15.01.21.
//

import Foundation
import Combine

class RequestHandle: ObservableObject{
    @Published var authenticated = false
    @Published var legalregister = false
    @Published var getUserByEmailFlag = false
    @Published var addTaskFlag = false
    @Published var currentUserEmail: String = ""
    @Published var userInfo = UserDataStructure()
    @Published var tmpRetUser = UserDataStructure()
    @Published var taskList: [TaskDataStructure] = []
    @Published var taskMemberList: [UserDataStructure] = []
    @Published var friendList: [UserDataStructure] = []
    @Published var rankList: [RankStructure] = []
    @Published var addFriendFlag = false
    @Published var inviteToGroupTask = false
    @Published var tmpRetTask = TaskDataStructure()
    @Published var taskFinishedFlag = false
    @Published var lostConnection = false
    @Published var startGroupTaskFlag = false
    @Published var quitGroupTaskFlag = false

    // Alreaday check connection
    func postLoginRequest(email: String, passwd: String) {
        let urlString = url + "/login"
        guard let url = URL(string: urlString) else { return }

        let body: [String: String] = ["email": email, "passwd": passwd]
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if Reachability.isConnectedToNetwork(){
            lostConnection = false
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse.statusCode)
                    if httpResponse.statusCode == 200{
                        DispatchQueue.main.async {
                            self.authenticated = true
                            self.currentUserEmail = email
                            localUserData.email = email
                            localAuth = true
                        }
                    }
                }
            }.resume()
        } else{
            lostConnection = true
        }
    }
    
    // Not check connection
    func postRegisterRequest(username: String, email: String, passwd: String){
        print("I am register")
        let urlString = url + "/register"
        guard let url = URL(string: urlString) else { return }
        
        let body: [String: String] = ["name": username, "email": email, "passwd": passwd]
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if Reachability.isConnectedToNetwork(){
            lostConnection = false
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse.statusCode)
                    if httpResponse.statusCode == 200{
                        DispatchQueue.main.async {
                            self.legalregister = true
                        }
                    }
                }
            }.resume()
        } else{
            lostConnection = true
        }
    }
    
    // Alreaday check connection
    func getUserData(){
        print("I am get user data")
        let urlString = url + "/getuserdata?email=" + localUserData.email
        let url = URL(string: urlString)!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if Reachability.isConnectedToNetwork(){
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard error == nil else {
                    print("Error: error get user data")
                    print(error!)
                    return
                }
                guard let data = data else {
                    print("Error: Did not receive data")
                    return
                }
                guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                    print("Error: HTTP request failed")
                    return
                }
                do{
                    let resData = try! JSONDecoder().decode(UserDataStructure.self, from: data)
                    DispatchQueue.main.async {
                        self.userInfo = resData
                        // Store to local user data
                        localUserData = resData
                    }
                }
            }.resume()
            
        }else{
            print("Internet Connection not Available!")
            self.userInfo = localUserData
        }
    }
    
    func getTaskList(){
        print("I am get task list")
        let urlString = url + "/gettasklist?email=" + localUserData.email
        let url = URL(string: urlString)!
      
        var request = URLRequest(url: url)
        var dataIsNull = false
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if Reachability.isConnectedToNetwork(){
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard error == nil else {
                    print(error!)
                    return
                }
                guard let data = data else {
                    print("Error: Did not receive data")
                    return
                }
                guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                    print("Error: HTTP request failed")
                    return
                }
                do {
                    try JSONSerialization.jsonObject(with: data, options: [])
                } catch {
                    dataIsNull = true
                    print("JSON error: \(error.localizedDescription)")
                }
                if (dataIsNull == false){
                    do{
                        let resData = try! JSONDecoder().decode([TaskDataStructure].self, from: data)
                        DispatchQueue.main.async {
                            self.taskList = resData
                            localTaskList = resData
                        }
                    }
                }
            }.resume()
            
        } else{
            print("Internet Connection not Available!")
            self.taskList = localTaskList
        }
    }
    
    // Not check connection
    func getTaskMember(taskid: UUID){
        print("I am get task member")
        let urlString = url + "/gettaskmember?taskid=" + taskid.uuidString
        let url = URL(string: urlString)!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            do{
                let resData = try! JSONDecoder().decode([UserDataStructure].self, from: data)
                DispatchQueue.main.async {
                    self.taskMemberList = resData
                }
            }
        }.resume()
    }
    
    // Alreaday check connection
    func getFriendList(email:String){
        print("I am get friend list")
        let urlString = url + "/getfriendlist?email=" + email
        let url = URL(string: urlString)!

        var request = URLRequest(url: url)
        var dataIsNull = false
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if Reachability.isConnectedToNetwork(){
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard error == nil else {
                    print(error!)
                    return
                }
                guard let data = data else {
                    print("Error: Did not receive data")
                    return
                }
                guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                    print("Error: HTTP request failed")
                    return
                }
                
                do {
                    try JSONSerialization.jsonObject(with: data, options: [])
                } catch {
                    dataIsNull = true
                    print("JSON error: \(error.localizedDescription)")
                }
                if(dataIsNull == false){
                    let resData = try! JSONDecoder().decode([UserDataStructure].self, from: data)
                    DispatchQueue.main.async {
                        self.friendList = resData
                        localFriendList = resData
                    }
                }
            }.resume()
            
        } else{
            print("Internet Connection not Available!")
            self.friendList = localFriendList
        }
    }
    
    // Alreaday check connection
    func getRankList(userid: UUID){
        print("I am get rank list")
        let urlString = url + "/getranklist?userid=" + userid.uuidString
        let url = URL(string: urlString)!

        var request = URLRequest(url: url)
        var dataIsNull = false
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if Reachability.isConnectedToNetwork(){
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard error == nil else {
                    print(error!)
                    return
                }
                guard let data = data else {
                    print("Error: Did not receive data")
                    return
                }
                guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                    print("Error: HTTP request failed")
                    return
                }
                do {
                    try JSONSerialization.jsonObject(with: data, options: [])
                } catch {
                    dataIsNull = true
                    print("JSON error: \(error.localizedDescription)")
                }
                if(dataIsNull == false){
                    let resData = try! JSONDecoder().decode([RankStructure].self, from: data)
                    DispatchQueue.main.async {
                        self.rankList = resData
                        localRankList = resData
                    }
                }
            }.resume()
            
        } else{
            print("Internet Connection not Available!")
            self.rankList = localRankList
        }
    }
    
    // Not check connection
    func postAddTask(addTask: AddTaskStructure) {
        print("I am post add task")
        
        let urlString = url + "/addtask"
        guard let url = URL(string: urlString) else { return }

        let finalBody: Data = try! JSONEncoder().encode(addTask)
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if Reachability.isConnectedToNetwork(){
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse.statusCode)
                    if httpResponse.statusCode == 200{
                        DispatchQueue.main.async {
                            self.addTaskFlag = true
                        }
                    }
                }
            }.resume()
            print(localTaskList)
        } else{
            var newLocalTask = TaskDataStructure()
            
            newLocalTask.id = addTask.id
            newLocalTask.title = addTask.title
            newLocalTask.description = addTask.description
            newLocalTask.typestr = addTask.typestr
            newLocalTask.duration = addTask.duration
            newLocalTask.isfinish = false
            newLocalTask.isgrouptask = false
            newLocalTask.remaintime = addTask.remaintime
            
            localTaskList.append(newLocalTask)
            print(localTaskList)
            HandleLocalFile.saveTaskToLocalFile(task: localTaskList)
        }   
    }
    
    // Not check connection
    func postAddFriend(myEmail: String, friendEmail: String) {
        print("I am post add friend")
        let urlString = url + "/addfriend"
        guard let url = URL(string: urlString) else { return }

        let body: [String: String] = ["myemail": myEmail, "friendemail": friendEmail]
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
                if httpResponse.statusCode == 200{
                    DispatchQueue.main.async {
                        self.addFriendFlag = true
                    }
                }
            }
        }.resume()
    }
    
    // Not check connection
    func getGroupTaskState(){
        print("I am get group task state")
        let urlString = url + "/getgrouptaskstate?id=" + localUserData.id.uuidString
        let url = URL(string: urlString)!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print("Error: error get user data")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            do{
                let resData = try! JSONDecoder().decode(TaskDataStructure.self, from: data)
                DispatchQueue.main.async {
                    self.inviteToGroupTask = true
                    self.tmpRetTask = resData
                }
            }
        }.resume()
    }
    
    func postTaksIsFinished(finishedTask: TaskDataStructure){
        print("I am post task is finished")
        let urlString = url + "/settaskisfinished"
        guard let url = URL(string: urlString) else { return }
        let body: [String: String] = ["taskid": finishedTask.id.uuidString]

        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if Reachability.isConnectedToNetwork(){
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse.statusCode)
                    if httpResponse.statusCode == 200{
                        DispatchQueue.main.async {
                            self.taskFinishedFlag = true
                        }
                    }
                }
            }.resume()
        } else{
            for idx in 0...localTaskList.count-1{
                if localTaskList[idx] == finishedTask{
                    localTaskList[idx].isfinish = true
                    print("Update finish flag successful")
                }
            }
        }
    }
    
    // Not check connection
    func postStartGroupTask(task: TaskDataStructure){
        print("I am post start group task")
        let urlString = url + "/startgrouptask"
        guard let url = URL(string: urlString) else { return }

        let finalBody: Data = try! JSONEncoder().encode(task)
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
                if httpResponse.statusCode == 200{
                    DispatchQueue.main.async {
                        print("create succeed")
                    }
                }
            }
        }.resume()
    }
    
    // Not check connection
    func postJoinGroupTask(userid: UUID, taskid: UUID){
        print("I am join group task")
        let urlString = url + "/checkstartgrouptask"
        guard let url = URL(string: urlString) else { return }
        let body: [String: String] = ["userid": userid.uuidString, "taskid": taskid.uuidString]

        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
                if httpResponse.statusCode == 200{
                    DispatchQueue.main.async {
                        print("join succeed")
                    }
                }
            }
        }.resume()
    }
    
    // Not check connection
    func checkStartGroupTask(taskid: UUID){
        print("I am check group task")
        let urlString = url + "/checkstartgrouptask"
        guard let url = URL(string: urlString) else { return }
        let body: [String: String] = ["taskid": taskid.uuidString]

        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
                if httpResponse.statusCode == 200{
                    DispatchQueue.main.async {
                        print("Task could start.")
                        self.startGroupTaskFlag = true
                    }
                }
            }
        }.resume()
    }
    
    // Not check connection
    func quitGroupTask(taskid: UUID){
        print("quit group task")
        let urlString = url + "/quitgrouptask"
        guard let url = URL(string: urlString) else { return }
        let body: [String: String] = ["taskid": taskid.uuidString]

        let finalBody = try! JSONSerialization.data(withJSONObject: body)  
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
                if httpResponse.statusCode == 200{
                    DispatchQueue.main.async {
                        print("Quit this task.")
                    }
                }
            }
        }.resume()
    }
    
    // Note check connection
    func checkGroupTaskQuit(taskid: UUID){
        print("I am check group task quit")
        let urlString = url + "/checkgrouptaskquit"
        guard let url = URL(string: urlString) else { return }
        let body: [String: String] = ["taskid": taskid.uuidString]

        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
                if httpResponse.statusCode == 200{
                    DispatchQueue.main.async {
                        print("Quit this task.")
                        self.quitGroupTaskFlag = true
                    }
                }
            }
        }.resume()
    }
    
    func postLocalDataUpdate(){
        print("I am update local data")
        let urlString = url + "/postlocaldataupdate?userid=" + localUserData.id.uuidString
        let url = URL(string: urlString)!

        let finalBody: Data = try! JSONEncoder().encode(localTaskList)
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
                if httpResponse.statusCode == 200{
                    DispatchQueue.main.async {
                        self.addTaskFlag = true
                    }
                }
            }
        }.resume()
    }
}
