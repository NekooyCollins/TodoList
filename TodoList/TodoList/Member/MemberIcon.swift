//
//  MemberIcon.swift
//  TodoList
//
//  Created by 陈子迪 on 2021/1/9.
//

import SwiftUI
import Foundation

struct MemberIcon: View {
//    @ObservedObject private var manager = RequestHandle()
    var mem: UserDataStructure
    
    var body: some View {
        ZStack{
            Circle()
                .strokeBorder(Color.gray, lineWidth: 1.5)
//                .scaleEffect(0.125)

            Text(getShortMemName(fullName: mem.name))
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
        }

    }
}

struct MemberIcon_Previews: PreviewProvider {
    static var previews: some View {
        MemberIcon(mem: localUserData)
    }
}
