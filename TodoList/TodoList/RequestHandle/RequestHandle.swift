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
    @Published var userInfo = UserDataStructure(id: 0, name: "", email: "", passwd: "", totalFocusTime: 0)
    @Published var taskList = AllTaskList(taskResults: [])
    @Published var taskMemberList = UserList(userResults: [])

    func postLoginRequest(email: String, passwd: String) {
        guard let url = URL(string: "http://127.0.0.1/login") else { return }
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
                    }
                }
            }
        }.resume()
    }
    
    func postRegisterRequest(username: String, email: String, passwd: String){
        guard let url = URL(string: "http://127.0.0.1/login") else { return }
        let body: [String: String] = ["username": username, "email": email, "passwd": passwd]
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
                    }
                }
            }
        }.resume()
    }
    
    func getUserData(email: String){
        let url = URL(string: "http://127.0.0.1/getuserdata")!
        let body: [String: String] = ["email": email]
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.httpBody = finalBody
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
                }
            }
        }.resume()
    }
    
    func getTaskList(userid: String){
        let url = URL(string: "http://127.0.0.1/gettasklist")!
        let body: [String: String] = ["userid": userid]
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.httpBody = finalBody
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
                let resData = try! JSONDecoder().decode(AllTaskList.self, from: data)
                DispatchQueue.main.async {
                    self.taskList = resData
                }
            }
        }.resume()
    }
    
    func getTaskMember(taskid: String){
        let url = URL(string: "http://127.0.0.1/gettaskmember")!
        let body: [String: String] = ["taskid": taskid]
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.httpBody = finalBody
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
                let resData = try! JSONDecoder().decode(UserList.self, from: data)
                DispatchQueue.main.async {
                    self.taskMemberList = resData
                }
            }
        }.resume()
    }
}

