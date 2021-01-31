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
    @State private var firstTime = true
    @State private var lostConnection = false
    let saveLocallyTimer = Timer.publish(every: 120, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        VStack (alignment: .leading){
            HStack {
                Text("My Friends")
                    .bold()
                    .font(.title)
                
                Button(action: {
                    if Reachability.isConnectedToNetwork(){
                        addFriend = true
                    } else{
                        lostConnection = true
                    }
                }) {
                    Image(systemName: "person.crop.circle.fill.badge.plus")
                        .resizable()
                        .frame(width: 35.0, height: 30.0)
                        .foregroundColor(Color.orange)
                }
                .alert(isPresented: $addFriend,
                        TextAlert(title: "Add a new friend",
                                  message: "Enter email") { result in
                         if let friendEmail = result {
                            print("Search for " + friendEmail)
                            friendManager.postAddFriend(myEmail:localUserData.email, friendEmail: friendEmail)
                         }
                    })
                .alert(isPresented: $lostConnection) { () -> Alert in
                    Alert(title: Text("Network is not available :("), message: Text("you can't add new friend now"))
                }
            }
            .frame(height: 30.0)
            .padding(.horizontal)
            
            List{
                ForEach(localFriendList, id: \.self) { friend in
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
                HandleLocalFile.saveFriendsToLocalFile(friends: localFriendList)
            })
        }
        .onReceive(saveLocallyTimer) { time in
            HandleLocalFile.saveFriendsToLocalFile(friends: localFriendList)
        }
    }
}

struct ShowFriends_Previews: PreviewProvider {
    static var previews: some View {
        ShowFriends()
    }
}
