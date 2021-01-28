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
    // Create timer to check for group task update
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    let saveLocallyTimer = Timer.publish(every: 120, on: .main, in: .common).autoconnect()
    @State private var showingAlert = false
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading){
                HStack{
                    Text("My TodoList")
                        .bold()
                        .font(.title)
                    Spacer()
                    NavigationLink(destination: UserDetailView()){
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 30.0, height: 30.0)
                            .foregroundColor(Color.orange)
                    }
                }
                Text("Overview")
                    .bold()
                    .font(.title2)
                Spacer().frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
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
                    HStack{
                        NavigationLink(destination: ShowFriends()) {
                           Text("See Friends")
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        }
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
        .onAppear(perform: {
            manager.getUserData()
            manager.getTaskList()
            saveUserToLocalFile(user: localUserData)
            saveTaskToLocalFile(task: localTaskList)
        })
        .onReceive(timer) { time in
            manager.getGroupTaskState()
            if manager.inviteToGroupTask == true{
                showingAlert = true
            }
        }
        .alert(isPresented: $showingAlert){
            Alert(title: Text("You are invited to task "+manager.tmpRetTask.title),
                              message: Text("If you accept, please go to this task to start."),
                              dismissButton: .default(Text("OK")))
        }
        .onReceive(saveLocallyTimer) { time in
            saveUserToLocalFile(user: localUserData)
            saveTaskToLocalFile(task: localTaskList)
        }
    }
    
    func saveUserToLocalFile(user: UserDataStructure){
        let homePath = HandleLocalFile.getDocumentsDirectory()
        let userFilePath = homePath.appendingPathComponent("userdata.json")
        
        let userJSONArr = try! JSONEncoder().encode(user)
        let jsonString = String(data: userJSONArr, encoding: .utf8)!
        print("saveUserLocal function:" + jsonString)

        let userDict = try? JSONSerialization.jsonObject(with: userJSONArr) as? [String: Any]
        let os = OutputStream(url: userFilePath, append: false)
        
        os?.open()
        JSONSerialization.writeJSONObject(userDict,
                                          to: os!,
                                          options: JSONSerialization.WritingOptions.prettyPrinted,
                                          error: NSErrorPointer.none)
        os?.close()
    }
    
    func saveTaskToLocalFile(task: [TaskDataStructure]){
        let homePath = HandleLocalFile.getDocumentsDirectory()
        let taskFilePath = homePath.appendingPathComponent("taskdata.json")
        
        let taskListDict = task.map{$0.convertToDictionary()}
        print("saveTaskLocal function:")
        print(taskListDict)
        let data = try! JSONSerialization.data(withJSONObject: taskListDict,
                                                   options: JSONSerialization.WritingOptions.prettyPrinted)
        try! data.write(to: taskFilePath, options: .atomic)
    }
}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}
