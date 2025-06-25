//
//  DataSource.swift
//  StatLogger
//
//  Created by Trịnh Xuân Minh on 25/6/25.
//

import Foundation

protocol DataSource {
  var name: String { get }
  var interval: TimeInterval { get }
  func collect() -> DeviceInfo
}
