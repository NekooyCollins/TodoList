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
    
    init(){
        id      = 0;
        name    = ""
        email   = ""
        passwd  = ""
    }
    
    func convertToDictionary() -> [String : Any] {
        let dic: [String: Any] = ["id":self.id, "name":self.name, "email":self.email, "passwd":self.passwd]
        return dic
    }
}
