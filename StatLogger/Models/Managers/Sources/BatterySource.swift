//
//  BatterySource.swift
//  StatLogger
//
//  Created by Trịnh Xuân Minh on 25/6/25.
//

import UIKit

final class BatterySource: DataSource {
  let name = "Battery"
  let interval: TimeInterval = 6
  
  func collect() -> DeviceInfo {
    UIDevice.current.isBatteryMonitoringEnabled = true
    let level = UIDevice.current.batteryLevel
    let percent = level >= 0 ? "\(Int(level * 100))%" : "Unknown Battery"
    return percent
  }
}
