//
//  HomepageView.swift
//  TodoList
//
//  Created by 陈子迪 on 2020/12/30.
//

import SwiftUI

struct HomepageView: View {
    var body: some View {
        NavigationView {
            MainPageView()
                .environmentObject(TaskData())
                .environmentObject(UserData())
        }
    }
}

struct HomepageView_Previews: PreviewProvider {
    static var previews: some View {
        HomepageView()
            .environmentObject(TaskData())
            .environmentObject(UserData())
    }
}
