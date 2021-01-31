//
//  UserDetailView.swift
//  ToDoList
//
//  Created by Xizhen Huang on 10.01.21.
//

import SwiftUI

struct UserDetailView: View {
    @State private var email: String = ""
    @State private var username: String = ""
    @State private var uFlag = false
    @State private var eFlag = false

    var body: some View {
        VStack {

            // image
            ZStack {
                Circle().fill(Color.orange).scaleEffect(0.8)
                Text(getShortMemName(fullName: localUserData.name))
                    .font(.title)
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
            }
            .frame(height: 120.0)

            // user info Hstack
            HStack{
                VStack (alignment: .leading){
                    Text("Email")
                        .frame(height: 50.0)
                        .foregroundColor(/*@START_MENU_TOKEN@*/Color.orange/*@END_MENU_TOKEN@*/)
                    Text("User Name")
                        .frame(height: 50.0)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.orange/*@END_MENU_TOKEN@*/)
                    Text("Password")
                        .frame(height: 50.0)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.orange/*@END_MENU_TOKEN@*/)
                }
                .frame(width: 100.0)

                VStack (alignment: .leading){

                    HStack{
                        Spacer()
                        Text(localUserData.email)
                            .frame(height: 50.0)
                            .foregroundColor(.gray)
                    }

                    HStack{
                        Spacer()
                        Text(localUserData.name)
                            .frame(height: 50.0)
                            .foregroundColor(.gray)

                        NavigationLink(
                            destination: ChangeNameView(),
                            label: {
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            })
                    }

                    HStack{
                        Spacer()
                        Text("already seted")
                            .frame(height: 50.0)
                            .foregroundColor(.gray)
                        // change password link
                        NavigationLink(
                            destination: ChangePwdView(),
                            label: {
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            })
                    }
                }
                .frame(width: 250.0)
            }
            Spacer()

            // log out button
//            Button(action: {
//                localUserData.email = ""
//                localTaskList = []
//                localFriendList = []
//            }) {
//                Text("Log out")
//                    .fontWeight(.bold)
//                    .foregroundColor(.white)
//            }
//            .frame(width: 300, height: 45, alignment: .center)
//            .background(Color.red)
//            .cornerRadius(20)
        }
        .navigationBarTitle("Account")
        .padding(.horizontal)
        .padding(.vertical, 50.0)
    }
}

struct InfoPrefixedTextField: View {
    var iconName: String
    var title: String
    @Binding var text: String

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(Color.orange)
            TextField(title, text: $text)
            Text("edit")
                .foregroundColor(Color.blue)
        }
        .padding(.trailing)
        Divider()
            .padding(.top, 1.0)
            .background(Color.orange)
        Spacer()
            .frame(height: 20.0)
    }
}
