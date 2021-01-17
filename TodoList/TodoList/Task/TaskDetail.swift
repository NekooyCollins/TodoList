//
//  TaskDetail.swift
//  TodoList
//
//  Created by 陈子迪 on 2020/12/30.
//

import SwiftUI

struct TaskDetail: View {
    @ObservedObject private var manager = RequestHandle()
    var task: TaskDataStructure
    
    var body: some View {
            VStack{
                VStack (alignment: .leading){
                    VStack{
                        HStack{
                            Text("Members").font(.title).bold()
                            Spacer()
                        }
                        MemberShortList(inputTask: task)
                    }
                    .frame(height: 130)
                    HStack{
                        NavigationLink(destination: AllMemberList(inputTask: task)) {
                           Text("See all members")
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        }
                        .buttonStyle(PlainButtonStyle())
                        Spacer()
                        NavigationLink(destination: AddMember()) {
                           Text("Add member")
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    HStack{
                        Text("Duration").font(.title).bold()
                        Spacer()
                    }
                    VStack (alignment: .leading){
                        VStack{
                            HStack{
                                Spacer()
                                Text(String(task.duration))
                                    .lineLimit(0)
                                    .padding(.top, 1.0)
                                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                Spacer().frame(width: 15)
                            }
                        }
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 10, maxHeight: 30, alignment: .center)
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 1.0, saturation: 0.0, brightness: 0.97)/*@END_MENU_TOKEN@*/)
                        .border(/*@START_MENU_TOKEN@*/Color.gray/*@END_MENU_TOKEN@*/, width: 0.3)
                        .cornerRadius(4.0)
                    }
                    HStack{
                        Text("Details").font(.title).bold()
                        Spacer()
                    }
                    VStack (alignment: .leading){
                        Text("Type").font(.title3)
                        VStack{
                            HStack{
                                Spacer()
                                Text(task.typestr)
                                    .lineLimit(0)
                                    .padding(.top, 1.0)
                                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                Spacer().frame(width: 15)
                            }
                        }
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 10, maxHeight: 30, alignment: .center)
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 1.0, saturation: 0.0, brightness: 0.97)/*@END_MENU_TOKEN@*/)
                        .border(/*@START_MENU_TOKEN@*/Color.gray/*@END_MENU_TOKEN@*/, width: 0.3)
                        .cornerRadius(4.0)
                    }
                    Spacer().frame(height: 20)
                    VStack (alignment: .leading){
                        Text("Description").font(.title3)
                        VStack{
                            HStack{
                                Text(task.descption)
                                    .lineLimit(0)
                                    .padding(.top, 1.0)
                                    .foregroundColor(.gray)
                                Spacer()
                            }
                        }
                        .padding()
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 10, maxHeight:120, alignment: .topLeading)
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 1.0, saturation: 0.0, brightness: 0.97)/*@END_MENU_TOKEN@*/)
                        .border(/*@START_MENU_TOKEN@*/Color.gray/*@END_MENU_TOKEN@*/, width: 0.3)
                        .cornerRadius(4.0)
                    }
                }
                .padding()
                
                VStack{
                    NavigationLink(destination: ProcessTask()) {
                       Text("Start")
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding()
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: 350, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 10, maxHeight:30, alignment: .center)
                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 1.0, saturation: 0.0, brightness: 0.97)/*@END_MENU_TOKEN@*/)
                .border(/*@START_MENU_TOKEN@*/Color.gray/*@END_MENU_TOKEN@*/, width: 0.3)
                .cornerRadius(4.0)
                
                Spacer()
            }
            .navigationBarTitle(task.title)
    }
    
}

struct TaskDetail_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetail(task: localTestTask)
    }
}

//func stringFromTimeInterval(time: TimeInterval) -> String {
//    let hours = Int(time) / 3600
//    let minutes = Int(time) / 60 % 60
//    let seconds = Int(time) % 60
//    return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
//}

