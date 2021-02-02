//
//  MemberShortList.swift
//  TodoList
//
//  Created by 陈子迪 on 2021/1/10.
//

import SwiftUI

struct MemberShortList: View {
    @ObservedObject private var manager = RequestHandle()
//    var task: TaskDataStructure
    init(inputTask: TaskDataStructure){
        self.manager.getTaskMember(taskid: inputTask.id)
    }
    
    var body: some View {
        let max: Int = manager.taskMemberList.count >= 5 ? 5 : manager.taskMemberList.count

        VStack{
            HStack{
                ForEach(0..<max, id: \.self) { idx in
                    MemberIcon(mem: manager.taskMemberList[idx])
                }
            }
        }
    }
}

struct MemberShortList_Previews: PreviewProvider {
    static var previews: some View {
        MemberShortList(inputTask: localTestTask)
    }
}
