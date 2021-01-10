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
