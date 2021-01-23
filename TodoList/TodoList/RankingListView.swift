//
//  RankingListView.swift
//  ToDoList
//
//  Created by Xizhen Huang on 09.01.21.
//

import SwiftUI

struct RankingListView: View {
    @ObservedObject private var rankingManager = RequestHandle()
    
    var body: some View {
        VStack{
            List {
                ForEach(rankingManager.rankList, id: \.self){ item in
                    RankingRowView(rankItem: item)
                }
            }
        }
        .navigationBarTitle(Text("Ranking"))
        .onAppear(perform: {
            rankingManager.getRankList(userid: String(localUserData.id))
        })
    }
}

struct RankingListView_Previews: PreviewProvider {
    static var previews: some View {
        RankingListView()
    }
}
