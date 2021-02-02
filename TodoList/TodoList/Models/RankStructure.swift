//
//  RankStructure.swift
//  TodoList
//
//  Created by Xizhen Huang on 22.01.21.
//

import Foundation
import CoreLocation

struct RankStructure : Hashable, Codable {
    var username: String
    var totalfocustime: Int
    
    init(){
        username = ""
        totalfocustime = 0
    }
    
    func convertToDictionary() -> [String : Any] {
        let dic: [String: Any] = ["username":self.username, "totalfocustime":self.totalfocustime]
        return dic
    }
}
