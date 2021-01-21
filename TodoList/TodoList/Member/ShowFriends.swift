//
//  ShowFriends.swift
//  TodoList
//
//  Created by Xizhen Huang on 21.01.21.
//

import SwiftUI

struct ShowFriends: View {
//    @State var friend1 = UserDataStructure()
//    @State var friend2 = UserDataStructure()
//    var friendList: [UserDataStructure]
    
    
//    @ObservedObject private var manager = RequestHandle()
//
//    init(inputTask: TaskDataStructure){
//        self.manager.getTaskMember(taskid: String(inputTask.id))
//    }
    
    var body: some View {
        VStack (alignment: .leading){
            HStack {
                Text("My Friends")
                    .bold()
                    .font(.title)
                Spacer()
                Image(systemName: "person.crop.circle.fill.badge.plus")
                    .resizable()
                    .frame(width: 35.0, height: 30.0)
                    .foregroundColor(Color.orange)
            }
            .padding(.horizontal)
            List{
//                ForEach(friendList, id: \.self) { mem in
                    HStack{
                        Text("Anna Hacker")
                            .foregroundColor(.orange)
                        Spacer()
                        Text("anna@apple.com")
                            .foregroundColor(.gray)
                    }
                    
//                }// end of ForEach
            }
        }
        .navigationBarTitle("Friends")
    }
}

struct ShowFriends_Previews: PreviewProvider {
    static var previews: some View {
        ShowFriends()
    }
}
