//
//  AddTask.swift
//  TodoList
//
//  Created by 陈子迪 on 2021/1/9.
//

import SwiftUI
import UIKit

struct AddTask: View {
    @State private var inputTitle: String = ""
    @State private var inputDesc: String = ""
    @State private var inputDuration = Date()
    
//    let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 320, height: 200))
//    let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 320, height: 200))
    
    var body: some View {

        VStack{
            VStack{
                TextField("Title", text: $inputTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Description", text: $inputDesc)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

            }
            .padding()
            VStack (alignment: .leading){
                HStack{
                    Text("Duration").font(.title3).bold()
                    Spacer()
                }
//                DatePicker(selection: $inputDuration, in: ...Date(), displayedComponents:.date) {
//                                Text("Set duration for task")
//                }
//                Text("Date is \(inputDuration, formatter: dateFormatter)")
            }
            .padding()
            Spacer()
        }
        .navigationBarTitle("Add Task")
    }
}

struct AddTask_Previews: PreviewProvider {
    static var previews: some View {
        AddTask()
    }
}
