//
//  UserDataStructure.swift
//  TodoList2
//
//  Created by 陈子迪 on 2020/12/30.
//

import Foundation
import SwiftUI
import CoreLocation

struct UserDataStructure : Hashable, Codable, Identifiable {
    var id : Int
    var name: String
    var email: String
    var passwd: String
    
    //FIXME: 
    init(){
        id      = 0;
        name    = "Lisa"
        email   = "lisa@apple.com"
        passwd  = "12345678"
    }
}
