//
//  Countdown.swift
//  TodoList
//
//  Created by Xizhen Huang on 20.01.21.
//

import SwiftUI

struct Countdown: View {
    @State private var showingAlert = false
    @State private var leave = false
    @State private var isActive = true
    @State private var timeRemaining = 20
    @State private var textContent = ""
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var finishSuccessfully: Bool {
        leave == false &&
        timeRemaining == 0
    }
    
    var body: some View {
        NavigationView{
            VStack{
                ZStack{
                    Circle()
                        .strokeBorder(Color.orange,lineWidth: 2)
                        .background(Circle().foregroundColor(Color.white))
                        .scaleEffect(0.7)
                    
                    Text("\(timeFormat(originalTime:timeRemaining))")
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
                    
                NavigationLink(destination: MainPageView(), isActive: $leave){
                    Button(action: {
                        if timeRemaining != 0 {
                            self.showingAlert = true
                        } else{
                            self.leave = true
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
                        }
                        let secondaryButton = Alert.Button.cancel(Text("No")) {
                            print("No button pressed")
                        }
                        return Alert(title: Text("Are you sure to leave?"), message: Text("Your task will fail :("), primaryButton: primaryButton, secondaryButton: secondaryButton)
                    }
                }
                
                Spacer()
                    .frame(height: 150.0)
            }
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
        } // end of NavigationView
    } // end of body view
}

struct Countdown_Previews: PreviewProvider {
    static var previews: some View {
        Countdown()
    }
}



