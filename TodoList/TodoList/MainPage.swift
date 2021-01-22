//
//  HomepageView.swift
//  TodoList
//
//  Created by 陈子迪 on 2020/12/30.
//

import SwiftUI

struct MainPageView: View {
    @ObservedObject private var manager = RequestHandle()
    @State var bakToMain : Bool = false

    
    init() {
        UITableView.appearance().backgroundColor = .clear
        manager.getUserData()
        manager.getTaskList()
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
                    
                    List{
                        let max = manager.taskList.count > 4 ? 4 : manager.taskList.count
                        ForEach(0..<max, id: \.self) { idx in
                            if manager.taskList[idx].isfinish == false{
                                NavigationLink(destination: TaskDetail(task: manager.taskList[idx])) {
                                    TaskRow(task: manager.taskList[idx])
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                    .padding(.all, -40.0)
                    .navigationBarTitle("Tasks")
                    .listRowInsets(EdgeInsets())
                    .navigationBarHidden(true)
                    .frame(height: 180)
                    .onAppear(perform: {
                        manager.getUserData()
                        manager.getTaskList()
                    })
                }
                .padding(5.0)
                
                VStack (alignment: .leading){
                    Spacer().frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    HStack{
                        NavigationLink(destination: AddTask(isDone: $bakToMain)) {
                           Text("New Task")
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        }
                        .buttonStyle(PlainButtonStyle())
                        Spacer()
                        NavigationLink(destination: TaskList()) {
                           Text("View All")
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer().frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                    Text("Statistics")
//                        .bold()
//                        .font(.title2)
                    HStack{
                        Spacer()
                        NavigationLink(destination: RankingListView()) {
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
        .navigationBarTitle(Text("Main page"))
        .navigationBarHidden(true)
    }
}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}
