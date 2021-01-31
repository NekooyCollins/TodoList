//
//  TaskList.swift
//  TodoList
//
//  Created by 陈子迪 on 2021/1/7.
//

import SwiftUI

struct TaskList: View {
    @ObservedObject private var manager = RequestHandle()
    @State var bakToMain: Bool = false
    
    var body: some View {
        VStack (alignment: .leading){
            HStack{
                Spacer()
                NavigationLink(destination: AddTask()) {
                   Text("Add Task  ")
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            List{
                ForEach(manager.taskList, id: \.self) { task in
                    if task.isfinish == false{
                        NavigationLink(destination: TaskDetail(task: task)) {
                                TaskRow(task: task)
                        }
                    }
                }
            }
            .onAppear(perform: {
                manager.getUserData()
                manager.getTaskList()
            })
        }
        .navigationBarTitle("Tasks")
    }
}
