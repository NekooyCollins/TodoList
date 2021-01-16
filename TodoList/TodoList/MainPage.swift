//
//  HomepageView.swift
//  TodoList
//
//  Created by 陈子迪 on 2020/12/30.
//

import SwiftUI

struct MainPageView: View {
    var user: UserDataStructure
    @EnvironmentObject private var taskData: TaskData
    @EnvironmentObject private var userData: UserData
    @ObservedObject private var manager = RequestHandle()
    
    
    init(inputuser: UserDataStructure) {
        UITableView.appearance().backgroundColor = .clear
        user = inputuser
    }
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading){
                VStack (alignment: .leading){
                    Text("My TodoList")
                        .bold()
                        .font(.title)
                    Spacer().frame(width: 100, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Text("Overview")
                        .bold()
                        .font(.title2)
                    Spacer().frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                
                VStack{
                    List(manager.taskList.taskResults) { task in
//                        ForEach(0..<4, id: \.self) {  in
//                             TODO: judge if task has finished
//                            NavigationLink(destination: TaskDetail(user: user, task: task)) {
//                                    TaskRow(task: task)
//                            }
//                            .buttonStyle(PlainButtonStyle())
//                        }
                    }
                    .padding(.all, -40.0)
                    .navigationBarTitle("Tasks")
                    .listRowInsets(EdgeInsets())
                    .navigationBarHidden(true)
                    .frame(height: 180)
                }
                .padding(5.0)
                
                VStack (alignment: .leading){
                    Spacer().frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    HStack{
                        NavigationLink(destination: AddTask(currentUser: user)) {
                           Text("New Task")
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        }
                        .buttonStyle(PlainButtonStyle())
                        Spacer()
                        NavigationLink(destination: TaskList(user: user)) {
                           Text("View All")
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer().frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Text("Statistics")
                        .bold()
                        .font(.title2)
                    HStack{
                        Spacer()
                        NavigationLink(destination: TaskList(user: user)) {
                           Text("See Ranking")
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                Spacer()
            }
            .navigationBarTitle("Main page")
            .navigationBarHidden(true)
            .padding(.horizontal)
            .padding(.top)
        }
        .frame(width: .infinity, height: .infinity, alignment: .topLeading)
    }
}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView(inputuser: userDataSet[0])
            .environmentObject(TaskData())
            .environmentObject(UserData())
    }
}
