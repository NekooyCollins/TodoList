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
    @Published var startGroupTaskFlag = false
    @Published var quitGroupTaskFlag = false

    func postLoginRequest(email: String, passwd: String) {
        guard let url = URL(string: "http://192.168.31.91:8080/login") else { return }
        let body: [String: String] = ["email": email, "passwd": passwd]
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
                        self.authenticated = true
                        self.currentUserEmail = email
                        localUserData.email = email
                        localAuth = true
                    }
                }
            }
        }.resume()
    }
    
    func postRegisterRequest(username: String, email: String, passwd: String){
        guard let url = URL(string: "http://192.168.31.91:8080/register") else { return }
        let body: [String: String] = ["name": username, "email": email, "passwd": passwd]
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
                        self.legalregister = true
                    }
                }
            }
        }.resume()
    }
    
    func getUserData(){
        let urlString: String = "http://192.168.31.91:8080/getuserdata?email=" + localUserData.email
        let url = URL(string: urlString)!
//        print("ask for:" + localUserData.email)
        
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
                let resData = try! JSONDecoder().decode(UserDataStructure.self, from: data)
                DispatchQueue.main.async {
                    self.userInfo = resData
                    // Store to local user data
                    localUserData = resData
                }
            }
        }.resume()
    }
    
    func getUserDataByEmail(email: String){
        let urlString: String = "http://192.168.31.91:8080/getuserdata?email=" + email
        let url = URL(string: urlString)!
//        print("ask for:" + localUserData.email)
        
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
                let resData = try! JSONDecoder().decode(UserDataStructure.self, from: data)
                DispatchQueue.main.async {
                    self.tmpRetUser = resData
                    self.getUserByEmailFlag = true
                }
            }
        }.resume()
    }
    
    func getTaskList(){
        let url = URL(string: "http://192.168.31.91:8080/gettasklist?email="+localUserData.email)!
        var request = URLRequest(url: url)
        var dataIsNull = false
        
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
    }
    
    func getTaskMember(taskid: String){
        let url = URL(string: "http://192.168.31.91:8080/gettaskmember?taskid="+taskid)!
        
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
    
    func getFriendList(email:String){
        let url = URL(string: "http://192.168.31.91:8080/getfriendlist?email="+email)!
        var request = URLRequest(url: url)
        var dataIsNull = false
        
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
                    localFriendList = []
                    localFriendList = resData
                }
            }
        }.resume()
    }
    
    func getRankList(userid: String){
        let url = URL(string: "http://192.168.31.91:8080/getranklist?userid="+userid)!
        var request = URLRequest(url: url)
        var dataIsNull = false
        
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
                }
            }
        }.resume()
    }
    
    
    func postAddTask(addTask: AddTaskStructure) {
        
        guard let url = URL(string: "http://192.168.31.91:8080/addtask") else { return }
        let finalBody: Data = try! JSONEncoder().encode(addTask)
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
    
    func postAddFriend(myEmail: String, friendEmail: String) {
        guard let url = URL(string: "http://192.168.31.91:8080/addfriend") else { return }
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
    
    func getGroupTaskState(){
        let urlString: String = "http://192.168.31.91:8080/getgrouptaskstate?id=" + String(localUserData.id)
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
                self.inviteToGroupTask = false
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
    
    func postTaksIsFinished(taskid: String){
        guard let url = URL(string: "http://192.168.31.91:8080/settaskisfinished") else { return }
        let body: [String: String] = ["taskid": taskid]
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
                        self.taskFinishedFlag = true
                    }
                }
            }
        }.resume()
    }
    
    func postStartGroupTask(task: TaskDataStructure){
        guard let url = URL(string: "http://192.168.31.91:8080/startgrouptask") else { return }
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
//                        self.startGroupTaskFlag = true
                        print("create succeed")
                    }
                }
            }
        }.resume()
    }
    
    func postJoinGroupTask(userid: Int, taskid: Int){
        guard let url = URL(string: "http://192.168.31.91:8080/joingrouptask") else { return }
        let body: [String: String] = ["userid": String(userid), "taskid": String(taskid)]
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
//                        self.legalregister = true
                        print("join succeed")
                    }
                }
            }
        }.resume()
    }
    
    func checkStartGroupTask(taskid: Int){
        guard let url = URL(string: "http://192.168.31.91:8080/checkstartgrouptask") else { return }
        let body: [String: String] = ["taskid": String(taskid)]
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
    
    func quitGroupTask(taskid: Int){
        guard let url = URL(string: "http://192.168.31.91:8080/quitgrouptask") else { return }
        let body: [String: String] = ["taskid": String(taskid)]
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
//                        self.startGroupTaskFlag = true
                    }
                }
            }
        }.resume()
    }
    
    func checkGroupTaskQuit(taskid: Int){
        guard let url = URL(string: "http://192.168.31.91:8080/checkgrouptaskquit") else { return }
        let body: [String: String] = ["taskid": String(taskid)]
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
}
