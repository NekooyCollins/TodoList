//
//  Countdown.swift
//  TodoList
//
//  Created by Xizhen Huang on 20.01.21.
//

import SwiftUI

//Button(action: {
//    if task.isgrouptask == false{
//        self.taskCanStart = true
//    }else{
//        if manager.startGroupTaskFlag == true {
//            self.taskCanStart = true
//        }else{
//            self.showingAlert = true
//            manager.postStartGroupTask(task: task)
//            sleep(2)
//            manager.postJoinGroupTask(userid: localUserData.id, taskid: task.id)
//            sleep(5)
//            manager.checkStartGroupTask(taskid: task.id)
//        }
//    }
//}) {
//    Text("Start")
//    .alert(isPresented: $showingAlert) {
//            Alert(title: Text("Task will start after others join."), message: Text("Please wait"), dismissButton: .default(Text("Got it!")))
//        }
//
//}
//}

struct Countdown: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var manager = RequestHandle()
    @ObservedObject private var countdownManager = RequestHandle()
    @State private var showingAlert = false
    @State private var leave = false
    @State private var isActive = false
    @State private var timeRemaining = 0
    @State private var textContent = ""
    var task: TaskDataStructure
    @State private var showingAlert1 = false
    @State private var showingAlert2 = false
    @State private var waitingJoin = 30
    
    let timer  = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let timer2 = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var finishSuccessfully: Bool {
        leave == false &&
        timeRemaining == 0
    }
    
    var body: some View {
        
            VStack{
                ZStack{
                    Circle()
                        .strokeBorder(Color.orange,lineWidth: 2)
                        .background(Circle().foregroundColor(Color.white))
                        .scaleEffect(0.7)
                    
                    Text("\(showTimer(originalTime:timeRemaining))")
                        .font(.system(size: 46))
                        .fontWeight(.light)
                        .foregroundColor(Color.gray)
                }
                .frame(height: 400.0)
                
                Text(finishSuccessfully ? "Well done!" : "Stay focus :)")
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundColor(Color.orange)
                    
                Spacer()
                    .frame(height: 100.0)
                    
                Button(action: {
                    if (timeRemaining != 0) {
                        self.showingAlert = true
                    } else{
                        self.countdownManager.postTaksIsFinished(taskid: String(task.id))
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Text(finishSuccessfully ? "OK" : "Quit")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                .frame(width: 300, height: 45, alignment: .center)
                .background(Color(UIColor.systemPink))
                .cornerRadius(10)
                .alert(isPresented: $showingAlert) {() -> Alert in
                    let primaryButton = Alert.Button.default(Text("Yes")) {
                        self.timeRemaining = 0
                        self.leave = true
                        print("Yes button pressed")
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    let secondaryButton = Alert.Button.cancel(Text("No")) {
                        print("No button pressed")
                    }
                    return Alert(title: Text("Are you sure to leave?"), message: Text("Your task will fail :("), primaryButton: primaryButton, secondaryButton: secondaryButton)
                }
                .alert(isPresented: $showingAlert1) {() -> Alert in
                    let primaryButton = Alert.Button.default(Text("Yes")) {
//                        self.timeRemaining = 0
//                        self.leave = true
//                        print("Yes button pressed")
//                        self.presentationMode.wrappedValue.dismiss()
                    }
                    return Alert(title: Text("Waiting others to join."), message: Text("Pleas wait for a moment"), primaryButton: primaryButton, secondaryButton: .cancel())
                }
                .alert(isPresented: $showingAlert2) {() -> Alert in
                    let primaryButton = Alert.Button.default(Text("Yes")) {
                        self.timeRemaining = 0
                        self.leave = true
                        print("Yes button pressed")
                        self.presentationMode.wrappedValue.dismiss()
                    }
//                    let secondaryButton = Alert.Button.cancel(Text("No")) {
//                        print("No button pressed")
//                    }
                    return Alert(title: Text("Can not start this task."), message: Text("Other members not able to join, please try again."), primaryButton: primaryButton, secondaryButton: .cancel())
                }
                
                Spacer()
                    .frame(height: 150.0)
            }
            .onAppear(perform: {
                self.timeRemaining = task.duration * 60
            })
            .navigationBarTitle("Countdown")
            .navigationBarBackButtonHidden(true)
            .onReceive(timer) { time in
                guard self.isActive else { return }
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                self.isActive = false
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                self.isActive = true
            }
            .onReceive(timer2, perform: { time in
                if waitingJoin > 0 && isActive == false {
                    manager.checkStartGroupTask(taskid: task.id)
                    if manager.startGroupTaskFlag == true {
                        self.isActive = true
                    }
                    self.waitingJoin -= 1
                }else{
                    self.showingAlert2 = true
                }
            })
            .onAppear(perform: {
                if task.isgrouptask == false{
                    self.isActive = true
//                }else if manager.startGroupTaskFlag == true{
//                    self.isActive = true
                }else{
                    self.showingAlert1 = true
                    manager.postStartGroupTask(task: task)
                    sleep(1)
                    manager.postJoinGroupTask(userid: localUserData.id, taskid: task.id)
//                    sleep(30)
//                    manager.checkStartGroupTask(taskid: task.id)
//                    if manager.startGroupTaskFlag == true {
//                        self.isActive = true
//                    }else{
//                        self.showingAlert2 = true
//                        self.presentationMode.wrappedValue.dismiss()
//                    }
                }
            })
       
    } // end of body view
}

//struct Countdown_Previews: PreviewProvider {
//    static var previews: some View {
//        Countdown()
//    }
//}



