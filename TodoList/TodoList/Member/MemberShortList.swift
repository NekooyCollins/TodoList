//
//  MemberShortList.swift
//  TodoList
//
//  Created by 陈子迪 on 2021/1/10.
//

import SwiftUI

struct MemberShortList: View {
    @EnvironmentObject private var userList: UserData
    var task: TaskDataStructure
    
    var body: some View {
        let max: Int = task.members.count >= 5 ? 5 : task.members.count
        
        VStack{
            HStack{
                ForEach(0..<max, id: \.self) { idx in
                    MemberIcon(memID: task.members[idx])
                }
            }
        }
    }
}

struct MemberShortList_Previews: PreviewProvider {
    static var previews: some View {
        let task = TaskData().dataset[0]
        MemberShortList(task: task)
            .environmentObject(UserData())
    }
}
