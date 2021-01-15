//
//  Data.swift
//  TodoList2
//
//  Created by 陈子迪 on 2020/12/30.
//

import Foundation
import UIKit
import SwiftUI
import CoreLocation

let taskDataSet: [TaskDataStructure] = load("taskdata.json")
let userDataSet: [UserDataStructure]  = load("userdata.json")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

func getShortMemName(memID: Int, userList: [UserDataStructure]) -> String {
    var fullName: String = ""
    var ret: String = ""
    
    for user in userList{
        if user.id == memID {
            fullName = user.name
        }
    }
    let fullNameArr = fullName.split(separator: " ")
    let firstName: String = String(fullNameArr[0])
    let lastName: String? = fullNameArr.count > 1 ? String(fullNameArr[1]) : nil
    
    if lastName != nil {
        ret = String(firstName[firstName.startIndex]) + String(lastName![lastName!.startIndex])
    }else{
        ret = String(firstName[firstName.startIndex])
    }
    
    return ret
}

func timeFormat(originalTime: Int) -> String{
    let hours = originalTime / 3600
    let minutes = originalTime % 3600 / 60
    let seconds = originalTime % 60
    var result: String
    
    result = String(hours) + "h" + String(minutes) + "m" + String(seconds) + "s"
    
    return result
}

// email validation
func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}

func getUserEmail(memID: Int, userList: [UserDataStructure]) -> String {
    var email: String = ""
    for user in userList{
        if user.id == memID {
            email  = user.email
        }
    }
    return email
}

func getUserFullName(memID: Int, userList: [UserDataStructure]) -> String {
    var fullName: String = ""
    
    for user in userList{
        if user.id == memID {
           fullName  = user.name
        }
    }
    return fullName
}
