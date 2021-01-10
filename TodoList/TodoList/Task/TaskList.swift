//
//  TaskList.swift
//  TodoList
//
//  Created by 陈子迪 on 2021/1/7.
//

import SwiftUI

struct TaskList: View {
    @EnvironmentObject private var AllTaskData: TaskData
    
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
                ForEach(AllTaskData.dataset, id: \.self) { task in
                    NavigationLink(destination: TaskDetail(task: task)) {
                            TaskRow(task: task)
                    }
                }
            }
        }
        .navigationBarTitle("Tasks")
    }
}

struct TaskList_Previews: PreviewProvider {
    static var previews: some View {
        TaskList()
            .environmentObject(TaskData())
    }
}
