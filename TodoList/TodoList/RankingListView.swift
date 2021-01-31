//
//  RankingListView.swift
//  ToDoList
//
//  Created by Xizhen Huang on 09.01.21.
//

import SwiftUI

struct RankingListView: View {
    @ObservedObject private var rankingManager = RequestHandle()
    let saveLocallyTimer = Timer.publish(every: 120, on: .main, in: .common).autoconnect()
    
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
            rankingManager.getRankList(userid: localUserData.id)
            HandleLocalFile.saveRankToLocalFile(ranklist: localRankList)
        })
        .onReceive(saveLocallyTimer) { time in
            HandleLocalFile.saveRankToLocalFile(ranklist: localRankList)
        }
    }
}

struct RankingListView_Previews: PreviewProvider {
    static var previews: some View {
        RankingListView()
    }
}
