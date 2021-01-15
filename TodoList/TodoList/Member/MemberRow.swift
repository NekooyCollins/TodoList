//
//  MemberRow.swift
//  TodoList
//
//  Created by 陈子迪 on 2021/1/14.
//

import SwiftUI

struct MemberRow: View {
    var memID: Int
    @EnvironmentObject private var userList: UserData
    
    var body: some View {
        HStack{
            Text(getMemName(memID: memID, userList: userList.dataset))
                .foregroundColor(.black)
        }
    }
}

struct MemberRow_Previews: PreviewProvider {
    static var previews: some View {
        MemberRow(memID: 0)
            .environmentObject(UserData())
    }
}
