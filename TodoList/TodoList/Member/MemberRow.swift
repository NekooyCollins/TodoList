//
//  MemberRow.swift
//  TodoList
//
//  Created by 陈子迪 on 2021/1/14.
//

import SwiftUI

struct MemberRow: View {
    var user: UserDataStructure
    
    var body: some View {
        HStack{
            Text(user.name)
                .foregroundColor(.black)
        }
    }
}

struct MemberRow_Previews: PreviewProvider {
    static var previews: some View {
        MemberRow(user: localUserData)
    }
}
