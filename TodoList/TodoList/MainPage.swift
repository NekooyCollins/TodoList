//
//  HomepageView.swift
//  TodoList
//
//  Created by 陈子迪 on 2020/12/30.
//

import SwiftUI

struct MainPageView: View {
    @EnvironmentObject private var taskData: TaskData
    @EnvironmentObject private var userData: UserData
    
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
                

//                List{
//                    ForEach(0..<4, id: \.self) { idx in
//                        NavigationLink(destination: TaskDetail(task: taskData.dataset[idx])) {
//                                TaskRow(task: taskData.dataset[idx])
//                        }
//                        .buttonStyle(PlainButtonStyle())
//                    }
//                }
//                .navigationBarTitle("Tasks")
//                .listRowInsets(EdgeInsets())
//                .navigationBarHidden(true)
//                .frame(height: 200)
//
                
                VStack{
                    ForEach(0..<4, id: \.self) { idx in
                        HStack{
                            Text(taskData.dataset[idx].title)
                                .lineLimit(0)
                                .padding(.top, 1.0)
                        }
                        Spacer().frame(height: 5)
                    }
                }
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 40, maxHeight: 120, alignment: .center)
                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 1.0, saturation: 0.0, brightness: 0.97)/*@END_MENU_TOKEN@*/)
                .border(/*@START_MENU_TOKEN@*/Color.gray/*@END_MENU_TOKEN@*/, width: 0.3)
                .cornerRadius(4.0)
                
                VStack (alignment: .leading){
                    Spacer().frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    HStack{
                        NavigationLink(destination: TaskList()) {
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
                    Text("Statistics")
                        .bold()
                        .font(.title2)
                    HStack{
                        Spacer()
                        NavigationLink(destination: TaskList()) {
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
        MainPageView()
            .environmentObject(TaskData())
            .environmentObject(UserData())
    }
}
