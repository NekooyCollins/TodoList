//
//  RankingRowView.swift
//  ToDoList
//
//  Created by Xizhen Huang on 09.01.21.
//

import SwiftUI

struct RankingRowView: View {
    var user: UserDataStructure
    @EnvironmentObject private var userList: UserData
    
    var body: some View {
        // single item
        HStack {
            ZStack {
                Circle().fill(Color.orange).scaleEffect(0.7)
                Text(getShortMemName(memID: user.id, userList: userList.dataset))
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
                    .frame(width: 150.0)
            }
            ZStack{
                Text(timeFormat(originalTime: user.totalFocusTime))
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
                    .frame(width: 150.0)
            }
            ZStack{
                Spacer()
                    .frame(width: 50.0)
            }
        }
        .frame(height: 80.0)
        .background(SwiftUI.Color.yellow)
        .cornerRadius(10)
    }
}

struct RankingRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RankingRowView(user: userDataSet[0])
        }
    }
}
