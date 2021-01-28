//
//  Countdown.swift
//  TodoList
//
//  Created by Xizhen Huang on 20.01.21.
//

import SwiftUI

struct Countdown: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var manager = RequestHandle()
    @ObservedObject private var countdownManager = RequestHandle()
    @State private var showingAlert = false
    @State private var leave = false
    @State private var isActive = false
    @State private var startFlag = false
    @State private var timeRemaining = 0
    @State private var textContent = ""
    var task: TaskDataStructure
    @State private var showingAlert1 = false // Alert when battery level is lower than 10%.
    @State private var showingAlert2 = false // Alert when others in a group task quit.
    @State private var waitingJoin = 30
    
    let timer  = Timer.publish(every: 1, on: .main, in: .common).autoconnect() // Countdown timer.
    let timer2 = Timer.publish(every: 1, on: .main, in: .common).autoconnect() // Wait other members to join a group task.
    let timer3 = Timer.publish(every: 1, on: .main, in: .common).autoconnect() // Check if group task has been quit by ohters.
    @State private var postInterval = 3
    @State private var postCount = 0
    
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
                
                Text(startFlag == false && task.isgrouptask ? "Please wait others to join" : "")
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundColor(Color.orange)
                
                Text(finishSuccessfully ? "Well done!" : "Stay focus :)")
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundColor(Color.orange)
                
                Text("")
                    .alert(isPresented: $showingAlert1){() -> Alert in
                        let primaryButton = Alert.Button.default(Text("Yes")) {
                            self.leave = true
                            print("Yes button pressed")
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        let secondaryButton = Alert.Button.cancel(Text("Cancel")) {
                            print("No button pressed")
                        }
                        return Alert(title: Text("Failed to start group task. Pleas try again."), message: Text("Task will return"), primaryButton: primaryButton, secondaryButton: secondaryButton)
                    }
                
                Text("")
                    .onAppear(perform: {
                        if checkBatteryLevel() > 0.0 && checkBatteryLevel() < 0.1 {
                            self.showingAlert2 = true
                        }
                    })
                    .alert(isPresented: $showingAlert2){() -> Alert in
                        let primaryButton = Alert.Button.default(Text("Yes")) {
                            self.leave = true
                            print("Yes button pressed")
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        let secondaryButton = Alert.Button.cancel(Text("Cancel")) {
                            print("No button pressed")
                        }
                        return Alert(title: Text("Battery low, can not start group task."), message: Text("Please charge and try again."), primaryButton: primaryButton, secondaryButton: secondaryButton)
                    }
                    
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
                        if task.isgrouptask == true{
                            manager.quitGroupTask(taskid: task.id)
                        }
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    let secondaryButton = Alert.Button.cancel(Text("No")) {
                        print("No button pressed")
                    }
                    return Alert(title: Text("Are you sure to leave?"), message: Text("Your task will fail :("), primaryButton: primaryButton, secondaryButton: secondaryButton)
                }

                Spacer()
                    .frame(height: 150.0)
            }
            .onAppear(perform: {
                self.timeRemaining = task.duration * 60
            })
            .onAppear(perform: {
                if checkBatteryLevel() < 0.1{
                    self.showingAlert1 = true
                }
            })
            .navigationBarTitle("Countdown")
            .navigationBarBackButtonHidden(true)
            .onAppear(perform: {
                if task.isgrouptask == false{
                    self.startFlag = true
                }else{
                    manager.postStartGroupTask(task: task)
                    sleep(1)
                    manager.postJoinGroupTask(userid: localUserData.id, taskid: task.id)
                }
            })

            .onReceive(timer) { time in
                if self.startFlag == true{
                    if self.timeRemaining > 0 {
                        self.timeRemaining -= 1
                    }
                }
            }
            .onReceive(timer2, perform: { time in
                if task.isgrouptask == false{
                    self.timer2.upstream.connect().cancel()
                    self.startFlag = true
                }
                if waitingJoin > 0 {
                    self.postCount += 1
                    // Change check post request frequency based on battery level.
                    if checkBatteryLevel() < 0.3 && checkBatteryLevel() > 0.1 {
                       postInterval = 10
                    }else if checkBatteryLevel() > 0.3{
                        postInterval = 3
                    }else{
                        postInterval = 1000
                    }
                    
                    if postCount % postInterval == 0{
                        manager.checkStartGroupTask(taskid: task.id)
                        if manager.startGroupTaskFlag == true {
                            self.startFlag = true
                        }
                        self.waitingJoin -= postInterval
                    }
                }else{
                    if startFlag == false{
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            })
            .onReceive(timer3, perform: { time in
                self.postCount += 1
                if task.isgrouptask == true && self.startFlag == true{
                    // Change check post request frequency based on battery level.
                    if checkBatteryLevel() < 0.3 && checkBatteryLevel() > 0.1 {
                       postInterval = 10
                    }else if checkBatteryLevel() > 0.3{
                        postInterval = 3
                    }else{
                        postInterval = 1000
                    }
                    
                    if postCount % postInterval == 0 {
                        manager.checkGroupTaskQuit(taskid: task.id)
                        if manager.quitGroupTaskFlag == true{
                            self.timeRemaining = 0
                            self.leave = true
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            })
    } // end of body view
}

//struct Countdown_Previews: PreviewProvider {
//    static var previews: some View {
//        Countdown()
//    }
//}



