//
//  DataStorage.swift
//  StatLogger
//
//  Created by Trịnh Xuân Minh on 25/6/25.
//

import Foundation

actor DataStorage {
  private var data: [DeviceInfo] = []
  
  func append(_ info: DeviceInfo) -> Bool {
    data.append(info)
    return data.count >= 5
  }
  
  func fetchAndClear() -> [DeviceInfo] {
    let copy = data
    data.removeAll()
    return copy
  }
}
