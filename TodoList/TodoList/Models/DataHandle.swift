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

//let taskDataSet: [TaskDataStructure] = load("taskdata.json")
//let userDataSet: [UserDataStructure] = load("userdata.json")

//func load<T: Decodable>(_ filename: String) -> T {
//    let data: Data
//    
//    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
//        else {
//            fatalError("Couldn't find \(filename) in main bundle.")
//    }
//    
//    do {
//        data = try Data(contentsOf: file)
//    } catch {
//        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
//    }
//
//    do {
//        let decoder = JSONDecoder()
//        return try decoder.decode(T.self, from: data)
//    } catch {
//        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
//    }
//}

func getMemName(memID: UUID, userList: [UserDataStructure]) -> String {
    var fullName: String = ""

    for user in userList{
        if user.id == memID {
            fullName = user.name
        }
    }

    return fullName
}

func getShortMemName(fullName: String) -> String {
    var ret: String = ""
    
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

// Transform Int to time format
func timeFormat(originalTime: Int) -> String{
    let hours = originalTime / 60
    let minutes = originalTime % 60
    var result: String
    
    result = String(hours) + "h" + String(minutes) + "m"
    return result
}

func showTimer(originalTime: Int) -> String{
    let hours = originalTime / 3600
    let minutes = originalTime % 3600 / 60
    let seconds = originalTime % 60
    var result: String
 
    result = String(hours) + " : " + String(minutes) + " : " + String(seconds)
    
    return result
}

// email validation
func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}

func getUserEmail(memID: UUID, userList: [UserDataStructure]) -> String {
    var email: String = ""
    for user in userList{
        if user.id == memID {
            email  = user.email
        }
    }
    return email
}

func getUserFullName(memID: UUID, userList: [UserDataStructure]) -> String {
    var fullName: String = ""
    
    for user in userList{
        if user.id == memID {
           fullName  = user.name
        }
    }
    return fullName
}

