//
//  AddTask.swift
//  TodoList
//
//  Created by 陈子迪 on 2021/1/9.
//

import SwiftUI
import UIKit

struct AddTask: View {
    var currentUser: UserDataStructure
    @State private var inputTitle: String = ""
    @State private var inputDesc: String = ""
    @State private var inputDuration: Int = 0
    @State private var inputType: String = ""
    @State private var newTask = TaskDataStructure()
    
    var body: some View {
        VStack{
            VStack{
                TextField("Title", text: $inputTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Description", text: $inputDesc)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

            }
            .padding()
            VStack (alignment: .leading){
                HStack{
                    Text("Duration").font(.title3).bold()
                    Spacer()
                }
                HStack{
                    TextField("Countdown duration", text: $inputDesc)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text("min")
                }
            }
            .padding()
            VStack{
                HStack{
                    Text("Member").font(.title3).bold()
                    Spacer()
                }
                List{
                    ForEach(newTask.members, id: \.self) { memID in
                            MemberRow(memID: memID)
                                .environmentObject(UserData())
                    }
                }
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                HStack{
                    NavigationLink(destination: AllMemberList(task: newTask)) {
                       Text("All members")
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }
                    .buttonStyle(PlainButtonStyle())
                    Spacer()
                    NavigationLink(destination: AddMember()) {
                       Text("Add members")
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
            VStack{
                HStack{
                    Text("Type").font(.title3).bold()
                    Spacer()
                }
                TextField("Type", text: $inputType)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding()
            
            // TODO: add 'Done' button here
            
            Spacer()
        }
        .navigationBarTitle("Add Task")
    }
}

struct AddTask_Previews: PreviewProvider {
    static var previews: some View {
        AddTask(currentUser: userDataSet[0])
    }
}
