//
//  ChangeNameView.swift
//  TodoList
//
//  Created by Xizhen Huang on 14.01.21.
//

import SwiftUI

struct ChangeNameView: View {
    @State private var newUsrName = ""
    
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    
    var pwdValidation: Bool {
        newUsrName.count >= 4
    }
    
    var body: some View {
        VStack{
            Form{
                Section(footer: Text("  username should be no less than 4 letters")){
                    TextField("New user name", text: $newUsrName)
                }
            }
            .frame(height: 120.0)
            
            Button(action: {
                print("new username confirm")
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
        .navigationBarTitle("Username")
    }
}

struct ChangeNameView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeNameView()
    }
}
