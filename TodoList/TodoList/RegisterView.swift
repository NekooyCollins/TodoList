//
//  RegisterView.swift
//  ToDoList
//
//  Created by Xizhen Huang on 06.01.21.
//

import SwiftUI

struct RegisterView: View {
    @ObservedObject private var manager = RequestHandle()
    @State private var email: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var uFlag = false
    @State private var pFlag = false
    @State private var isEmailValid = true
    @State private var isLegal = false
    
    var isCanRegister: Bool {
        username.count >= 4 &&
        password.count >= 6
    }

    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        VStack {
            // app name
            HStack{
                Text("Create Account")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                
            }
            Spacer()
                .frame(height: 50.0)
            
            // information form
            Form {
                // email Hstack
                TextField("email", text: $email, onEditingChanged: { (isChanged) in
                    if !isChanged {
                        if isValidEmail(email) {
                            self.isEmailValid = true
                        } else {
                            self.isEmailValid = false
                            self.email = ""
                        }
                    }
                })
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                .prefixedWithIcon(named: "envelope.fill")
                
                if !isEmailValid {
                    Text("Email is Not Valid")
                        .font(.callout)
                        .foregroundColor(Color.red)
                }
                
                // username Hstack
                Section(footer: Text("  username should be no less than 4 letters")){
                    TextField("username", text: $username)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        .prefixedWithIcon(named: "person.fill")
                }
                
                // password HStack
                Section(footer: Text("  password should no less than 6 digits")){
                    SecureField("password", text: $password, onCommit: {})
                        .prefixedWithIcon(named: "lock.fill")
                }
            }
            .background(Color.orange)

            NavigationLink(
                destination: LoginView(),
                isActive: $isLegal
                ){
                if (isCanRegister) && (self.isEmailValid) {
                    Button(action: {
                        self.manager.postRegisterRequest(username: self.username, email: self.email, passwd: self.password)
                        if self.manager.legalregister == true{
                            isLegal = true
                        }
                    }) {
                        Text("Sign Up")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .frame(width: 300, height: 45, alignment: .center)
                    .background(Color.green)
                    .cornerRadius(20)
                }
            }
            Spacer()
        }
        .padding(.top, 80.0)
        .padding(.bottom, 20.0)
        .padding(.horizontal)
        .background(Color(UIColor.systemOrange).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
        .navigationBarTitle("Register")
        .navigationBarHidden(true)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

extension View {
    func prefixedWithIcon(named name: String) -> some View {
        HStack {
            Image(systemName: name)
                .foregroundColor(Color.orange)
            self
        }
    }
}

//struct Validation<Value>: ViewModifier {
//    var value: Value
//    var validator: (Value) -> Bool
//
//    func body(content: Content) -> some View {
//        Group {
//            if validator(value) {
//                content.border(Color.green)
//            } else {
//                content
//            }
//        }
//    }
//}

