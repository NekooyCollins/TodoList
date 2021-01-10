//
//  TaskRow.swift
//  TodoList
//
//  Created by 陈子迪 on 2020/12/30.
//

import Foundation
import SwiftUI

struct TaskRow: View {
    var task: TaskDataStructure
    
    var body: some View{
        HStack{
            Text(task.title)
                .foregroundColor(.black)
            
        }
    }
}


struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            TaskRow(task: taskDataSet[0])
        }
    }
}
