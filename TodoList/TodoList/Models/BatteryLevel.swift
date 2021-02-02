//
//  BatteryLevel.swift
//  TodoList
//
//  Created by 陈子迪 on 2021/1/26.
//

import Foundation
import UIKit

func checkBatteryLevel() -> Float {
    let batteryLevel = UIDevice.current.batteryLevel
    return batteryLevel
}
