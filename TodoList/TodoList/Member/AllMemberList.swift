//
//  AllMemberList.swift
//  TodoList
//
//  Created by 陈子迪 on 2021/1/10.
//

import SwiftUI

struct AllMemberList: View {
    var task: TaskDataStructure
    @EnvironmentObject private var userList: UserData
    
    var body: some View {
        VStack (alignment: .leading){
            HStack{
                Spacer()
                NavigationLink(destination: AddMember()) {
                   Text("Add Member  ")
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            List{
                ForEach(task.members, id: \.self) { memID in
                        MemberRow(memID: memID)
                            .environmentObject(UserData())
                }
            }
        }
        .navigationBarTitle("Task Members")
    }
}

struct AllMemberList_Previews: PreviewProvider {
    static var previews: some View {
        AllMemberList(task: taskDataSet[0])
            .environmentObject(UserData())
    }
}
