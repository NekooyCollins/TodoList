//
//  AllMemberList.swift
//  TodoList
//
//  Created by 陈子迪 on 2021/1/10.
//

import SwiftUI

struct AllMemberList: View {
//    var inputTask: TaskDataStructure
    @ObservedObject private var manager = RequestHandle()
    
    init(inputTask: TaskDataStructure){
        self.manager.getTaskMember(taskid: String(inputTask.id))
    }
    
    var body: some View {
        VStack (alignment: .leading){
            HStack{
                Spacer()
//                NavigationLink(destination: AddMember()) {
//                   Text("Add Member  ")
//                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
//                }
//                .buttonStyle(PlainButtonStyle())
            }

            List{
                ForEach(manager.taskMemberList, id: \.self) { mem in
                    MemberRow(user: mem)
                }
            }
        }
        .navigationBarTitle("Task Members")
    }
}

struct AllMemberList_Previews: PreviewProvider {
    static var previews: some View {
        AllMemberList(inputTask: localTestTask)
    }
}
