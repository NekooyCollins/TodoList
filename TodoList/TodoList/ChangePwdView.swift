//
//  ChangePwdView.swift
//  TodoList
//
//  Created by Xizhen Huang on 14.01.21.
//

import SwiftUI

struct ChangePwdView: View {
    @State private var newPwd: String = ""
    @State private var repeatPwd: String = ""
    
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    
    var pwdValidation: Bool {
        newPwd.count >= 6 &&
        repeatPwd.count >= 6 &&
        newPwd == repeatPwd
    }
    
    var body: some View {
        VStack{
            Form{
                Section(footer: Text("  password should no less than 6 digits")){
                    SecureField("new password", text: $newPwd)
                    SecureField("repeat password", text: $repeatPwd)
                }
            }
            .frame(height: 180.0)
            
            Button(action: {
                print("new password confirm")
            }) {
                Text("Confirm")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            .frame(width: 300, height: 40, alignment: .center)
            .background(pwdValidation ? Color.green : Color.gray)
            .cornerRadius(20)
            .disabled(!pwdValidation)
            
            Spacer()
        }
        .background(Color(UIColor.systemOrange).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
        .navigationBarTitle("Password")
    }
}

struct ChangePwdView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePwdView()
    }
}
