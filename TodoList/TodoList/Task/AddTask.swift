//
//  AddTask.swift
//  TodoList
//
//  Created by 陈子迪 on 2021/1/9.
//

import SwiftUI
import UIKit

struct AddTask: View {
    @ObservedObject private var manager = RequestHandle()
    @ObservedObject private var tmpmanager = RequestHandle()
    @State private var inputDuration: String = ""
    @State private var inputType: String = ""
    @State private var newTask = AddTaskStructure()
    @State private var tmpMem = UserDataStructure()
    @State private var isDone = false
    @State private var addMember = false

    var body: some View {
        VStack{
            VStack{
                TextField("Title", text: $newTask.title, onCommit: {})
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Description", text: $newTask.description, onCommit: {})
                    .textFieldStyle(RoundedBorderTextFieldStyle())

            }
            .padding()
            VStack (alignment: .leading){
                HStack{
                    Text("Duration").font(.title3).bold()
                    Spacer()
                }
                HStack{
                    TextField("Countdown duration",
                              text: $inputDuration)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text("minutes")
                }
            }
            .padding()
            VStack{
                HStack{
                    Text("Member").font(.title3).bold()
                    Spacer()
                }
                List{
                    ForEach(newTask.member, id: \.self) { mem in
                            MemberRow(user: mem)
                    }
                }
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                HStack{
//                    NavigationLink(destination: AllMemberList(inputTask: newTask)) {
//                       Text("All members")
//                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
//                    }
//                    .buttonStyle(PlainButtonStyle())
                    Spacer().frame(width: 240)
//                    NavigationLink(destination: AddMember()) {
//                       Text("Add member")
//                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
//                    }
//                    .buttonStyle(PlainButtonStyle())
                    Button(action: {
                        addMember = true
                    }) {
                        Text("Add member")
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: 120, maxWidth: 120, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
                    .alert(isPresented: $addMember,
                           TextAlert(title: "Add Member",
                                     message: "Enter member email") { result in
                            if let text = result {
                                // Text was accepted
                                print("Search for "+text)
                                tmpmanager.getUserDataByEmail(email: text)
                                if tmpmanager.getUserByEmailFlag {
                                    tmpMem = tmpmanager.userInfo
                                    newTask.member.append(tmpMem)
                                    tmpmanager.getUserByEmailFlag = false
                                }
                            }
                           })
                }
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: 30, maxWidth:.infinity, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 10, maxHeight: 20, alignment: .topTrailing)
            }
            .padding()
            VStack{
                HStack{
                    Text("Type").font(.title3).bold()
                    Spacer()
                }
                TextField("Type", text: $newTask.typestr)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding()

            // TODO: add 'Done' button here
            VStack{
                NavigationLink(
                    destination: MainPageView(),
                    isActive: $isDone){
                    Button(action: {
                        newTask.duration = Int(inputDuration) ?? 0
                        self.manager.postAddTask(addTask: newTask)
                        if self.manager.addTaskFlag == true{
                            isDone = true
                        }
                    }) {
                        Text("Done")
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }
                }
            }

            Spacer()
        }
        .navigationBarTitle("Add Task")
    }
}

struct AddTask_Previews: PreviewProvider {
    static var previews: some View {
        AddTask()
    }
}
