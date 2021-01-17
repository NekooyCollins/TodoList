//
//  RankingListView.swift
//  ToDoList
//
//  Created by Xizhen Huang on 09.01.21.
//

import SwiftUI

struct RankingListView: View {
//    @EnvironmentObject private var allUserData: UserData
    @ObservedObject private var manager = RequestHandle()
    
    var body: some View {
//        NavigationView {
//            List {
//                ForEach(allUserData.dataset){ user in
//                    RankingRowView()
//                }
//            }
//            .navigationBarTitle(Text("Ranking"))
//        }
        Text("hello world")
    }
}

struct RankingListView_Previews: PreviewProvider {
    static var previews: some View {
        RankingListView()
    }
}
