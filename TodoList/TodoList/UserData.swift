//
//  UserData.swift
//  TodoList
//
//  Created by 陈子迪 on 2020/12/30.
//

import Foundation
import SwiftUI
import Combine

final class UserData: ObservableObject  {
    @Published var dataset = userDataSet
}
