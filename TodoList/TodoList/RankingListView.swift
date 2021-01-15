//
//  RankingListView.swift
//  ToDoList
//
//  Created by Xizhen Huang on 09.01.21.
//

import SwiftUI

struct RankingListView: View {
    @EnvironmentObject private var allUserData: UserData
    
    var body: some View {
        NavigationView {
            List {
                ForEach(allUserData.dataset){ user in
                    RankingRowView(user: user)
                }
            }
            .navigationBarTitle(Text("Ranking"))
        }
    }
}

struct RankingListView_Previews: PreviewProvider {
    static var previews: some View {
        RankingListView()
            .environmentObject(UserData())
    }
}
