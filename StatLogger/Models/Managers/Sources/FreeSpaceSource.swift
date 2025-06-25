//
//  FreeSpaceSource.swift
//  StatLogger
//
//  Created by Trịnh Xuân Minh on 25/6/25.
//

import Foundation

final class FreeSpaceSource: DataSource {
  let name = "FreeSpace"
  let interval: TimeInterval = 3
  
  func collect() -> DeviceInfo {
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    if let dict = try? FileManager.default.attributesOfFileSystem(forPath: paths.last!),
       let free = dict[.systemFreeSize] as? NSNumber {
      return ByteCountFormatter.string(fromByteCount: free.int64Value, countStyle: .file)
    }
    return "Unknown Free Space"
  }
}
