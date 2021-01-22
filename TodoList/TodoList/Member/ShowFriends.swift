//
//  ShowFriends.swift
//  TodoList
//
//  Created by Xizhen Huang on 21.01.21.
//

import SwiftUI

struct ShowFriends: View {
    @ObservedObject private var friendManager = RequestHandle()
    @State private var addFriend = false
    
    var body: some View {
        VStack (alignment: .leading){
            HStack {
                Text("My Friends")
                    .bold()
                    .font(.title)
                
                Button(action: {
                    addFriend = true
                }) {
                    Image(systemName: "person.crop.circle.fill.badge.plus")
                        .resizable()
                        .frame(width: 35.0, height: 30.0)
                        .foregroundColor(Color.orange)
                }.alert(isPresented: $addFriend,
                        TextAlert(title: "Add a new friend",
                                  message: "Enter email") { result in
                         if let friendEmail = result {
                            print("Search for " + friendEmail)
                            friendManager.postAddFriend(myEmail:localUserData.email, friendEmail: friendEmail)
                            friendManager.getFriendList(email: localUserData.email)
                         }
                 })
            }
            .frame(height: 30.0)
            .padding(.horizontal)
            
            List{
                ForEach(friendManager.friendList, id: \.self) { friend in
                    HStack{
                        Text(friend.name)
                            .foregroundColor(.orange)
                        Spacer()
                        Text(friend.email)
                            .foregroundColor(.gray)
                    }
                }// end of ForEach
            }
            .onAppear(perform: {
                friendManager.getFriendList(email: localUserData.email)
            })
        }
        .navigationBarTitle("Friends")
        .navigationBarHidden(true)
        .onAppear(perform: {
            friendManager.getFriendList(email: localUserData.email)
        })
    }
}

struct ShowFriends_Previews: PreviewProvider {
    static var previews: some View {
        ShowFriends()
    }
}
