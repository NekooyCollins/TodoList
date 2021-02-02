//
//  RankingRowView.swift
//  ToDoList
//
//  Created by Xizhen Huang on 09.01.21.
//

import SwiftUI

struct RankingRowView: View {
    var rankItem: RankStructure
   
    var body: some View {
        // single item
        HStack {
            Text(rankItem.username)
                .font(.title3)
                .fontWeight(.medium)
                .foregroundColor(Color.white)
                .frame(width: 150.0)
            Spacer()
            Text(timeFormat(originalTime: rankItem.totalfocustime))
                .font(.title3)
                .fontWeight(.medium)
                .foregroundColor(Color.white)
                .frame(width: 150.0)
        
            Spacer()
                .frame(width: 50.0)
            
        }
        .frame(height: 70.0)
        .background(Color(red: 255 / 255, green: 177 / 255, blue: 27 / 255))
        .cornerRadius(10)
    }
}
