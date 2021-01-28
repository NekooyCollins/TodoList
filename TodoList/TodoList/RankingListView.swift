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
            rankingManager.getRankList(userid: String(localUserData.id))
            saveRankToLocalFile(ranklist: localRankList)
        })
        .onReceive(saveLocallyTimer) { time in
            saveRankToLocalFile(ranklist: localRankList)
        }
    }
    
    func saveRankToLocalFile(ranklist: [RankStructure]){
        let homePath = HandleLocalFile.getDocumentsDirectory()
        let rankFilePath = homePath.appendingPathComponent("ranking.json")
        
        let rankListDict = ranklist.map{$0.convertToDictionary()}
        let data = try! JSONSerialization.data(withJSONObject: rankListDict,
                                                   options: JSONSerialization.WritingOptions.prettyPrinted)
        try! data.write(to: rankFilePath, options: .atomic)
    }
}

struct RankingListView_Previews: PreviewProvider {
    static var previews: some View {
        RankingListView()
    }
}
